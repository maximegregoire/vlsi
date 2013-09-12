set basepath "c:/altera/13.0/quartus"

# ModelSimPE and OEM have different requirements
# regarding how they simulate their test bench.
# We account for that here.
if { [ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
 alias _init_setup {vlib work
                       vmap altera               work
                       vmap arriaii_hssi         work
                       vmap arriaii_pcie_hip     work
                       vmap cycloneiv_pcie_hip   work
                       vmap cycloneiv_hssi       work
                       vmap hardcopyiv_pcie_hip  work
                       vmap hardcopyiv_hssi      work
                       vcom -93 -explicit $basepath/libraries/vhdl/altera/altera_europa_support_lib.vhd
		       } } else {
 alias _init_setup {vlib work
                       vmap altera               work
                       vmap arriaii_hssi         work
                       vmap arriaii_pcie_hip     work
                       vmap cycloneiv_pcie_hip   work
                       vmap cycloneiv_hssi       work
                       vmap hardcopyiv_pcie_hip  work
                       vmap hardcopyiv_hssi      work
                       vmap lpm                  work
                       vmap altera_mf            work
                       vmap sgate_pack           work
                       vmap sgate                work
                       vmap stratixiigx_hssi     work
                       vmap arriagx_hssi         work
                       vmap stratixgx_hssi       work
                       vmap stratixiv_hssi       work
                       vmap stratixiv_pcie_hip   work
                       vmap altgxb_lib           work
                       vcom -93 -explicit $basepath/libraries/vhdl/altera/altera_europa_support_lib.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/altera_mf_components.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/altera_mf.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/220pack.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/220model.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/sgate_pack.vhd
                       vcom -93 -explicit $basepath/eda/sim_lib/sgate.vhd
                       } } 


# Map and compile Altera libraries
_init_setup

