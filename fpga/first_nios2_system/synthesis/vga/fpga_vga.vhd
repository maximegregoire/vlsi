library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpga_vga is
   port (
      -- video decoder
      CLOCK_27   : in         std_logic; -- decoder output clock
      TD_DATA     : in         std_logic_vector(7 downto 0); -- decoder pixel output
      TD_RESET       : buffer     std_logic; -- decoder reset input
      -- VGA connector
      VGA_HS      : buffer std_logic;
      VGA_VS      : buffer std_logic;
      -- DAC
      VGA_CLK     : buffer     std_logic;
      VGA_SYNC    : buffer     std_logic;
      VGA_BLANK   : buffer     std_logic;
      VGA_R       : buffer     std_logic_vector(9 downto 0);
      VGA_G       : buffer     std_logic_vector(9 downto 0);
      VGA_B       : buffer     std_logic_vector(9 downto 0);
      -- board general
      SW        :  in     std_logic_vector(17 downto 0); -- global reset
      LEDG      :  buffer std_logic_vector(7 downto 0);
      LEDR      :  buffer std_logic_vector(7 downto 0)
   );
end fpga_vga;

architecture functional of fpga_vga is

component itu656 is
port (
      -- Video decoder
      dclk        : in     std_logic; -- decoder output clock
      dpix        : in     std_logic_vector(7 downto 0); -- decoder pixel output
      -- VGA controlleroisvertb
		
      rden        : in     std_logic;
      rdaddress   : in     std_logic_vector(10 downto 0);
      lineOddEven : buffer std_logic;
      hrst        : buffer std_logic;    --   sync for H alignment
      vrst        : buffer std_logic;    --   sync for V alignment
      linebufout  : buffer std_logic_vector(31 downto 0);
      -- LED
      ledg        : buffer std_logic_vector(7 downto 0);
      ledr        : buffer std_logic_vector(7 downto 0);
      switch0     : in     std_logic
     );
end component;

component itu656_behavioral is
port (
      -- Video Decoder
      dclk        : in     std_logic; -- decoder output clock
      dpix        : in     std_logic_vector(7 downto 0); -- decoder pixel output
      -- VGA controller
      rden        : in     std_logic;
      rdaddress   : in     std_logic_vector(10 downto 0);
      lineOddEven : buffer std_logic;
      hrst        : buffer std_logic;    --   sync for H alignment
      vrst        : buffer std_logic;    --   sync for V alignment
      linebufout  : buffer std_logic_vector(31 downto 0);
      -- LED
      ledg        : buffer std_logic_vector(7 downto 0);
      ledr        : buffer std_logic_vector(7 downto 0);
      switch0     : in     std_logic
     );
end component;

component vga is
port (
      -- Video Decoder
      dclk        : in     std_logic; -- decoder output clock
      rstN        : in     std_logic;
      -- Debug
      SW          : in     std_logic_vector(17 downto 0);
      -- VGA controller
      rden        : buffer std_logic;
      rdaddress   : buffer std_logic_vector(10 downto 0);
      lineOddEven : in     std_logic;
      hrst        : in     std_logic;    --   sync for H alignment
      vrst        : in     std_logic;    --   sync for V alignment
      linebufout  : in     std_logic_vector(31 downto 0);
      -- VGA connector
      hsyncN      : buffer std_logic;
      vsyncN      : buffer std_logic;
      -- DAC
      clockdac    : buffer std_logic;
      blankN      : buffer std_logic;
      syncN       : buffer std_logic;
      red         : buffer std_logic_vector(9 downto 0);
      green       : buffer std_logic_vector(9 downto 0);
      blue        : buffer std_logic_vector(9 downto 0)
      );
end component;

signal linebufout : std_logic_vector(31 downto 0);
signal hrst       : std_logic;
signal vrst       : std_logic;
signal rden       : std_logic;
signal rdaddress  : std_logic_vector(10 downto 0);
signal lineOddEven : std_logic;
signal rst1pN     : std_logic;
signal rst2pN     : std_logic;
signal rstN       : std_logic;

begin

TD_RESET <= '1';

-------------------------------------------------------------------------------
-- Process: P_RESETSYNC
-- Purpose:
-------------------------------------------------------------------------------
P_RESETSYNC : process (SW(0), CLOCK_27)
   
begin  --  process P_RESETSYNC 

if (SW(0) = '0') then
   rst1pN <= '0';
   rst2pN <= '0';
elsif (CLOCK_27'event and CLOCK_27='1') then
   rst1pN <= SW(0);
   rst2pN <= rst1pN;
end if;

end process P_RESETSYNC;

--rstN <= SW(0) and rst2PN;
rstN <= SW(0);

VGA_CLK <= CLOCK_27;

xitu656 : itu656_behavioral
port map (
      dclk        => CLOCK_27,
      dpix        => TD_DATA,
      rden        => rden,
      rdaddress   => rdaddress,
      lineOddEven => lineOddEven,
      hrst        => hrst,
      vrst        => vrst,
      linebufout  => linebufout,
      ledg        => LEDG,
      ledr        => LEDR,
      switch0     => rstN
     );


xvga : vga
port map (
      dclk        => CLOCK_27,
      rstN        => rstN,
      SW          => SW,
      rden        => rden,
      rdaddress   => rdaddress,
      lineOddEven => lineOddEven,
      hrst        => hrst,
      vrst        => vrst,
      linebufout  => linebufout,
      hsyncN      => VGA_HS,
      vsyncN      => VGA_VS,
      clockdac    => open,
      blankN      => VGA_BLANK,
      syncN       => VGA_SYNC,
      red         => VGA_R,      
      green       => VGA_G,
      blue        => VGA_B
      );

end functional;
