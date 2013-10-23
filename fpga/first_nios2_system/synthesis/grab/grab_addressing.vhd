--   *****************************************************************************
--   Project      :   Frame Grabber
--
--   Unite        :   Read Controller
--
--   Description  :   
--   This block generates the address for writing to memory (through
--   the Avalon switch).
--   -----------------------------------------------------------------------------
--   HISTORY
--   Team #1   12/01/2006
--   ECSE 431, McGill University
--   Alexandre Raymond, 260096239
--   Francois Leduc-Primeau, 260077400
--   Eric Demers, 260093486
--   Guillaume St-Yves, 260071029
--   eboisver 10/01/2007
--   Formatted text; Add comment.
--
--   This file is used with the written permission of the authors (team #1, 2006).
--   *****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grab_addressing is
  
  generic (
    ADDRSIZE    : integer := 23;        -- Size of address bus (without
                                        -- 0-MSb's, byte-aligned)
    LINESIZE    : integer := 1440;      -- nb of bytes / line
    LINESIZELOG : integer := 11;        -- nb of bits to code LINESIZE
    WORDSIZE    : integer := 2          -- nb of bytes / addressable unit
    );

  port (
    sclk      : in  std_logic;
    resetN    : in  std_logic;          -- asynch reset (active low)
    GFSTART   : in  std_logic_vector(ADDRSIZE-1 downto 0);  -- frame start addr
    GLPITCH   : in  std_logic_vector(ADDRSIZE-1 downto 0);  -- grab line pitch
    resetaddr : in  std_logic;          -- triggers reset address
    nextaddr  : in  std_logic;          -- triggers next address
    address   : out std_logic_vector(ADDRSIZE-1 downto 0)
    );

end grab_addressing;

architecture functional of grab_addressing is
  signal address_reg   : std_logic_vector(ADDRSIZE-2 downto 0);  --word-aligned
  signal baseline_addr : std_logic_vector(ADDRSIZE-2 downto 0);  --word-aligned
  signal pixcount      : std_logic_vector(LINESIZELOG-1 downto 0);  -- pixel counter

  -- word aligned inputs
  signal GFSTART_w : std_logic_vector(ADDRSIZE-2 downto 0);
  signal GLPITCH_w : std_logic_vector(ADDRSIZE-2 downto 0);

begin

  -- make word-aligned inputs
  GFSTART_w <= GFSTART(ADDRSIZE-1 downto 1);
  GLPITCH_w <= GLPITCH(ADDRSIZE-1 downto 1);

  -- make byte-aligned output
  address <= address_reg & "0";

  -- each time we receive nextaddr, we increment the address by 1
  -- we also count the number of pixels received, and when we have reached a
  -- line size we go to the next line (baseline + line pitch)
  -- all this while taking into account for the word size
  process (sclk, resetN)
  begin  -- process
    if resetN = '0' then                -- asynchronous reset (active low)
      address_reg   <= (others => '0');
      baseline_addr <= (others => '0');
      pixcount      <= (others => '0');
      
    elsif sclk'event and sclk = '1' then  -- rising clock edge
      if resetaddr = '1' then
        pixcount      <= (others => '0');
        address_reg   <= GFSTART_w;
        baseline_addr <= GFSTART_w;

      elsif nextaddr = '1' then
        -- update pixel counter
        if pixcount = LINESIZE/WORDSIZE - 1 then
          pixcount      <= (others => '0');
          address_reg   <= baseline_addr + GLPITCH_w;
          baseline_addr <= baseline_addr + GLPITCH_w;
        else
          pixcount    <= pixcount + conv_std_logic_vector(1, LINESIZELOG);
          address_reg <= address_reg + conv_std_logic_vector(1, ADDRSIZE-1);
        end if;
      end if;
    end if;
  end process;


end functional;

