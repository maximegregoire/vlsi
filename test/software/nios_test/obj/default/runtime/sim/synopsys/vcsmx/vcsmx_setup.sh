
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

# ACDS 13.0 156 win32 2013.10.03.09:18:27

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="nios_test_tb"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/13.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera/
mkdir -p ./libraries/lpm/
mkdir -p ./libraries/sgate/
mkdir -p ./libraries/altera_mf/
mkdir -p ./libraries/altera_lnsim/
mkdir -p ./libraries/cycloneii/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_onchip_memory2_0.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_bht_ram.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_bht_ram.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_bht_ram.mif ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_dc_tag_ram.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_dc_tag_ram.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_dc_tag_ram.mif ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ic_tag_ram.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ic_tag_ram.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ic_tag_ram.mif ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ociram_default_contents.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ociram_default_contents.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_ociram_default_contents.mif ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_a.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_a.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_a.mif ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_b.dat ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_b.hex ./
  cp -f C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_rf_ram_b.mif ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm         
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm         
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate       
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate       
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf   
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf   
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                  -work altera_lnsim
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.vhd"              -work cycloneii   
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_components.vhd"         -work cycloneii   
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_irq_mapper.vho"                                                                       
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_rsp_xbar_mux.vho"                                                                     
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_rsp_xbar_demux.vho"                                                                   
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_cmd_xbar_mux.vho"                                                                     
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_cmd_xbar_demux.vho"                                                                   
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_id_router.vho"                                                                        
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_addr_router.vho"                                                                      
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo.vho"
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/regfile.vhd"                                                                                    
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_onchip_memory2_0.vhd"                                                                 
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0.vho"                                                                     
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_jtag_debug_module_sysclk.vhd"                                            
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_jtag_debug_module_tck.vhd"                                               
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_jtag_debug_module_wrapper.vhd"                                           
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_mult_cell.vhd"                                                           
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_oci_test_bench.vhd"                                                      
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_test_bench.vhd"                                                          
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/altera_avalon_reset_source.vhd"                                                                 
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/altera_avalon_clock_source.vhd"                                                                 
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test.vhd"                                                                                  
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_jtag_debug_module_translator.vhd"                                        
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_onchip_memory2_0_s1_translator.vhd"                                                   
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_reg_0_avalon_slave_0_translator.vhd"                                                  
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_instruction_master_translator.vhd"                                       
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/submodules/nios_test_nios2_qsys_0_data_master_translator.vhd"                                              
  vhdlan -xlrm "C:/Users/mgrego29/vlsi/test/nios_test/testbench/nios_test_tb/simulation/nios_test_tb.vhd"                                                                                          
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $USER_DEFINED_SIM_OPTIONS
fi
