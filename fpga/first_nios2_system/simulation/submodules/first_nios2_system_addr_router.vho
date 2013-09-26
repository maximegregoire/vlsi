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

--synthesis_resources = mux21 35 
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
		 src_channel	:	OUT  STD_LOGIC_VECTOR (5 DOWNTO 0);
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
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_13m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_17m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_23m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_26m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_27m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_33m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_35m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_36m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_37m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_43m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_44m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_45m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_46m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_47m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_53m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_54m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_55m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_56m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_57m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_channel_58m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_19m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_20m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_21m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_29m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_30m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_31m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_39m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_40m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_41m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_49m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_50m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_51m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_59m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_60m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_src_data_61m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_0_293_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout :	STD_LOGIC;
 BEGIN

	wire_w1w(0) <= NOT s_wire_first_nios2_system_addr_router_src_channel_0_293_dataout;
	s_wire_first_nios2_system_addr_router_src_channel_0_293_dataout <= ((((((((((((((NOT sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout <= ((((((((((((((((NOT sink_data(40)) AND (NOT sink_data(41))) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout <= (((((((((((((((((NOT sink_data(39)) AND sink_data(40)) AND (NOT sink_data(41))) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout <= ((((((((((((((sink_data(41) AND sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout <= (((((((((NOT sink_data(47)) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout <= (((((NOT sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND sink_data(55));
	sink_ready <= src_ready;
	src_channel <= ( wire_first_nios2_system_addr_router_src_channel_53m_dataout & wire_first_nios2_system_addr_router_src_channel_54m_dataout & wire_first_nios2_system_addr_router_src_channel_55m_dataout & wire_first_nios2_system_addr_router_src_channel_56m_dataout & wire_first_nios2_system_addr_router_src_channel_57m_dataout & wire_first_nios2_system_addr_router_src_channel_58m_dataout);
	src_data <= ( sink_data(92 DOWNTO 83) & wire_first_nios2_system_addr_router_src_data_59m_dataout & wire_first_nios2_system_addr_router_src_data_60m_dataout & wire_first_nios2_system_addr_router_src_data_61m_dataout & sink_data(79 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_first_nios2_system_addr_router_src_channel_13m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_0_293_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout);
	wire_first_nios2_system_addr_router_src_channel_17m_dataout <= wire_w1w(0) AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout);
	wire_first_nios2_system_addr_router_src_channel_23m_dataout <= wire_first_nios2_system_addr_router_src_channel_13m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout);
	wire_first_nios2_system_addr_router_src_channel_26m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout);
	wire_first_nios2_system_addr_router_src_channel_27m_dataout <= wire_first_nios2_system_addr_router_src_channel_17m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout);
	wire_first_nios2_system_addr_router_src_channel_33m_dataout <= wire_first_nios2_system_addr_router_src_channel_23m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout);
	wire_first_nios2_system_addr_router_src_channel_35m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout);
	wire_first_nios2_system_addr_router_src_channel_36m_dataout <= wire_first_nios2_system_addr_router_src_channel_26m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout);
	wire_first_nios2_system_addr_router_src_channel_37m_dataout <= wire_first_nios2_system_addr_router_src_channel_27m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout);
	wire_first_nios2_system_addr_router_src_channel_43m_dataout <= wire_first_nios2_system_addr_router_src_channel_33m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_channel_44m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_channel_45m_dataout <= wire_first_nios2_system_addr_router_src_channel_35m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_channel_46m_dataout <= wire_first_nios2_system_addr_router_src_channel_36m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_channel_47m_dataout <= wire_first_nios2_system_addr_router_src_channel_37m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_channel_53m_dataout <= wire_first_nios2_system_addr_router_src_channel_43m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_channel_54m_dataout <= wire_first_nios2_system_addr_router_src_channel_44m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_channel_55m_dataout <= wire_first_nios2_system_addr_router_src_channel_45m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_channel_56m_dataout <= wire_first_nios2_system_addr_router_src_channel_46m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_channel_57m_dataout <= wire_first_nios2_system_addr_router_src_channel_47m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout;
	wire_first_nios2_system_addr_router_src_channel_58m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_data_19m_dataout <= s_wire_first_nios2_system_addr_router_src_channel_0_293_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout);
	wire_first_nios2_system_addr_router_src_data_20m_dataout <= wire_w1w(0) OR s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout;
	wire_first_nios2_system_addr_router_src_data_21m_dataout <= wire_w1w(0) AND NOT(s_wire_first_nios2_system_addr_router_src_channel_1_314_dataout);
	wire_first_nios2_system_addr_router_src_data_29m_dataout <= wire_first_nios2_system_addr_router_src_data_19m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout);
	wire_first_nios2_system_addr_router_src_data_30m_dataout <= wire_first_nios2_system_addr_router_src_data_20m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout);
	wire_first_nios2_system_addr_router_src_data_31m_dataout <= wire_first_nios2_system_addr_router_src_data_21m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_2_335_dataout;
	wire_first_nios2_system_addr_router_src_data_39m_dataout <= wire_first_nios2_system_addr_router_src_data_29m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout;
	wire_first_nios2_system_addr_router_src_data_40m_dataout <= wire_first_nios2_system_addr_router_src_data_30m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout);
	wire_first_nios2_system_addr_router_src_data_41m_dataout <= wire_first_nios2_system_addr_router_src_data_31m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_3_356_dataout;
	wire_first_nios2_system_addr_router_src_data_49m_dataout <= wire_first_nios2_system_addr_router_src_data_39m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_data_50m_dataout <= wire_first_nios2_system_addr_router_src_data_40m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_data_51m_dataout <= wire_first_nios2_system_addr_router_src_data_41m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_4_377_dataout);
	wire_first_nios2_system_addr_router_src_data_59m_dataout <= wire_first_nios2_system_addr_router_src_data_49m_dataout AND NOT(s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout);
	wire_first_nios2_system_addr_router_src_data_60m_dataout <= wire_first_nios2_system_addr_router_src_data_50m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout;
	wire_first_nios2_system_addr_router_src_data_61m_dataout <= wire_first_nios2_system_addr_router_src_data_51m_dataout OR s_wire_first_nios2_system_addr_router_src_channel_5_398_dataout;

 END RTL; --first_nios2_system_addr_router
--synopsys translate_on
--VALID FILE
