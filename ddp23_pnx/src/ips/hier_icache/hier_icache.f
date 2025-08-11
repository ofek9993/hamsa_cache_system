//INCDIRS
// +INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/common_cells/include
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/axi/include
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/axi/src
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/icache_intc
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/hero
+INCDIR+$PULP_ENV/src/ips/hier_icache/rtl/tech_cells_generic

// SUBCOMPONENTS
-f $PULP_ENV/src/ips/hier_icache/rtl/axi/axi.f

//FILES

// top icache module file
$PULP_ENV/src/ips/hier_icache/rtl/top/icache_hier_top.sv

// l1 icache module files
$PULP_ENV/src/ips/hier_icache/rtl/l1_cache/pri_icache_controller.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1_cache/pri_icache.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1_cache/register_file_1w_multi_port_read.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1_cache/register_file_1w_multi_port_read_test_wrap.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1_cache/refill_arbiter.sv

// l1.5 icache module files
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/AXI4_REFILL_Resp_Deserializer.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/share_icache.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/share_icache_controller.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/RefillTracker_4.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/REP_buffer_4.sv
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/ram_ws_rs_data_scm.sv +define+USE_SRAM
$PULP_ENV/src/ips/hier_icache/rtl/l1.5_cache/ram_ws_rs_tag_scm.sv  +define+USE_SRAM

// pulp-platform/axi_slice module files
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_r_buffer.sv
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_ar_buffer.sv
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_aw_buffer.sv
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_w_buffer.sv
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_b_buffer.sv
// $PULP_ENV/src/ips/hier_icache/rtl/axi_slice/axi_buffer.sv

// pulp-platform/common_cells module files
// $PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/fifo_v3.sv
// $PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/deprecated/generic_fifo.sv
$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/lfsr_8bit.sv
$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/onehot_to_bin.sv
$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/cf_math_pkg.sv
$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/lzc.sv
// $PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/rr_arb_tree.sv
$PULP_ENV/src/ips/hier_icache/rtl/common_cells/src/spill_register.sv

// pulp-platform/tech_cells_generic module files
// $PULP_ENV/src/ips/hier_icache/rtl/tech_cells_generic/src/deprecated/cluster_clk_cells.sv
$PULP_ENV/src/ips/hier_icache/rtl/tech_cells_generic/src/rtl/tc_clk.sv

// pulp-platform/icache_intc module files
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/DistributedArbitrationNetwork_Req_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/DistributedArbitrationNetwork_Resp_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/Req_Arb_Node_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/Resp_Arb_Node_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/RoutingBlock_Req_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/RoutingBlock_2ch_Req_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/RoutingBlock_Resp_icache_intc.sv
$PULP_ENV/src/ips/hier_icache/rtl/icache_intc/lint_mux.sv

// pulp-platform/latch_scm module files
$PULP_ENV/src/ips/hier_icache/rtl/scm/latch_scm/register_file_1r_1w_test_wrap.sv
$PULP_ENV/src/ips/hier_icache/rtl/scm/latch_scm/register_file_1r_1w.sv




$PULP_ENV/src/ips/hier_icache/rtl/pulp_interfaces.sv
$PULP_ENV/src/ips/hier_icache/rtl/axi_intf_to_bus_bridge.sv
$PULP_ENV/src/ips/hier_icache/rtl/axi_arbiter_fixed.sv
// $PULP_ENV/src/ips/hier_icache/rtl/icache_wrapper.sv