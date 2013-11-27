
--*****************************************************************************
--  $Source: /proj/typhoon/image2/hw/util/emacs/RCS/vhdl.el,v $
--  $Locker:  $
--  $Revision: 1.1 $
--  $Date: 1995/03/09 17:22:04 $
--  $Author: $
--
--   Project      :   [VGA]
--
--   Unite        :   [ADV7181B]
--
--   Description  :   Model for the ADV7181B
--                    
--
--**************************************************************************** 

library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adv7181b is
port (
      -- Avalon signals
      dclk        : buffer     std_logic:='0'; -- decoder output clock
      dpix        : buffer     std_logic_vector(7 downto 0); -- decoder pixel output
      GYSIZE      : in         std_logic_vector(8 downto 0); -- valid line per field
      GXSIZE      : in         std_logic_vector(10 downto 0); -- valid pixel per line
      GVTOTAL     : in         std_logic_vector(9 downto 0); -- total lines per FRAME (including vertical blanking)
      GHTOTAL     : in         std_logic_vector(10 downto 0) -- total pixel per line (including horizontal blanking 
     );
end adv7181b;

architecture functional of adv7181b is


  function to_integer(arg : std_logic_vector) return integer is
    variable result : integer;
  begin
--synopsys synthesis_off
    assert arg'length <= 31
                         report "arg is too large in CONV_INTEGER"
                         severity failure;
--synopsys synthesis_on
    result := 0;
    for i in arg'reverse_range loop
      if arg(i) = '1' then
        result := result + 2 ** i;
      end if;
    end loop;
    return result;
  end;


signal HTOTAL  : std_logic_vector(10 downto 0):="11010110011"; -- 1716-1
signal VTOTAL  : std_logic_vector(9 downto 0):="1000001100"; -- 525-1
signal HSAV    : std_logic_vector(10 downto 0):="00100001111"; -- 4+268-1

--constant F0_VSVALiD : integer := 28;
--constant F0_VEVALiD : integer := 268;
--constant F1_VSVALiD : integer := 281;
--constant F1_VEVALiD : integer := 521;
--constant FIELD_LINE : integer := 261;

signal F0_VSVALiD : integer := 1;
signal F0_VEVALiD : integer := 5;
signal F1_VSVALiD : integer := 9;
signal F1_VEVALiD : integer := 13;
signal FIELD_LINE : integer := 6;

signal    resetN       : std_logic:='0';

signal    hcounter     : std_logic_vector(15 downto 0);
signal    vcounter     : std_logic_vector(15 downto 0);
signal    field        : std_logic:='0';

signal    hvalid       : std_logic;
signal    vvalid       : std_logic;
signal    ramp         : std_logic_vector(7 downto 0);
signal NXTstart_EAV_FF : std_logic;
signal    start_EAV    : std_logic;
signal    start_EAV1p  : std_logic;
signal    start_EAV2p  : std_logic;
signal NXTstart_SAV_FF : std_logic;
signal    start_SAV    : std_logic;
signal    start_SAV1p  : std_logic;
signal    start_SAV2p  : std_logic;
signal    start_SAV3p  : std_logic;
signal    temph         : std_logic_vector(10 downto 0);
signal    tempv         : std_logic_vector(9 downto 0);
signal    tempva         : std_logic_vector(9 downto 0);
signal    tempvb         : std_logic_vector(9 downto 0);
signal    tempvc         : std_logic_vector(9 downto 0);
signal    color          : std_logic;

begin

HSAV <= GHTOTAL-GXSIZE-4; -- -4 to account for SAV code
--HSAV <= '0'&temph(10 downto 1);
tempva <= '0'&GVTOTAL(9 downto 1);
tempvb <= UNSIGNED(tempva) - UNSIGNED(GYSIZE);
tempvc <= '0'&tempvb(9 downto 1);
F0_VSVALiD <= to_integer(tempvc);
F0_VEVALiD <= F0_VSVALID + to_integer(GYSIZE);
tempv <= '0'&GVTOTAL(9 downto 1);
F1_VSVALiD <= F0_VSVALID + to_integer(tempva);
F1_VEVALiD <= F1_VSVALID + to_integer(GYSIZE);
FIELD_LINE <= to_integer(tempv);

VTOTAL <= GVTOTAL;
HTOTAL <= GHTOTAL;


  
-- Orphan processes --
dclk   <= not dclk after 18518 ps; -- 27 MHz
resetN <= '1' after 140 us;
NXTstart_EAV_FF <= '1' when hcounter=HSAV+GXSIZE+4 else '0';
NXTstart_SAV_FF <= '1' when hcounter=HSAV        else '0';


-------------------------------------------------------------------------------
-- Process: P_COUNT
-- Purpose: H and V counters
-------------------------------------------------------------------------------
P_COUNT : process (dclk, resetN)
   
begin  --  process P_COUNT

if (resetN = '0') then
   hcounter <= (others => '0');
   vcounter <= (others => '0');
elsif (dclk'event and dclk='1') then
   -- Horizontal
   hcounter <= unsigned(hcounter) + '1';
   if (hcounter = HTOTAL) then
      hcounter <= (others => '0');
   end if;   
   -- Vertical
   if (hcounter = HTOTAL) then
      if (vcounter = VTOTAL) then
         vcounter <= (others => '0');
         field    <= not field;
      else
         vcounter <= vcounter + '1';
      end if;
      if (vcounter = FIELD_LINE) then
         field <= not field;
      end if;
   end if;
end if;

end process P_COUNT;


-------------------------------------------------------------------------------
-- Process: P_EAV_SAV
-- Purpose: SET EAV SAV code position
-------------------------------------------------------------------------------
P_EAV_SAV : process (dclk, resetN)
   
begin  --  process P_EAV_SAV 

if (resetN = '0') then
   start_EAV <= '0';
   start_SAV <= '0';
   hvalid    <= '0';
   vvalid    <= '0';
elsif (dclk'event and dclk='1') then   
   if (start_SAV3p='1') then
      hvalid <= '1';
   end if;
   if (hcounter = HTOTAL) then
      start_EAV <= '1'; 
      hvalid    <= '0';
      if (field = '0') then
         if (vcounter = F0_VSVALID) then 
            vvalid <= '1';
         elsif (vcounter = F0_VEVALID) then
            vvalid <= '0';
         end if;
      end if;
      if (field = '1') then
         if (vcounter = F1_VSVALID) then
            vvalid <= '1';
         elsif (vcounter = F1_VEVALID) then
            vvalid <= '0';
         end if;
      end if;
   end if;
   if (start_EAV = '1') then
      start_EAV <= '0';
   end if;

   if (hcounter = HSAV) then
      start_SAV <= '1';
   elsif (start_SAV = '1') then
      start_SAV <= '0';
   end if;

end if;

end process P_EAV_SAV;


-------------------------------------------------------------------------------
-- Process: P_PIXEL
-- Purpose:
-------------------------------------------------------------------------------
P_PIXEL : process (dclk, resetN)
   
begin  --  process P_PIXEL

if (resetN <= '0') then
   dpix   <= (others => '0');
   ramp   <= (others => '0');
   color  <= '0';
elsif (dclk'event and dclk='1') then
   if (NXTstart_EAV_FF='1' or NXTstart_SAV_FF='1') then
      dpix <= (others => '1');
   elsif (start_EAV='1' or start_SAV='1' or start_EAV1p='1' or start_SAV1p='1') then
      dpix <= (others => '0');
   elsif (start_EAV2p='1' or start_SAV2p='1') then
      dpix(7) <= '1';
      dpix(6) <= field;
      dpix(5) <= not vvalid;
      dpix(4) <= start_EAV2p;
      dpix(3) <= (not vvalid) xor start_EAV2p;
      dpix(2) <= field  xor start_EAV2p;
      dpix(1) <= field xor (not vvalid);
      dpix(0) <= field xor (not vvalid) xor start_EAV2p;
   elsif (start_SAV3p = '1') then
      ramp <= (others => '0');
      dpix <= x"80";
      color <= '1';
   elsif (hvalid = '1') then   
      if (color = '0') then
         dpix <= x"80";
         color <= '1';
      else
         ramp <= unsigned(ramp) + 1;
         dpix <= ramp;
         color <= '0';
      end if;
   else --  (hvalid = '0') then -- black pixel
      if (hcounter(0) = '1') then
         dpix <= x"80";
      else
         dpix <= x"10";
      end if;
   end if;
end if;
              
end process P_PIXEL;



-------------------------------------------------------------------------------
-- Process: P_REGISTER
-- Purpose:
-------------------------------------------------------------------------------
P_REGISTER : process (dclk, resetN)
   
begin  --  process P_REGISTER 

if (resetN = '0') then
   start_EAV1p <= '0';
   start_EAV2p <= '0';
   start_SAV1p <= '0';
   start_SAV2p <= '0';
   start_SAV3p <= '0';
elsif (dclk'event and dclk='1') then
   start_EAV1p <= start_EAV;
   start_EAV2p <= start_EAV1p;
   start_SAV1p <= start_SAV;
   start_SAV2p <= start_SAV1p;
   start_SAV3p <= start_SAV2p;
end if;

end process P_REGISTER;

end functional;



 
