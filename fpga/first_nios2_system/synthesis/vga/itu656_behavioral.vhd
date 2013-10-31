
--*****************************************************************************
--  $Source: /proj/typhoon/image2/hw/util/emacs/RCS/vhdl.el,v $
--  $Locker:  $
--  $Revision: 1.1 $
--  $Date: 1995/03/09 17:22:04 $
--  $Author: $
--
--   Project      :   [VGA]
--
--   Unite        :   [ITU 656 Decoder]
--
--   Description  :   Initialize line buffer with pattern.
--                    Modelize ITU decoder.
--
--**************************************************************************** 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity itu656_behavioral is
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
end itu656_behavioral;

architecture functional of itu656_behavioral is

component linebuffer IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wraddress	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;


signal    colpix    : std_logic_vector(31 downto 0);
signal    data      : std_logic_vector(7 downto 0);
signal    wren      : std_logic;
signal    wraddr    : std_logic_vector(10 downto 0);
signal NXTresetN    : std_logic;


begin

hrst        <= '0';
vrst        <= '0';
lineOddEven <= '1';
colpix      <= data&data&data&data;
NXTresetN   <= switch0;

xlinebuffer : linebuffer
PORT map
(
clock     => dclk,
data      => colpix,
rdaddress => rdaddress,
wraddress => wraddr,
wren      => wren,
q	  => linebufout
);


-------------------------------------------------------------------------------
--  Process: P_INIT_LINEBUF
--  Purpose: init line buffer with a data ramp.
-------------------------------------------------------------------------------
P_INIT_LINEBUF : process (NXTresetN, dclk)
   
begin  

if (NXTresetN = '0') then
   wren     <= '0';
   wraddr   <= (others => '0');
   data     <= (others => '0');
elsif (dclk'event and dclk='1') then
   if (wraddr = 0 and wren = '0') then
      wren <= '1';
   elsif (wraddr /= 360 and wren='1') then
      wren     <= '1';
      wraddr   <= UNSIGNED(wraddr) + 1;
      if (data /= 255) then
        data <= UNSIGNED(data) + 4;
      else
         data <= (others => '0');
      end if;
   else
     wren <= '0';
     wraddr <= wraddr;
   end if;   
end if;
   
end process P_INIT_LINEBUF;
 

end functional;
