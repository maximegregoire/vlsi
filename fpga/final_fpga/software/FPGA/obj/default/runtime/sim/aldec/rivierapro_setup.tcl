
# (C) 2001-2013 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0 156 win32 2013.12.02.18:36:12

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize the variable
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
} 

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "final_fpga_tb"
} 

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
} 

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/13.0/quartus/"
} 

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ic_tag_ram.dat ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ic_tag_ram.hex ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ic_tag_ram.mif ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ociram_default_contents.dat ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ociram_default_contents.hex ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_ociram_default_contents.mif ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_a.dat ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_a.hex ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_a.mif ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_b.dat ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_b.hex ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_rf_ram_b.mif ./
  file copy -force C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_onchip_mem.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                  ./libraries/altera_ver      
vmap       altera_ver       ./libraries/altera_ver      
ensure_lib                  ./libraries/lpm_ver         
vmap       lpm_ver          ./libraries/lpm_ver         
ensure_lib                  ./libraries/sgate_ver       
vmap       sgate_ver        ./libraries/sgate_ver       
ensure_lib                  ./libraries/altera_mf_ver   
vmap       altera_mf_ver    ./libraries/altera_mf_ver   
ensure_lib                  ./libraries/altera_lnsim_ver
vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver
ensure_lib                  ./libraries/cycloneii_ver   
vmap       cycloneii_ver    ./libraries/cycloneii_ver   
ensure_lib                  ./libraries/altera          
vmap       altera           ./libraries/altera          
ensure_lib                  ./libraries/lpm             
vmap       lpm              ./libraries/lpm             
ensure_lib                  ./libraries/sgate           
vmap       sgate            ./libraries/sgate           
ensure_lib                  ./libraries/altera_mf       
vmap       altera_mf        ./libraries/altera_mf       
ensure_lib                  ./libraries/altera_lnsim    
vmap       altera_lnsim     ./libraries/altera_lnsim    
ensure_lib                  ./libraries/cycloneii       
vmap       cycloneii        ./libraries/cycloneii       


# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  vlog +define+SKIP_KEYWORDS_PRAGMA "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"              -work altera_ver      
  vlog                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                       -work lpm_ver         
  vlog                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                          -work sgate_ver       
  vlog                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                      -work altera_mf_ver   
  vlog                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                  -work altera_lnsim_ver
  vlog                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v"                -work cycloneii_ver   
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera          
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm             
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm             
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate           
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate           
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf       
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf       
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim    
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.vhd"              -work cycloneii       
  vcom                              "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_components.vhd"         -work cycloneii       
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_irq_mapper.vho"                                                                    
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_width_adapter.sv"                                                         
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_address_alignment.sv"                                                     
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_burst_uncompressor.sv"                                                    
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_rsp_xbar_mux.vho"                                                                  
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_rsp_xbar_demux_005.vho"                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_rsp_xbar_demux.vho"                                                                
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cmd_xbar_mux_005.vho"                                                              
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cmd_xbar_mux.vho"                                                                  
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cmd_xbar_demux_002.vho"                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cmd_xbar_demux_001.vho"                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cmd_xbar_demux.vho"                                                                
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_reset_controller.v"                                                              
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_reset_synchronizer.v"                                                            
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_burst_adapter.sv"                                                         
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_address_alignment.sv"                                                     
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_traffic_limiter.sv"                                                       
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_avalon_st_pipeline_base.v"                                                       
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_id_router_005.vho"                                                                 
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_id_router.vho"                                                                     
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_addr_router_002.vho"                                                               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_addr_router.vho"                                                                   
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo.vho"
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo.vho"  
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo.vho"    
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo.vho"      
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_slave_agent.sv"                                                           
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_burst_uncompressor.sv"                                                    
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_master_agent.sv"                                                          
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_slave_translator.sv"                                                      
  vlog  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/aldec/altera_merlin_master_translator.sv"                                                     
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/dma_engine.vhd"                                                                               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/regfile_final.vhd"                                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_avdetect.vhd"                                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_buffer.vhd"                                                                              
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_rcontrol.vhd"                                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_addressing.vhd"                                                                          
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_if.vhd"                                                                                  
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/grab_wcontrol.vhd"                                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_new_sdram_controller_0.vhd"                                                        
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_sysid.vho"                                                                         
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_sys_clk_timer.vhd"                                                                 
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_jtag_uart.vhd"                                                                     
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu.vho"                                                                           
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_sysclk.vhd"                                                  
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_tck.vhd"                                                     
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_wrapper.vhd"                                                 
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_mult_cell.vhd"                                                                 
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_oci_test_bench.vhd"                                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_test_bench.vhd"                                                                
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_onchip_mem.vhd"                                                                    
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/altera_avalon_reset_source.vhd"                                                               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/altera_avalon_clock_source.vhd"                                                               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga.vhd"                                                                               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent.vhd"               
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent.vhd"           
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_width_adapter.vhd"                                                                 
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_width_adapter_002.vhd"                                                             
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_data_master_translator.vhd"                                                    
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_instruction_master_translator.vhd"                                             
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_grab_if_0_avalon_master_translator.vhd"                                            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_dma_engine_0_avalon_master_translator.vhd"                                         
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_jtag_debug_module_translator.vhd"                                              
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_onchip_mem_s1_translator.vhd"                                                      
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_jtag_uart_avalon_jtag_slave_translator.vhd"                                        
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_sys_clk_timer_s1_translator.vhd"                                                   
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_sysid_control_slave_translator.vhd"                                                
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_new_sdram_controller_0_s1_translator.vhd"                                          
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_regfile_final_0_avalon_slave_0_translator.vhd"                                     
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_cpu_data_master_translator_avalon_universal_master_0_agent.vhd"                    
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_grab_if_0_avalon_master_translator_avalon_universal_master_0_agent.vhd"            
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/submodules/final_fpga_dma_engine_0_avalon_master_translator_avalon_universal_master_0_agent.vhd"         
  vcom  "C:/Users/pwhite8/vlsi/fpga/final_fpga/testbench/final_fpga_tb/simulation/final_fpga_tb.vhd"                                                                                       
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  vsim +access +r  -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  vsim -dbg -O2 +access +r -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h