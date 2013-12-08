-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Alexandre Raymond, 260096239
-- Francois Leduc-Primeau, 260077400
-- Eric Demers, 260093486
-- Guillaume St-Yves, 260071029
-------------------------------------------------------------------------------
-- Description: The Write Controller handles the address and write_enable to
-- write data in the Grab Buffer. Note: The size of an addressable unit in the
-- Grab Buffer (determined by grab_if.SIZE_OUT) does not necessarily match
-- the size of grab_if.data => must account for that. wcontrol notifies
-- rcontrol when a buffer is ready to be read using handshaking.
--
-- Clock domain: gclk
--
-- Handshaking protocol (wcontrol=slave):
--  When done writing, wait for rdone, then raise wdone and start writing
--  immediately in the other buffer. Clear wdone when rdone goes low.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grab_wcontrol is

  generic (
    BADDRSIZE : integer := 8;           -- # of bits in buffer addr
    BUFFERLEN : integer := 256          -- # of addressable units in buffer
    );
  port (
    gclk     : in  std_logic;
    resetN   : in  std_logic;           -- asynch reset (active low?)
    av       : in  std_logic;           -- high when data is active video
    field    : in  std_logic;           -- video field: 0=odd, 1=even
    -- External registers
    gmode    : in  std_logic_vector(1 downto 0);   --grab mode
    gfmt     : in  std_logic;           -- grab format
    gssht    : in  std_logic;           -- grab snapshot
    gcont    : in  std_logic;           -- grab continuous
    gysize   : in  std_logic_vector(8 downto 0);
    gspdg    : out std_logic;           -- grab snapshot pending
    gactive  : out std_logic;           -- grab active
    regdebug : out std_logic_vector(31 downto 0);  -- debug
    -- End external registers
    waddr    : out std_logic_vector(BADDRSIZE-1 downto 0);
    wen      : out std_logic;           -- write enable (active high)
    -- Handshaking between rcontrol and wcontrol:
    rdone    : in  std_logic;           -- signal from read controller
    wdone    : out std_logic    -- H when done writing (handshake slave)
    );

end grab_wcontrol;

architecture a0 of grab_wcontrol is

  -- constants
  -- index of last line containing image pixels
  -- (odd and even fields have a different number of lines)
  constant cst_lastlineindexO : std_logic_vector(8 downto 0) :=  conv_std_logic_vector(240-1, 9);    -- was 244-1
  constant cst_lastlineindexE : std_logic_vector(8 downto 0) :=  conv_std_logic_vector(240-1, 9);    -- was 243-1
  
  type   state_signal is (WAITING, ACTIVEWAIT, ACTIVE);
  signal state : state_signal;

  signal linecount    : std_logic_vector(8 downto 0);  -- line counter
  signal curbuf       : std_logic;      -- current buffer
  signal multiplegrab : std_logic;      -- '1' when grabbing 2nd frame

  -- internal copies of outputs
  signal waddr_int   : std_logic_vector(BADDRSIZE-1 downto 0);
  signal wdone_int   : std_logic;
  signal gactive_int : std_logic;
  signal gspdg_int   : std_logic;

  -- global condition flags and reference
  signal validfield    : std_logic;     -- whether should grab cur field
  signal lastlineindex : std_logic_vector(8 downto 0);  -- choose a cst

  -- debug
  signal overrun_count : std_logic_vector(31 downto 0);
  
begin  -- a0

  -- assign internal signals to outputs
  waddr   <= waddr_int;
  wdone   <= wdone_int;
  gactive <= gactive_int;
  gspdg   <= gspdg_int;

  regdebug <= overrun_count;            --debug

  -- global conditions
  validfield <= '1' when (gmode = "00" and multiplegrab = '0' and field = '0')
                or (gmode = "00" and multiplegrab = '1' and field = '1')
                or (gmode = "01" and multiplegrab = '0' and field = '1')
                or (gmode = "01" and multiplegrab = '1' and field = '0')
                or (gmode = "10" and field = '0')
                or (gmode = "11" and field = '1')
                else '0';
--  with field select
    lastlineindex <= gysize;
