-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Alexandre Raymond, 260096239
-- Francois Leduc-Primeau, 260077400
-- Eric Demers, 260093486
-- Guillaume St-Yves, 260071029
-------------------------------------------------------------------------------

--*****************************************************************************
--  $Source: /proj/typhoon/image2/hw/util/emacs/RCS/vhdl.el,v $
--  $Locker:  $
--  $Revision: 1.1 $
--  $Date: 1995/03/09 17:22:04 $
--  $Author: dpozzebo $
--
--   Project      :   Frame grabber
--
--   Unite        :   grab interface
--
--   Description  :   
--   The Grab interface is responsible for accepting data from the
--   video decoder (ADV7181B) and writing it in the correct location in memory.
--   It communicates with memory through an Avalon switch. The operation of the
--   circuit is controlled by a set of registers. This block contains two clock
--   domains: gclk and sclk. The design assumes that sclk is faster or equal to gclk.
--   Registers:
--   GCTRL
--   bit 6 to 5: GMODE= grab mode, read-write
--   bit 4: GFMT= grab format, read-write
--   bit 3: GACTIVE= grab active, read-only
--   bit 2: GCONT= grab continuous, read-write
--   bit 1: GSPDG= grab snapshot pending, read-only
--   bit 0: GSSHT= grab snapshot, write-only
--   GFSTART
--   bit 22 to 0: GFSTART= grab frame start address, read-write(22:1), read-only(bit 0)
--   GLPITCH
--   bit 22 to 0: GLPITCH= grab line pitch, read-write(22:1), read-only(bit 0)
--
--*****************************************************************************
--   HISTORY
--   eboisver 05/05/2007
--   Formatted text; Add comment.

