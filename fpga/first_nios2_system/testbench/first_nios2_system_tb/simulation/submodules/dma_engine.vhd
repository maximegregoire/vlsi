-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Maxime Gregoire
-- Patrick White
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dma_engine is

  generic (
    size_in  : integer := 8;            -- from video decoder
    size_out : integer := 16;           -- to avalon switch (memory)
    addrsize : integer := 23            -- Memory address width
    );
  port (
    -- Avalon interface:
    resetN        	: in  std_logic;      -- asynch reset (active low)
    sclk          	: in  std_logic;      -- system clock
    readdata     	: in std_logic_vector(15 downto 0);
    waitrequest   	: in  std_logic;
    readen       	: out std_logic;
    byteenable    	: out std_logic_vector(1 downto 0);
    address       	: out std_logic_vector(31 downto 0);  -- SDRAM memory address
	readdata_valid 	: in std_logic;
	burstcount      : out std_logic_vector(7 downto 0);
    -- External registers
    DMAEN         	: in  std_logic;      -- enables dma engine to fetch line from memory
	DMALR         	: in  std_logic;      -- reverse the line
    DMAFSTART     	: in  std_logic_vector(22 downto 0); -- start address of the image to be read from mem
	DMALPITCH     	: in  std_logic_vector(22 downto 0); -- amount of bytes between two consecutive lines into mem
    DMAXSIZE     	: in  std_logic_vector(15 downto 0); -- amount of bytes per line
	-- Line Buffer
	data			: out 	std_logic_vector(31 downto 0);
	read_address	: in 	std_logic_vector(10 downto 0);
	write_address	: out 	std_logic_vector(10 downto 0);
	write_enable	: out 	std_logic;
	read_enable		: in	std_logic
    );
	end dma_engine;

architecture functional of dma_engine is
  
	--LINEBUF SIGNALS
	signal data_sig 			: std_logic_vector(31 downto 0);
	signal write_enable_sig 	: std_logic;
	signal write_address_sig 	: std_logic_vector(10 downto 0);
	
	-- AVALON SIGNALS
	signal address_sig 		: std_logic_vector(31 downto 0);
	signal readen_sig 		: std_logic;
	signal byteenable_sig		: std_logic_vector(1 downto 0);
	signal burstcount_sig 	: std_logic_vector(7 downto 0);
	
	-- STATE MACHINE SIGNALS
	signal readen_set 		: std_logic;
	signal read_enable_sig 	: std_logic;
	signal readen_rst 		: std_logic;
	signal address_set 		: std_logic;
	signal address_rst		: std_logic;
	
	signal readdata_valid_sig : std_logic;
	
	-- COUNTERS
	signal read_count : std_logic_vector(3 downto 0);
	signal readdata_valid_clk_count : std_logic_vector(9 downto 0);
	
	signal line_toggle : std_logic;
	
begin
 
  byteenable_sig <= "11";
  
  -- COUNTERS
  
	-- Count the number of clock pulses while data_valid is high
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   readdata_valid_clk_count <= (others => '0');
	   line_toggle = '0';
	elsif sclk'event and sclk ='1' then
		if readdata_valid_sig = '1' then
			readdata_valid_clk_count <= UNSIGNED(readdata_valid_clk_count) + 1;
		elsif readdata_valid_clk_count = "1011010000" then
			readdata_valid_clk_count <= (others => '0');
			
			if line_toggle = '0' then
				line_toggle = '1';
			elsif line_toggle = '1' then
				line_toggle = '0';
			end if;
			
		end if;
	end if;
	end process;
	
	-- Sets increment read count signal
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   read_count <= "0000";
	elsif sclk'event and sclk ='1' then
	case conv_integer(UNSIGNED(readdata_valid_clk_count)) is
		when 0 to 127 => read_count <= "0000";
		when 128 to 255 => read_count <= "0001";
		when 256 to 383 => read_count <= "0010";
		when 384 to 511 => read_count <= "0011";
		when 512 to 639 => read_count <= "0100";
		when 640 to 720 => read_count <= "0101";
		when others => read_count <= "0000";
	end case;
	end if;
	end process;
	
	-- Register readdata_valid_sig
	process(sclk, resetN)
	begin
	if resetN = '0' then
		readdata_valid_sig <= '0';
	elsif sclk'event and sclk ='1' then
		readdata_valid_sig <= readdata_valid;
	end if;
	end process;
	
	-- Resets read_count and sets burstcount signal
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   burstcount_sig <= "10000000";
	elsif sclk'event and sclk ='1' then
	if read_count = "0101" then 
	   burstcount_sig <= "01010000";
	else
		burstcount_sig <= "10000000";
	end if;
	end if;
	end process;
	
  -- READEN_SET and ADDRESS_SET process
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   readen_set <= '0';
	elsif sclk'event and sclk ='1' then
		read_enable_sig <= read_enable;
	if read_enable = '1' and read_enable_sig = '0' then -- rising edge detection
	   readen_set <= '1';
	   address_set <= '1';
	else
	   readen_set <= '0';
	   address_set <= '0';
	end if;
	end if;
	end process;
	
	-- READEN_RST and ADDRESS_RST process
	process(sclk, resetN, readen_sig, readen_rst)
	begin
	if resetN = '0' then
	   readen_rst <= '0';
	   address_rst <= '0';
	elsif sclk'event and sclk ='1' then
		readen_rst <= '0';	
		address_rst <= '0';
		if waitrequest = '0' and readen_sig = '1' then
			readen_rst <= '1';
			address_rst <= '1';
		end if;	
	end if;
	end process;

	-- SET THE ADDRESS OF THE NEXT BURST
	process(sclk, resetN, readen_rst)
	begin
	if resetN = '0' then
	   readen_sig <= '0';
	   address_sig <= (others => '0');
	elsif sclk'event and sclk='1' then
		readen_sig <= readen_sig;
		address_sig <= address_sig;
	if readen_set = '1' then--and DMAEN = '1' then
	   readen_sig <= '1';
	elsif readen_rst = '1' then -- handled by write to clear
	   readen_sig <= '0';
	end if;
	if address_set = '1' then
		address_sig(23) <= '1';
		address_sig(10 downto 0) <= read_address(10 downto 0);
	elsif address_rst <= '1' then
		address_sig(23) <= '1';
		address_sig(10 downto 0) <= (others => '0');
	end if;
	end if;
	end process;
  
  process (sclk, resetN, read_address, read_enable)
  begin
	  if resetN = '0' then
	  elsif sclk'event and sclk = '1' then
		if DMAEN = '1' then -- and waitrequest = '0' 
		end if;
	  end if;
  end process;
  
  process (sclk, resetN, readen_sig, readdata_valid)
  begin
	if resetN = '0' then
		data_sig <= (others => '0');
		write_enable_sig <= '0';
		write_address_sig <= (others => '0');
	elsif sclk'event and sclk = '1' then
			write_enable_sig <= '0';
		  if readdata_valid = '1' then
			write_address_sig  <= address_sig(10 downto 0);
			data_sig(31 downto 16) <= readdata;
			write_enable_sig <= '1';
		  end if;
	end if;
  end process;
  
	--PUSH SIGNALS TO OUTPUT
	data <= data_sig;
	address <= address_sig;
	readen <= readen_sig;
	write_enable <= write_enable_sig;
	write_address(10) <= toggle_line;
	write_address(9 downto 0) <= readdata_valid_clk_count;
	byteenable <= byteenable_sig;
	burstcount <= burstcount_sig;

end functional;
