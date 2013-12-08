-------------------------------------------------------------------------------
-- ECSE 431, McGill University
-- Team:
-- Maxime Gregoire
-- Patrick White
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	SOL_in			: in 	std_logic;
	SOF_in			: in 	std_logic;
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
	
	signal start_address		: std_logic_vector(22 downto 0);
	
	signal readen_sig 		: std_logic;
	signal byteenable_sig		: std_logic_vector(1 downto 0);
	signal burstcount_sig 	: std_logic_vector(7 downto 0):= "01111000";
	
	-- STATE MACHINE SIGNALS
	signal read_enable_sig 	: std_logic;
	
	signal readdata_valid_sig : std_logic;
	
	signal SOL				: std_logic;
	signal SOF 				: std_logic;
	
	-- COUNTERS
	signal line_count : unsigned(9 downto 0);
	
	signal read_count : std_logic_vector(3 downto 0);
	signal read_count_1p : std_logic_vector(3 downto 0);
	
	signal readdata_valid_clk_count : unsigned(9 downto 0);--std_logic_vector(9 downto 0);
	
	signal toggle_line : std_logic;
	signal toggle_line_1p : std_logic;
	
	signal SOL_1p	: std_logic;
	signal SOL_2p	: std_logic;
	signal SOL_2p_set : std_logic;
	
	signal SOF_1p	: std_logic;
	signal SOF_2p	: std_logic;	
	signal SOF_2p_set : std_logic;
	
	signal SOL_final	: std_logic;
	signal SOF_final	: std_logic;	
	
	signal first_line	: std_logic;
	signal first_line_rst	: std_logic;
	signal first_line_edge : std_logic;
	
	signal first_frame	: std_logic;
	signal first_frame_rst	: std_logic;
	signal first_frame_edge : std_logic;
	
	signal set_readen : std_logic;
	
	signal increment_address : std_logic;
	
	signal DMAFSTART_sig_1p : std_logic_vector(22 downto 0);
	
