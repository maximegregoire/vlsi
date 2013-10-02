
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

# ACDS 13.0 156 win32 2013.10.01.19:04:43

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="first_nios2_system_tb"
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
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/rsp_xbar_mux/
mkdir -p ./libraries/rsp_xbar_demux/
mkdir -p ./libraries/cmd_xbar_mux/
mkdir -p ./libraries/cmd_xbar_demux_001/
mkdir -p ./libraries/cmd_xbar_demux/
mkdir -p ./libraries/id_router/
mkdir -p ./libraries/addr_router/
mkdir -p ./libraries/cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo/
mkdir -p ./libraries/regfile_0/
mkdir -p ./libraries/sysid/
mkdir -p ./libraries/sys_clk_timer/
mkdir -p ./libraries/jtag_uart/
mkdir -p ./libraries/led_pio/
mkdir -p ./libraries/cpu/
mkdir -p ./libraries/onchip_mem/
mkdir -p ./libraries/first_nios2_system_inst_reset_bfm/
mkdir -p ./libraries/first_nios2_system_inst_clk_bfm/
mkdir -p ./libraries/first_nios2_system_inst/
mkdir -p ./libraries/altera/
mkdir -p ./libraries/lpm/
mkdir -p ./libraries/sgate/
mkdir -p ./libraries/altera_mf/
mkdir -p ./libraries/altera_lnsim/
mkdir -p ./libraries/cycloneii/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ic_tag_ram.dat ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ic_tag_ram.hex ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ic_tag_ram.mif ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ociram_default_contents.dat ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ociram_default_contents.hex ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_ociram_default_contents.mif ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_a.dat ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_a.hex ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_a.mif ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_b.dat ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_b.hex ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_rf_ram_b.mif ./
  cp -f C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_onchip_mem.hex ./
  cp -f C:/Users/pwhite8/vlsi/fpga/software/test_proj/mem_init/hdl_sim/first_nios2_system_onchip_mem.dat ./
  cp -f C:/Users/pwhite8/vlsi/fpga/software/test_proj/mem_init/first_nios2_system_onchip_mem.hex ./
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
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_irq_mapper.vho"                                                               -work irq_mapper                                                              
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_rsp_xbar_mux.vho"                                                             -work rsp_xbar_mux                                                            
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_rsp_xbar_demux.vho"                                                           -work rsp_xbar_demux                                                          
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cmd_xbar_mux.vho"                                                             -work cmd_xbar_mux                                                            
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cmd_xbar_demux_001.vho"                                                       -work cmd_xbar_demux_001                                                      
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cmd_xbar_demux.vho"                                                           -work cmd_xbar_demux                                                          
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_id_router.vho"                                                                -work id_router                                                               
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_addr_router.vho"                                                              -work addr_router                                                             
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo.vho" -work cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/regfile.vhd"                                                                                     -work regfile_0                                                               
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_sysid.vho"                                                                    -work sysid                                                                   
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_sys_clk_timer.vhd"                                                            -work sys_clk_timer                                                           
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_jtag_uart.vhd"                                                                -work jtag_uart                                                               
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_led_pio.vhd"                                                                  -work led_pio                                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu.vho"                                                                      -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_jtag_debug_module_sysclk.vhd"                                             -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_jtag_debug_module_tck.vhd"                                                -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_jtag_debug_module_wrapper.vhd"                                            -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_mult_cell.vhd"                                                            -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_oci_test_bench.vhd"                                                       -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_test_bench.vhd"                                                           -work cpu                                                                     
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_onchip_mem.vhd"                                                               -work onchip_mem                                                              
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/altera_avalon_reset_source.vhd"                                                                  -work first_nios2_system_inst_reset_bfm                                       
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/altera_avalon_clock_source.vhd"                                                                  -work first_nios2_system_inst_clk_bfm                                         
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system.vhd"                                                                          -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_jtag_debug_module_translator.vhd"                                         -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_onchip_mem_s1_translator.vhd"                                                 -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_led_pio_s1_translator.vhd"                                                    -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_jtag_uart_avalon_jtag_slave_translator.vhd"                                   -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_sys_clk_timer_s1_translator.vhd"                                              -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_regfile_0_avalon_slave_0_translator.vhd"                                      -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_instruction_master_translator.vhd"                                        -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/submodules/first_nios2_system_cpu_data_master_translator.vhd"                                               -work first_nios2_system_inst                                                 
  vhdlan -xlrm "C:/Users/pwhite8/vlsi/fpga/first_nios2_system/testbench/first_nios2_system_tb/simulation/first_nios2_system_tb.vhd"                                                                                                                                                                
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
