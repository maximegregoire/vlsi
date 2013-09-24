-- ================================================================================
-- Register File -- Altera DE2 Board
-- ================================================================================
-- Authors : Maxime Grégoire, Patrick White
-- Last modified: 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;

entity regfile is
port (	
	address : in std_logic_vector(3 downto 0);
	read_n : in std_logic;
	readdata : out std_logic_vector(31 downto 0);
	write_n : in std_logic;
	writedata : in std_logic_vector(31 downto 0);
	rst : in std_logic;
	clk : in std_logic;
	
	AVINTDIS : 	out std_logic;
	T1INTOVR : 	out std_logic;
	T1INTSTS : 	out std_logic;
	T0INTSTS : 	out std_logic;
	T1INTEN : 	out std_logic;
	T0INTEN : 	out std_logic;
	
	T1CNTEN : 	out std_logic;
	T0CNTEN : 	out std_logic;
	T1RST : 		out std_logic;
	T0RST : 		out std_logic;
	
	T0CNT : 		out std_logic_vector(31 downto 0);
	
	T1CNT : 		out std_logic_vector(31 downto 0);
	
	T0CMP : 		out std_logic_vector(31 downto 0);
	
	T1CMP : 		out std_logic_vector(31 downto 0);
	
	GP0 : 		out std_logic_vector(31 downto 0);
	
	GP1 : 		out std_logic_vector(31 downto 0)
	  );
end entity regfile;

architecture arch of regfile is

signal	AVINTDIS_sig 	: 	 std_logic;
signal	T1INTOVR_sig 	: 	 std_logic;
signal	T1INTSTS_sig 	: 	 std_logic;
signal	T0INTSTS_sig 	: 	 std_logic;
signal	T1INTEN_sig 	: 	 std_logic;
signal	T0INTEN_sig 	: 	 std_logic;

signal	T1CNTEN_sig : 	std_logic;
signal	T0CNTEN_sig : 	std_logic;
signal	T1RST_sig : 	std_logic;
signal	T0RST_sig : 	std_logic;

signal	T0CNT_sig : 		 	std_logic_vector(31 downto 0);

signal	T1CNT_sig : 		 	std_logic_vector(31 downto 0);	

signal	T0CMP_sig : 		 	std_logic_vector(31 downto 0);

signal	T1CMP_sig : 		 	std_logic_vector(31 downto 0);

signal	GP0_sig : 		 	std_logic_vector(31 downto 0);

signal	GP1_sig : 		 	std_logic_vector(31 downto 0);


begin


process(clk, rst, write_n, read_n)
begin
if clk'event and clk='1' then
if rst='1' then
-- Reset all registers
AVINTDIS_sig 	<=		'0';
T1INTOVR_sig 	<=		'0';
T1INTSTS_sig 	<=		'0';
T0INTSTS_sig 	<=		'0';
T1INTEN_sig 	<=		'0';
T0INTEN_sig 	<=		'0';
T1CNTEN_sig 	<=		'0';
T0CNTEN_sig 	<=		'0';
T1RST_sig 		<=		'0';
T0RST_sig 		<=		'0';
T0CNT_sig 		<=		(others	=> '0');
T1CNT_sig 		<=		(others	=> '0');
T0CMP_sig 		<=		(others	=> '0');	
T1CMP_sig 		<=		(others	=> '0');	
GP0_sig 			<=		(others	=> '0');	
GP1_sig 			<=		(others	=> '0');

else

if write_n='1' then
case address is
	when "0000" 	=>
		-- RW
		T0INTEN_sig <= writedata(0);
		T1INTEN_sig <= writedata(1);
		-- RW2C (TO DO!!!!)
		if (writedata(2) = '1') then
			T0INTSTS_sig <= '0';
		end if;
		if (writedata(3) = '1') then
			T1INTSTS_sig <= '0';
		end if;
		if (writedata(4) = '1') then
			T1INTOVR_sig <= '0';
		end if;
		-- RW
		AVINTDIS_sig <= writedata(5);
	when "0001" 	=>
		-- RW
		T0RST_sig <= writedata(0);
		T1RST_sig <= writedata(1);
		T0CNTEN_sig <= writedata(2);
		T1CNTEN_sig <= writedata(3);
	when "0010" 	=>	null;
	when "0011" 	=> null;	
	when "0100" 	=>
		-- RW
		T0CMP_sig <= writedata(31 downto 0);
	when "0101" 	=>
		-- RW
		T1CMP_sig <= writedata(31 downto 0);
	when "0110" 	=>
		-- RW
		GP0_sig	<= writedata(31 downto 0);
	when "0111" 	=>
		-- RW
		GP1_sig	<= writedata(31 downto 0);	
	when others	=> null;
end case;
end if;

if read_n = '1' then
case address is
	when "0000" 	=>
		-- RW
		readdata(0)		<= T0INTEN_sig;
		readdata(1)		<= T1INTEN_sig;
		-- RW2C (TO DO!!!!)
		readdata(2)	<= T0INTSTS_sig;
		readdata(3)	<= T1INTSTS_sig;
		readdata(4)	<= T1INTOVR_sig;
		-- RW
		readdata(5)	<=	AVINTDIS_sig;
	when "0001" 	=>
		-- RW
		readdata(0)	<=	T0RST_sig;
		readdata(1)	<=	T1RST_sig;
		readdata(2)	<=	T0CNTEN_sig;
		readdata(3)	<=	T1CNTEN_sig;
	when "0010" 	=>	null;
	when "0011" 	=> null;	
	when "0100" 	=>
		-- RW
		readdata(31 downto 0)	<=	T0CMP_sig;
	when "0101" 	=>
		-- RW
		readdata(31 downto 0)	<= T1CMP_sig;
	when "0110" 	=>
		-- RW
		readdata(31 downto 0)	<=	GP0_sig;
	when "0111" 	=>
		-- RW
		readdata(31 downto 0)	<=	GP1_sig;
	when others	=> null;
end case;
end if;

end if;
end if;
end process;

	-- Assignment the signals to the outputs
	AVINTDIS			<=	AVINTDIS_sig;
	T1INTOVR			<=	T1INTOVR_sig;
	T1INTSTS			<=	T1INTSTS_sig;
	T0INTSTS			<=	T0INTSTS_sig;
	T1INTEN 			<=	T1INTEN_sig;
	T0INTEN 			<=	T0INTEN_sig;	
	T1CNTEN			<= T1CNTEN_sig;
	T0CNTEN			<= T0CNTEN_sig;
	T1RST				<= T1RST_sig;
	T0RST				<= T0RST_sig;	
	T0CNT				<= T0CNT_sig;	
	T1CNT				<= T1CNT_sig;	
	T0CMP				<= T0CMP_sig;	
	T1CMP				<=	T1CMP_sig;	
	GP0				<= GP0_sig;	
	GP1				<= GP1_sig;
end arch;
	
	