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
	

	-- INSERT NIOS QSYS STYSTEM HERE
	
	-- INSERT VGA AND LINEBUFFER HERE!!!
	
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
--DRAM_CLK   <= '0'; -- out std_logic;        --  SDRAM Clock
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
VGA_CLK    <= '0'; -- out std_logic;    --  VGA Clock
VGA_HS     <= '0'; -- out std_logic;    --  VGA H_SYNC
VGA_VS     <= '0'; -- out std_logic;    --  VGA V_SYNC
VGA_BLANK  <= '0'; -- out std_logic;    --  VGA BLANK
VGA_SYNC   <= '0'; -- out std_logic;    --  VGA SYNC
VGA_R      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Red[9:0]
VGA_G      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Green[9:0]
VGA_B      <= (Others => '0'); -- out std_logic_vector(9 downto 0);    --  VGA Blue[9:0]
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
TD_RESET     <= '1'; -- out std_logic;    --  TV Decoder Reset
--------------------  GPIO  ----------------------------
GPIO_0   <= (Others => 'Z'); -- inout std_logic_vector(35 downto 0);  --  GPIO Connection 0
GPIO_1   <= (Others => 'Z'); -- inout std_logic_vector(35 downto 0)   --  GPIO Connection 1

-- Simple test circuit: use the red LEDs to display a slow counter.
count : process(CLOCK_50, KEY(0))
begin
end process count;

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

xhexconverter_0: component hexconverter
			port map (
				bcd 		=> GP_0_sig(3 downto 0),  --BCD input
				segment7 => HEX0  -- 7 bit decoded output.
				);
				
xhexconverter_1: component hexconverter
			port map (
				bcd 		=> GP_0_sig(7 downto 4),  --BCD input
				segment7 => HEX1  -- 7 bit decoded output.
				);

xhexconverter_2: component hexconverter
			port map (
				bcd 		=> GP_0_sig(11 downto 8),  --BCD input
				segment7 => HEX2  -- 7 bit decoded output.
				);	
	
xhexconverter_3: component hexconverter
			port map (
				bcd 		=> GP_0_sig(15 downto 12),  --BCD input
				segment7 => HEX3  -- 7 bit decoded output.
				);	
				
xhexconverter_4: component hexconverter
			port map (
				bcd 		=> GP_0_sig(19 downto 16),  --BCD input
				segment7 => HEX4  -- 7 bit decoded output.
				);
				
xhexconverter_5: component hexconverter
			port map (
				bcd 		=> GP_0_sig(23 downto 20),  --BCD input
				segment7 => HEX5  -- 7 bit decoded output.
				);
				
xhexconverter_6: component hexconverter
			port map (
				bcd 		=> GP_0_sig(27 downto 24),  --BCD input
				segment7 => HEX6  -- 7 bit decoded output.
				);
				
xhexconverter_7: component hexconverter
			port map (
				bcd 		=> GP_0_sig(31 downto 28),  --BCD input
				segment7 => HEX7  -- 7 bit decoded output.
				);
				
				-- INSERT NIOS QSYS PORT MAP HERE
		  
		  		new_sdram_controller_0_wire_addr    	=> SDRAM_ADDR_sig,    -- new_sdram_controller_0_wire.addr
            new_sdram_controller_0_wire_ba      	=> SDRAM_BA_sig,      --                            .ba
            new_sdram_controller_0_wire_cas_n   	=> SDRAM_CAS_N_sig,   --                            .cas_n
            new_sdram_controller_0_wire_cke     	=> SDRAM_CKE_sig,     --                            .cke
            new_sdram_controller_0_wire_cs_n    	=> SDRAM_CS_N_sig,    --                            .cs_n
            new_sdram_controller_0_wire_dq      	=> SDRAM_SD_sig,      --                            .dq
            new_sdram_controller_0_wire_dqm     	=> SDRAM_DQM_sig,     --                            .dqm
            new_sdram_controller_0_wire_ras_n   	=> SDRAM_RAS_N_sig,   --                            .ras_n
            new_sdram_controller_0_wire_we_n    	=> SDRAM_WE_N_sig,    --                            .we_n
		  
				-- END OF NIOS QSYS PORT MAP
		  
			DRAM_ADDR <= SDRAM_ADDR_sig;
			DRAM_BA_1 <= SDRAM_BA_sig(1);
			DRAM_BA_0 <= SDRAM_BA_sig(0);
			DRAM_CAS_N <= SDRAM_CAS_N_sig;
			DRAM_CKE <= SDRAM_CKE_sig;
			DRAM_CLK <= SDRAM_CLK_sig;
			DRAM_CS_N <= SDRAM_CS_N_sig;
			DRAM_UDQM <= SDRAM_DQM_sig(1);
			DRAM_LDQM <= SDRAM_DQM_sig(0);
			DRAM_RAS_N <= SDRAM_RAS_N_sig;
			DRAM_WE_N <= SDRAM_WE_N_sig;
			DRAM_DQ <= SDRAM_SD_sig;
		  
end Structural_Basic;

