onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM
add wave -noupdate /final_fpga_tb/final_fpga_inst_clk_bfm_clk_clk
add wave -noupdate /final_fpga_tb/final_fpga_inst_reset_bfm_reset_reset
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_cs_n
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_ba
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_dqm
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_cke
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_addr
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_we_n
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_ras_n
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_dq
add wave -noupdate /final_fpga_tb/final_fpga_inst_new_sdram_controller_cas_n
add wave -noupdate -divider {GRAB IF}
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gssht
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gmode
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gxss
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_debug_grabif1
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_debug_grabif2
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gfstart
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_vdata
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_gspdg
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gfmt
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_glpitch
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gclk
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gyss
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_gactive
add wave -noupdate /final_fpga_tb/final_fpga_inst_grab_if_conduit_bfm_conduit_gcont
add wave -noupdate -divider REGFILE
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gssht
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vesync
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vtotal
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_dmaen
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gfstart
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_hssync
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_hsvalid
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_eofien
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_pfmt
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_bfm_conduit_gspdg_in
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_glpitch
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gactive
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vgahzoom
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_bfm_conduit_gactive_in
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gmode
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_dmalr
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_dmaxsize
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vevalid
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gxss
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_dmafstart
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vgavzoom
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vssync
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_hesync
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_sofists
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_sofien
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gspdg
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_hevalid
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_dmalpitch
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gfmt
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_gyss
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_htotal
add wave -noupdate /final_fpga_tb/final_fpga_inst_regfile_conduit_vsvalid
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_dmalr
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_dmaxsize
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_dmalpitch
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_read_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_data
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_sof_in
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_write_address
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_dmafstart
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_write_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_dmaen
add wave -noupdate /final_fpga_tb/final_fpga_inst_dma_conduit_bfm_conduit_sol_in
add wave -noupdate /final_fpga_tb/final_fpga_inst_reset_bfm_reset_reset_ports_inv
add wave -noupdate -divider NIOS
add wave -noupdate /final_fpga_tb/dump
add wave -noupdate /final_fpga_tb/load
add wave -noupdate /final_fpga_tb/final_fpga_inst_clk_bfm_clk_clk_clk
add wave -noupdate /final_fpga_tb/vclk
add wave -noupdate /final_fpga_tb/vdata
add wave -noupdate /final_fpga_tb/rden_sig
add wave -noupdate /final_fpga_tb/rdaddress_sig
add wave -noupdate /final_fpga_tb/wren_sig
add wave -noupdate /final_fpga_tb/wraddress_sig
add wave -noupdate /final_fpga_tb/data_sig
add wave -noupdate /final_fpga_tb/linebufout_sig
add wave -noupdate /final_fpga_tb/hrst_sig
add wave -noupdate /final_fpga_tb/vrst_sig
add wave -noupdate /final_fpga_tb/lineOddEven_sig
add wave -noupdate /final_fpga_tb/hsyncN_sig
add wave -noupdate /final_fpga_tb/vsyncN_sig
add wave -noupdate /final_fpga_tb/clockdac_sig
add wave -noupdate /final_fpga_tb/blackN_sig
add wave -noupdate /final_fpga_tb/syncN_sig
add wave -noupdate /final_fpga_tb/red_sig
add wave -noupdate /final_fpga_tb/green_sig
add wave -noupdate /final_fpga_tb/blue_sig
add wave -noupdate /final_fpga_tb/SW_sig
add wave -noupdate /final_fpga_tb/GYSIZE
add wave -noupdate /final_fpga_tb/GVTOTAL
add wave -noupdate /final_fpga_tb/GXSIZE
add wave -noupdate /final_fpga_tb/GHTOTAL
add wave -noupdate /final_fpga_tb/SOL_sig
add wave -noupdate /final_fpga_tb/SOF_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/gclk
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/vdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/resetN
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/sclk
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/writedata
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/waitrequest
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/writeen
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/byteenable
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/address
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSSHT
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GMODE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GCONT
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GFMT
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GFSTART
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GLPITCH
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GYSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GXSS
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GACTIVE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSPDG
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/DEBUG_GRABIF1
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/DEBUG_GRABIF2
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/DEBUG_GRABIF1_int
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/DEBUG_GRABIF2_int
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/rdone
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/wdone
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/rdone1
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/rdone2
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/wdone1
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/wdone2
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/av
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/field
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/waddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/wen
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/raddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/reset_memaddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/next_memaddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GACTIVE_int
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GACTIVE_int1
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GACTIVE_int2
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSPDG_s
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSPDG_r
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GSPDG_2r
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/gssht_gclk
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/gssht_flag
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/q
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GYSIZE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/GXSIZE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/small_address
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/incr_memaddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/old_reset_memaddr
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/y_toggle
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/vdata_delayed
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/av_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/s1_av_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/s_av_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/vdata_debug
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/dbg_linecnt
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/last_av
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/overrun_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/cnt_GACTIVE
add wave -noupdate /final_fpga_tb/final_fpga_inst/grab_if_0/debug_reg
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/address
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/readdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/write_n
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/writedata
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/rst
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/clk
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GACTIVE_IN
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSPDG_IN
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSSHT
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSPDG
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GACTIVE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GFMT
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
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAFSTART
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMALPITCH
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAXSIZE
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAHZOOM
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAVZOOM
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/PFMT
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HTOTAL
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HSSYNC
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HESYNC
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HSVALID
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HEVALID
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VTOTAL
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VSSYNC
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VESYNC
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VSVALID
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VEVALID
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSSHT_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GSPDG_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GACTIVE_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GFMT_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GMODE_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GXSS_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GYSS_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GFSTART_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GLPITCH_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFIEN_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFISTS_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFIEN_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFISTS_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAEN_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMALR_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAFSTART_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMALPITCH_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/DMAXSIZE_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAHZOOM_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VGAVZOOM_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/PFMT_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HTOTAL_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HSSYNC_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HESYNC_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HSVALID_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/HEVALID_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VTOTAL_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VSSYNC_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VESYNC_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VSVALID_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/VEVALID_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFISTS_set
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFISTS_set
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/SOFISTS_rst
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/EOFISTS_rst
add wave -noupdate /final_fpga_tb/final_fpga_inst/regfile_final_0/GACTIVE_1P
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/resetN
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/sclk
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/waitrequest
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readen
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/byteenable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/address
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata_valid
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/burstcount
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAEN
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMALR
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAFSTART
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMALPITCH
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/DMAXSIZE
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/data
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_in
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_in
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/write_address
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/write_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/read_enable
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/data_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/write_enable_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/write_address_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/address_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readen_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/byteenable_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/burstcount_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/read_enable_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata_valid_sig
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/read_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/readdata_valid_clk_count
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/toggle_line
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_1p
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_2p
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_1p
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_2p
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_2p_set
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_2p_set
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOL_final
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/SOF_final
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/first_line
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/first_line_rst
add wave -noupdate /final_fpga_tb/final_fpga_inst/dma_engine_0/first_line_edge
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 418
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
WaveRestoreZoom {0 ps} {19566750 ps}