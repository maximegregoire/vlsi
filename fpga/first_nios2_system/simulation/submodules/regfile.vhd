-- ================================================================================
-- Register File -- Altera DE2 Board
-- ================================================================================
-- Authors : Maxime GrÃ©goire, Patrick White
-- Last modified: 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;

entity regfile is
port (	
	-- Avalon Interface
	address 		: in std_logic_vector(3 downto 0);
	readdata 		: out std_logic_vector(31 downto 0);
	write_n 		: in std_logic;
	writedata 		: in std_logic_vector(31 downto 0);
	rst 			: in std_logic;
	clk 			: in std_logic;
	
	avalon_int		: out std_logic;
	
	T0INT_set	: in std_logic;
	T1INT_set	: in std_logic;
	
	T0CNT_in 		: 	in std_logic_vector(31 downto 0);	
	T1CNT_in 		: 	in std_logic_vector(31 downto 0);
	
	-- Registers
	AVINTDIS 	: 	out std_logic;
	T1INTOVR 	: 	out std_logic;
	T1INTSTS 	: 	out std_logic;
	T0INTSTS 	: 	out std_logic;
	T1INTEN 		: 	out std_logic;
	T0INTEN 		: 	out std_logic;	
	T1CNTEN 		: 	out std_logic;
	T0CNTEN 		: 	out std_logic;
	T1RST 		: 	out std_logic;
	T0RST 		: 	out std_logic;	
	T0CNT 		: 	out std_logic_vector(31 downto 0);	
	T1CNT 		: 	out std_logic_vector(31 downto 0);	
	T0CMP 		: 	out std_logic_vector(31 downto 0);	
	T1CMP 		: 	out std_logic_vector(31 downto 0);	
	GP0 			: 	out std_logic_vector(31 downto 0);	
	GP1 			: 	out std_logic_vector(31 downto 0);
	avalon_inten 	: in std_logic
	  );
end entity regfile;

architecture arch of regfile is

signal	AVINTDIS_sig 	: 	std_logic;
signal	T1INTOVR_sig 	: 	std_logic;
signal	T1INTSTS_sig 	: 	std_logic;
signal	T0INTSTS_sig 	: 	std_logic;
signal	T1INTEN_sig 	: 	std_logic;
signal	T0INTEN_sig 	: 	std_logic;
signal	T1CNTEN_sig 	: 	std_logic;
signal	T0CNTEN_sig 	: 	std_logic;
signal	T1RST_sig 		: 	std_logic;
signal	T0RST_sig 		: 	std_logic;	
signal	T0CNT_sig 		: 	std_logic_vector(31 downto 0);
signal	T1CNT_sig 		: 	std_logic_vector(31 downto 0);
signal	T0CMP_sig 		: 	std_logic_vector(31 downto 0);
signal	T1CMP_sig 		: 	std_logic_vector(31 downto 0);
signal	GP0_sig 		: 	std_logic_vector(31 downto 0);
signal	GP1_sig 		: 	std_logic_vector(31 downto 0);

begin
process(clk)
begin
if clk'event and clk='1' then
-- RESET PROCEDURE
if rst='1' then
AVINTDIS_sig 	<=		NOT(avalon_inten);
T1INTOVR_sig 	<=		'0';
T1INTSTS_sig 	<=		'0';
T0INTSTS_sig 	<=		'0';
T1INTEN_sig 	<=		'0';
T0INTEN_sig 	<=		'0';
T1CNTEN_sig 	<=		'0';
T0CNTEN_sig 	<=		'0';
T1RST_sig 		<=		'0';
T0RST_sig 		<=		'0';
T0CMP_sig 		<=		(others	=> '0');	
T1CMP_sig 		<=		(others	=> '0');	
GP0_sig 		<=		(others	=> '0');	
GP1_sig 		<=		(others	=> '0');

-- READ AND WRITE PROCEDURE --
else
-- If not in reset, force counters count onto count signal

