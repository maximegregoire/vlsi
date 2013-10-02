--IP Functional Simulation Model
--VERSION_BEGIN 13.0 cbx_mgl 2013:04:24:18:11:10:SJ cbx_simgen 2013:04:24:18:08:47:SJ  VERSION_END


-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

--synthesis_resources = mux21 45 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  first_nios2_system_addr_router IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (92 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (92 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END first_nios2_system_addr_router;

 ARCHITECTURE RTL OF first_nios2_system_addr_router IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_15m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_19m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_26m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_29m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_30m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_37m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_39m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_40m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_41m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_48m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_49m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_50m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_51m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_52m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_58m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_59m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_60m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_61m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_62m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_63m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_69m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_70m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_71m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_72m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_73m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_74m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_75m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_21m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_22m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_23m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_32m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_33m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_34m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_43m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_44m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_45m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_54m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_55m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_56m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_65m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_66m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_67m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_76m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_77m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_78m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_0_312_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout :	STD_LOGIC;
 BEGIN

	wire_w1w(0) <= NOT s_wire_first_nios2_system_addr_router_src_channel_0_312_dataout;
	s_wire_first_nios2_system_addr_router_src_channel_0_312_dataout <= ((((((((((((((NOT sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout <= ((((((((((((((((NOT sink_data(40)) AND (NOT sink_data(41))) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout <= (((((((((((((((((NOT sink_data(39)) AND sink_data(40)) AND (NOT sink_data(41))) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout <= ((((((((((((((sink_data(41) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout <= (((((((((((((((((NOT sink_data(39)) AND (NOT sink_data(40))) AND (NOT sink_data(41))) AND (NOT sink_data(42))) AND sink_data(43)) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout <= (((((((((NOT sink_data(47)) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout <= (((((NOT sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND sink_data(55));
	sink_ready <= src_ready;
	src_channel <= ( wire_first_nios2_system_addr_router_src_channel_69m_dataout & wire_first_nios2_system_addr_router_src_channel_70m_dataout & wire_first_nios2_system_addr_router_src_channel_71m_dataout & wire_first_nios2_system_addr_router_src_channel_72m_dataout & wire_first_nios2_system_addr_router_src_channel_73m_dataout & wire_first_nios2_system_addr_router_src_channel_74m_dataout & wire_first_nios2_system_addr_router_src_channel_75m_dataout);
	src_data <= ( sink_data(92 DOWNTO 83) & wire_first_nios2_system_addr_router_src_data_76m_dataout & wire_first_nios2_system_addr_router_src_data_77m_dataout & wire_first_nios2_system_addr_router_src_data_78m_dataout & sink_data(79 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_first_nios2_system_addr_router_src_channel_15m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_0_312_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout);
	wire_first_nios2_system_addr_router_src_channel_19m_dataout <= wire_w1w(0) AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout);
	wire_first_nios2_system_addr_router_src_channel_26m_dataout <= wire_first_nios2_system_addr_router_src_channel_15m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout);
	wire_first_nios2_system_addr_router_src_channel_29m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout);
	wire_first_nios2_system_addr_router_src_channel_30m_dataout <= wire_first_nios2_system_addr_router_src_channel_19m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout);
	wire_first_nios2_system_addr_router_src_channel_37m_dataout <= wire_first_nios2_system_addr_router_src_channel_26m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout);
	wire_first_nios2_system_addr_router_src_channel_39m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout);
	wire_first_nios2_system_addr_router_src_channel_40m_dataout <= wire_first_nios2_system_addr_router_src_channel_29m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout);
	wire_first_nios2_system_addr_router_src_channel_41m_dataout <= wire_first_nios2_system_addr_router_src_channel_30m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout);
	wire_first_nios2_system_addr_router_src_channel_48m_dataout <= wire_first_nios2_system_addr_router_src_channel_37m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_channel_49m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_channel_50m_dataout <= wire_first_nios2_system_addr_router_src_channel_39m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_channel_51m_dataout <= wire_first_nios2_system_addr_router_src_channel_40m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_channel_52m_dataout <= wire_first_nios2_system_addr_router_src_channel_41m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_channel_58m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_59m_dataout <= wire_first_nios2_system_addr_router_src_channel_48m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_60m_dataout <= wire_first_nios2_system_addr_router_src_channel_49m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_61m_dataout <= wire_first_nios2_system_addr_router_src_channel_50m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_62m_dataout <= wire_first_nios2_system_addr_router_src_channel_51m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_63m_dataout <= wire_first_nios2_system_addr_router_src_channel_52m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_channel_69m_dataout <= wire_first_nios2_system_addr_router_src_channel_58m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_channel_70m_dataout <= wire_first_nios2_system_addr_router_src_channel_59m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_channel_71m_dataout <= wire_first_nios2_system_addr_router_src_channel_60m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_channel_72m_dataout <= wire_first_nios2_system_addr_router_src_channel_61m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_channel_73m_dataout <= wire_first_nios2_system_addr_router_src_channel_62m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_channel_74m_dataout <= wire_first_nios2_system_addr_router_src_channel_63m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout;
	wire_first_nios2_system_addr_router_src_channel_75m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_data_21m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_0_312_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout);
	wire_first_nios2_system_addr_router_src_data_22m_dataout <= wire_w1w(0) OR s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout;
	wire_first_nios2_system_addr_router_src_data_23m_dataout <= wire_w1w(0) AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_333_dataout);
	wire_first_nios2_system_addr_router_src_data_32m_dataout <= wire_first_nios2_system_addr_router_src_data_21m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout);
	wire_first_nios2_system_addr_router_src_data_33m_dataout <= wire_first_nios2_system_addr_router_src_data_22m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout);
	wire_first_nios2_system_addr_router_src_data_34m_dataout <= wire_first_nios2_system_addr_router_src_data_23m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_2_354_dataout;
	wire_first_nios2_system_addr_router_src_data_43m_dataout <= wire_first_nios2_system_addr_router_src_data_32m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout;
	wire_first_nios2_system_addr_router_src_data_44m_dataout <= wire_first_nios2_system_addr_router_src_data_33m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout);
	wire_first_nios2_system_addr_router_src_data_45m_dataout <= wire_first_nios2_system_addr_router_src_data_34m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_3_375_dataout;
	wire_first_nios2_system_addr_router_src_data_54m_dataout <= wire_first_nios2_system_addr_router_src_data_43m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout;
	wire_first_nios2_system_addr_router_src_data_55m_dataout <= wire_first_nios2_system_addr_router_src_data_44m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout;
	wire_first_nios2_system_addr_router_src_data_56m_dataout <= wire_first_nios2_system_addr_router_src_data_45m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_396_dataout);
	wire_first_nios2_system_addr_router_src_data_65m_dataout <= wire_first_nios2_system_addr_router_src_data_54m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_data_66m_dataout <= wire_first_nios2_system_addr_router_src_data_55m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_data_67m_dataout <= wire_first_nios2_system_addr_router_src_data_56m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_417_dataout);
	wire_first_nios2_system_addr_router_src_data_76m_dataout <= wire_first_nios2_system_addr_router_src_data_65m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout);
	wire_first_nios2_system_addr_router_src_data_77m_dataout <= wire_first_nios2_system_addr_router_src_data_66m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout;
	wire_first_nios2_system_addr_router_src_data_78m_dataout <= wire_first_nios2_system_addr_router_src_data_67m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_6_438_dataout;

 END RTL; --first_nios2_system_addr_router
--synopsys translate_on
--VALID FILE
