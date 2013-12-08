
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
end entity vga;

architecture functional of vga is

signal hcounter : std_logic_vector(15 downto 0);
signal vcounter : std_logic_vector(15 downto 0);
signal hvalid   : std_logic;
signal hvalid1p   : std_logic;
signal vvalid   : std_logic;
signal count4   : std_logic_vector(1 downto 0);
signal framecnt : std_logic_vector(7 downto 0);

signal hsync_1p	: std_logic;
signal vsync_1p : std_logic;

signal set_SOL : std_logic;
signal set_SOF : std_logic;

signal first_line_rst : std_logic;
signal first_line : std_logic;

signal lineOddEven_sig : std_logic;

begin

clockdac      <=  not dclk; -- inverted to respect hold and setup
syncN         <= '0'; -- No composite sync required (on green component)
blankN        <= vvalid and hvalid; -- FIXME (pipeline missing)
rden          <= vvalid and hvalid; 
rdaddress(10) <= not lineOddEven_sig; 

 -- monochrome
P_DATAOUT : process (SW,linebufout)
begin
if (SW(2) = '0') then
   red     <= linebufout(31 downto 24)&"00";
   green   <= linebufout(31 downto 24)&"00";
   blue    <= linebufout(31 downto 24)&"00";
-- Hardcoded color (PINK)
else
   red     <= "1111111100";
   green   <= "0110011000";
   blue    <= "1111111100";
end if;

end process P_DATAOUT;

-- SOL
process (dclk, rstN)
begin
if rstN = '0' then
	hsync_1p <= '1';
	set_SOL <= '0';
elsif dclk = '1' and dclk'event then
	hsync_1p <= hsyncN;
	set_SOL <= '0';
	if hsync_1p = '1' and hsyncN = '0' and vvalid = '1' then
		set_SOL  <= '1';
	end if;
end if;
end process;

-- SOF
process (dclk, rstN)
begin
if rstN = '0' then
	vsync_1p <= '1';
	set_SOF <= '0';
elsif dclk = '1' and dclk'event then
	vsync_1p <= vsyncN;
	set_SOF <= '0';
	if vsync_1p = '1' and vsyncN = '0' then
		set_SOF  <= '1';
	end if;
end if;
end process;

process (dclk, rstN)
begin
if rstN = '0' then
	lineOddEven_sig <= '1';
	first_line_rst <= '0';
elsif dclk = '1' and dclk'event then
		first_line_rst <= '0';
	if set_SOL = '1' and first_line = '0' then
		if lineOddEven_sig = '1' then
			lineOddEven_sig <= '0';
		elsif lineOddEven_sig = '0' then
			lineOddEven_sig <= '1';
		end if;
	elsif set_SOL = '1' then
		first_line_rst <= '1';
		lineOddEven_sig <= '1';
	end if;
end if;
end process;


process (dclk, rstN)
begin
if rstN = '0' then
	first_line <= '0';
elsif dclk = '1' and dclk'event then
	if set_SOF = '1' then
		first_line <= '1';
	elsif first_line_rst = '1' then
		first_line <= '0';
	end if;
end if;
end process;

-------------------------------------------------------------------------------
-- Process: P_COUNTER
-- Purpose:
-------------------------------------------------------------------------------
P_COUNTER : process (dclk, rstN)
   
begin  --  process P_COUNTER

if (rstN = '0') then
   hcounter <= (others => '0');
   vcounter <= (others => '0');
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
   if (hcounter=HTOTAL) then
      hcounter <= (others => '0');
      hsyncN   <= '0';
      if (vcounter = VTOTAL) then
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
   else
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
      rdaddress(9 downto 0) <= UNSIGNED(rdaddress(9 downto 0)) + 1; --+ framecnt; // Remove to start at raddress 0
      count4 <= unsigned(count4) + 1;
   --elsif (hvalid = '1' and count4="11") then -- will perform a 4x zoom
   --   rdaddress(9 downto 0) <= UNSIGNED(rdaddress(9 downto 0)) + 1;
   --   count4 <= unsigned(count4) + 1;
   elsif hvalid = '1' then
      rdaddress(9 downto 0) <= rdaddress(9 downto 0) + 1;
      count4 <= unsigned(count4) + 1;
   else   
      rdaddress(9 downto 0) <= (others => '0');
      count4 <= "00";
   end if; 

end if;

end process P_COUNTER;

SOL <= set_SOL;
SOF <= set_SOF;

end functional;



     

