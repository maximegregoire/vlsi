onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/clk
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_address
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_byteenable
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_irq
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_read
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_readdata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_waitrequest
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_write
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/d_writedata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/i_address
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/i_read
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/i_readdata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/i_readdatavalid
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/cpu/i_waitrequest
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/address
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/byteenable
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/chipselect
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/clk
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/clken
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/reset
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/write
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/writedata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/readdata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/internal_readdata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/onchip_mem/wren
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/address
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/readdata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/write_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/writedata
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/rst
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/clk
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/AVINTDIS
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTOVR
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTSTS
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0INTSTS
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTEN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0INTEN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CNTEN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CNTEN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1RST
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0RST
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CNT
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CNT
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CMP
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CMP
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/GP0
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/GP1
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/AVINTDIS_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTOVR_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTSTS_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0INTSTS_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1INTEN_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0INTEN_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CNTEN_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CNTEN_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1RST_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0RST_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CNT_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CNT_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T0CMP_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/T1CMP_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/GP0_sig
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/regfile_0/GP1_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1550000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 443
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {1337258 ps} {1585501 ps}
