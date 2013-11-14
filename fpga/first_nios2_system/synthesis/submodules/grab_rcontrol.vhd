-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Alexandre Raymond, 260096239
-- Francois Leduc-Primeau, 260077400
-- Eric Demers, 260093486
-- Guillaume St-Yves, 260071029
-------------------------------------------------------------------------------
-- Description: The Read Controller selects an address to be read from the
-- Grab Buffer, and triggers address changes in Addressing Logic. It
-- communicates with the Write Controller to know when to read the Grab buffer
-- (communication is done using handshaking). The data read from the buffer is
-- written to memory according to the Avalon protocol. rcontrol determines when
-- to copy data to memory using the gactive signal from wcontrol. The rising
-- edge of gactive triggers the reset of the address counter.
--
-- Clock domain: sclk
--
-- Handshaking protocol (rcontrol=master):
--  When done reading, raise rdone. Wait for wdone, start reading other buffer
--  and clear rdone.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision 2007 by Jerry
-- Fixed a bug where the state machine does not go to LASTWRITE when
-- waitrequest changes during MEMWAIT.
-- Also added a condition to ensure that writeen (avalon signal) stays constant
-- during waitrequest. 
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grab_rcontrol is
  
  generic (
    BADDRSIZE : integer := 8;           -- # of bits in buffer addr
    BUFFERLEN : integer := 256          -- # of BYTES in buffer
                                        -- (#addressable units = /2)
    );

  port (
    sclk          : in  std_logic;
    resetN        : in  std_logic;      -- asynch reset (active low?)
    waitrequest   : in  std_logic;      -- from Avalon
    writeen       : out std_logic;      -- to Avalon
    byteenable    : out std_logic_vector(1 downto 0);  -- to Avalon
    raddr         : out std_logic_vector(BADDRSIZE-1 downto 0);
    reset_memaddr : out std_logic;      -- (trigger)mem addr<-frame start
    next_memaddr  : out std_logic;      -- (trigger)next mem addr
    -- Handshaking between rcontrol and wcontrol:
    wdone         : in  std_logic;      -- signal from write controller
    rdone         : out std_logic;  -- H when done reading (handshake master)
    gactive       : in  std_logic       -- tells us when the frame starts
    );

end grab_rcontrol;

architecture implem of grab_rcontrol is
  type   STATE_TYPE is (DONE, WAITING, BURST, MEMWAIT, LASTWRITE);
  signal state        : STATE_TYPE := DONE;
  signal nextstate    : STATE_TYPE;
  signal buf_raddr1   : std_logic_vector(BADDRSIZE-1 downto 0);
  signal buf_raddr2   : std_logic_vector(BADDRSIZE-1 downto 0);
  signal cur_raddrbuf : std_logic;
  signal raddrmux     : std_logic_vector(BADDRSIZE-1 downto 0);  -- mux output
  signal raddr_sel    : std_logic;      -- select input for raddr mux
  signal next_data    : std_logic;      -- equivalent to next_memaddr for data
  signal reset_gbuf   : std_logic;      -- next grab buf addr is 0
  signal current_half : std_logic  := '0';  -- '0' means top half of buffer is active
  signal framedone    : std_logic;      -- '1' indicates last read cycle

  --buffering output signal
  signal reset_memaddr_i        : std_logic;
  signal reset_memaddr_buffered : std_logic;
  
begin
  -----------------------------------------------------------------------------
  -- sequential process that handles state change
  -----------------------------------------------------------------------------
  FSM : process (sclk, resetN)
  begin  -- process NEXTSTATE
    if resetN = '0' then                -- asynchronous reset (active low)
      state               <= DONE;
    elsif sclk'event and sclk = '1' then
      state <= nextstate;
    end if;
  end process FSM;

  -----------------------------------------------------------------------------
  -- next state combinatorial process
  -----------------------------------------------------------------------------
  NEXTSTATE_GEN : process (state, gactive, wdone, framedone, raddrmux, waitrequest)
  begin  -- process NEXTSTATE_GEN
    nextstate <= state;                 -- default

    case state is
      -- waiting for the frame grabbing to start
      when DONE =>
        if gactive = '1' then
          nextstate <= WAITING;
        end if;

        -- waiting for handshake from wcontrol
      when WAITING =>
        if wdone = '1' and waitrequest = '0' then
          nextstate <= BURST;
        elsif wdone = '1' then
          nextstate <= MEMWAIT;
        end if;

      when BURST =>
        if waitrequest = '1' then
          nextstate <= MEMWAIT;
          -- check for end of buffer
          -- (divide by 4 because we use words (/2) and only half the buffer (/2))
        elsif raddrmux = conv_std_logic_vector(BUFFERLEN/4-1, BADDRSIZE) then
          nextstate <= LASTWRITE;
        end if;

      when MEMWAIT =>
        if waitrequest = '0' then
          if raddrmux = conv_std_logic_vector(BUFFERLEN/4-1, BADDRSIZE) then                                                                            
            nextstate <= LASTWRITE;     -- bug fix 2007: ensure that the state
                                        -- machine is able to go to the
                                        -- LASTWRITE state during MEMWAIT
          else
            nextstate <= BURST;
          end if;
        end if;

      when LASTWRITE =>
        if waitrequest = '0' then
          if framedone = '1' then
            nextstate <= DONE;
          else
            nextstate <= WAITING;
          end if;
        end if;
        
      when others => null;
                     
    end case;
  end process NEXTSTATE_GEN;

  -----------------------------------------------------------------------------
  -- updates registers according to state
  -- type: sequential
  -- inputs: state, nextstate, gactive
  -- outputs: buf_raddr1, buf_raddr2, framedone, current_half, cur_raddrbuf,
  --          writeen
  -----------------------------------------------------------------------------
  regs : process(sclk, resetN)
  begin
    if resetN = '0' then                -- asynchronous reset
      current_half <= '0';              -- toggled at end of field
      framedone    <= '0';
      buf_raddr1   <= (others => '0');
      buf_raddr2   <= (others => '0');
      cur_raddrbuf <= '0';
      writeen      <= '0';

    elsif rising_edge(sclk) then

      -- buffer read addr
      if next_data = '1' then
        if cur_raddrbuf = '0' then
          buf_raddr1 <= buf_raddr1 + conv_std_logic_vector(2, BADDRSIZE);
        else
          buf_raddr2 <= buf_raddr2 + conv_std_logic_vector(2, BADDRSIZE);
        end if;
        cur_raddrbuf <= not cur_raddrbuf;
      end if;
      if reset_gbuf = '1' then
        buf_raddr1   <= conv_std_logic_vector(0, BADDRSIZE);
        buf_raddr2   <= conv_std_logic_vector(1, BADDRSIZE);
        cur_raddrbuf <= '0';
      end if;

      -- framedone flag
      if gactive = '0' and not (state = DONE) then
        framedone <= '1';
      end if;
      if state = DONE then
        framedone <= '0';
      end if;

      -- current buffer
      if state = LASTWRITE and nextstate = WAITING then
        current_half <= not current_half;
      elsif state = DONE and nextstate = WAITING then
        current_half <= '0';
      end if;

     -- if waitrequest = '0' then         -- bug fix 2007: ensure that writeen
                                        -- doesnt change during waitrequest
        -- write enable (follows data and address)
        if state = WAITING and nextstate = BURST then
          writeen <= '1';
        --elsif state = MEMWAIT and nextstate = BURST then
		elsif state = WAITING and nextstate = MEMWAIT then
          writeen <= '1';        -- in case we went from WAITING->MEMWAIT
        elsif state = LASTWRITE then
          writeen <= '0';
        elsif state = DONE then
          writeen <= '0';
        end if;
     -- end if;
      
    end if;  -- end rising_edge(sclk)
  end process regs;

-- purpose: Defines output based on state.
-- type   : combinational
-- inputs : state, current_half, raddrmux, waitrequest 
-- outputs: rdone, byteenable, next_memaddr, reset_memaddr, raddr,
--          next_data, reset_gbuf
  stateout : process (gactive, state, nextstate, current_half, raddrmux, waitrequest)
  begin  -- process stateout

    -- defaults
    rdone                    <= '0';
    byteenable               <= "11";   -- always write both bytes
    next_memaddr             <= '0';
    reset_memaddr_i          <= '0';
    next_data                <= '0';
    reset_gbuf               <= '0';

    case state is
      when DONE =>
        rdone <= '1';
        if gactive = '1' then           -- DONE to WAITING
          reset_memaddr_i <= '1';
        end if;
      when WAITING =>
        rdone      <= '1';
        reset_gbuf <= '1';
        -----------------------------------------------------------------------
        -- bug fux 2007: next_memaddr and next_data should only be enabled when
        -- waitrequest is low.
        -----------------------------------------------------------------------
      when BURST =>
        if waitrequest = '0' then       -- BURST to not MEMWAIT
          next_memaddr <= '1';
          next_data    <= '1';
        end if;
      when MEMWAIT =>
        if waitrequest = '0' then       -- MEMWAIT to BURST
            next_memaddr <= '1';
            next_data    <= '1';          
        end if;
      when LASTWRITE =>
        if waitrequest = '0' then
          next_memaddr <= '1';          -- prepare for next mem write
          next_data    <= '1';
        end if;
      when others => null;
    end case;

    -- decide which half we want to read from
    if current_half = '1' then
      -- divide by 4 because we use words (/2) and only half the buffer (/2)
      raddr <= raddrmux+conv_std_logic_vector(BUFFERLEN/4, BADDRSIZE);
    else
      raddr <= raddrmux;
    end if;
    
  end process stateout;

  --buffers reset_memaddr
--      pilo: process(resetN, sclk)
--        begin
--      if resetN = '0' then
--        reset_memaddr_buffered <= '0';
--      else
--        if rising_edge(sclk) then
--          reset_memaddr_buffered <= reset_memaddr_i;
--        end if;
--      end if;
--      end process pilo;
  reset_memaddr <= reset_memaddr_i;     --TODO:reset_memaddr_buffered;

  -- mux for raddr output
  with raddr_sel select
    raddrmux <=
    buf_raddr1 when '0',
    buf_raddr2 when others;

  raddr_sel <= next_data xor cur_raddrbuf;


end implem;
