-- ================================================================================
-- Top Level entity -- Altera DE2 Board
-- ================================================================================
-- Authors : Jean-Samuel Chenard, Andrew Wong, Francois Leduc-Primeau
-- Based on the DE2_TOP.v file by Terasic (V1.2).  Translation to VHDL.
-- Pin names kept the same
-- Last modified: Francois Leduc-Primeau 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_arith.all;
use	  work.sdrampack.all;
        
entity DE2_TOP is
port (
    -- ====== Clock Inputs ===============
    CLOCK_27  : in std_logic; --  27 MHz
    CLOCK_50  : in std_logic; --  50 MHz
    EXT_CLOCK : in std_logic; --  External Clock
    --------------------  Push Button   --------------------
    KEY       : in std_logic_vector(3 downto 0);  -- Pushbutton[3:0]
    --------------------  DPDT Switch   --------------------
    SW        : in std_logic_vector(17 downto 0); --  Toggle Switch[17:0]
    --------------------  7-SEG Dispaly --------------------
    HEX0      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 0
    HEX1      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 1
    HEX2      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 2
    HEX3      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 3
    HEX4      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 4
    HEX5      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 5
    HEX6      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 6
    HEX7      : out std_logic_vector(6 downto 0);     --  Seven Segment Digit 7
    ------------------------  LED   ------------------------
    LEDG      : out std_logic_vector(8 downto 0);     --  LED Green[8:0]
    LEDR      : out std_logic_vector(17 downto 0);    --  LED Red[17:0]
    ------------------------  UART  ------------------------
    UART_TXD  : out std_logic;      --  UART Transmitter
    UART_RXD  : in std_logic;     --  UART Receiver
    ------------------------  IRDA  ------------------------
    IRDA_TXD  : out std_logic;      --  IRDA Transmitter
    IRDA_RXD  : in std_logic;     --  IRDA Receiver
    --------------------/ SDRAM Interface   ----------------
    DRAM_DQ   : inout std_logic_vector(15 downto 0); -- SDRAM Data bus 16 Bits
    DRAM_ADDR : out std_logic_vector(11 downto 0);   -- SDRAM Address bus 12 Bits
    DRAM_LDQM : out std_logic;        --  SDRAM Low-byte Data Mask 
    DRAM_UDQM : out std_logic;        --  SDRAM High-byte Data Mask
    DRAM_WE_N : out std_logic;        --  SDRAM Write Enable
    DRAM_CAS_N: out std_logic;        --  SDRAM Column Address Strobe
    DRAM_RAS_N: out std_logic;        --  SDRAM Row Address Strobe
    DRAM_CS_N : out std_logic;        --  SDRAM Chip Select
    DRAM_BA_0 : out std_logic;        --  SDRAM Bank Address 0
    DRAM_BA_1 : out std_logic;        --  SDRAM Bank Address 0
    DRAM_CLK  : out std_logic;        --  SDRAM Clock
    DRAM_CKE  : out std_logic;        --  SDRAM Clock Enable
    --------------------  Flash Interface   ----------------
    FL_DQ     : inout std_logic_vector( 7 downto 0);  --  FLASH Data bus 8 Bits
    FL_ADDR   : out std_logic_vector(21 downto 0);    --  FLASH Address bus 22 Bits
    FL_WE_N   : out std_logic;        --  FLASH Write Enable
    FL_RST_N  : out std_logic;        --  FLASH Reset
    FL_OE_N   : out std_logic;        --  FLASH Output Enable
    FL_CE_N   : out std_logic;        --  FLASH Chip Enable
    --------------------  SRAM Interface    ----------------
    SRAM_DQ    : inout std_logic_vector(15 downto 0); --  SRAM Data bus 16 Bits
    SRAM_ADDR  : out std_logic_vector(17 downto 0);   --  SRAM Address bus 18 Bits
    SRAM_UB_N  : out std_logic;       --  SRAM High-byte Data Mask 
    SRAM_LB_N  : out std_logic;       --  SRAM Low-byte Data Mask 
    SRAM_WE_N  : out std_logic;       --  SRAM Write Enable
    SRAM_CE_N  : out std_logic;       --  SRAM Chip Enable
    SRAM_OE_N  : out std_logic;       --  SRAM Output Enable
    --------------------  ISP1362 Interface ----------------
    OTG_DATA    : inout std_logic_vector(15 downto 0);  --  ISP1362 Data bus 16 Bits
    OTG_ADDR    : out std_logic_vector(1 downto 0);     --  ISP1362 Address 2 Bits
    OTG_CS_N    : out std_logic;  --  ISP1362 Chip Select
    OTG_RD_N    : out std_logic;  --  ISP1362 Write
    OTG_WR_N    : out std_logic;  --  ISP1362 Read
    OTG_RST_N   : out std_logic;  --  ISP1362 Reset
    OTG_FSPEED  : out std_logic;  --  USB Full Speed, 0 = Enable, Z = Disable
    OTG_LSPEED  : out std_logic;  --  USB Low Speed , 0 = Enable, Z = Disable
    OTG_INT0    : in std_logic;   --  ISP1362 Interrupt 0
    OTG_INT1    : in std_logic;   --  ISP1362 Interrupt 1
    OTG_DREQ0   : in std_logic;   --  ISP1362 DMA Request 0
    OTG_DREQ1   : in std_logic;   --  ISP1362 DMA Request 1
    OTG_DACK0_N : out std_logic;  --  ISP1362 DMA Acknowledge 0
    OTG_DACK1_N : out std_logic;  --  ISP1362 DMA Acknowledge 1
    --------------------  LCD Module 16X2   ----------------
    LCD_ON    : out std_logic;  --  LCD Power ON/OFF
    LCD_BLON  : out std_logic;  --  LCD Back Light ON/OFF
    LCD_RW    : out std_logic;  --  LCD Read/Write Select, 0 = Write, 1 = Read
    LCD_EN    : out std_logic;  --  LCD Enable
    LCD_RS    : out std_logic;  --  LCD Command/Data Select, 0 = Command, 1 = Data
    LCD_DATA  : inout std_logic_vector( 7 downto 0);  --  LCD Data bus 8 bits
    --------------------  SD_Card Interface ----------------
    SD_DAT    : inout std_logic;  --  SD Card Data
    SD_DAT3   : inout std_logic;  --  SD Card Data 3
    SD_CMD    : inout std_logic;  --  SD Card Command Signal
    SD_CLK    : out std_logic;    --  SD Card Clock
    --------------------  USB JTAG link --------------------
    TDI       : in std_logic;     -- CPLD -> FPGA (data in)
    TCK       : in std_logic;     -- CPLD -> FPGA (clk)
    TCS       : in std_logic;     -- CPLD -> FPGA (CS)
    TDO       : out std_logic;    -- FPGA -> CPLD (data out)
    --------------------  I2C   ----------------------------
    I2C_SDAT  : inout std_logic;  --  I2C Data
    I2C_SCLK  : out std_logic;    --  I2C Clock
    --------------------  PS2   ----------------------------
    PS2_DAT   : in std_logic;     --  PS2 Data
    PS2_CLK   : in std_logic;     --  PS2 Clock
    --------------------  VGA   ----------------------------
    VGA_CLK   : out std_logic;    --  VGA Clock
    VGA_HS    : out std_logic;    --  VGA H_SYNC
    VGA_VS    : out std_logic;    --  VGA V_SYNC
    VGA_BLANK : out std_logic;    --  VGA BLANK
    VGA_SYNC  : out std_logic;    --  VGA SYNC
    VGA_R     : out std_logic_vector(9 downto 0);    --  VGA Red[9:0]
    VGA_G     : out std_logic_vector(9 downto 0);    --  VGA Green[9:0]
    VGA_B     : out std_logic_vector(9 downto 0);    --  VGA Blue[9:0]
    ------------  Ethernet Interface  ------------------------
    ENET_DATA : inout std_logic_vector(15 downto 0); --  DM9000A DATA bus 16Bits
    ENET_CMD  : out std_logic;    --  DM9000A Command/Data Select, 0 = Command , 1 = Data
    ENET_CS_N : out std_logic;    --  DM9000A Chip Select
    ENET_WR_N : out std_logic;    --  DM9000A Write
    ENET_RD_N : out std_logic;    --  DM9000A Read
    ENET_RST_N: out std_logic;    --  DM9000A Reset
    ENET_INT  : in  std_logic;    --  DM9000A Interrupt
    ENET_CLK  : out std_logic;    --  DM9000A Clock 25 MHz
    ----------------  Audio CODEC   ------------------------
    AUD_ADCLRCK : inout std_logic;  --  Audio CODEC ADC LR Clock
    AUD_ADCDAT  : in    std_logic;  --  Audio CODEC ADC Data
    AUD_DACLRCK : inout std_logic;  --  Audio CODEC DAC LR Clock
    AUD_DACDAT  : out   std_logic;  --  Audio CODEC DAC Data
    AUD_BCLK    : inout std_logic;  --  Audio CODEC Bit-Stream Clock
    AUD_XCK     : out   std_logic;  --  Audio CODEC Chip Clock
    ----------------  TV Decoder    ------------------------
    TD_DATA     : in  std_logic_vector(7 downto 0); --  TV Decoder Data bus 8 bits
    TD_HS       : in  std_logic;    --  TV Decoder H_SYNC
    TD_VS       : in  std_logic;    --  TV Decoder V_SYNC
    TD_RESET    : out std_logic;    --  TV Decoder Reset
    --------------------  GPIO  ----------------------------
    GPIO_0  : inout std_logic_vector(35 downto 0);  --  GPIO Connection 0
    GPIO_1  : inout std_logic_vector(35 downto 0)   --  GPIO Connection 1
  );
