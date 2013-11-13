-- ================================================================================
-- Register File for final project -- Altera DE2 Board
-- ================================================================================
-- Authors : Maxime GrÃ©goire, Patrick White
-- Last modified: 2013
-- ================================================================================
Library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;

entity regfile_final is
port (	
	-- Avalon Interface
	address 		: in std_logic_vector(4 downto 0);
	readdata 		: out std_logic_vector(31 downto 0);
	write_n 		: in std_logic;
	writedata 		: in std_logic_vector(31 downto 0);
	rst 			: in std_logic;
	clk 			: in std_logic;
	
	GACTIVE_IN		: in std_logic;
	GSPDG_IN		: in std_logic;
	
	-- Registers
	GSSHT 		: 	out std_logic;
	GSPDG 		: 	out std_logic;
	GACTIVE 		: 	out std_logic;
	GFMT 			: 	out std_logic;
	GMODE 		: 	out std_logic_vector(1 downto 0);
	GXSS 			: 	out std_logic_vector(1 downto 0);
	GYSS 			: 	out std_logic_vector(1 downto 0);

	GFSTART 		: 	out std_logic_vector(22 downto 0);
	
	GLPITCH		: 	out std_logic_vector(22 downto 0);
	
	SOFIEN 		: 	out std_logic;
	SOFISTS 		: 	out std_logic;	
	EOFIEN 		: 	out std_logic;	
	EOFISTS 		: 	out std_logic;	
	
	DMAEN 		: 	out std_logic;	
	DMALR 		: 	out std_logic;	
	
	DMAFSTART	: 	out std_logic_vector(22 downto 0);	
	
	DMALPITCH	: 	out std_logic_vector(22 downto 0);
	
	DMAXSIZE		: 	out std_logic_vector(15 downto 0);
	
	VGAHZOOM		: 	out std_logic_vector(1 downto 0);
	VGAVZOOM		: 	out std_logic_vector(1 downto 0);
	PFMT			: 	out std_logic_vector(1 downto 0);
	
	HTOTAL		: 	out std_logic_vector(15 downto 0);
	
	HSSYNC		:	out std_logic_vector(15 downto 0);
	
	HESYNC		:	out std_logic_vector(15 downto 0);
	
	HSVALID		: 	out std_logic_vector(15 downto 0);
	
	HEVALID		:	out std_logic_vector(15 downto 0);
	
	VTOTAL		: 	out std_logic_vector(15 downto 0);
	
	VSSYNC		:	out std_logic_vector(15 downto 0);
	
	VESYNC		:	out std_logic_vector(15 downto 0);
	
	VSVALID		:	out std_logic_vector(15 downto 0);
	
	VEVALID		:	out std_logic_vector(15 downto 0)
	  );
end entity regfile_final;

architecture arch of regfile_final is

signal	GSSHT_sig 			: 	 std_logic;
signal	GSPDG_sig 			: 	 std_logic;
signal	GACTIVE_sig 		: 	 std_logic;
signal	GFMT_sig 			: 	 std_logic;
signal	GMODE_sig 			: 	 std_logic_vector(1 downto 0);
signal	GXSS_sig 			: 	 std_logic_vector(1 downto 0);
signal	GYSS_sig				: 	 std_logic_vector(1 downto 0);
signal	GFSTART_sig 		: 	 std_logic_vector(22 downto 0);
signal	GLPITCH_sig			: 	 std_logic_vector(22 downto 0);
signal	SOFIEN_sig 			: 	 std_logic;
signal	SOFISTS_sig 		: 	 std_logic;	
signal	EOFIEN_sig 			: 	 std_logic;	
signal	EOFISTS_sig 		: 	 std_logic;		
signal	DMAEN_sig 			: 	 std_logic;	
signal	DMALR_sig 			: 	 std_logic;		
signal	DMAFSTART_sig		: 	 std_logic_vector(22 downto 0);		
signal	DMALPITCH_sig		: 	 std_logic_vector(22 downto 0);	
signal	DMAXSIZE_sig		: 	 std_logic_vector(15 downto 0);	
signal	VGAHZOOM_sig		: 	 std_logic_vector(1 downto 0);
signal	VGAVZOOM_sig		: 	 std_logic_vector(1 downto 0);
signal	PFMT_sig			: 	 std_logic_vector(1 downto 0);	
signal	HTOTAL_sig			: 	 std_logic_vector(15 downto 0);	
signal	HSSYNC_sig			:	 std_logic_vector(15 downto 0);	
signal	HESYNC_sig			:	 std_logic_vector(15 downto 0);	
signal	HSVALID_sig			: 	 std_logic_vector(15 downto 0);	
signal	HEVALID_sig			:	 std_logic_vector(15 downto 0);
signal	VTOTAL_sig			: 	 std_logic_vector(15 downto 0);
signal	VSSYNC_sig			:	 std_logic_vector(15 downto 0);
signal	VESYNC_sig			:	 std_logic_vector(15 downto 0);
signal	VSVALID_sig			:	 std_logic_vector(15 downto 0);
signal	VEVALID_sig			:	 std_logic_vector(15 downto 0);

