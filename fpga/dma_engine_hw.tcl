# TCL File Generated by Component Editor 13.0
# Wed Nov 20 14:51:06 EST 2013
# DO NOT MODIFY


# 
# dma_engine "dma" v1.0
#  2013.11.20.14:51:06
# 
# 

# 
# request TCL package from ACDS 13.0
# 
package require -exact qsys 13.0


# 
# module dma_engine
# 
set_module_property DESCRIPTION ""
set_module_property NAME dma_engine
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME dma
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL dma_engine
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file dma_engine.vhd VHDL PATH first_nios2_system/synthesis/dma_engine.vhd TOP_LEVEL_FILE

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL dma_engine
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file dma_engine.vhd VHDL PATH first_nios2_system/synthesis/dma_engine.vhd


# 
# parameters
# 
add_parameter size_in INTEGER 8
set_parameter_property size_in DEFAULT_VALUE 8
set_parameter_property size_in DISPLAY_NAME size_in
set_parameter_property size_in TYPE INTEGER
set_parameter_property size_in UNITS None
set_parameter_property size_in HDL_PARAMETER true
add_parameter size_out INTEGER 16
set_parameter_property size_out DEFAULT_VALUE 16
set_parameter_property size_out DISPLAY_NAME size_out
set_parameter_property size_out TYPE INTEGER
set_parameter_property size_out UNITS None
set_parameter_property size_out HDL_PARAMETER true
add_parameter addrsize INTEGER 23
set_parameter_property addrsize DEFAULT_VALUE 23
set_parameter_property addrsize DISPLAY_NAME addrsize
set_parameter_property addrsize TYPE INTEGER
set_parameter_property addrsize UNITS None
set_parameter_property addrsize HDL_PARAMETER true


# 
# display items
# 


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock_sink
set_interface_property avalon_master associatedReset reset_sink
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master readdata readdata Input 16
add_interface_port avalon_master waitrequest waitrequest Input 1
add_interface_port avalon_master readen read Output 1
add_interface_port avalon_master byteenable byteenable Output 2
add_interface_port avalon_master address address Output 32
add_interface_port avalon_master readdata_valid readdatavalid Input 1


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink sclk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink resetN reset_n Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end DMAEN export Input 1
add_interface_port conduit_end DMALR export Input 1
add_interface_port conduit_end DMAFSTART export Input 23
add_interface_port conduit_end DMALPITCH export Input 23
add_interface_port conduit_end DMAXSIZE export Input 23
add_interface_port conduit_end data export Output 32
add_interface_port conduit_end read_address export Input 11
add_interface_port conduit_end write_address export Output 11
add_interface_port conduit_end write_enable export Output 1
add_interface_port conduit_end read_enable export Input 1