end entity DE2_TOP;

architecture Structural_Basic of DE2_TOP is

	signal counter_r     : integer;
	signal slowcounter_r : integer;
	
	signal GP_0_sig : std_logic_vector(31 downto 0);
	signal GP_1_sig : std_logic_vector(31 downto 0);
	
	signal SDRAM_ADDR_sig : std_logic_vector(11 downto 0);
	signal SDRAM_BA_sig 	: std_logic_vector(1 downto 0);
	signal SDRAM_CAS_N_sig : std_logic;
	signal SDRAM_CKE_sig : std_logic;
	signal SDRAM_CLK_sig : std_logic;
	signal SDRAM_CS_N_sig : std_logic;
	signal SDRAM_DQM_sig : std_logic_vector(1 downto 0);
	signal SDRAM_RAS_N_sig : std_logic;
	signal SDRAM_WE_N_sig : std_logic;
	signal SDRAM_SD_sig : std_logic_vector(15 downto 0);

	signal dump : std_logic;
	signal load : std_logic;
	
	--GRAB IF
	signal VDATA_sig 			: std_logic_VECTOR (7 DOWNTO 0);
	signal GCLK_sig  			: std_logic;
	signal GCONT_sig 			: std_logic := '0';
	signal DEBUG1_sig			: std_logic_VECTOR (31 DOWNTO 0);
	signal DEBUG2_sig			: std_logic_VECTOR (31 DOWNTO 0);
	
	--REGfile
	signal GSPDG_sig    			: std_logic;
	signal GACTIVE_sig  			: std_logic;
   signal GFMT_sig     			: std_logic;
	signal GMODE_sig    			: std_logic_vector(1 downto 0);
	signal GXSS_sig     			: std_logic_vector(1 downto 0);
	signal GYSS_sig     			: std_logic_vector(1 downto 0);
	signal GFSTART_sig  			: std_logic_vector(22 downto 0);
	signal GLPITCH_sig  			: std_logic_vector(22 downto 0);
	signal SOFIEN_sig   			: std_logic;
	signal DMAEN_sig    			: std_logic;
	signal DMALR_sig    			: std_logic;
	signal DMAFSTART_sig			: std_logic_vector(22 downto 0);
	signal DMALPITCH_sig			: std_logic_vector(22 downto 0);
	signal DMAXSIZE_sig 			: std_logic_vector(15 downto 0);
	signal VGAHZOOM_sig 			: std_logic_vector(1 downto 0);
	signal VGAVZOOM_sig 			: std_logic_vector(1 downto 0);
	signal PFMT_sig     			: std_logic_vector(1 downto 0);
	signal HTOTAL_sig   			: std_logic_vector(15 downto 0);
	signal HSSYNC_sig   			: std_logic_vector(15 downto 0);
	signal HESYNC_sig   			: std_logic_vector(15 downto 0);
	signal HSVALID_sig  			: std_logic_vector(15 downto 0);
	signal HEVALID_sig  			: std_logic_vector(15 downto 0);
	signal VTOTAL_sig   			: std_logic_vector(15 downto 0);
	signal VSSYNC_sig   			: std_logic_vector(15 downto 0);
	signal VESYNC_sig   			: std_logic_vector(15 downto 0);
	signal VSVALID_sig  			: std_logic_vector(15 downto 0);
	signal VEVALID_sig  			: std_logic_vector(15 downto 0);
	signal GSSHT_sig    			: std_logic;
	signal SOFISTS_sig  			: std_logic;
	signal EOFIEN_sig   			: std_logic;
	
	--DMA	
	signal data_sig      			: std_logic_vector(31 downto 0);	
	signal wraddress_sig				: std_logic_vector(10 downto 0);
	signal wren_sig    				: std_logic;
	signal SOL_sig						: std_logic;
	signal SOF_sig       			: std_logic;	 
	
	--Resets
	signal rstN	 : std_logic;
	signal rst	 : std_logic;
	
	--VGA
	signal vclk							: std_logic;				
	signal SW_sig						: std_logic_vector(17 downto 0);	
	signal rden_sig					: std_logic;		
	signal rdaddress_sig				: std_logic_vector(10 downto 0);	
	signal lineOddEven_sig			: std_logic;	
	signal hrst_sig					: std_logic;		
	signal vrst_sig					: std_logic;		
	signal linebufout_sig			: std_logic_vector(31 downto 0);	
	signal hsyncN_sig					: std_logic;	
	signal vsyncN_sig					: std_logic;	
	signal clockdac_sig				: std_logic;	
	signal blackN_sig					: std_logic;	
	signal syncN_sig					: std_logic;	
	signal red_sig						: std_logic_vector(9 downto 0);	
	signal green_sig					: std_logic_vector(9 downto 0);
	signal blue_sig					: std_logic_vector(9 downto 0);	


	signal CLOCK_100	: std_logic;
	signal CLOCK_100_clk : std_logic;
	
	signal CLOCK_100_LOCKED : std_logic;

	component final_fpga is
		port (
			clk_clk                       : in    std_logic                     := 'X';             -- clk
			reset_reset_n                 : in    std_logic                     := 'X';             -- reset_n
			new_sdram_controller_addr     : out   std_logic_vector(11 downto 0);                    -- addr
			new_sdram_controller_ba       : out   std_logic_vector(1 downto 0);                     -- ba
			new_sdram_controller_cas_n    : out   std_logic;                                        -- cas_n
			new_sdram_controller_cke      : out   std_logic;                                        -- cke
			new_sdram_controller_cs_n     : out   std_logic;                                        -- cs_n
			new_sdram_controller_dq       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			new_sdram_controller_dqm      : out   std_logic_vector(1 downto 0);                     -- dqm
			new_sdram_controller_ras_n    : out   std_logic;                                        -- ras_n
			new_sdram_controller_we_n     : out   std_logic;                                        -- we_n
			grab_if_conduit_gclk          : in    std_logic                     := 'X';             -- gclk
			grab_if_conduit_vdata         : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- vdata
			grab_if_conduit_GSSHT         : in    std_logic                     := 'X';             -- GSSHT
			grab_if_conduit_GMODE         : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- GMODE
			grab_if_conduit_GCONT         : in    std_logic                     := 'X';             -- GCONT
			grab_if_conduit_GFMT          : in    std_logic                     := 'X';             -- GFMT
			grab_if_conduit_GFSTART       : in    std_logic_vector(22 downto 0) := (others => 'X'); -- GFSTART
			grab_if_conduit_GLPITCH       : in    std_logic_vector(22 downto 0) := (others => 'X'); -- GLPITCH
			grab_if_conduit_GYSS          : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- GYSS
			grab_if_conduit_GXSS          : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- GXSS
			grab_if_conduit_GACTIVE       : out   std_logic;                                        -- GACTIVE
			grab_if_conduit_GSPDG         : out   std_logic;                                        -- GSPDG
			grab_if_conduit_DEBUG_GRABIF1 : out   std_logic_vector(31 downto 0);                    -- DEBUG_GRABIF1
			grab_if_conduit_DEBUG_GRABIF2 : out   std_logic_vector(31 downto 0);                    -- DEBUG_GRABIF2
			regfile_conduit_GSPDG         : out   std_logic;                                        -- GSPDG
			regfile_conduit_GACTIVE       : out   std_logic;                                        -- GACTIVE
			regfile_conduit_GFMT          : out   std_logic;                                        -- GFMT
			regfile_conduit_GMODE         : out   std_logic_vector(1 downto 0);                     -- GMODE
			regfile_conduit_GXSS          : out   std_logic_vector(1 downto 0);                     -- GXSS
			regfile_conduit_GYSS          : out   std_logic_vector(1 downto 0);                     -- GYSS
			regfile_conduit_GFSTART       : out   std_logic_vector(22 downto 0);                    -- GFSTART
			regfile_conduit_GLPITCH       : out   std_logic_vector(22 downto 0);                    -- GLPITCH
			regfile_conduit_SOFIEN        : out   std_logic;                                        -- SOFIEN
			regfile_conduit_DMAEN         : out   std_logic;                                        -- DMAEN
			regfile_conduit_DMALR         : out   std_logic;                                        -- DMALR
			regfile_conduit_DMAFSTART     : out   std_logic_vector(22 downto 0);                    -- DMAFSTART
			regfile_conduit_DMALPITCH     : out   std_logic_vector(22 downto 0);                    -- DMALPITCH
			regfile_conduit_DMAXSIZE      : out   std_logic_vector(15 downto 0);                    -- DMAXSIZE
			regfile_conduit_VGAHZOOM      : out   std_logic_vector(1 downto 0);                     -- VGAHZOOM
			regfile_conduit_VGAVZOOM      : out   std_logic_vector(1 downto 0);                     -- VGAVZOOM
			regfile_conduit_PFMT          : out   std_logic_vector(1 downto 0);                     -- PFMT
			regfile_conduit_HTOTAL        : out   std_logic_vector(15 downto 0);                    -- HTOTAL
			regfile_conduit_HSSYNC        : out   std_logic_vector(15 downto 0);                    -- HSSYNC
			regfile_conduit_HESYNC        : out   std_logic_vector(15 downto 0);                    -- HESYNC
			regfile_conduit_HSVALID       : out   std_logic_vector(15 downto 0);                    -- HSVALID
			regfile_conduit_HEVALID       : out   std_logic_vector(15 downto 0);                    -- HEVALID
			regfile_conduit_VTOTAL        : out   std_logic_vector(15 downto 0);                    -- VTOTAL
			regfile_conduit_VSSYNC        : out   std_logic_vector(15 downto 0);                    -- VSSYNC
			regfile_conduit_VESYNC        : out   std_logic_vector(15 downto 0);                    -- VESYNC
			regfile_conduit_VSVALID       : out   std_logic_vector(15 downto 0);                    -- VSVALID
			regfile_conduit_VEVALID       : out   std_logic_vector(15 downto 0);                    -- VEVALID
			regfile_conduit_GACTIVE_IN    : in    std_logic                     := 'X';             -- GACTIVE_IN
			regfile_conduit_GSPDG_IN      : in    std_logic                     := 'X';             -- GSPDG_IN
			regfile_conduit_GSSHT         : out   std_logic;                                        -- GSSHT
			regfile_conduit_SOFISTS       : out   std_logic;                                        -- SOFISTS
			regfile_conduit_EOFIEN        : out   std_logic;                                        -- EOFIEN
			dma_conduit_DMAEN             : in    std_logic                     := 'X';             -- DMAEN
			dma_conduit_DMALR             : in    std_logic                     := 'X';             -- DMALR
			dma_conduit_DMAFSTART         : in    std_logic_vector(22 downto 0) := (others => 'X'); -- DMAFSTART
			dma_conduit_DMALPITCH         : in    std_logic_vector(22 downto 0) := (others => 'X'); -- DMALPITCH
			dma_conduit_DMAXSIZE          : in    std_logic_vector(15 downto 0) := (others => 'X'); -- DMAXSIZE
			dma_conduit_data              : out   std_logic_vector(31 downto 0);                    -- data
			dma_conduit_write_address     : out   std_logic_vector(10 downto 0);                    -- write_address
			dma_conduit_write_enable      : out   std_logic;                                        -- write_enable
			dma_conduit_read_enable       : in    std_logic                     := 'X';             -- read_enable
			dma_conduit_SOL_in            : in    std_logic                     := 'X';             -- SOL_in
			dma_conduit_SOF_in            : in    std_logic                     := 'X'              -- SOF_in
		);
	end component final_fpga;
	
	-- INSERT VGA AND LINEBUFFER HERE!!!
	
	component linebuffer IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component linebuffer;
	
	component vga is
		port (
		-- Video Decoder
		dclk        : in     std_logic; -- decoder output clock
		rstN        : in     std_logic; -- global reset
		-- Debug
		SW          : in     std_logic_vector(17 downto 0);
		-- VGA controller
		rden        : buffer std_logic;
		rdaddress   : buffer std_logic_vector(10 downto 0);
		lineOddEven : in     std_logic;
		linebufout  : in     std_logic_vector(31 downto 0);
		-- VGA connector
		hsyncN      : buffer std_logic;
		vsyncN      : buffer std_logic;
		  
		-- TO DMA ENGINE
		SOF			: out std_logic;
		SOL			: out std_logic;
		
		  -- DAC
		clockdac    : buffer std_logic;
		blankN      : buffer std_logic;
		syncN       : buffer std_logic;
		red         : buffer std_logic_vector(9 downto 0);
		green       : buffer std_logic_vector(9 downto 0);
		blue        : buffer std_logic_vector(9 downto 0);
		
		HTOTAL  : in std_logic_vector(15 downto 0);
      HSVALID : in std_logic_vector(15 downto 0);
      HEVALID : in std_logic_vector(15 downto 0);
      HESYNC  : in std_logic_vector(15 downto 0);
		HSSYNC  : in std_logic_vector(15 downto 0);
	  
		VTOTAL  : in std_logic_vector(15 downto 0);
      VSVALID : in std_logic_vector(15 downto 0);
		VEVALID : in std_logic_vector(15 downto 0);
		VESYNC  : in std_logic_vector(15 downto 0);
		VSSYNC  : in std_logic_vector(15 downto 0)
		  );
	end component vga;
	
	component PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0				: OUT STD_LOGIC ;
		c1				: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	END component PLL;
	
	
	component hexconverter is
			port (
				bcd 		: in std_logic_vector(3 downto 0);  --BCD input
				segment7 : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
				);
	end component hexconverter;
	