signal SOFISTS_set			: 		std_logic;
signal EOFISTS_set			: 		std_logic;

signal GACTIVE_1P			: 		std_logic;


begin

GACTIVE_sig <= GACTIVE_IN;
GSPDG_sig <= GSPDG_IN;


process(clk, rst, GACTIVE_sig, GACTIVE_1P)
begin
if rst = '1' then
   SOFISTS_set <= '0';
   EOFISTS_set <= '0';
   GACTIVE_1P <= '0';
elsif clk'event and clk ='1' then

	GACTIVE_1P <= GACTIVE_sig;
	
if GACTIVE_1P = '0' and GACTIVE_sig = '1' then -- rising edge detection
   SOFISTS_set <= '1';
else
   SOFISTS_set <= '0';
end if;

if GACTIVE_1P = '1' and GACTIVE_sig = '0' then -- falling edge detection
   EOFISTS_set <= '1';
else
   EOFISTS_set <= '0';
end if;

end if;
end process;

process(clk, rst, SOFISTS_set, SOFISTS_sig)
begin

if rst = '1' then
   SOFISTS_sig <= '0';
elsif clk'event and clk='1' then

	SOFISTS_sig <= SOFISTS_sig;
	
if SOFISTS_set = '1' then
   SOFISTS_sig <= '1';
-- elsif SOFISTS_set = '0' then -- handled by write to clear
   --SOFISTS_sig <= '0';
end if;

end if;
end process;

process(clk, rst, EOFISTS_set, EOFISTS_sig)
begin
if rst = '1' then
   EOFISTS_sig <= '0';
elsif clk'event and clk='1' then

	EOFISTS_sig <= EOFISTS_sig;
	
if EOFISTS_set = '1' then
   EOFISTS_sig <= '1';
-- elsif EOFISTS_set = '0' then -- handled by write to clear
   --EOFISTS_sig <= '0';
end if;

end if;
end process;


process(clk)
begin
if clk'event and clk='1' then
-- RESET PROCEDURE
if rst='1' then
GSSHT_sig 			<=  '0';
GFMT_sig 			<=  '0';
GMODE_sig 			<= (others	=> '0');	
GXSS_sig 			<= (others	=> '0');	
GYSS_sig				<= (others	=> '0');	
GFSTART_sig 		<= (others	=> '0');	
GLPITCH_sig			<= (others	=> '0');	
SOFIEN_sig 			<= '0';
--SOFISTS_sig 		<= '0';
EOFIEN_sig 			<= '0';
--EOFISTS_sig 		<= '0';
DMAEN_sig 			<= '0';
DMALR_sig 			<= '0';
DMAFSTART_sig		<= (others	=> '0');		
DMALPITCH_sig		<=	(others	=> '0');	
DMAXSIZE_sig		<= (others	=> '0');	
VGAHZOOM_sig		<= (others	=> '0');	
VGAVZOOM_sig		<= (others	=> '0');	
PFMT_sig			<= (others	=> '0');	
HTOTAL_sig			<= (others	=> '0');		
HSSYNC_sig			<=	(others	=> '0');	
HESYNC_sig			<=	(others	=> '0');	
HSVALID_sig			<= (others	=> '0');		
HEVALID_sig			<=	(others	=> '0');	
VTOTAL_sig			<= (others	=> '0');	
VSSYNC_sig			<=	(others	=> '0');	
VESYNC_sig			<=	(others	=> '0');	
VSVALID_sig			<= (others	=> '0');
VEVALID_sig			<=	(others	=> '0');	

