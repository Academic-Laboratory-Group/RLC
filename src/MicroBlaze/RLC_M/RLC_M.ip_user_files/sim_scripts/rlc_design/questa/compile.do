vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/microblaze_v11_0_0
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/interrupt_control_v3_1_4
vlib questa_lib/msim/axi_gpio_v2_0_20
vlib questa_lib/msim/lmb_v10_v3_0_9
vlib questa_lib/msim/lmb_bram_if_cntlr_v4_0_15
vlib questa_lib/msim/blk_mem_gen_v8_4_2
vlib questa_lib/msim/mdm_v3_2_15
vlib questa_lib/msim/proc_sys_reset_v5_0_13
vlib questa_lib/msim/generic_baseblocks_v2_1_0
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_18
vlib questa_lib/msim/fifo_generator_v13_2_3
vlib questa_lib/msim/axi_data_fifo_v2_1_17
vlib questa_lib/msim/axi_crossbar_v2_1_19

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap microblaze_v11_0_0 questa_lib/msim/microblaze_v11_0_0
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap interrupt_control_v3_1_4 questa_lib/msim/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_20 questa_lib/msim/axi_gpio_v2_0_20
vmap lmb_v10_v3_0_9 questa_lib/msim/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 questa_lib/msim/lmb_bram_if_cntlr_v4_0_15
vmap blk_mem_gen_v8_4_2 questa_lib/msim/blk_mem_gen_v8_4_2
vmap mdm_v3_2_15 questa_lib/msim/mdm_v3_2_15
vmap proc_sys_reset_v5_0_13 questa_lib/msim/proc_sys_reset_v5_0_13
vmap generic_baseblocks_v2_1_0 questa_lib/msim/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_18 questa_lib/msim/axi_register_slice_v2_1_18
vmap fifo_generator_v13_2_3 questa_lib/msim/fifo_generator_v13_2_3
vmap axi_data_fifo_v2_1_17 questa_lib/msim/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 questa_lib/msim/axi_crossbar_v2_1_19

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"D:/Programy/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Programy/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Programy/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ipshared/4119/hdl/coder_ip_v1_0_S00_AXI.v" \

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ipshared/4119/hdl/rlc_coder_rtl.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ipshared/4119/hdl/coder_ip_v1_0.v" \
"../../../bd/rlc_design/ip/rlc_design_coder_ip_0_0/sim/rlc_design_coder_ip_0_0.v" \
"../../../bd/rlc_design/ipshared/c05e/hdl/decoder_ip_v1_0_S00_AXI.v" \

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ipshared/c05e/hdl/rlc_decoder_rtl.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ipshared/c05e/hdl/decoder_ip_v1_0.v" \
"../../../bd/rlc_design/ip/rlc_design_decoder_ip_0_0/sim/rlc_design_decoder_ip_0_0.v" \

vcom -work microblaze_v11_0_0 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/2ed1/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_microblaze_0_0/sim/rlc_design_microblaze_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_20 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/a7c9/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_axi_gpio_1_0/sim/rlc_design_axi_gpio_1_0.vhd" \

vcom -work lmb_v10_v3_0_9 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_dlmb_v10_0/sim/rlc_design_dlmb_v10_0.vhd" \
"../../../bd/rlc_design/ip/rlc_design_ilmb_v10_0/sim/rlc_design_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_dlmb_bram_if_cntlr_0/sim/rlc_design_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/rlc_design/ip/rlc_design_ilmb_bram_if_cntlr_0/sim/rlc_design_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_2 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/37c2/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ip/rlc_design_lmb_bram_0/sim/rlc_design_lmb_bram_0.v" \

vcom -work mdm_v3_2_15 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/41ef/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_mdm_1_0/sim/rlc_design_mdm_1_0.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ip/rlc_design_clk_wiz_1_0/rlc_design_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/rlc_design/ip/rlc_design_clk_wiz_1_0/rlc_design_clk_wiz_1_0.v" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/rlc_design/ip/rlc_design_rst_clk_wiz_1_100M_0/sim/rlc_design_rst_clk_wiz_1_100M_0.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_3 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -64 -93 \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_17 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19 -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/85a3" "+incdir+../../../../RLC_M.srcs/sources_1/bd/rlc_design/ipshared/ec67/hdl" \
"../../../bd/rlc_design/ip/rlc_design_xbar_0/sim/rlc_design_xbar_0.v" \
"../../../bd/rlc_design/sim/rlc_design.v" \

vlog -work xil_defaultlib \
"glbl.v"