--   Jerry 06/11/2007
--   Added clock domain crossing for GACTIVE, GSPDG and GSSHT between Grab if
--   and reg file.
--   Changed constants for the new display resolution. Decreased line buffer
--   size to 256 bytes.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grab_if is

  generic (
    size_in  : integer := 8;            -- from video decoder
    size_out : integer := 16;           -- to avalon switch (memory)
    addrsize : integer := 23            -- Memory address width
    );
  port (
    -- Video decoder interface
    gclk          : in  std_logic;      -- video decoder clock
    vdata         : in  std_logic_vector(7 downto 0);  -- input from video dec
    -- Avalon interface:
    resetN        : in  std_logic;      -- asynch reset (active low)
    sclk          : in  std_logic;      -- system clock
    writedata     : out std_logic_vector(15 downto 0);
    waitrequest   : in  std_logic;
    writeen       : out std_logic;
    byteenable    : out std_logic_vector(1 downto 0);
    address       : out std_logic_vector(31 downto 0);  -- SDRAM memory address
    -- External registers
    GSSHT         : in  std_logic;      -- triggers a one frame grab
    GMODE         : in  std_logic_vector(1 downto 0);
    GCONT         : in  std_logic;      -- only '0' supported (snapshot)
    GFMT          : in  std_logic;  -- only '1' supported (color)  -- SIGNAL POLLUTION!
    GFSTART       : in  std_logic_vector(22 downto 0);
    GLPITCH       : in  std_logic_vector(22 downto 0);
    GYSS          : in  std_logic_vector(1 downto 0);  -- watch out, 2bits (see Alex's sheet)
    GXSS          : in  std_logic_vector(1 downto 0);  -- watch out, 2bits (see Alex's sheet)
    GACTIVE       : out std_logic;
    GSPDG         : out std_logic;      -- grab snapshot pending
    --REGISTERS USED FOR DEBUG
    DEBUG_GRABIF1 : out std_logic_vector(31 downto 0);
    DEBUG_GRABIF2 : out std_logic_vector(31 downto 0)
    );

end grab_if;

architecture functional of grab_if is
  -- implementation details
  constant LINESIZE    : integer := 1440;  -- bytes / line
  constant LINESIZELOG : integer := 11;    -- log2(LINESIZE)
  constant BRADDRSIZE  : integer := 12;    -- buffer read address size
  constant BWADDRSIZE  : integer := 13;    -- buffer write address size
  constant BUFFERLEN   : integer := 256;  -- nb of bytes in buffer --changed
                                           -- from 5120
  constant WORDSIZE    : integer := 2;     -- nb of bytes/pixel

  --debug registers buffered
  signal DEBUG_GRABIF1_int : std_logic_vector(31 downto 0);
  signal DEBUG_GRABIF2_int : std_logic_vector(31 downto 0);
  signal rdone, wdone      : std_logic;  -- rcontrol<->wcontrol
  signal rdone1, rdone2    : std_logic;  --cdom crossing
  signal wdone1, wdone2    : std_logic;  --cdom crossing
  signal av, field         : std_logic;  -- AVdetect->wcontrol
  signal waddr             : std_logic_vector(BWADDRSIZE-1 downto 0);  -- wcontrol->buffer
  signal wen               : std_logic;  -- wcontrol->buffer
  signal raddr             : std_logic_vector(BRADDRSIZE-1 downto 0);  -- rcontrol->buffer
  signal reset_memaddr     : std_logic;  -- rcontrol->addressing
  signal next_memaddr      : std_logic;  -- rcontrol->addressing
  signal GACTIVE_int       : std_logic;  -- wcontrol->rcontrol (and ->regfile)
  signal GACTIVE_int1      : std_logic;  --cdom crossing
  signal GACTIVE_int2      : std_logic;  --cdom crossing
  signal GSPDG_s           : std_logic;
  signal GSPDG_r           : std_logic;
  signal GSPDG_2r          : std_logic;  -- cdom crossing
  signal gssht_gclk        : std_logic;
  signal gssht_flag        : std_logic;
  signal q                 : std_logic_vector(15 downto 0);

  -- address going to memory, without the padding:
  signal small_address : std_logic_vector(ADDRSIZE-1 downto 0);

  --debug
  signal incr_memaddr      : std_logic_vector(31 downto 0);
  signal old_reset_memaddr : std_logic;

  --monochrome
  signal y_toggle : std_logic;


  component grab_AVdetect
    generic (
      LINESIZE    : integer;
      LINESIZELOG : integer;
      SIZEIN      : integer);
    port (
      gclk   : in  std_logic;
      resetN : in  std_logic;
      data   : in  std_logic_vector(SIZEIN-1 downto 0);
      av     : out std_logic;
      field  : out std_logic);
  end component;

  component grab_wcontrol
    generic (
      BADDRSIZE : integer;
      BUFFERLEN : integer);
    port (
      gclk     : in  std_logic;
      resetN   : in  std_logic;
      av       : in  std_logic;
      field    : in  std_logic;
      GMODE    : in  std_logic_vector(1 downto 0);
      GFMT     : in  std_logic;
      GSSHT    : in  std_logic;
      GCONT    : in  std_logic;
      GSPDG    : out std_logic;
      GACTIVE  : out std_logic;
      regdebug : out std_logic_vector(31 downto 0);
      waddr    : out std_logic_vector(BADDRSIZE-1 downto 0);
      wen      : out std_logic;
      rdone    : in  std_logic;
      wdone    : out std_logic);
  end component;

  component grab_rcontrol
    generic (
      BADDRSIZE : integer;
      BUFFERLEN : integer);
    port (
      sclk          : in  std_logic;
      resetN        : in  std_logic;
      waitrequest   : in  std_logic;
      writeen       : out std_logic;
      byteenable    : out std_logic_vector(1 downto 0);  -- to Avalon
      raddr         : out std_logic_vector(BADDRSIZE-1 downto 0);
      reset_memaddr : out std_logic;
      next_memaddr  : out std_logic;
      wdone         : in  std_logic;
      rdone         : out std_logic;
      GACTIVE       : in  std_logic);
  end component;

  component grab_addressing
    generic (
      ADDRSIZE    : integer;
      LINESIZE    : integer;
      LINESIZELOG : integer;
      WORDSIZE    : integer);
    port (
      sclk      : in  std_logic;
      resetN    : in  std_logic;
      GFSTART   : in  std_logic_vector(ADDRSIZE-1 downto 0);
      GLPITCH   : in  std_logic_vector(ADDRSIZE-1 downto 0);
      resetaddr : in  std_logic;
      nextaddr  : in  std_logic;
      address   : out std_logic_vector(ADDRSIZE-1 downto 0));
    --debug_reg : out std_logic_vector(31 downto 0));      
  end component;

  component grab_buffer
    port (
      data      : in  std_logic_vector (7 downto 0);
      wren      : in  std_logic := '1';
      wraddress : in  std_logic_vector (12 downto 0);
      rdaddress : in  std_logic_vector (11 downto 0);
      wrclock   : in  std_logic;
      rdclock   : in  std_logic;
      q         : out std_logic_vector (15 downto 0));
  end component;

  signal vdata_delayed : std_logic_vector (7 downto 0);

  --debug
  signal av_count      : std_logic_vector(14 downto 0);
  signal s1_av_count   : std_logic_vector(14 downto 0);  -- in sclk domain
  signal s_av_count    : std_logic_vector(14 downto 0);  -- in sclk domain
  signal vdata_debug   : std_logic_vector(7 downto 0);   -- see debug1 proc
  signal dbg_linecnt   : integer;
  signal last_av       : std_logic;
  signal overrun_count : std_logic_vector(31 downto 0);  -- gclk

  signal cnt_GACTIVE : std_logic_vector(31 downto 0);  -- gclk
  signal debug_reg   : std_logic_vector(31 downto 0);
begin  -- functional

  --clock domain crossing (gclk -> sclk)
  poill : process(sclk, resetN)
  begin
    if resetN = '0' then
      GACTIVE_int1 <= '0';
      GACTIVE_int2 <= '0';
      GSPDG_r      <= '0';
      GSPDG_2r     <= '0';
      wdone1       <= '0';
      wdone2       <= '0';
    else
      if rising_edge(sclk) then
        GACTIVE_int1 <= GACTIVE_int;
        GACTIVE_int2 <= GACTIVE_int1;
        GSPDG_r      <= GSPDG_s;
        GSPDG_2r     <= GSPDG_r;
        wdone1       <= wdone;
        wdone2       <= wdone1;
      end if;
    end if;
  end process poill;
  --clock domain crossing (sclk -> gclk)
  poill2 : process(gclk, resetN)
  begin
    if resetN = '0' then
      rdone1 <= '0';
      rdone2 <= '0';
    else
      if rising_edge(gclk) then
        rdone1 <= rdone;
        rdone2 <= rdone1;
      end if;
    end if;
  end process poill2;


  --clock domain crossing (sclk -> gclk) for gssht generated from reg_file
  gssht_latch : process (sclk, gclk, resetN)
  begin  -- process gssht_crs
    if resetN = '0' then                -- asynchronous reset (active low)
      gssht_flag <= '0';
    elsif rising_edge(sclk) then        -- rising clock edge
      if GSSHT = '1' then
        gssht_flag <= '1';              -- latches gssht of sclk domain
      end if;
      if gssht_gclk = '1' then
        gssht_flag <= '0';
      end if;
    end if;
  end process gssht_latch;

  gssht_gclk_crs : process (gclk, resetN)
  begin  -- process
    if resetN = '0' then                -- asynchronous reset (active low)
      gssht_gclk <= '0';
    elsif rising_edge(gclk) then        -- rising clock edge
      gssht_gclk <= '0';
      if (gssht_flag = '1') then
        gssht_gclk <= '1';              -- generate 1 pulse of gssht on gclk
      end if;
    end if;
  end process gssht_gclk_crs;


  --debug
  count_GACTIVE : process (gclk, resetN)
  begin
    if resetN = '0' then
      cnt_GACTIVE <= (others => '0');
    elsif rising_edge(gclk) then
      if GACTIVE_int = '1' then
        cnt_GACTIVE <= cnt_GACTIVE + conv_std_logic_vector(1, 32);
      end if;
    end if;
  end process count_GACTIVE;

  --debug
  poil1 : process(sclk, resetN)
  begin
    if resetN = '0' then
      incr_memaddr      <= (others => '0');
      old_reset_memaddr <= '0';
    else
      if rising_edge(sclk) then
        --if reset_memaddr = '1' and old_reset_memaddr /= reset_memaddr then
        if waitrequest = '1' then
          incr_memaddr <= incr_memaddr + 1;
        end if;
        --old_reset_memaddr <= reset_memaddr;
      end if;
    end if;
  end process poil1;

  grab_AVdetect_1 : grab_AVdetect
    generic map (
      LINESIZE    => LINESIZE,
      LINESIZELOG => LINESIZELOG,
      SIZEIN      => SIZE_IN)
    port map (
      gclk   => gclk,
      resetN => resetN,
      data   => vdata,
      av     => av,
      field  => field);

  av_count_proc : process(gclk, resetN)
  begin
    if (resetN = '0') then
      av_count <= (others => '0');
      last_av  <= '0';
    elsif (gclk'event and gclk = '1') then
      if (last_av = '0' and av = '1') then
        av_count <= av_count + 1;
      end if;
      last_av <= av;
    end if;
  end process;

  cdcross : process(sclk, resetN)
  begin
    if (resetN = '0') then
      s_av_count  <= (others => '0');
      s1_av_count <= (others => '0');

      --DEBUG REGISTERS
      DEBUG_GRABIF1_int <= (others => '0');
      DEBUG_GRABIF2_int <= (others => '0');
    elsif (sclk'event and sclk = '1') then
      s1_av_count <= av_count;
      s_av_count  <= s1_av_count;

      --DEBUG REGISTERS
      DEBUG_GRABIF1_int <= debug_reg;  --cnt_GACTIVE; --vielles choses: "00110" & field & "000" & small_address;  --23+1
      DEBUG_GRABIF2_int <= overrun_count;  --vieilles choses: incr_memaddr; --s_av_count & waddr & raddr;          -- 9+8
    end if;
  end process;
--  DEBUG_GRABIF1 <= DEBUG_GRABIF1_int;
-----------------------------------------------------------------------------------
-- debug 2007, used to display one pixel on the BCD display using DEBUG_GRABIF1
-----------------------------------------------------------------------------------  
  DEBUG_GRABIF2              <= DEBUG_GRABIF2_int;
  DEBUG_GRABIF1(15 downto 0) <=
    q when small_address(19 downto 0) = "1110000000000000000";  -- x70000                                                     

  grab_wcontrol_1 : grab_wcontrol
    generic map (
      BADDRSIZE => BWADDRSIZE,
      BUFFERLEN => BUFFERLEN)
    port map (
      gclk     => gclk,
      resetN   => resetN,
      av       => av,
      field    => field,
      GMODE    => GMODE,
      GFMT     => GFMT,
      GSSHT    => gssht_gclk,
      GCONT    => GCONT,
      GSPDG    => GSPDG_s,
      GACTIVE  => GACTIVE_int,
      regdebug => overrun_count,
      waddr    => waddr,
      wen      => wen,
      rdone    => rdone2,
      wdone    => wdone);

  grab_rcontrol_1 : grab_rcontrol
    generic map (
      BADDRSIZE => BRADDRSIZE,
      BUFFERLEN => BUFFERLEN)
    port map (
      sclk          => sclk,
      resetN        => resetN,
      waitrequest   => waitrequest,
      writeen       => writeen,
      byteenable    => byteenable,
      raddr         => raddr,
      reset_memaddr => reset_memaddr,
      next_memaddr  => next_memaddr,
      wdone         => wdone2,
      rdone         => rdone,
      GACTIVE       => GACTIVE_int2);   --clock domain crossing here

  grab_addressing_1 : grab_addressing
    generic map (
      ADDRSIZE    => ADDRSIZE,
      LINESIZE    => LINESIZE,
      LINESIZELOG => LINESIZELOG,
      WORDSIZE    => WORDSIZE)
    port map (
      sclk      => sclk,
      resetN    => resetN,
      GFSTART   => GFSTART,
      GLPITCH   => GLPITCH,
      resetaddr => reset_memaddr,
      nextaddr  => next_memaddr,
      address   => small_address);
  --debug_reg => debug_reg);

  -- pad the address with 0's so that it can go to the actual memory
  address(31 downto ADDRSIZE)  <= (others => '0');  -- pad MSb with 0's
  address(ADDRSIZE-1 downto 0) <= small_address;

  grab_buffer_1 : grab_buffer
    port map (
      data      => vdata_delayed,       -- for debug: vdata_debug
      wren      => wen,
      wraddress => waddr,
      rdaddress => raddr,
      wrclock   => gclk,
      rdclock   => sclk,
      q         => q);
  writedata <= q;
  -- this delays by 1 clk the incoming data for grab_buffer
  process(gclk,resetN)
  begin
    if resetN = '0' then
      vdata_delayed <= (others => '0');
    elsif rising_edge(gclk) then
      vdata_delayed <= vdata;
      if GFMT = '0' then                -- monochrome
        if y_toggle = '0' then          -- clear Cr, Cb to 128
          vdata_delayed <= conv_std_logic_vector (128, 8);
        end if;
      end if;
    end if;
  end process;

  -- purpose: toggles y_toggle and lock it on the rising edge of AV, used for monochrome
  toggle_y : process (gclk, resetN)
  begin  -- process
    if resetN = '0' then                -- asynchronous reset (active low)
      y_toggle <= '0';
    elsif rising_edge (gclk) then       -- rising clock edge
      y_toggle <= not y_toggle;
      if (last_av = '0' and av = '1') then  --rising edge of av, Y is being captured
        y_toggle <= '1';
      end if;
    end if;
  end process;

  GACTIVE <= GACTIVE_int2;
  GSPDG   <= GSPDG_2r;

--DEBUG ONLY
  -- purpose: make up pink data with incrementing Y
  -- type   : sequential
  -- inputs : gclk, resetN, av
  -- outputs: vdata_debug
--  debug1: process (gclk, resetN)
--  begin  -- process debug1
--    if resetN = '0' then                -- asynchronous reset (active low)
--      vdata_debug <= (others => '0');
--       dbg_linecnt <= 0;
--    elsif gclk'event and gclk = '1' then  -- rising clock edge
--      if (last_av = '0' and av='1') then
--        vdata_debug <= conv_std_logic_vector(dbg_linecnt, 8);
--        if (dbg_linecnt = 525) then
--          dbg_linecnt <= 0;
--        else 
--          dbg_linecnt <= dbg_linecnt + 1;
--        end if;
--      elsif av='1' then
--        vdata_debug <= vdata_debug + '1';
--      end if;
--    end if;
--  end process debug1;
end functional;