-- READ AND WRITE PROCEDURE --
else
-- If not in reset, force counters count onto count signal

if (GSSHT_sig = '1') then
GSSHT_sig <= '0';
end if;

-- WRITE PROCEDURE --
if write_n='0' then
case address is
	when "00000" 	=>
		-- RW
		GYSS_sig 	<= writedata(11 downto 10);
		GXSS_sig 	<= writedata(9 downto 8);
		GMODE_sig 	<= writedata(6 downto 5);
		GFMT_sig	<= writedata(4);
		--	WO
		if (GSSHT_sig = '0') then
		GSSHT_sig	<= writedata(0);
		end if;		
	when "00001" 	=>
		-- RW
		GFSTART_sig(22 downto 1) 	<= writedata(22 downto 1);
	when "00010" 	=>
		-- RW
		GLPITCH_sig(22 downto 1) 	<= writedata(22 downto 1);
	when "00011" 	=>
		-- RW
		SOFIEN_sig 	<= writedata(0);
		EOFIEN_sig	<= writedata(2);
		-- RW2C
		if (writedata(1) = '1') then
			SOFISTS_sig <= '0';
		end if;
		if (writedata(3) = '1') then
			EOFISTS_sig <= '0';
		end if;
	when "00100" 	=>
		-- RW
		DMAEN_sig	<= writedata(0);
		DMALR_sig	<= writedata(1);
	when "00101" 	=>
		-- RW
		DMAFSTART_sig(22 downto 1)	<= writedata(22 downto 1);	
	when "00110"		=>
		-- RW
		DMALPITCH_sig(22 downto 1) <= writedata(22 downto 1);
	when "00111"		=>
		-- RW
		DMAXSIZE(15 downto 0) <= writedata(15 downto 0);
	when "01000"		=>
		-- RW
		VGAHZOOM_sig(1 downto 0) <= writedata(1 downto 0);
		VGAVZOOM_sig(1 downto 0) <= writedata(3 downto 2);
		PFMT_sig(1 downto 0) <= writedata(5 downto 4);
	when "01001"		=>
		-- RW
		HTOTAL_sig(15 downto 0) <= writedata(15 downto 0);
	when "01010"		=>
		-- RW
		HSSYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "01011"		=>
		-- RW
		HESYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "01100"		=>
		-- RW
		HSVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "01101"		=>
		-- RW
		HEVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "01110"		=>
		-- RW
		VTOTAL_sig(15 downto 0) <= writedata(15 downto 0);
	when "01111"		=>
		-- RW
		VSSYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "10000"		=>
		-- RW
		VESYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "10001"		=>
		-- RW
		VSVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "10010"		=>
		-- RW
		VEVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when others	=> null;
end case;
end if;
end if;
end if;
end process;

process(GSSHT_sig, GSPDG_sig, GACTIVE_sig, GFMT_sig, GMODE_sig, GXSS_sig, GYSS_sig,	GFSTART_sig, 	
		GLPITCH_sig, SOFIEN_sig, SOFISTS_sig, EOFIEN_sig, EOFISTS_sig, DMAEN_sig, DMALR_sig, DMAFSTART_sig,	
		DMALPITCH_sig, DMAXSIZE_sig, VGAHZOOM_sig, VGAVZOOM_sig, PFMT_sig, HTOTAL_sig, HSSYNC_sig,		
		HESYNC_sig, HSVALID_sig, HEVALID_sig, VTOTAL_sig, VSSYNC_sig, VESYNC_sig, VSVALID_sig, VEVALID_sig, address)
