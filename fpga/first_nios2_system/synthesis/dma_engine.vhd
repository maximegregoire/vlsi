-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Maxime Gregoire
-- Patrick White
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dma_engine is

  generic (
    size_in  : integer := 8;            -- from video decoder
    size_out : integer := 16;           -- to avalon switch (memory)
    addrsize : integer := 23            -- Memory address width
    );
  port (
    -- Avalon interface:
    resetN        : in  std_logic;      -- asynch reset (active low)
    sclk          : in  std_logic;      -- system clock
    readdata     : in std_logic_vector(15 downto 0);
    waitrequest   : in  std_logic;
    readen       : out std_logic;
    byteenable    : out std_logic_vector(1 downto 0);
    address       : out std_logic_vector(31 downto 0);  -- SDRAM memory address
	readdata_valid : in std_logic;
    -- External registers
    DMAEN         : in  std_logic;      -- enables dma engine to fetch line from memory
	DMALR         : in  std_logic;      -- reverse the line
    DMAFSTART     : in  std_logic_vector(22 downto 0); -- start address of the image to be read from mem
	DMALPITCH     : in  std_logic_vector(22 downto 0); -- amount of bytes between two consecutive lines into mem
    DMAXSIZE     : in  std_logic_vector(22 downto 0); -- amount of bytes per line
	-- Line Buffer
	data			: out 	std_logic_vector(31 downto 0);
	read_address	: in 	std_logic_vector(10 downto 0);
	write_address	: out 	std_logic_vector(10 downto 0);
	write_enable	: out 	std_logic;
	read_enable		: in	std_logic;
    );

end dma_engine;

architecture functional of dma_engine is
  
  --signals
  signal data_sig : std_logic_vector(31 downto 0);
  signal address_sig : std_logic_vector(31 downto 0);
  signal readen_sig : std_logic;
  signal write_enable_sig : std_logic;
  signal write_address_sig : std_logic_vector(10 downto 0);
 
  byteenable <= "11";
  
  process (sclk, resetN, read_address, read_enable)
  begin
  if resetN = '0' then
	readen_sig <= '0';
	address_sig <= (others => '0');
  elsif sclk'event and sclk = '1' then
  if waitrequest = '0' and DMAEN = '1' and read_enable = '1' then
	address_sig(31 downto 10) <= DMAFSTART(22 downto 1);
	address_sig(9 downto 0) <= read_address(9 downto 0);
	readen_sig <= '1';
  end if;
  end if;
  end process;
  
  process (clk, resetN, readen_sig, readdata_valid)
  begin
	readdata_sig <= (others => '0');
	if resetN = '0' then
		data_sig <= (others => '0');;
	  elsif sclk'event and sclk = '1' then
	  if readen_sig = '1' and readdata_valid = '1' then
		write_address_sig  <= address_sig(10 downto 0);
		data_sig(15 downto 0) <= readdata;
		readen_sig <= '0';
		write_enable_sig <= '1';
	  end if;
	  end if;
  end process;
  
	--PUSH SIGNALS TO OUTPUT
	data <= data_sig;
	address <= address_sig;
	readen <= readen_sig;
	write_enable <= write_enable_sig;
	write_address <= write_address_sig;

end functional;
