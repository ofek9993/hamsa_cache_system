// axi_intf_to_bus_bridge.sv

// This module bridges an AXI_BUS_INTF.Master interface to an AXI_BUS.Master interface.
// It handles signal mapping and the 'aw_atop' signal.
module axi_intf_to_bus_bridge
#(
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 64,
  parameter int unsigned AXI_ID_WIDTH   = 10,
  parameter int unsigned AXI_USER_WIDTH = 6
)
(
  // Input: The AXI_BUS_INTF Slave interface (from the arbiter)
  AXI_BUS_INTF.Slave s_axi,

  // Output: The AXI_BUS Master interface (for Xcore_region's core_master port)
  AXI_BUS.Master      m_axi
);

  // --- AXI Write Address Channel (AW) ---
  assign m_axi.aw_id       = s_axi.aw_id;
  assign m_axi.aw_addr     = s_axi.aw_addr;
  assign m_axi.aw_len      = s_axi.aw_len;
  assign m_axi.aw_size     = s_axi.aw_size;
  assign m_axi.aw_burst    = s_axi.aw_burst;
  assign m_axi.aw_lock     = s_axi.aw_lock;
  assign m_axi.aw_cache    = s_axi.aw_cache;
  assign m_axi.aw_prot     = s_axi.aw_prot;
  assign m_axi.aw_qos      = s_axi.aw_qos;
  assign m_axi.aw_region   = s_axi.aw_region;
  assign m_axi.aw_user     = s_axi.aw_user;
  assign m_axi.aw_valid    = s_axi.aw_valid;
  assign s_axi.aw_ready    = m_axi.aw_ready;

  // --- AXI Write Data Channel (W) ---
  assign m_axi.w_data      = s_axi.w_data;
  assign m_axi.w_strb      = s_axi.w_strb;
  assign m_axi.w_last      = s_axi.w_last;
  assign m_axi.w_user      = s_axi.w_user;
  assign m_axi.w_valid     = s_axi.w_valid;
  assign s_axi.w_ready     = m_axi.w_ready;

  // --- AXI Write Response Channel (B) ---
  assign s_axi.b_id        = m_axi.b_id;
  assign s_axi.b_resp      = m_axi.b_resp;
  assign s_axi.b_user      = m_axi.b_user;
  assign s_axi.b_valid     = m_axi.b_valid;
  assign m_axi.b_ready     = s_axi.b_ready;

  // --- AXI Read Address Channel (AR) ---
  assign m_axi.ar_id       = s_axi.ar_id;
  assign m_axi.ar_addr     = s_axi.ar_addr;
  assign m_axi.ar_len      = s_axi.ar_len;
  assign m_axi.ar_size     = s_axi.ar_size;
  assign m_axi.ar_burst    = s_axi.ar_burst;
  assign m_axi.ar_lock     = s_axi.ar_lock;
  assign m_axi.ar_cache    = s_axi.ar_cache;
  assign m_axi.ar_prot     = s_axi.ar_prot;
  assign m_axi.ar_qos      = s_axi.ar_qos;
  assign m_axi.ar_region   = s_axi.ar_region;
  assign m_axi.ar_user     = s_axi.ar_user;
  assign m_axi.ar_valid    = s_axi.ar_valid;
  assign s_axi.ar_ready    = m_axi.ar_ready;

  // --- AXI Read Data Channel (R): 
  assign s_axi.r_id        = m_axi.r_id;
  assign s_axi.r_data      = m_axi.r_data;
  assign s_axi.r_resp      = m_axi.r_resp;
  assign s_axi.r_last      = m_axi.r_last;
  assign s_axi.r_user      = m_axi.r_user;
  assign s_axi.r_valid     = m_axi.r_valid;
  assign m_axi.r_ready     = s_axi.r_ready;

  // Note: 'aw_atop' and 'ar_atop' signals from AXI_BUS_INTF are not present in AXI_BUS.
  // The master-side interface of AXI_BUS_INTF does not have these.
  // No need to handle them here since AXI_BUS.Master doesn't have them.

endmodule