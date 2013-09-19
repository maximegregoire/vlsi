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
	
	address : in std_logic_vector(31 downto 0);
	read_n : in std_logic;
	readdata : out std_logic_vector(31 downto 0);
	write_n : in std_logic;
	writedata : in std_logic_vector(31 downto 0);
	rst : in std_logic;
	clk : in std_logic;
	
	
	AVINTDIS : 	inout std_logic;
	T1INTOVR : 	inout std_logic;
	T1INTSTS : 	inout std_logic;
	T0INTSTS : 	inout std_logic;
	T1INTEN : 	inout std_logic;
	T0INTEN : 	inout std_logic;
	
	T1CNTEN : 	inout std_logic;
	T0CNTEN : 	inout std_logic;
	T1RST : 		inout std_logic;
	T0RST : 		inout std_logic;
	
	T0CNT : inout std_logic_vector(31 downto 0);
	
	T1CNT : inout std_logic_vector(31 downto 0);
	
	T0CMP : inout std_logic_vector(31 downto 0);
	
	T1CMP : inout std_logic_vector(31 downto 0);
	
	GP0 : inout std_logic_vector(31 downto 0);
	
	GP1 : inout std_logic_vector(31 downto 0)
	
	  );
end entity regfile;

architecture arch of regfile is
begin



process(clk, rst)
begin

case address is
	when x"0" => 
		if rst='1' then 
			AVINTDIS <= '0';
			T1INTOVR <= '0';
			T1INTSTS <= '0';
			T0INTSTS <= '0';
			T1INTEN <= '0';
			T0INTEN <= '0';
		elsif clk'event and clk = '1' then
			if write_n = '1' then
				AVINTDIS <= writedata(5);
				if writedata(4) = '1' then
					T1INTOVR <= '0';
				end if;
				if writedata(3) = '1' then
					T1INTSTS <= '0';
				end if;
				if writedata(2) = '1' then
					T0INTSTS <= '0';
				end if;
				T1INTEN <= writedata(1);
				T0INTEN <= writedata(0);
			elsif read_n = '1' then
				readdata(5) <= AVINTDIS;
				readdata(4) <= T1INTOVR;
				readdata(3) <= T1INTSTS;
				readdata(2) <= T0INTSTS;
				readdata(1) <= T1INTEN;
				readdata(0) <= T0INTEN;
			end if;
		end if;
	when x"4" =>
		if rst='1' then 
			T1CNTEN <= '0';
			T0CNTEN <= '0';
			T1RST <= '0';
			T0RST <= '0';
		elsif clk'event and clk = '1' then
			if write_n = '1' then
				T1CNTEN <= writedata(3);
				T0CNTEN <= writedata(2);
				T1RST <= writedata(1);
				T0RST <= writedata(0);
			elsif read_n = '1' then
				readdata(3) <= T1CNTEN;
				readdata(2) <= T0CNTEN;
				readdata(1) <= T1RST;
				readdata(0) <= T0RST;
			end if;
		end if;
	when x"8" =>
		if rst='1' then
			T0CNT <= to_stdlogicvector(x"0");
		elsif clk'event and clk = '1' then
			if read_n = '1' then
				readdata(31 downto 0) <= T0CNT;
			end if;
		end if;
	when x"C" =>
		if rst='1' then
			T1CNT <= to_stdlogicvector(x"0");
		elsif clk'event and clk = '1' then
			if read_n = '1' then
				readdata <= T1CNT;
			end if;
		end if;
	when x"10" =>
		if rst = '1' then
			T0CMP <= to_stdlogicvector(x"0");
		elsif clk'event and clk='1' then
			if write_n = '1' then
				T0CMP <= writedata;
			elsif read_n = '1' then
				readdata <= T0CMP;
			end if;
		end if;
	when x"14" =>
		if rst = '1' then
			T1CMP <= to_stdlogicvector(x"0");
		elsif clk'event and clk='1' then
			if write_n = '1' then
				T1CMP <= writedata;
			elsif read_n = '1' then
				readdata <= T1CMP;
			end if;
		end if;
	when x"18" =>
		if rst = '1' then
			GP0 <= to_stdlogicvector(x"0");
		elsif clk'event and clk='1' then
			if write_n = '1' then
				GP0 <= writedata;
			elsif read_n = '1' then
				readdata <= GP0;
			end if;
		end if;
	when x"18" =>
		if rst = '1' then
			GP1 <= to_stdlogicvector(x"0");
		elsif clk'event and clk='1' then
			if write_n = '1' then
				GP1 <= writedata;
			elsif read_n = '1' then
				readdata <= GP1;
			end if;
		end if;
	end case;
			


end process;

end arch;
	
	