--    cst_lastlineindexO when '0',
--    cst_lastlineindexE when others;

  -- purpose: State transition
  -- type   : sequential
  -- inputs : av, gspdg_int, gmode, field, linecount
  -- outputs: state
  statetrans : process (gclk, resetN)
  begin  -- process statetrans
    -- Simulation: warn about unimplemented features
    --assert not (gmode = "00" or gmode = "01")
    --  report "This grab mode not tested!"
    --  severity note;
   -- assert not gfmt = '0'
     -- report "Monochrome grab not implemented!"
     -- severity warning;

    if resetN = '0' then                  -- asynchronous reset (active low)
      state <= WAITING;
    elsif gclk'event and gclk = '1' then  -- rising clock edge
      case state is
        when WAITING =>
          if av = '1' and gspdg_int = '1' and validfield = '1' then
            state <= ACTIVE;
          end if;
        when ACTIVE =>
          -- We only leave ACTIVE when a line ends
          -- last line in frame
          if av = '0' and linecount = lastlineindex then
            state <= WAITING;
            -- still lines left
          elsif av = '0' then
            state <= ACTIVEWAIT;
          end if;
        when ACTIVEWAIT =>
          if av = '1' then
            state <= ACTIVE;
          end if;
        when others => null;
      end case;
    end if;
  end process statetrans;

  -- purpose: Updates registers
  -- type   : sequential
  -- inputs : gcont, gspdg, av, field
  -- outputs: waddr_int, wdone_int, gspdg_int, multiplegrab
  regs : process (gclk, resetN)
    variable nextbuf         : std_logic;         -- next buffer
    variable WAITINGtoACTIVE : boolean := false;  -- state transition
  begin  -- process regs
    -- Init variables
    WAITINGtoACTIVE := state = WAITING and av = '1'
                       and gspdg_int = '1' and validfield = '1';
    
    if resetN = '0' then                -- asynchronous reset (active low)
      waddr_int    <= conv_std_logic_vector(0, BADDRSIZE);
      wdone_int    <= '0';
      gspdg_int    <= '0';
      curbuf       <= '0';
      linecount    <= conv_std_logic_vector(0, 9);
      multiplegrab <= '0';

      overrun_count <= (others => '0');  --debug
      
    elsif gclk'event and gclk = '1' then  -- rising clock edge
      nextbuf := curbuf;
      -- Buffer control
      if state = ACTIVE then
        -- Write-address counter
        if waddr_int = BUFFERLEN-1 then
          waddr_int <= conv_std_logic_vector(0, BADDRSIZE);
          nextbuf   := '0';
        else
          waddr_int <= waddr_int + conv_std_logic_vector(1, BADDRSIZE);
        end if;
        if waddr_int = conv_std_logic_vector(BUFFERLEN/2-1, BADDRSIZE) then
          nextbuf := '1';
        end if;

        -- Go to next buffer on end-of-frame
        if av = '0' and linecount = lastlineindex then  -- ACTIVE -> WAITING
          -- now, we always return to buffer 0 at beginning of frame.
--          if curbuf = '0' then
--            waddr_int <= conv_std_logic_vector(BUFFERLEN, BADDRSIZE);
--            nextbuf := '1';
--          else -- curbuf='1'
          waddr_int <= conv_std_logic_vector(0, BADDRSIZE);
          nextbuf   := '0';
--          end if;
        end if;
      end if;  -- state=ACTIVE

      -- count active video lines
      if state = ACTIVE and av = '0' then  -- leaving ACTIVE
        if linecount = lastlineindex then
          linecount <= conv_std_logic_vector(0, 9);
        else
          linecount <= linecount + conv_std_logic_vector(1, 9);
        end if;
      end if;

      -- Status signals
      -- (grab active is combinational)
      -- grab snapshot pending
      if gssht = '1' then
        gspdg_int <= '1';
      end if;
      if WAITINGtoACTIVE then           -- transition to ACTIVE
        -- if we're in multiple grab mode (gmode(1)='0'),
        -- only clear gspdg at the end
        if gmode(1) = '1' or multiplegrab = '1' then
          gspdg_int <= '0';
        end if;
      end if;

      -- Multiple grab: count frames
      if WAITINGtoACTIVE then
        if gmode(1) = '0' then          -- multiple grab mode
          multiplegrab <= not multiplegrab;
        end if;
      end if;

      -- Communication with grab_rcontrol:
      -- Changing buffer
      if (curbuf xor nextbuf) = '1' then
        wdone_int <= '1';
        if rdone = '0' then             -- debug
          overrun_count <= overrun_count + X"00000001";
        end if;
      end if;
      -- Handshaking
      if wdone_int = '1' and rdone = '0' then
        wdone_int <= '0';
      end if;
      -- End communication with grab_rcontrol

      -- Update curbuf
      curbuf <= nextbuf;
    end if;
  end process regs;

  -- Combinational output
  -- Write-enable equivalent to state=ACTIVE
  with state select
    weN <=
    '1' when ACTIVE,                    -- (active high)
    '0' when others;
  -- grab active
  with state select   -- assumes that others={ACTIVE, ACTIVEWAIT}
    gactive_int <=
    '0' when WAITING,
    '1' when others;

end a0;
