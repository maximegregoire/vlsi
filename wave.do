onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/resetN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/scke
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/dump
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/load
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sclk
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sa
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sbs
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/scsN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/srasN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/scasN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sweN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sd
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sdqm
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/MSG69_inhibit
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/action
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/bankState
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/burstBank
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/burstEnd
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/checkReWRite
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/colAdr
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/firstWrite
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/mode
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/powOnState
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/readMem
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/refresh
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/reset1N
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/rfhViolation
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/rowsAdr
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/scasNI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/scsNI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sdqmD1
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sdqmD2
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sdqmI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/dumpI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/loadI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/setSclkPeriod
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/setupTiming
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/setupTiming1
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/srasNI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/sweNI
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/trigMe
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/writeMem
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/BURST_LENGTH
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/CAS_LATENCY
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/CLK_PERIOD
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/DUMMY_REF_MIN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/IRSA
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/IRSA_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/RFH_PERIOD
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TAC
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TDPL
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TDPL_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/THZ
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TLZ
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TOH
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRAS_CAS2_MIN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRAS_CAS2_MIN_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRAS_CAS3_MIN
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRAS_CAS3_MIN_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRAS_MAX
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRC
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRCD
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRCD_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRC_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRP
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRP_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRRD
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/TRRD_PER
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/colVec
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/rowVec
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/autoPre
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/xsdramsdr/preSel
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider {SDRAM CONTROLLER}
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_cs_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_ba
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_dqm
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_cke
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_addr
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_we_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_ras_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_dq
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst_new_sdram_controller_0_wire_cas_n
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/dump
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3390000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {3009597 ps} {3706222 ps}