begin
 
  byteenable_sig <= "11";
  
  -- COUNTERS
  
	-- Count the number of clock pulses while data_valid is high
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   readdata_valid_clk_count <= (others => '0');
	   toggle_line <= '0';
	elsif sclk'event and sclk ='1' then
		if readdata_valid_sig = '1' then
			readdata_valid_clk_count <= readdata_valid_clk_count + 1;
		elsif readdata_valid_clk_count = "1011010000" then
			readdata_valid_clk_count <= (others => '0');
			
			if toggle_line = '0' then
				toggle_line <= '1';
			elsif toggle_line = '1' then
				toggle_line <= '0';
			end if;
			
		end if;
	end if;
	end process;
	
	-- Sets increment read count signal
	-- process(sclk, resetN)
	-- begin
	-- if resetN = '0' then
	   -- read_count <= "0000";
	-- elsif sclk'event and sclk ='1' then
	-- case to_integer(readdata_valid_clk_count) is
		-- when 0 to 127 => read_count <= 		"0000";
		-- when 128 to 255 => read_count <= 	"0001";
		-- when 256 to 383 => read_count <= 	"0010";
		-- when 384 to 511 => read_count <= 	"0011";
		-- when 512 to 639 => read_count <= 	"0100";
		-- when 640 to 720 => read_count <= 	"0101";
		-- when others 	=> read_count <= 	"0000";
	-- end case;
	-- end if;
	-- end process;
	
	
	-- Sets increment read count signal
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   read_count <= "0000";
	elsif sclk'event and sclk ='1' then
	case to_integer(readdata_valid_clk_count) is
		when 0 to 119 => read_count <= 		"0000";
		when 120 to 239 => read_count <= 	"0001";
		when 240 to 359 => read_count <= 	"0010";
		when 360 to 479 => read_count <= 	"0011";
		when 480 to 599 => read_count <= 	"0100";
		when 600 to 720 => read_count <= 	"0101";
		when others 	=> read_count <= 	"0000";
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

  -- Set the data to be writen to the line buffer and sets a writeen
  process (sclk, resetN)
  begin
	if resetN = '0' then
		data_sig <= (others => '0');
		write_enable_sig <= '0';
	elsif sclk'event and sclk = '1' then
			data_sig(15 downto 0) <= (others => '0');
			write_enable_sig <= '0';
		  if readdata_valid = '1' then
			data_sig(31 downto 16) <= readdata;
			write_enable_sig <= '1';
		  end if;
	end if;
  end process;
  
	-- Pipeline SOL_1p
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOL_1p <= '0';
		elsif sclk = '1' and sclk'event then
			SOL_1p <= SOL;
		end if;
	end process;

	-- SET SOL_2p
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOL_2p <= '0';
		elsif sclk = '1' and sclk'event then
			SOL_2p <= SOL_1p;
			SOL_2p_set <= '0';
			if SOL_2p = '0' and SOL_1p = '1' then	-- Rising edge detection
				SOL_2p_set <= '1';
			end if;
		end if;
	end process;

	-- SET SOL_FINAL (SOL we use)
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOL_final <= '0';
		elsif sclk = '1' and sclk'event then
			SOL_final <= '0';	
			if SOL_2p_set = '1' then
				SOL_final <= '1';
			end if;
		end if;
	end process;


  -- Pipeline SOF_1p
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOF_1p <= '0';
		elsif sclk = '1' and sclk'event then
			SOF_1p <= SOF;
		end if;
	end process;

	  -- SET SOL_2p
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOF_2p <= '0';
		elsif sclk = '1' and sclk'event then
			SOF_2p <= SOF_1p;
			SOF_2p_set <= '0';
			if SOF_2p = '0' and SOF_1p = '1' then	-- Rising edge detection
				SOF_2p_set <= '1';
			end if;
		end if;
	end process;

	-- SET SOF_FINAL (SOF we use)
	process (sclk, resetN)
	begin
		if resetN = '0' then
			SOF_final <= '0';
		elsif sclk = '1' and sclk'event then
			SOF_final <= '0';	
			if SOF_2p_set = '1' then
				SOF_final <= '1';
			end if;
		end if;
	end process;


	-- SET THE ADDRESS OF THE NEXT BURST
	process(sclk, resetN)
	begin
	if resetN = '0' then
	   readen_sig <= '0';
	   address_sig(22 downto 0) <= (others => '0');
	   address_sig(31 downto 23) <= "000000001";
	   start_address <= (others => '0');
	   first_line_rst <= '0';
	   first_frame_rst <= '0';
	   line_count <= (others => '0');
	   DMAFSTART_sig_1p <= (others => '0');
	elsif sclk'event and sclk='1' then
	    first_line_rst <= '0';
		first_frame_rst <= '0';
		
		
	if SOL_final = '1' and line_count /= "0000000100" then
		readen_sig <= '1';
		line_count <= line_count + 1;
	elsif SOL_final = '1' and line_count = "0000000100" then
		line_count <= (others => '0');
	elsif SOF_final = '1' then
		readen_sig <= '1';
		line_count <= line_count + 1;
	elsif set_readen = '1' then
		readen_sig <= '1';
	end if;
	
	if readen_sig = '1' and waitrequest = '0' then
		readen_sig <= '0';
	end if;
	
	DMAFSTART_sig_1p <= DMAFSTART;
	if DMAFSTART_sig_1p /= DMAFSTART then
		address_sig(22 downto 0) <= DMAFSTART;
	end if;
	
	if SOF_final = '1' and first_frame = '1' then
		first_frame_rst <= '1';
	elsif SOL_final = '1' and first_line = '1' then
		first_line_rst <= '1';
		start_address <= address_sig(22 downto 0);
	elsif SOL_final = '1' and line_count /= "0000000100" then
		address_sig (22 downto 0) <= std_logic_vector(resize((UNSIGNED(DMALPITCH)*(line_count - 1)), 23) + UNSIGNED(start_address));
	elsif increment_address = '1' then
		address_sig (22 downto 0) <= std_logic_vector(UNSIGNED(address_sig(22 downto 0)) + 240);
	end if;
	
	end if;
	end process;
	
	-- Makes sure the first line does no increment the address
	process(sclk, resetN)
	begin
	if resetN = '0' then
		first_line <= '0';
		first_line_edge <= '0';
	elsif sclk = '1' and sclk'event then
		first_line_edge <= SOF_final;
		if first_line_edge = '0' and SOF_final = '1' then
			first_line <= '1';
		elsif first_line_rst = '1' then
			first_line <= '0';
		end if;
	end if;
	end process;
	
	
	-- Makes sure the frame start doesn't increment all the time
	process(sclk, resetN)
	begin
	if resetN = '0' then
		first_frame <= '0';
		first_frame_edge <= '0';
	elsif sclk = '1' and sclk'event then
		first_frame_edge <= SOF_final;
		if first_frame_edge = '0' and SOF_final = '1' then
			first_frame <= '1';
		elsif first_frame_rst = '1' then
			first_frame <= '0';
		end if;
	end if;
	end process;
	
	
	-- Set intermediate readen that are not at the beginning of a line
	process(sclk, resetN)
	begin
	if resetN = '0' then
		set_readen <= '0';
		increment_address <= '0';
		read_count_1p <= (others => '0');
	elsif sclk = '1' and sclk'event then
		set_readen <= '0';
		increment_address <= '0';
		read_count_1p <= read_count;
		-- Register edges of read_count
		if read_count_1p /= read_count then--and read_count /= "0000" then
			increment_address <= '1';
		if read_count /= "0000" then
			set_readen <= '1';
		end if;
		end if;
	end if;
	end process;
	
  
	--PUSH SIGNALS TO OUTPUT
	SOF <= SOF_in;
	SOL <= SOL_in;
	
	data <= data_sig;
	address <= address_sig;
	readen <= readen_sig;
	write_enable <= write_enable_sig;
	write_address(10) <= toggle_line;
	write_address(9 downto 0) <= std_logic_vector(readdata_valid_clk_count);
	byteenable <= byteenable_sig;
	burstcount <= burstcount_sig;

end functional;
