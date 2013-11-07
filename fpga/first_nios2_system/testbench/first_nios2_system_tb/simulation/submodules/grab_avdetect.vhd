-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Alexandre Raymond, 260096239
-- Francois Leduc-Primeau, 260077400
-- Eric Demers, 260093486
-- Guillaume St-Yves, 260071029
-------------------------------------------------------------------------------
-- Description: Decodes the SAV codes transmitted during the horizontal
-- blanking to indicate when data represents (active) video data. Also
-- indicates which field is being transmitted. Decoding the EAV code is of no
-- use since we are writing data in real time. Instead, to detect end-of-line
-- we count the pixels in the line.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grab_AVdetect is
  generic (
    LINESIZE    : integer := 2;         -- number of bytes in a line
    LINESIZELOG : integer := 1;         -- nb of bits to code LINESIZE
    SIZEIN      : integer := 1);        -- size of databus in
  port (
    gclk   : in  std_logic;
    resetN : in  std_logic;             -- active low (?)
    data   : in  std_logic_vector(SIZEIN-1 downto 0);
    av     : out std_logic;             -- high for active video
    field  : out std_logic);            -- 0 = odd field, 1 = even field
end grab_AVdetect;

architecture a0 of grab_AVdetect is

  constant cst_FF : std_logic_vector(7 downto 0) := "11111111";
  constant cst_00 : std_logic_vector(7 downto 0) := "00000000";

  type   state_signal is (WAITING, ARM1, ARM2, UPDATE);
  signal state : state_signal;

  signal av_int    : std_logic;         -- internal for active video output
  signal field_int : std_logic;         -- internal for field output
  signal pixcount  : std_logic_vector(LINESIZELOG-1 downto 0);  -- pixel count
  
begin  -- a0

  -- assign internal signals to outputs
  av    <= av_int;
  field <= field_int;

  -- purpose: State transition
  -- type   : sequential
  -- inputs : gclk, resetN, data
  -- outputs: state
  statetrans : process (gclk, resetN)
  begin  -- process statetrans
    if resetN = '0' then                  -- asynchronous reset (active low)
      state <= WAITING;
    elsif gclk'event and gclk = '1' then  -- rising clock edge
      case state is
        when WAITING =>
          if(data(7 downto 0) = cst_FF) then
            state <= ARM1;
          end if;
        when ARM1 =>
          if(data(7 downto 0) = cst_00) then
            state <= ARM2;
          else
            state <= WAITING;
          end if;
        when ARM2 =>
          if(data(7 downto 0) = cst_00) then
            state <= UPDATE;
          else
            state <= WAITING;
          end if;
        when UPDATE =>
          state <= WAITING;
        when others => null;
      end case;
    end if;
  end process statetrans;

  -- purpose: Updates the registers
  -- type   : sequential
  -- inputs : gclk, resetN, state, data
  -- outputs: av_int, field_int, pixcount
  registers : process (gclk, resetN)
  begin  -- process registers
    if resetN = '0' then                -- asynchronous reset (active low)
      av_int    <= '0';
      field_int <= '0';
      pixcount  <= conv_std_logic_vector(0, LINESIZELOG);
      
    elsif gclk'event and gclk = '1' then  -- rising clock edge
      if state = UPDATE then
        if data(5) = '0' then             -- ignore tags during vertical blank
          if data(4) = '0' then           -- SAV (Start Active Video)
            av_int <= '1';
            if data(6) = '0' then         -- Field 1 (Odd)
              field_int <= '0';
            else                          -- Field 2 (Even)
              field_int <= '1';
            end if;
          else                            -- EAV (End Active Video)
            assert not av_int = '1'
              report "av still high at EAV event, problem with pixel count."
              severity error;
          end if;  -- end data(4)=...
        end if;  -- end data(5)='0'
      end if;  -- end state=UPDATE

      if av_int = '1' then
        pixcount <= pixcount + conv_std_logic_vector(1, LINESIZELOG);
      end if;
      if pixcount = conv_std_logic_vector(LINESIZE-1, LINESIZELOG) then
        av_int   <= '0';
        pixcount <= conv_std_logic_vector(0, LINESIZELOG);
      end if;
    end if;
  end process registers;
  
end a0;
