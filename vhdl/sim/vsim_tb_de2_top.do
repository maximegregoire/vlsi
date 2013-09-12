# Make sure the "work" library is clean by deleting and creating it again.
# Note: A "library" in modelsim is an object that holds compiled code.
vlib work
vdel -all -lib work
vlib work
vmap work work

# Compile everything, in the right order
#vcom ../testramblock.vhd
vcom ../DE2_TOP.vhd
vcom tb_DE2_TOP.vhd

# Launch simulation
vsim work.tb_de2_top

# Set-up the waveform window (here we add all possible signals)
add wave -r /*

# Run the simulation
run 10us