begin 

-- Here we simply make sure that unused outputs are driven with some value.
-- TODO: Remove this code for outputs you want to use.

--------------------  7-SEG Dispaly --------------------
-- HEX0       <= (Others => '1'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 0
-- HEX1       <= (Others => '0'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 1
-- HEX2       <= (Others => '1'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 2
-- HEX3       <= (Others => '0'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 3
-- HEX4       <= (Others => '1'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 4
-- HEX5       <= (Others => '0'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 5
-- HEX6       <= (Others => '1'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 6
-- HEX7       <= (Others => '0'); -- out std_logic_vector(6 downto 0);     --  Seven Segment Digit 7
------------------------  LED   ------------------------
-- (These outputs are used in the example below)
--LEDG       <= (Others => '1'); -- out std_logic_vector(8 downto 0);     --  LED Green[8:0]
--LEDR       <= (Others => '0'); -- out std_logic_vector(17 downto 0);    --  LED Red[17:0]
------------------------  UART  ------------------------
UART_TXD   <= '1'; -- out std_logic;      --  UART Transmitter
------------------------  IRDA  ------------------------
IRDA_TXD   <= '0'; -- out std_logic;      --  IRDA Transmitter
--------------------/ SDRAM Interface   ----------------
--DRAM_DQ    <= (Others => 'Z'); -- inout std_logic_vector(15 downto 0); -- SDRAM Data bus 16 Bits
--DRAM_ADDR  <= (Others => '0'); -- out std_logic_vector(11 downto 0);   -- SDRAM Address bus 12 Bits
--DRAM_LDQM  <= '0'; -- out std_logic;        --  SDRAM Low-byte Data Mask 
--DRAM_UDQM  <= '0'; -- out std_logic;        --  SDRAM High-byte Data Mask
--DRAM_WE_N  <= '1'; -- out std_logic;        --  SDRAM Write Enable
--DRAM_CAS_N <= '1'; -- out std_logic;        --  SDRAM Column Address Strobe
--DRAM_RAS_N <= '1'; -- out std_logic;        --  SDRAM Row Address Strobe
--DRAM_CS_N  <= '1'; -- out std_logic;        --  SDRAM Chip Select
--DRAM_BA_0  <= '0'; -- out std_logic;        --  SDRAM Bank Address 0
--DRAM_BA_1  <= '0'; -- out std_logic;        --  SDRAM Bank Address 0
--DRAM_CLK   <= CLOCK_100_clk; -- out std_logic;        --  SDRAM Clock
--DRAM_CKE   <= '0'; -- out std_logic;        --  SDRAM Clock Enable
--------------------  Flash Interface   ----------------
FL_DQ      <= (Others => 'Z'); -- inout std_logic_vector( 7 downto 0);  --  FLASH Data bus 8 Bits
FL_ADDR    <= (Others => '0') ; -- out std_logic_vector(21 downto 0);    --  FLASH Address bus 22 Bits
FL_WE_N    <= '1'; -- out std_logic;        --  FLASH Write Enable
FL_RST_N   <= '1'; -- out std_logic;        --  FLASH Reset
FL_OE_N    <= '1'; -- out std_logic;        --  FLASH Output Enable
FL_CE_N    <= '1'; -- out std_logic;        --  FLASH Chip Enable
--------------------  SRAM Interface    ----------------
SRAM_DQ     <= (Others => 'Z'); -- inout std_logic_vector(15 downto 0); --  SRAM Data bus 16 Bits
SRAM_ADDR   <= (Others => '0'); -- out std_logic_vector(17 downto 0);   --  SRAM Address bus 18 Bits
SRAM_UB_N   <= '0'; -- out std_logic;       --  SRAM High-byte Data Mask 
SRAM_LB_N   <= '0'; -- out std_logic;       --  SRAM Low-byte Data Mask 
SRAM_WE_N   <= '1'; -- out std_logic;       --  SRAM Write Enable
SRAM_CE_N   <= '1'; -- out std_logic;       --  SRAM Chip Enable
SRAM_OE_N   <= '1'; -- out std_logic;       --  SRAM Output Enable
--------------------  ISP1362 Interface ----------------
OTG_DATA     <= (Others => 'Z') ; -- inout std_logic_vector(15 downto 0);  --  ISP1362 Data bus 16 Bits
OTG_ADDR     <= (Others => '0'); -- out std_logic_vector(1 downto 0);     --  ISP1362 Address 2 Bits
OTG_CS_N     <= '1'; -- out std_logic;  --  ISP1362 Chip Select
OTG_RD_N     <= '1'; -- out std_logic;  --  ISP1362 Write
OTG_WR_N     <= '1'; -- out std_logic;  --  ISP1362 Read
OTG_RST_N    <= '1'; -- out std_logic;  --  ISP1362 Reset
OTG_FSPEED   <= 'Z'; -- out std_logic;  --  USB Full Speed, 0 = Enable, Z = Disable
OTG_LSPEED   <= 'Z'; -- out std_logic;  --  USB Low Speed, 0 = Enable,Z = Disable
OTG_DACK0_N  <= '1'; -- out std_logic;  --  ISP1362 DMA Acknowledge 0
OTG_DACK1_N  <= '1'; -- out std_logic;  --  ISP1362 DMA Acknowledge 1
--------------------  LCD Module 16X2   ----------------
LCD_ON     <= '0'; -- out std_logic;  --  LCD Power ON/OFF
LCD_BLON   <= '1'; -- out std_logic;  --  LCD Back Light ON/OFF
LCD_RW     <= '1'; -- out std_logic;  --  LCD Read/Write Select, 0 = Write, 1 = Read
LCD_EN     <= '0'; -- out std_logic;  --  LCD Enable
LCD_RS     <= '1'; -- out std_logic;  --  LCD Command/Data Select,0 = Command, 1 = Data
LCD_DATA   <= (Others => 'Z'); -- inout std_logic_vector( 7 downto 0);  --  LCD Data bus 8 bits
--------------------  SD_Card Interface ----------------
SD_DAT     <= 'Z'; -- inout std_logic;  --  SD Card Data
SD_DAT3    <= 'Z'; -- inout std_logic;  --  SD Card Data 3
SD_CMD     <= 'Z'; -- inout std_logic;  --  SD Card Command Signal
SD_CLK     <= '0'; -- out std_logic;    --  SD Card Clock
--------------------  USB JTAG link --------------------
TDO        <= '0'; -- out std_logic;    -- FPGA -> CPLD (data out)
--------------------  I2C   ----------------------------
I2C_SDAT   <= 'Z'; -- inout std_logic;  --  I2C Data
I2C_SCLK   <= '0'; -- out std_logic;    --  I2C Clock
--------------------  VGA   ----------------------------
--VGA_CLK    <= '0'; -- out std_logic;    --  VGA Clock
--VGA_HS     <= '0'; -- out std_logic;    --  VGA H_SYNC
--VGA_VS     <= '0'; -- out std_logic;    --  VGA V_SYNC
--VGA_BLANK  <= '0'; -- out std_logic;    --  VGA BLANK
--VGA_SYNC   <= '0'; -- out std_logic;    --  VGA SYNC
--VGA_R      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Red[9:0]
--VGA_G      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Green[9:0]
--VGA_B      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Blue[9:0]
------------  Ethernet Interface  ------------------------
ENET_DATA  <= (Others => 'Z'); -- inout std_logic_vector(15 downto 0); --  DM9000A DATA bus 16Bits
ENET_CMD   <= '1'; -- out std_logic;    --  DM9000A Command/Data Select, 0 = Command, 1 = Data
ENET_CS_N  <= '1'; -- out std_logic;    --  DM9000A Chip Select
ENET_WR_N  <= '1'; -- out std_logic;    --  DM9000A Write
ENET_RD_N  <= '1'; -- out std_logic;    --  DM9000A Read
ENET_RST_N <= '1'; -- out std_logic;    --  DM9000A Reset
ENET_CLK   <= '0'; -- out std_logic;    --  DM9000A Clock 25 MHz
----------------  Audio CODEC   ------------------------
AUD_ADCLRCK  <= 'Z'; -- inout std_logic;  --  Audio CODEC ADC LR Clock
AUD_DACLRCK  <= 'Z'; -- inout std_logic;  --  Audio CODEC DAC LR Clock
AUD_DACDAT   <= '0'; -- out   std_logic;  --  Audio CODEC DAC Data
AUD_BCLK     <= 'Z'; -- inout std_logic;  --  Audio CODEC Bit-Stream Clock
AUD_XCK      <= '0'; -- out   std_logic;  --  Audio CODEC Chip Clock
----------------  TV Decoder    ------------------------
--TD_RESET     <= '1'; -- out std_logic;    --  TV Decoder Reset
--------------------  GPIO  ----------------------------
GPIO_0   <= (Others => 'Z'); -- inout std_logic_vector(35 downto 0);  --  GPIO Connection 0
GPIO_1   <= (Others => 'Z'); -- inout std_logic_vector(35 downto 0)   --  GPIO Connection 1


--Reset assignment
rst <= SW(0);
rstN <= not(SW(0));

-- LEDR <= conv_std_logic_vector(slowcounter_r, 18);

---- instantiate the test RAM block
--xtestramblock : entity work.testramblock
--	port map (
--		address => ramaddr_s,
--		clock	  => CLOCK_50,
--		data	  => ramdatain_s,
--		wren	  => ramwren_s,
--		q	     => ramdataout_s
--	);
--	
--ramwren_s <= '1' when counter_r < 256 else
--             '0';
--ramaddr_s <= conv_std_logic_vector(counter_r, 8); -- here I am hoping that the conv function will take the 8 lsb's (TEMP)
--ramdatain_s <= conv_std_logic_vector(counter_r+1, 8) when ramwren_s='1' else
--               (others => '0');

-- send the RAM data output to the green LEDs
--LEDG(7 downto 0) <= ramdataout_s;
--LEDG(8) <= '0';
--LEDG(8 downto 0) <= (others => '0');

--xhexconverter_0: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(3 downto 0),  --BCD input
--				segment7 => HEX0  -- 7 bit decoded output.
--				);
--				
--xhexconverter_1: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(7 downto 4),  --BCD input
--				segment7 => HEX1  -- 7 bit decoded output.
--				);
--
--xhexconverter_2: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(11 downto 8),  --BCD input
--				segment7 => HEX2  -- 7 bit decoded output.
--				);	
--	
--xhexconverter_3: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(15 downto 12),  --BCD input
--				segment7 => HEX3  -- 7 bit decoded output.
--				);	
--				
--xhexconverter_4: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(19 downto 16),  --BCD input
--				segment7 => HEX4  -- 7 bit decoded output.
--				);
--				
--xhexconverter_5: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(23 downto 20),  --BCD input
--				segment7 => HEX5  -- 7 bit decoded output.
--				);
--				
--xhexconverter_6: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(27 downto 24),  --BCD input
--				segment7 => HEX6  -- 7 bit decoded output.
--				);
--				
--xhexconverter_7: component hexconverter
--			port map (
--				bcd 		=> GP_0_sig(31 downto 28),  --BCD input
--				segment7 => HEX7  -- 7 bit decoded output.
--				);

	xpll : component PLL
	PORT map
	(
		areset	=> rst,
		inclk0	=> CLOCK_50,
		c0			=> CLOCK_100,
		c1      => CLOCK_100_clk,
		locked	=> CLOCK_100_LOCKED
	);
	
	LEDR(1)	<= GACTIVE_sig;
	LEDR(2)	<= DMAEN_sig;
	LEDR(3) <= CLOCK_100_LOCKED;
	
	LEDR(17) <= GMODE_sig(1);
	LEDR(16)	<= GMODE_sig(0);
	
	-- If it is ever 0 everything stops working
	TD_RESET <= '1';
	SW_sig(2) <= SW(2);
	
	DRAM_CLK <= CLOCK_100_clk; -- out std_logic;        --  SDRAM Clock
				
				-- INSERT NIOS QSYS PORT MAP HERE
