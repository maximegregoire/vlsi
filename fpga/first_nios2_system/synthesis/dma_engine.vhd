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
    );

end dma_engine;

architecture functional of dma_engine is
  
  --signals
  signal data_sig : std_logic_vector(31 downto 0);
  signal read_address_sig	:	std_logic_vector(10 downto 0);
  signal address_sig : std_logic_vector(31 downto 0);
  signal readen_sig : std_logic;
  signal write_enable_sig : std_logic;
 
  byteenable <= "11";
  
  process (sclk, resetN, read_address)
  begin
  
  if resetN = '0' then
	readen_sig <= '0';
	address_sig <= (others => '0');
  elsif sclk'event and sclk = '1' then
  if waitrequest = '0' and DMAEN = '1' then
	read_address_sig <= read_address;
	if read_address_sig /= read_address then
		address_sig(10 downto 0) <= read_address;
		readen_sig <= '1';
	end if;
  end if;
  end if;
  
  end process;
  
  process (clk, resetN, readen)
  begin
	readdata_sig <= (others => '0');
	
	if resetN = '0' then
		data_sig <= (others => '0');;
	  elsif sclk'event and sclk = '1' then
	  if readen_sig = '1' and readdata_valid = '1' then
		data_sig(15 downto 0) <= readdata;
		readen_sig <= '0';
		write_enable_sig <= '1';
	  end if;
	  end if;
	
  end process;

  
  
end functional;
