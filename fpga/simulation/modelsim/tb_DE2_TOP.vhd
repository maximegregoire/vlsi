Library ieee;
use     ieee.std_logic_1164.all;

-- declare empty entity
entity tb_DE2_TOP is
end tb_DE2_TOP;

architecture a0 of tb_DE2_TOP is

  -- the basic signals
  signal   clk        : std_logic := '0';        -- the clock
  constant CLK_PERIOD : time := 10 ns;
  signal   resetn     : std_logic := '0';
  
  signal keys_s : std_logic_vector(3 downto 0);
  
begin  -- a0

  -- create the clock
  clk <= not clk after CLK_PERIOD/2;

  -- asynchronous reset
  resetn <= '0', '1' after 2*CLK_PERIOD;
  
  -- Input "KEY0" is used as asynch reset in the design
  keys_s(0) <= resetn;
  keys_s(3 downto 1) <= (others => '0');

  -- TODO: instantiate the component to be tested
  DE2_TOP_1: entity work.DE2_TOP
    port map (
      CLOCK_27    => '0',
      CLOCK_50    => clk,
      EXT_CLOCK   => '0',
      KEY         => keys_s,
      SW          => (others => '0'),
      HEX0        => OPEN,
      HEX1        => OPEN,
      HEX2        => OPEN,
      HEX3        => OPEN,
      HEX4        => OPEN,
      HEX5        => OPEN,
      HEX6        => OPEN,
      HEX7        => OPEN,
      LEDG        => OPEN,
      LEDR        => OPEN,
      UART_TXD    => OPEN,
      UART_RXD    => '0',
      IRDA_TXD    => OPEN,
      IRDA_RXD    => '0',
      DRAM_DQ     => OPEN,
      DRAM_ADDR   => OPEN,
      DRAM_LDQM   => OPEN,
      DRAM_UDQM   => OPEN,
      DRAM_WE_N   => OPEN,
      DRAM_CAS_N  => OPEN,
      DRAM_RAS_N  => OPEN,
      DRAM_CS_N   => OPEN,
      DRAM_BA_0   => OPEN,
      DRAM_BA_1   => OPEN,
      DRAM_CLK    => OPEN,
      DRAM_CKE    => OPEN,
      FL_DQ       => OPEN,
      FL_ADDR     => OPEN,
      FL_WE_N     => OPEN,
      FL_RST_N    => OPEN,
      FL_OE_N     => OPEN,
      FL_CE_N     => OPEN,
      SRAM_DQ     => OPEN,
      SRAM_ADDR   => OPEN,
      SRAM_UB_N   => OPEN,
      SRAM_LB_N   => OPEN,
      SRAM_WE_N   => OPEN,
      SRAM_CE_N   => OPEN,
      SRAM_OE_N   => OPEN,
      OTG_DATA    => OPEN,
      OTG_ADDR    => OPEN,
      OTG_CS_N    => OPEN,
      OTG_RD_N    => OPEN,
      OTG_WR_N    => OPEN,
      OTG_RST_N   => OPEN,
      OTG_FSPEED  => OPEN,
      OTG_LSPEED  => OPEN,
      OTG_INT0    => '0',
      OTG_INT1    => '0',
      OTG_DREQ0   => '0',
      OTG_DREQ1   => '0',
      OTG_DACK0_N => OPEN,
      OTG_DACK1_N => OPEN,
      LCD_ON      => OPEN,
      LCD_BLON    => OPEN,
      LCD_RW      => OPEN,
      LCD_EN      => OPEN,
      LCD_RS      => OPEN,
      LCD_DATA    => OPEN,
      SD_DAT      => OPEN,
      SD_DAT3     => OPEN,
      SD_CMD      => OPEN,
      SD_CLK      => OPEN,
      TDI         => '0',
      TCK         => '0',
      TCS         => '0',
      TDO         => OPEN,
      I2C_SDAT    => OPEN,
      I2C_SCLK    => OPEN,
      PS2_DAT     => '0',
      PS2_CLK     => '0',
      VGA_CLK     => OPEN,
      VGA_HS      => OPEN,
      VGA_VS      => OPEN,
      VGA_BLANK   => OPEN,
      VGA_SYNC    => OPEN,
      VGA_R       => OPEN,
      VGA_G       => OPEN,
      VGA_B       => OPEN,
      ENET_DATA   => OPEN,
      ENET_CMD    => OPEN,
      ENET_CS_N   => OPEN,
      ENET_WR_N   => OPEN,
      ENET_RD_N   => OPEN,
      ENET_RST_N  => OPEN,
      ENET_INT    => '0',
      ENET_CLK    => OPEN,
      AUD_ADCLRCK => OPEN,
      AUD_ADCDAT  => '0',
      AUD_DACLRCK => OPEN,
      AUD_DACDAT  => OPEN,
      AUD_BCLK    => OPEN,
      AUD_XCK     => OPEN,
      TD_DATA     => (others => '0'),
      TD_HS       => '0',
      TD_VS       => '0',
      TD_RESET    => OPEN,
      GPIO_0      => OPEN,
      GPIO_1      => OPEN);
end a0;
