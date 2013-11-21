onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider VGA
add wave -noupdate /first_nios2_system_tb/xvga/dclk
add wave -noupdate /first_nios2_system_tb/xvga/rstN
add wave -noupdate /first_nios2_system_tb/xvga/SW
add wave -noupdate /first_nios2_system_tb/xvga/rden
add wave -noupdate /first_nios2_system_tb/xvga/rdaddress
add wave -noupdate /first_nios2_system_tb/xvga/lineOddEven
add wave -noupdate /first_nios2_system_tb/xvga/hrst
add wave -noupdate /first_nios2_system_tb/xvga/vrst
add wave -noupdate /first_nios2_system_tb/xvga/linebufout
add wave -noupdate /first_nios2_system_tb/xvga/HESYNC
add wave -noupdate /first_nios2_system_tb/xvga/HEVALID
add wave -noupdate /first_nios2_system_tb/xvga/HSVALID
add wave -noupdate /first_nios2_system_tb/xvga/hsyncN
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/hcounter
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/VESYNC
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/VEVALID
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/VSVALID
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/VTOTAL
add wave -noupdate /first_nios2_system_tb/xvga/vsyncN
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/vcounter
add wave -noupdate /first_nios2_system_tb/xvga/clockdac
add wave -noupdate /first_nios2_system_tb/xvga/blankN
add wave -noupdate /first_nios2_system_tb/xvga/syncN
add wave -noupdate /first_nios2_system_tb/xvga/red
add wave -noupdate /first_nios2_system_tb/xvga/green
add wave -noupdate /first_nios2_system_tb/xvga/blue
add wave -noupdate -radix unsigned /first_nios2_system_tb/xvga/HTOTAL
add wave -noupdate /first_nios2_system_tb/xvga/count4
add wave -noupdate /first_nios2_system_tb/xvga/framecnt
add wave -noupdate /first_nios2_system_tb/xvga/hvalid
add wave -noupdate /first_nios2_system_tb/xvga/hvalid1p
add wave -noupdate /first_nios2_system_tb/xvga/vvalid
add wave -noupdate -divider {LINE BUF}
add wave -noupdate /first_nios2_system_tb/xlinebuffer/clock
add wave -noupdate /first_nios2_system_tb/xlinebuffer/data
add wave -noupdate /first_nios2_system_tb/xlinebuffer/rdaddress
add wave -noupdate /first_nios2_system_tb/xlinebuffer/wraddress
add wave -noupdate /first_nios2_system_tb/xlinebuffer/wren
add wave -noupdate /first_nios2_system_tb/xlinebuffer/q
add wave -noupdate -divider DMA
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/DMAEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/DMAFSTART
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/DMALPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/DMALR
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/DMAXSIZE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/addrsize
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/read_address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/read_enable
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/readdata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/readdata_valid
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/resetN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/sclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/size_in
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/size_out
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/waitrequest
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/byteenable
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/data
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/readen
add wave -noupdate -radix hexadecimal /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/write_address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/write_enable
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/read_count
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/readdata_valid_count
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/dma_engine_0/burstcount
add wave -noupdate -divider GRAB_IF
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GCONT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GFMT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GLPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GMODE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GSSHT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GXSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GYSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/addrsize
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/gclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/resetN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/sclk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/size_in
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/size_out
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/vdata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/waitrequest
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/DEBUG_GRABIF1
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/DEBUG_GRABIF2
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GACTIVE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/GSPDG
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/byteenable
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/writedata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/grab_if_0/writeen
add wave -noupdate -divider REGFILE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GACTIVE_IN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GSPDG_IN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/address
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/clk
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/rst
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/write_n
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/writedata
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/DMAEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/DMAFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/DMALPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/DMALR
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/DMAXSIZE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/EOFIEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/EOFISTS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GACTIVE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GFMT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GFSTART
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GLPITCH
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GMODE
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GSPDG
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GSSHT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GXSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/GYSS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/HESYNC
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/HEVALID
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/HSSYNC
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/HSVALID
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/HTOTAL
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/PFMT
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/SOFIEN
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/SOFISTS
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VESYNC
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VEVALID
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VGAHZOOM
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VGAVZOOM
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VSSYNC
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VSVALID
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/VTOTAL
add wave -noupdate /first_nios2_system_tb/first_nios2_system_inst/regfile_final_0/readdata
add wave -noupdate -divider DECODER
add wave -noupdate /first_nios2_system_tb/xadv7181b/dclk
add wave -noupdate /first_nios2_system_tb/xadv7181b/dpix
add wave -noupdate -divider MEM
add wave -noupdate /first_nios2_system_tb/xsdramsdr/DUMPFILE
add wave -noupdate /first_nios2_system_tb/xsdramsdr/LOADFILE
add wave -noupdate /first_nios2_system_tb/xsdramsdr/dump
add wave -noupdate /first_nios2_system_tb/xsdramsdr/load
add wave -noupdate /first_nios2_system_tb/xsdramsdr/resetN
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sa
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sbs
add wave -noupdate /first_nios2_system_tb/xsdramsdr/scasN
add wave -noupdate /first_nios2_system_tb/xsdramsdr/scke
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sclk
add wave -noupdate /first_nios2_system_tb/xsdramsdr/scsN
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sdqm
add wave -noupdate /first_nios2_system_tb/xsdramsdr/srasN
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sweN
add wave -noupdate /first_nios2_system_tb/xsdramsdr/sd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {378522606 ps} 0}
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
WaveRestoreZoom {377425334 ps} {401188141 ps}
