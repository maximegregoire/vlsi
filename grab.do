onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider REGFILE
add wave -noupdate /first_nios2_system_tb/xsdramsdr/dump
add wave -noupdate /first_nios2_system_tb/xsdramsdr/load
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_addr
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_ba
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_cas_n
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_cke
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_cs_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_dq
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_dqm
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_ras_n
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/new_sdram_controller_0_wire_we_n
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GMODE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GCONT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GFMT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GYSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GXSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_DEBUG_GRABIF1
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_DEBUG_GRABIF2
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_vdata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_gclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GSPDG
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GACTIVE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GFMT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GMODE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GXSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GYSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GLPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_SOFIEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_SOFISTS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_EOFIEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_EOFISTS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GLPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GACTIVE_IN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GSPDG_IN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0_conduit_end_GSSHT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GSSHT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GACTIVE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0_conduit_end_GSPDG
add wave -noupdate -divider GRAB_IF
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/gclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/vdata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/sclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/writedata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/writeen
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/resetN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/waitrequest
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GSSHT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GSPDG
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GACTIVE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/waddr
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/raddr
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/reset_memaddr
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/next_memaddr
add wave -noupdate -divider {Video Decoder}
add wave -noupdate /first_nios2_system_tb/xadv7181b/dclk
add wave -noupdate /first_nios2_system_tb/xadv7181b/dpix
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {221281825 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 287
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {430500 ns}
