-- ================================================================================
-- Counter File -- Altera DE2 Board
-- Increments count every 16 clock pulses
-- ================================================================================
-- Authors : Maxime Grégoire, Patrick White
-- Last modified: 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity counter_16 is
port (	
	-- Counter interface
	clk 			: in std_logic;
	rst 			: in std_logic;
	
	clear			: in std_logic;
	enable	 	: in std_logic;
	count 		: out std_logic_vector(31 downto 0)
	  );
end entity counter_16;

architecture arch of counter_16 is

signal	count_sig 		: 	std_logic_vector(31 downto 0) := (others => '0');
signal	clock_pulses 	:	std_logic_vector(3 downto 0) 	:= (others => '0');

begin
process(clk)
begin
if clk'event and clk='1' then

if rst='1' or clear = '1' then
count_sig <= (others => '0');
clock_pulses <= (others => '0');
elsif enable = '1' then
if (clock_pulses = "1111") then
count_sig <= std_logic_vector(unsigned(count_sig) + 1);
clock_pulses <= (others => '0');
else
clock_pulses <= std_logic_vector(unsigned(clock_pulses) + 1);
end if;

end if;

end if;
end process;

count <= count_sig;

end arch;
	
	