begin
-- Drive default value to readData output --
	readdata <= (others	=> '0');
	case address is
		when "00000" 	=>
			readdata(0) <= GSSHT_sig;
			readdata(1) <= GSPDG_sig;
			readdata(3) <= GACTIVE_sig;
			readdata(4) <= GFMT_sig;
			readdata(6 downto 5) <= GMODE_sig;
			readdata(9 downto 8) <= GXSS_sig;
			readdata(11 downto 10) <= GYSS_sig;
		when "00001" 	=>
			readdata(22 downto 0) <= GFSTART_sig;
		when "00010" 	=>	
			readdata(22 downto 0) <= GLPITCH_sig;
		when "00011" 	=> 
			readdata(0) <= SOFIEN_sig;
			readdata(1) <= SOFISTS_sig;
			readdata(2) <= EOFIEN_sig;
			readdata(3) <= EOFISTS_sig;
		when "00100" 	=>
			readdata(0) <= DMAEN_sig;
			readdata(1) <= DMALR_sig;
		when "00101" 	=>
			readdata(22 downto 0) <= DMAFSTART_sig;
		when "00110" 	=>
			readdata(22 downto 0)	<= DMALPITCH_sig;
		when "00111" 	=>
			readdata(15 downto 0)	<= DMAXSIZE_sig;	
		when "01000" 	=>
			readdata(1 downto 0)	<= VGAHZOOM_sig;	
			readdata(3 downto 2)	<= VGAVZOOM_sig;
			readdata(5 downto 4)	<= PFMT_sig;		
		when "01001" 	=>
			readdata(15 downto 0)	<= HTOTAL_sig;	
		when "01010" 	=>
			readdata(15 downto 0)	<= HSSYNC_sig;	
		when "01011" 	=>
			readdata(15 downto 0)	<= HESYNC_sig;
		when "01100" 	=>
			readdata(15 downto 0)	<= HSVALID_sig;
		when "01101" 	=>
			readdata(15 downto 0)	<= HEVALID_sig;
		when "01110" 	=>
			readdata(15 downto 0)	<= VTOTAL_sig;
		when "01111" 	=>
			readdata(15 downto 0)	<= VSSYNC_sig;
		when "10000" 	=>
			readdata(15 downto 0)	<= VESYNC_sig;
		when "10001" 	=>
			readdata(15 downto 0)	<= VSVALID_sig;
		when "10010"	=>
			readdata(15 downto 0)	<= VEVALID_sig;
		when others	=> 
		end case;
end process;

	-- Assignment the signals to the outputs
	GSSHT 		<= GSSHT_sig;
	GSPDG		<= GSPDG_sig; 		
	GACTIVE		<= GACTIVE_sig; 	
	GFMT		<= GFMT_sig; 		
	GMODE		<= GMODE_sig; 		
	GXSS		<= GXSS_sig; 		
	GYSS		<= GYSS_sig;		
	GFSTART 	<= GFSTART_sig; 	
	GLPITCH		<= GLPITCH_sig;		
	SOFIEN		<= SOFIEN_sig; 		
	SOFISTS		<= SOFISTS_sig; 	
	EOFIEN		<= EOFIEN_sig; 		
	EOFISTS		<= EOFISTS_sig; 	
	DMAEN 		<= DMAEN_sig; 		
	DMALR 		<= DMALR_sig; 		
	DMAFSTART	<= DMAFSTART_sig;	
	DMALPITCH	<= DMALPITCH_sig;	
	DMAXSIZE	<= DMAXSIZE_sig;	
	VGAHZOOM	<= VGAHZOOM_sig;	
	VGAVZOOM	<= VGAVZOOM_sig;	
	PFMT		<= PFMT_sig;		
	HTOTAL		<= HTOTAL_sig;		
	HSSYNC		<= HSSYNC_sig;		
	HESYNC		<= HESYNC_sig;		
	HSVALID		<= HSVALID_sig;		
	HEVALID		<= HEVALID_sig;		
	VTOTAL		<= VTOTAL_sig;		
	VSSYNC		<= VSSYNC_sig;		
	VESYNC		<= VESYNC_sig;		
	VSVALID		<= VSVALID_sig;		
	VEVALID		<= VEVALID_sig;		

end arch;
	
	