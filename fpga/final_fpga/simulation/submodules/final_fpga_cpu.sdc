# Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_internal_jtag|tckutap}
#set_clock_groups -asynchronous -group {altera_internal_jtag|tckutap}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	final_fpga_cpu 	final_fpga_cpu:*
set 	final_fpga_cpu_oci 	final_fpga_cpu_nios2_oci:the_final_fpga_cpu_nios2_oci
set 	final_fpga_cpu_oci_break 	final_fpga_cpu_nios2_oci_break:the_final_fpga_cpu_nios2_oci_break
set 	final_fpga_cpu_ocimem 	final_fpga_cpu_nios2_ocimem:the_final_fpga_cpu_nios2_ocimem
set 	final_fpga_cpu_oci_debug 	final_fpga_cpu_nios2_oci_debug:the_final_fpga_cpu_nios2_oci_debug
set 	final_fpga_cpu_wrapper 	final_fpga_cpu_jtag_debug_module_wrapper:the_final_fpga_cpu_jtag_debug_module_wrapper
set 	final_fpga_cpu_jtag_tck 	final_fpga_cpu_jtag_debug_module_tck:the_final_fpga_cpu_jtag_debug_module_tck
set 	final_fpga_cpu_jtag_sysclk 	final_fpga_cpu_jtag_debug_module_sysclk:the_final_fpga_cpu_jtag_debug_module_sysclk
set 	final_fpga_cpu_oci_path 	 [format "%s|%s" $final_fpga_cpu $final_fpga_cpu_oci]
set 	final_fpga_cpu_oci_break_path 	 [format "%s|%s" $final_fpga_cpu_oci_path $final_fpga_cpu_oci_break]
set 	final_fpga_cpu_ocimem_path 	 [format "%s|%s" $final_fpga_cpu_oci_path $final_fpga_cpu_ocimem]
set 	final_fpga_cpu_oci_debug_path 	 [format "%s|%s" $final_fpga_cpu_oci_path $final_fpga_cpu_oci_debug]
set 	final_fpga_cpu_jtag_tck_path 	 [format "%s|%s|%s" $final_fpga_cpu_oci_path $final_fpga_cpu_wrapper $final_fpga_cpu_jtag_tck]
set 	final_fpga_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $final_fpga_cpu_oci_path $final_fpga_cpu_wrapper $final_fpga_cpu_jtag_sysclk]
set 	final_fpga_cpu_jtag_sr 	 [format "%s|*sr" $final_fpga_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$final_fpga_cpu_oci_break_path|break_readreg*] -to [get_keepers *$final_fpga_cpu_jtag_sr*]
set_false_path -from [get_keepers *$final_fpga_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$final_fpga_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$final_fpga_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$final_fpga_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$final_fpga_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$final_fpga_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$final_fpga_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$final_fpga_cpu_jtag_sr*]
set_false_path -from *$final_fpga_cpu_jtag_sr*    -to *$final_fpga_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$final_fpga_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$final_fpga_cpu_oci_debug_path|monitor_go
