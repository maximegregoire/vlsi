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

--synthesis_resources = mux21 4 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  first_nios2_system_addr_router_002 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (86 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (86 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END first_nios2_system_addr_router_002;

 ARCHITECTURE RTL OF first_nios2_system_addr_router_002 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_first_nios2_system_addr_router_002_src_channel_18m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_002_src_channel_19m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_002_src_data_20m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_first_nios2_system_addr_router_002_src_data_21m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_first_nios2_system_addr_router_002_src_channel_0_248_dataout :	STD_LOGIC;
 BEGIN

	wire_w1w(0) <= NOT s_wire_first_nios2_system_addr_router_002_src_channel_0_248_dataout;
	s_wire_first_nios2_system_addr_router_002_src_channel_0_248_dataout <= ((((((((((((((((((NOT sink_data(24)) AND (NOT sink_data(25))) AND (NOT sink_data(26))) AND (NOT sink_data(27))) AND (NOT sink_data(28))) AND (NOT sink_data(29))) AND (NOT sink_data(30))) AND (NOT sink_data(31))) AND (NOT sink_data(32))) AND (NOT sink_data(33))) AND (NOT sink_data(34))) AND (NOT sink_data(35))) AND (NOT sink_data(36))) AND (NOT sink_data(37))) AND (NOT sink_data(38))) AND (NOT sink_data(39))) AND (NOT sink_data(40))) AND (NOT sink_data(41)));
	sink_ready <= src_ready;
	src_channel <= ( "0" & "0" & "0" & "0" & "0" & wire_first_nios2_system_addr_router_002_src_channel_18m_dataout & wire_first_nios2_system_addr_router_002_src_channel_19m_dataout);
	src_data <= ( sink_data(86 DOWNTO 77) & wire_first_nios2_system_addr_router_002_src_data_20m_dataout & wire_first_nios2_system_addr_router_002_src_data_21m_dataout & "0" & sink_data(73 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_first_nios2_system_addr_router_002_src_channel_18m_dataout <= wire_w1w(0) OR sink_data(41);
	wire_first_nios2_system_addr_router_002_src_channel_19m_dataout <= s_wire_first_nios2_system_addr_router_002_src_channel_0_248_dataout AND NOT(sink_data(41));
	wire_first_nios2_system_addr_router_002_src_data_20m_dataout <= s_wire_first_nios2_system_addr_router_002_src_channel_0_248_dataout AND NOT(sink_data(41));
	wire_first_nios2_system_addr_router_002_src_data_21m_dataout <= wire_w1w(0) OR sink_data(41);

 END RTL; --first_nios2_system_addr_router_002
--synopsys translate_on
--VALID FILE
