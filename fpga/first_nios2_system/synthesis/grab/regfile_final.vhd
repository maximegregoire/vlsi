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
	address 		: in std_logic_vector(3 downto 0);
	readdata 		: out std_logic_vector(31 downto 0);
	write_n 		: in std_logic;
	writedata 		: in std_logic_vector(31 downto 0);
	rst 			: in std_logic;
	clk 			: in std_logic;
	
	avalon_int		: out std_logic;
	
	T0INT_set	: in std_logic;
	T1INT_set	: in std_logic;
	
	T0CNT_in 		: 	in std_logic_vector(31 downto 0);	
	T1CNT_in 		: 	in std_logic_vector(31 downto 0);
	
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
	
	VEVALID		:	out std_logic_vector(15 downto 0);
	
	T0CNT 		: 	out std_logic_vector(31 downto 0);	
	T1CNT 		: 	out std_logic_vector(31 downto 0);	
	T0CMP 		: 	out std_logic_vector(31 downto 0);	
	T1CMP 		: 	out std_logic_vector(31 downto 0);	
	GP0 			: 	out std_logic_vector(31 downto 0);	
	GP1 			: 	out std_logic_vector(31 downto 0);
	avalon_inten 	: in std_logic
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
signal	PFMT_sig_sig		: 	 std_logic_vector(1 downto 0);	
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

begin
process(clk)
begin
if clk'event and clk='1' then
-- RESET PROCEDURE
if rst='1' then

GSSHT_sig 			<=  '0';
GSPDG_sig 			<=  '0';
GACTIVE_sig 		<=  '0';
GFMT_sig 			<=  '0';
GMODE_sig 			<= (others	=> '0');	
GXSS_sig 			<= (others	=> '0');	
GYSS_sig				<= (others	=> '0');	
GFSTART_sig 		<= (others	=> '0');	
GLPITCH_sig			<= (others	=> '0');	
SOFIEN_sig 			<= '0';
SOFISTS_sig 		<= '0';
EOFIEN_sig 			<= '0';
EOFISTS_sig 		<= '0';
DMAEN_sig 			<= '0';
DMALR_sig 			<= '0';
DMAFSTART_sig		<= (others	=> '0');		
DMALPITCH_sig		<=	(others	=> '0');	
DMAXSIZE_sig		<= (others	=> '0');	
VGAHZOOM_sig		<= (others	=> '0');	
VGAVZOOM_sig		<= (others	=> '0');	
PFMT_sig_sig		<= (others	=> '0');	
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

-- WRITE PROCEDURE --
if write_n='0' then
case address is
	when "addr" 	=>
		-- RW
		GYSS_sig 	<= writedata(11 downto 10);
		GXSS_sig 	<= writedata(9 downto 8);
		GMODE_sig 	<= writedata(6 downto 5);
		GFMT_sig		<= writedata(4);
		--	WO
		GSSHT_sig	<= writedata(0);
	when "addr" 	=>
		-- RW
		GFSTART_sig(22 downto 1) 	<= writedata(22 downto 1);
	when "addr" 	=>
		-- RW
		GLPITCH_sig(22 downto 1) 	<= writedata(22 downto 1);
	when "addr" 	=>
		-- RW
		SOFIEN 	<= writedata(0);
		EOFIEN	<= writedata(2)
		-- RW2C
		if (writedata(1) = '1') then
			SOFISTS_sig <= '0';
		end if;
		if (writedata(3) = '1') then
			EOFISTS_sig <= '0';
		end if;
	when "addr" 	=>
		-- RW
		DMAEN_sig	<= writedata(0);
		DMALR_sig	<= writedata(1);
	when "addr" 	=>
		-- RW
		DMAFSTART_sig(22 downto 1)	<= writedata(22 downto 1);	
	when "addr"		=>
		-- RW
		DMALPITCH_sig(22 downto 1) <= writedata(22 downto 1);
	when "addr"		=>
		-- RW
		DMAXSIZE(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VGAHZOOM_sig(1 downto 0) <= writedata(1 downto 0);
		VGAVZOOM_sig(1 downto 0) <= writedata(3 downto 2);
		PFMT_sig(1 downto 0) <= writedata(5 downto 4);
	when "addr"		=>
		-- RW
		HTOTAL_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		HSSYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		HESYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		HSVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		HEVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VTOTAL_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VSSYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VESYNC_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VSVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when "addr"		=>
		-- RW
		VEVALID_sig(15 downto 0) <= writedata(15 downto 0);
	when others	=> null;
end case;
end if;
end if;
end if;
end process;

process(T0INTEN_sig, T1INTEN_sig, T0INTSTS_sig, T1INTSTS_sig, T1INTOVR_sig, avalon_inten, T0RST_sig, T1RST_sig, T0CNTEN_sig, T1CNTEN_sig,
T0CMP_sig, T1CMP_sig, GP0_sig, GP1_sig, T0CNT_sig, T1CNT_sig, address)
begin
-- Drive default value to readData output --
	readdata <= (others	=> '0');
	case address is
		when "addr" 	=>
			-- RW
			readdata(0)	<= T0INTEN_sig;
			readdata(1)	<= T1INTEN_sig;
			-- RW2C (TO DO!!!!)
			readdata(2)	<= T0INTSTS_sig;
			readdata(3)	<= T1INTSTS_sig;
			readdata(4)	<= T1INTOVR_sig;
			-- RW
			readdata(5)	<=	NOT(avalon_inten);
		when "0001" 	=>
			-- RW
			readdata(0)	<=	T0RST_sig;
			readdata(1)	<=	T1RST_sig;
			readdata(2)	<=	T0CNTEN_sig;
			readdata(3)	<=	T1CNTEN_sig;
		when "0010" 	=>	
			readdata		<= T0CNT_sig;
		when "0011" 	=> 
			readdata		<= T1CNT_sig;
		when "0100" 	=>
			-- RW
			readdata(31 downto 0)	<=	T0CMP_sig;
		when "0101" 	=>
			-- RW
			readdata(31 downto 0)	<= T1CMP_sig;
		when "0110" 	=>
			-- RW
			readdata(31 downto 0)	<=	GP0_sig;
		when "0111" 	=>
			-- RW
			readdata(31 downto 0)	<=	GP1_sig;
		when others	=> 
		end case;
end process;
	
process(T0INTSTS_sig, T1INTSTS_sig, avalon_inten)
	begin
	avalon_int <= (T0INTSTS_sig OR T1INTSTS_sig) AND avalon_inten;
end process;

	-- Assignment the signals to the outputs
	AVINTDIS		<=	NOT(avalon_inten);
	T1INTOVR		<=	T1INTOVR_sig;
	T1INTSTS		<=	T1INTSTS_sig;
	T0INTSTS		<=	T0INTSTS_sig;
	T1INTEN 		<=	T1INTEN_sig;
	T0INTEN 		<=	T0INTEN_sig;	
	T1CNTEN			<= T1CNTEN_sig;
	T0CNTEN			<= T0CNTEN_sig;
	T1RST			<= T1RST_sig;
	T0RST			<= T0RST_sig;	
	T0CMP			<= T0CMP_sig;	
	T1CMP			<=	T1CMP_sig;	
	
	T0CNT			<= T0CNT_sig;
	T1CNT			<= T1CNT_sig;
	
	GP0				<= GP0_sig;	
	GP1				<= GP1_sig;
end arch;
	
	