xfinal_fpga : component final_fpga
			port map (
				clk_clk                         => CLOCK_100,                                    --                         clk.clk
				reset_reset_n                   => rstN,                              --                       reset.reset_n
				new_sdram_controller_addr       => DRAM_ADDR,                    -- new_sdram_controller_0_wire.addr
 				new_sdram_controller_ba(0)      => DRAM_BA_0,                      --                            .ba
				new_sdram_controller_ba(1)      => DRAM_BA_1,                      --                            .ba
				new_sdram_controller_cas_n      => DRAM_CAS_N,                   --                            .cas_n
				new_sdram_controller_cke        => DRAM_CKE,                     --                            .cke
				new_sdram_controller_cs_n       => DRAM_CS_N,                    --                            .cs_n
				new_sdram_controller_dq         => DRAM_DQ,                      --                            .dq
				new_sdram_controller_dqm(0)     => DRAM_LDQM,                     --                            .dqm
				new_sdram_controller_dqm(1)     => DRAM_UDQM,                     --                            .dqm
				new_sdram_controller_ras_n      => DRAM_RAS_N,                   --                            .ras_n
				new_sdram_controller_we_n       => DRAM_WE_N,                    --                            .we_n
				grab_if_conduit_vdata           => TD_DATA,            --                            .vdata
				grab_if_conduit_gclk            => CLOCK_27,             --                            .gclk
				grab_if_conduit_GSSHT           => GSSHT_sig,            --       grab_if_0_conduit_end.GSSHT
				grab_if_conduit_GMODE           => GMODE_sig,            --                            .GMODE
				grab_if_conduit_GCONT           => GCONT_sig,            --                            .GCONT
				grab_if_conduit_GFMT            => GFMT_sig,             --                            .GFMT
				grab_if_conduit_GFSTART         => GFSTART_sig,          --                            .GFSTART
				grab_if_conduit_GLPITCH         => GLPITCH_sig,          --                            .GLPITCH
				grab_if_conduit_GYSS            => GYSS_sig,             --                            .GYSS
				grab_if_conduit_GXSS            => GXSS_sig,             --                            .GXSS
				grab_if_conduit_GACTIVE         => GACTIVE_sig,                      --                            .GACTIVE
				grab_if_conduit_GSPDG           => GSPDG_sig,                        --                            .GSPDG
				grab_if_conduit_DEBUG_GRABIF1   => DEBUG1_sig,                --                            .DEBUG_GRABIF1
				grab_if_conduit_DEBUG_GRABIF2   => DEBUG2_sig,                --                            .DEBUG_GRABIF2
				regfile_conduit_GSPDG      	  => LEDR(0),                  -- regfile_final_0_conduit_end.GSPDG
				regfile_conduit_GACTIVE    	  => GACTIVE_sig,                --                            .GACTIVE
				regfile_conduit_GFMT       	  => GFMT_sig,                   --                            .GFMT
				regfile_conduit_GMODE      	  => GMODE_sig,                  --                            .GMODE
				regfile_conduit_GXSS       	  => GXSS_sig,                   --                            .GXSS
				regfile_conduit_GYSS       	  => GYSS_sig,                   --                            .GYSS
				regfile_conduit_GFSTART    	  => GFSTART_sig,                --                            .GFSTART
				regfile_conduit_GLPITCH    	  => GLPITCH_sig,                ---                            .GLPITCH
				regfile_conduit_SOFIEN     	  => SOFIEN_sig,                 --                            .SOFIEN
				regfile_conduit_DMAEN      	  => DMAEN_sig,                  --                            .DMAEN
				regfile_conduit_DMALR      	  => DMALR_sig,                  --                            .DMALR
				regfile_conduit_DMAFSTART  	  => DMAFSTART_sig,              --                            .DMAFSTART
				regfile_conduit_DMALPITCH  	  => DMALPITCH_sig,              --                            .DMALPITCH
				regfile_conduit_DMAXSIZE   	  => DMAXSIZE_sig,               --                            .DMAXSIZE
				regfile_conduit_VGAHZOOM   	  => VGAHZOOM_sig,               --                            .VGAHZOOM
				regfile_conduit_VGAVZOOM   	  => VGAVZOOM_sig,               --                            .VGAVZOOM
				regfile_conduit_PFMT       	  => PFMT_sig,                   --                            .PFMT
				regfile_conduit_HTOTAL     	  => HTOTAL_sig,                 --                            .HTOTAL
				regfile_conduit_HSSYNC     	  => HSSYNC_sig,                 --                            .HSSYNC
				regfile_conduit_HESYNC     	  => HESYNC_sig,                 --                            .HESYNC
				regfile_conduit_HSVALID    	  => HSVALID_sig,                --                            .HSVALID
				regfile_conduit_HEVALID    	  => HEVALID_sig,                --                            .HEVALID
				regfile_conduit_VTOTAL     	  => VTOTAL_sig,                 --                            .VTOTAL
				regfile_conduit_VSSYNC     	  => VSSYNC_sig,                 --                            .VSSYNC
				regfile_conduit_VESYNC     	  => VESYNC_sig,                 --                            .VESYNC
				regfile_conduit_VSVALID    	  => VSVALID_sig,                --                            .VSVALID
				regfile_conduit_VEVALID    	  => VEVALID_sig,                --                            .VEVALID
				regfile_conduit_GACTIVE_IN 	  => GACTIVE_sig, 					 --                            .GACTIVE_IN
				regfile_conduit_GSPDG_IN   	  => GSPDG_sig,   					 --                            .GSPDG_IN
				regfile_conduit_GSSHT      	  => GSSHT_sig,                  --                            .GSSHT
				regfile_conduit_SOFISTS    	  => SOFISTS_sig,                --                            .SOFISTS
				regfile_conduit_EOFIEN     	  => EOFIEN_sig,                 --                            .EOFIEN
				dma_conduit_DMAEN         		  => DMAEN_sig,         --    dma_engine_0_conduit_end.DMAEN
				dma_conduit_DMALR         		  => DMALR_sig,         --                            .DMALR
				dma_conduit_DMAFSTART     		  => DMAFSTART_sig,     --                            .DMAFSTART
				dma_conduit_DMALPITCH     		  => DMALPITCH_sig,     --                            .DMALPITCH
				dma_conduit_DMAXSIZE      		  => DMAXSIZE_sig,      --                            .DMAXSIZE
				dma_conduit_data          		  => data_sig,                      --                            .data                           .read_address
				dma_conduit_write_address 		  => wraddress_sig,             --                            .write_address
				dma_conduit_write_enable  		  => wren_sig,              --                            .write_enable
				dma_conduit_read_enable   		  => rden_sig,    --                            .read_enable
				dma_conduit_SOL_in        		  => SOL_sig,         --                     .SOL_in
				dma_conduit_SOF_in        		  => SOF_sig          --                     .SOF_in
				);
				
