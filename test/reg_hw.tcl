# TCL File Generated by Component Editor 13.0
# Thu Oct 03 08:44:13 EDT 2013
# DO NOT MODIFY


# 
# reg "reg" v1.0
#  2013.10.03.08:44:13
# 
# 

# 
# request TCL package from ACDS 13.0
# 
package require -exact qsys 13.0


# 
# module reg
# 
set_module_property DESCRIPTION ""
set_module_property NAME reg
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME reg
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL regfile
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file regfile.vhd VHDL PATH regfile.vhd TOP_LEVEL_FILE

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL regfile
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file regfile.vhd VHDL PATH regfile.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 readLatency 1
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 address address Input 4
add_interface_port avalon_slave_0 readdata readdata Output 32
add_interface_port avalon_slave_0 write_n write_n Input 1
add_interface_port avalon_slave_0 writedata writedata Input 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 50000000
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rst reset Input 1


# 
# connection point conduit
# 
add_interface conduit conduit end
set_interface_property conduit associatedClock clock
set_interface_property conduit associatedReset reset
set_interface_property conduit ENABLED true
set_interface_property conduit EXPORT_OF ""
set_interface_property conduit PORT_NAME_MAP ""
set_interface_property conduit SVD_ADDRESS_GROUP ""

add_interface_port conduit AVINTDIS export Output 1
add_interface_port conduit T1INTOVR export Output 1
add_interface_port conduit T1INTSTS export Output 1
add_interface_port conduit T0INTSTS export Output 1
add_interface_port conduit T1INTEN export Output 1
add_interface_port conduit T0INTEN export Output 1
add_interface_port conduit T1CNTEN export Output 1
add_interface_port conduit T0CNTEN export Output 1
add_interface_port conduit T1RST export Output 1
add_interface_port conduit T0RST export Output 1
add_interface_port conduit T0CNT export Output 32
add_interface_port conduit T1CNT export Output 32
add_interface_port conduit T0CMP export Output 32
add_interface_port conduit T1CMP export Output 32
add_interface_port conduit GP0 export Output 32
add_interface_port conduit GP1 export Output 32
