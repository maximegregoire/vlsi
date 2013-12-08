onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DMA
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/resetN
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/sclk
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/dma_engine_0/address
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata_valid
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/waitrequest
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/burstcount
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readen
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_final
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/first_line
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_final
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/byteenable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAEN
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMALR
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAFSTART
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/DMALPITCH
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAXSIZE
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/dma_engine_0/data
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/write_address
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/write_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/read_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/read_count
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata_valid_clk_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/toggle_line
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/dma_engine_0/line_count
add wave -noupdate -divider VGA
add wave -noupdate /final_fpga_tb/xvga/dclk
add wave -noupdate /final_fpga_tb/xvga/rstN
add wave -noupdate /final_fpga_tb/xvga/SW
add wave -noupdate /final_fpga_tb/xvga/rden
add wave -noupdate -radix unsigned /final_fpga_tb/xvga/rdaddress
add wave -noupdate /final_fpga_tb/xvga/lineOddEven
add wave -noupdate -radix hexadecimal /final_fpga_tb/xvga/linebufout
add wave -noupdate /final_fpga_tb/xvga/hsyncN
add wave -noupdate /final_fpga_tb/xvga/vsyncN
add wave -noupdate /final_fpga_tb/xvga/SOF
add wave -noupdate /final_fpga_tb/xvga/SOL
add wave -noupdate /final_fpga_tb/xvga/clockdac
add wave -noupdate /final_fpga_tb/xvga/blankN
add wave -noupdate /final_fpga_tb/xvga/syncN
add wave -noupdate -radix hexadecimal /final_fpga_tb/xvga/red
add wave -noupdate -radix hexadecimal /final_fpga_tb/xvga/green
add wave -noupdate -radix hexadecimal /final_fpga_tb/xvga/blue
add wave -noupdate -radix unsigned /final_fpga_tb/xvga/hcounter
add wave -noupdate -radix unsigned /final_fpga_tb/xvga/vcounter
add wave -noupdate /final_fpga_tb/xvga/hvalid
add wave -noupdate /final_fpga_tb/xvga/vvalid
add wave -noupdate -divider LINEBUF
add wave -noupdate /final_fpga_tb/xlinebuffer/clock
add wave -noupdate /final_fpga_tb/xlinebuffer/data
add wave -noupdate /final_fpga_tb/xlinebuffer/rdaddress
add wave -noupdate /final_fpga_tb/xlinebuffer/wraddress
add wave -noupdate /final_fpga_tb/xlinebuffer/wren
add wave -noupdate /final_fpga_tb/xlinebuffer/q
add wave -noupdate -divider DECODER
add wave -noupdate /final_fpga_tb/xadv7181b/dclk
add wave -noupdate /final_fpga_tb/xadv7181b/dpix
add wave -noupdate /final_fpga_tb/xadv7181b/GYSIZE
add wave -noupdate /final_fpga_tb/xadv7181b/GXSIZE
add wave -noupdate /final_fpga_tb/xadv7181b/GVTOTAL
add wave -noupdate /final_fpga_tb/xadv7181b/GHTOTAL
add wave -noupdate -divider REGFILE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/address
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/readdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/write_n
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/writedata
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/rst
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/clk
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSSHT
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSPDG
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GACTIVE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GMODE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GXSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GYSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GFSTART
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GLPITCH
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFIEN
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFISTS
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFIEN
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFISTS
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAEN
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMALR
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAFSTART
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/DMALPITCH
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAXSIZE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAHZOOM
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAVZOOM
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/PFMT
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/HTOTAL
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/HSSYNC
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/HESYNC
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/HSVALID
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/HEVALID
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/VTOTAL
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/VSSYNC
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/VESYNC
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/VSVALID
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/regfile_final_0/VEVALID
add wave -noupdate -divider SDRAM
add wave -noupdate /final_fpga_tb/xsdramsdr/resetN
add wave -noupdate /final_fpga_tb/xsdramsdr/sa
add wave -noupdate /final_fpga_tb/xsdramsdr/sbs
add wave -noupdate /final_fpga_tb/xsdramsdr/scasN
add wave -noupdate /final_fpga_tb/xsdramsdr/scke
add wave -noupdate /final_fpga_tb/xsdramsdr/sclk
add wave -noupdate /final_fpga_tb/xsdramsdr/scsN
add wave -noupdate /final_fpga_tb/xsdramsdr/sdqm
add wave -noupdate /final_fpga_tb/xsdramsdr/dump
add wave -noupdate /final_fpga_tb/xsdramsdr/load
add wave -noupdate /final_fpga_tb/xsdramsdr/srasN
add wave -noupdate /final_fpga_tb/xsdramsdr/sweN
add wave -noupdate /final_fpga_tb/xsdramsdr/sd
add wave -noupdate -divider GRAB_IF
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/gclk
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/vdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/resetN
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/sclk
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/grab_if_0/writedata
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/waitrequest
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/writeen
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/byteenable
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/grab_if_0/address
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSSHT
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GMODE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GCONT
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GFMT
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/grab_if_0/GFSTART
add wave -noupdate -radix unsigned /final_fpga_tb/final_fpga_inst/grab_if_0/GLPITCH
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GYSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GXSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GACTIVE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSPDG
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/grab_if_0/waddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/wen
add wave -noupdate -radix hexadecimal /final_fpga_tb/final_fpga_inst/grab_if_0/raddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1744545000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 328
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
WaveRestoreZoom {0 ps} {2118212250 ps}
