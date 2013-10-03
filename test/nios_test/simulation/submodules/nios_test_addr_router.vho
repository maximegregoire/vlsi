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

--synthesis_resources = mux21 9 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  nios_test_addr_router IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (87 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (2 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (87 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END nios_test_addr_router;

 ARCHITECTURE RTL OF nios_test_addr_router IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_nios_test_addr_router_src_channel_10m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_channel_15m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_channel_16m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_channel_17m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_channel_9m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_data_12m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_data_13m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_data_18m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios_test_addr_router_src_data_19m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_sink_data_range143w286w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range146w276w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_nios_test_addr_router_src_channel_0_231_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_nios_test_addr_router_src_channel_1_249_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_nios_test_addr_router_src_channel_2_267_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range143w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range146w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_data_range143w286w(0) <= wire_w_sink_data_range143w(0) AND wire_w_lg_w_sink_data_range146w276w(0);
	wire_w1w(0) <= NOT s_wire_nios_test_addr_router_src_channel_0_231_dataout;
	wire_w_lg_w_sink_data_range146w276w(0) <= NOT wire_w_sink_data_range146w(0);
	s_wire_nios_test_addr_router_src_channel_0_231_dataout <= (((((((((((NOT sink_data(42)) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND wire_w_lg_w_sink_data_range146w276w(0)) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52)));
	s_wire_nios_test_addr_router_src_channel_1_249_dataout <= ((((wire_w_lg_w_sink_data_range143w286w(0) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52)));
	s_wire_nios_test_addr_router_src_channel_2_267_dataout <= ((NOT sink_data(51)) AND sink_data(52));
	sink_ready <= src_ready;
	src_channel <= ( wire_nios_test_addr_router_src_channel_15m_dataout & wire_nios_test_addr_router_src_channel_16m_dataout & wire_nios_test_addr_router_src_channel_17m_dataout);
	src_data <= ( sink_data(87 DOWNTO 78) & wire_nios_test_addr_router_src_data_18m_dataout & wire_nios_test_addr_router_src_data_19m_dataout & sink_data(75 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range143w(0) <= sink_data(47);
	wire_w_sink_data_range146w(0) <= sink_data(48);
	wire_nios_test_addr_router_src_channel_10m_dataout <= wire_w1w(0) AND NOT(s_wire_nios_test_addr_router_src_channel_1_249_dataout);
	wire_nios_test_addr_router_src_channel_15m_dataout <= wire_nios_test_addr_router_src_channel_9m_dataout AND NOT(s_wire_nios_test_addr_router_src_channel_2_267_dataout);
	wire_nios_test_addr_router_src_channel_16m_dataout <= wire_nios_test_addr_router_src_channel_10m_dataout OR s_wire_nios_test_addr_router_src_channel_2_267_dataout;
	wire_nios_test_addr_router_src_channel_17m_dataout <= s_wire_nios_test_addr_router_src_channel_1_249_dataout AND NOT(s_wire_nios_test_addr_router_src_channel_2_267_dataout);
	wire_nios_test_addr_router_src_channel_9m_dataout <= s_wire_nios_test_addr_router_src_channel_0_231_dataout AND NOT(s_wire_nios_test_addr_router_src_channel_1_249_dataout);
	wire_nios_test_addr_router_src_data_12m_dataout <= s_wire_nios_test_addr_router_src_channel_0_231_dataout AND NOT(s_wire_nios_test_addr_router_src_channel_1_249_dataout);
	wire_nios_test_addr_router_src_data_13m_dataout <= wire_w1w(0) AND NOT(s_wire_nios_test_addr_router_src_channel_1_249_dataout);
	wire_nios_test_addr_router_src_data_18m_dataout <= wire_nios_test_addr_router_src_data_12m_dataout AND NOT(s_wire_nios_test_addr_router_src_channel_2_267_dataout);
	wire_nios_test_addr_router_src_data_19m_dataout <= wire_nios_test_addr_router_src_data_13m_dataout OR s_wire_nios_test_addr_router_src_channel_2_267_dataout;

 END RTL; --nios_test_addr_router
--synopsys translate_on
--VALID FILE