-- WRITE PROCEDURE --
if write_n='0' then
case address is
	when "0000" 	=>
		-- RW
		T0INTEN_sig <= writedata(0);
		T1INTEN_sig <= writedata(1);
		-- RW2C
		if (writedata(2) = '1' AND T0INT_set = '0') then
			T0INTSTS_sig <= '0';
		end if;
		if (writedata(3) = '1' AND T1INT_set = '0') then
			T1INTSTS_sig <= '0';
		end if;
		if (writedata(4) = '1' AND T1INTOVR_sig = '1') then
			T1INTOVR_sig <= '0';
		end if;
		-- RW
		AVINTDIS_sig <= NOT(avalon_inten);
	when "0001" 	=>
		-- RW
		T0RST_sig 	<= writedata(0);
		T1RST_sig 	<= writedata(1);
		T0CNTEN_sig <= writedata(2);
		T1CNTEN_sig <= writedata(3);
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

-- Counters Count Register --
-- Reset the counter if certain registers are set
if (T0RST_sig = '1') then
T0CNT_sig <= (others => '0');
else
T0CNT_sig <= T0CNT_in;
end if;

if (T1RST_sig = '1') then
T1CNT_sig <= (others => '0');
else
T1CNT_sig <= T1CNT_in;
end if;
-- End of Counters --

-- Interupts Registers --
if (T0INT_set = '1' AND T0INTEN_sig = '1') then
	T0INTSTS_sig <= '1';
end if;
if (T1INT_set = '1' AND T1INTEN_sig = '1') then
	if (T1INTSTS_sig = '1') then 	-- First interupt not yet handled, causes overun
		T1INTOVR_sig <= '1';
	else									-- Interupt is clear, set INTSTS for CNT 1
		T1INTSTS_sig <= '1';
	end if;
end if;
-- End of Interupts --

end if;
end if;
end process;

process(T0INTEN_sig, T1INTEN_sig, T0INTSTS_sig, T1INTSTS_sig, T1INTOVR_sig, avalon_inten, T0RST_sig, T1RST_sig, T0CNTEN_sig, T1CNTEN_sig,
T0CMP_sig, T1CMP_sig, GP0_sig, GP1_sig, T0CNT_sig, T1CNT_sig, address)
begin
-- Drive default value to readData output --
	readdata <= (others	=> '0');
	case address is
		when "0000" 	=>
			-- RW
			readdata(0)	<= T0INTEN_sig;
			readdata(1)	<= T1INTEN_sig;
			-- RW2C (TO DO!!!!)
			readdata(2)	<= T0INTSTS_sig;
			readdata(3)	<= T1INTSTS_sig;
			readdata(4)	<= T1INTOVR_sig;
			-- RW
			readdata(5)	<=	NOT(avalon_inten);
		when "0001" 	=>
			-- RW
			readdata(0)	<=	T0RST_sig;
			readdata(1)	<=	T1RST_sig;
			readdata(2)	<=	T0CNTEN_sig;
			readdata(3)	<=	T1CNTEN_sig;
		when "0010" 	=>	
			readdata		<= T0CNT_sig;
		when "0011" 	=> 
			readdata		<= T1CNT_sig;
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
		when others	=> 
		end case;
end process;
	
process(T0INTSTS_sig, T1INTSTS_sig, avalon_inten)
	begin
	avalon_int <= (T0INTSTS_sig OR T1INTSTS_sig) AND avalon_inten;
end process;

	-- Assignment the signals to the outputs
	AVINTDIS		<=	NOT(avalon_inten);
	T1INTOVR		<=	T1INTOVR_sig;
	T1INTSTS		<=	T1INTSTS_sig;
	T0INTSTS		<=	T0INTSTS_sig;
	T1INTEN 		<=	T1INTEN_sig;
	T0INTEN 		<=	T0INTEN_sig;	
	T1CNTEN			<= T1CNTEN_sig;
	T0CNTEN			<= T0CNTEN_sig;
	T1RST			<= T1RST_sig;
	T0RST			<= T0RST_sig;	
	T0CMP			<= T0CMP_sig;	
	T1CMP			<=	T1CMP_sig;	
	
	T0CNT			<= T0CNT_sig;
	T1CNT			<= T1CNT_sig;
	
	GP0				<= GP0_sig;	
	GP1				<= GP1_sig;
end arch;
	
	