xlinebuffer : component linebuffer
	port map
	(
		clock			=> CLOCK_100,						--: IN STD_LOGIC  := '1';
		data			=> data_sig,													--: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress 	=> rdaddress_sig,												--: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wraddress 	=> wraddress_sig,												--: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wren			=> wren_sig,													--: IN STD_LOGIC  := '0';
		q				=> linebufout_sig												--: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	); 
	
xvga : component vga
		port map (
		-- Video Decoder
		dclk        => CLOCK_27,														--: in     std_logic; -- decoder output clock
		rstN        => rstN,															--: in     std_logic; -- global reset
		-- Debug
		SW          => SW_sig,														--: in     std_logic_vector(17 downto 0);
		-- VGA controller
		rden        => rden_sig,													--: buffer std_logic;
		rdaddress   => rdaddress_sig,												--: buffer std_logic_vector(10 downto 0);
		lineOddEven => lineOddEven_sig,											--: in     std_logic;
		linebufout  => linebufout_sig,											--: in     std_logic_vector(31 downto 0);
		-- VGA connector
		hsyncN      => VGA_HS,												--: buffer std_logic;
		vsyncN      => VGA_VS,												--: buffer std_logic;
		
		-- TO DMA ENGINE
		SOF			=>	SOF_sig,														--: out std_logic;
		SOL			=>	SOL_sig,														--: out std_logic;
		
		-- DAC
		clockdac    => VGA_CLK,													--: buffer std_logic;
		blankN      => VGA_BLANK,												--: buffer std_logic;
		syncN       => VGA_SYNC,												--: buffer std_logic;
		red         => VGA_R,													--: buffer std_logic_vector(9 downto 0);
		green       => VGA_G,													--: buffer std_logic_vector(9 downto 0);
		blue        => VGA_B,													--: buffer std_logic_vector(9 downto 0)
		  
		HTOTAL  => HTOTAL_sig,
		HSVALID => HSVALID_sig,
		HEVALID => HEVALID_sig,
		HESYNC  => HESYNC_sig,
		HSSYNC  => HSSYNC_sig,
		VTOTAL  => VTOTAL_sig,
		VSVALID => VSVALID_sig,
		VEVALID => VEVALID_sig,
		VESYNC  => VESYNC_sig,
		VSSYNC  => VSSYNC_sig
		);
				-- END OF NIOS QSYS PORT MA)P										--: buffer std_logic;\
		  
end Structural_Basic;

