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

--synthesis_resources = mux21 2 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  first_nios2_system_id_router_005 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (104 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (104 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END first_nios2_system_id_router_005;

 ARCHITECTURE RTL OF first_nios2_system_id_router_005 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_first_nios2_system_id_router_005_src_channel_24m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_id_router_005_src_channel_25m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_sink_data_range278w330w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range281w329w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_first_nios2_system_id_router_005_src_channel_1_328_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_first_nios2_system_id_router_005_src_channel_2_361_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range278w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range281w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_data_range278w330w(0) <= wire_w_sink_data_range278w(0) AND wire_w_lg_w_sink_data_range281w329w(0);
	wire_w1w(0) <= NOT s_wire_first_nios2_system_id_router_005_src_channel_1_328_dataout;
	wire_w_lg_w_sink_data_range281w329w(0) <= NOT wire_w_sink_data_range281w(0);
	s_wire_first_nios2_system_id_router_005_src_channel_1_328_dataout <= (wire_w_lg_w_sink_data_range278w330w(0) AND (NOT sink_data(94)));
	s_wire_first_nios2_system_id_router_005_src_channel_2_361_dataout <= (((NOT sink_data(92)) AND sink_data(93)) AND (NOT sink_data(94)));
	sink_ready <= src_ready;
	src_channel <= ( "0" & "0" & "0" & "0" & s_wire_first_nios2_system_id_router_005_src_channel_2_361_dataout & wire_first_nios2_system_id_router_005_src_channel_24m_dataout & wire_first_nios2_system_id_router_005_src_channel_25m_dataout);
	src_data <= ( sink_data(104 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range278w(0) <= sink_data(92);
	wire_w_sink_data_range281w(0) <= sink_data(93);
	wire_first_nios2_system_id_router_005_src_channel_24m_dataout <= s_wire_first_nios2_system_id_router_005_src_channel_1_328_dataout AND NOT(s_wire_first_nios2_system_id_router_005_src_channel_2_361_dataout);
	wire_first_nios2_system_id_router_005_src_channel_25m_dataout <= wire_w1w(0) AND NOT(s_wire_first_nios2_system_id_router_005_src_channel_2_361_dataout);

 END RTL; --first_nios2_system_id_router_005
--synopsys translate_on
--VALID FILE
