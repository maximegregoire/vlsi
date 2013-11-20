
--*****************************************************************************
--  $Source:  $
--  $Locker:  $
--  $Revision: 1.1 $
--  $Date: 2013 $
--  $Author: $
--
--   Project      :   [VGA]
--
--   Unite        :   [VGA controller]
--
--   Description  :   Generate VGA sync signals toward DAC. Read out line buffer
--                    with valid data. Interlace to progressive conversion.
--                    Sync with valid input source through hrst and vrst.
--
--**************************************************************************** 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga is
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
end entity vga;

architecture functional of vga is

constant HTOTAL  : std_logic_vector(15 downto 0):=x"0359"; -- 858-1
--constant HSVALID : std_logic_vector(15 downto 0):=x"0098"; -- 152
constant HSVALID : std_logic_vector(15 downto 0):=x"0084"; -- 132
--constant HEVALID : std_logic_vector(15 downto 0):=x"0340"; -- 832
constant HEVALID : std_logic_vector(15 downto 0):=x"0354"; -- 852
constant HESYNC  : std_logic_vector(15 downto 0):=x"0060"; -- 96


constant VTOTAL  : std_logic_vector(15 downto 0):=x"0010";						--:=x"020C"; -- 525-1
constant VSVALID : std_logic_vector(15 downto 0):=x"0002";							--:=x"0026"; -- 38 
constant VEVALID : std_logic_vector(15 downto 0):=x"0008";							--:=x"0206"; -- 518
constant VESYNC  : std_logic_vector(15 downto 0):=x"0003"; -- 3


signal hcounter : std_logic_vector(15 downto 0);
signal vcounter : std_logic_vector(15 downto 0);
signal hvalid   : std_logic;
signal hvalid1p   : std_logic;
signal vvalid   : std_logic;
signal count4   : std_logic_vector(1 downto 0);
signal framecnt : std_logic_vector(7 downto 0);

begin

clockdac      <=  not dclk; -- inverted to respect hold and setup
syncN         <= '0'; -- No composite sync required (on green component)
blankN        <= vvalid and hvalid; -- FIXME (pipeline missing)
rden          <= vvalid and hvalid; 
rdaddress(10) <= not lineOddEven; 

 -- monochrome
P_DATAOUT : process (SW,linebufout)
begin
if (SW(2) = '0') then
   red     <= linebufout(31 downto 24)&"00";
   green   <= linebufout(31 downto 24)&"00";
   blue    <= linebufout(31 downto 24)&"00";
else
   red     <= "1000000000";
   green   <= "1111111111";
   blue    <= "1000000000";
end if;

end process P_DATAOUT;

-------------------------------------------------------------------------------
-- Process: P_COUNTER
-- Purpose:
-------------------------------------------------------------------------------
P_COUNTER : process (dclk, rstN)
   
begin  --  process P_COUNTER

if (rstN = '0') then
   hcounter <= (others => '0');
   vcounter <=  "0000000000000000";
   hsyncN   <= '1';
   vsyncN   <= '1';
   vvalid   <= '0';
   hvalid   <= '0';
   hvalid1p <= '0';
   count4   <= "00";
   framecnt <= (others => '0');
   rdaddress(9 downto 0) <= (others => '0');
elsif (dclk'event and dclk='1') then
   hvalid1p <= hvalid;
   framecnt <= framecnt;
   if (hrst = '1' or hcounter=HTOTAL) then
      hcounter <= (others => '0');
      hsyncN   <= '0';
      if (vcounter = VTOTAL or (vrst = '1' and vcounter /= "0000000000000000")) then
         vcounter <= (others => '0');
         vsyncN   <= '0';
         if (framecnt < 63) then
            framecnt <= unsigned(framecnt) + 1;
         else
            framecnt <= (others => '0');
         end if;
      else
         vcounter <= UNSIGNED(vcounter) + 1;
         if (vcounter = VESYNC) then
            vsyncN <= '1';
         end if;
         if (vcounter = VSVALID) then 
            vvalid <= '1';
         elsif (vcounter = VEVALID) then
            vvalid <= '0';
         else
            vvalid <= vvalid;
         end if;
      end if;
   else -- hrst = '0'
      hcounter <= UNSIGNED(hcounter) + 1;
      if (hcounter = HESYNC) then
         hsyncN <= '1';
      end if;
      if (hcounter = HSVALID) then
         hvalid <= '1';
      elsif (hcounter = HEVALID) then
         hvalid <= '0';
      else
         hvalid <= hvalid;
      end if;
   end if;

   if (hvalid = '1' and hvalid1p = '0') then
      rdaddress(9 downto 0) <= UNSIGNED(rdaddress(9 downto 0)) + 1 + framecnt;
      count4 <= unsigned(count4) + 1;
   elsif (hvalid = '1' and count4="11") then
      rdaddress(9 downto 0) <= UNSIGNED(rdaddress(9 downto 0)) + 1;
      count4 <= unsigned(count4) + 1;
      
   elsif hvalid = '1' then
      rdaddress(9 downto 0) <= rdaddress(9 downto 0);
      count4 <= unsigned(count4) + 1;
   else   
      rdaddress(9 downto 0) <= (others => '0');
      count4 <= "00";
   end if; 

end if;

end process P_COUNTER;

end functional;



     

