-- ================================================================================
-- Counter File -- Altera DE2 Board
-- Increments count every 16 clock pulses
-- ================================================================================
-- Authors : Maxime Grégoire, Patrick White
-- Last modified: 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
-- use     ieee.std_logic_unsigned.all; -- This is a depreciated library of ieee.numeric_std.all
use     ieee.numeric_std.all;

entity comparator is
port (	
	-- Counter interface
	clk 			: in std_logic;
	rst			: in std_logic;
	
	clear			: in std_logic;
	count 		: in std_logic_vector(31 downto 0);
	count_cmp	: in std_logic_vector(31 downto 0);
	count_equal : out std_logic
	  );
end entity comparator;

architecture arch of comparator is

signal count_equal_sig : std_logic;

begin
process(clk)
begin
if clk'event and clk='1' then
if rst='1' or clear = '1' then
count_equal_sig <= '0';
else
if (count = count_cmp) then
count_equal_sig <= '1';
else
count_equal_sig <= '0';
end if;
end if;
end if;
end process;

count_equal <= count_equal_sig;

end arch;
	
	