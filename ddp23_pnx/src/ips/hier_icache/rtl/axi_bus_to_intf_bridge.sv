// axi_bus_to_intf_bridge.sv

// This module bridges an AXI_BUS.Master interface to an AXI_BUS_INTF.Master interface.
module axi_bus_to_intf_bridge
#(
  parameter AXI_ADDR_WIDTH = 32,
  parameter AXI_DATA_WIDTH = 64,
  parameter AXI_ID_WIDTH   = 10,
  parameter AXI_USER_WIDTH = 6
)
(
  AXI_BUS_INTF.Master      s_axi,
  AXI_BUS.Slave           m_axi // Check AXI_BUS
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
  assign m_axi.b_id        = s_axi.b_id;
  assign m_axi.b_resp      = s_axi.b_resp;
  assign m_axi.b_user      = s_axi.b_user;
  assign m_axi.b_valid     = s_axi.b_valid;
  assign s_axi.b_ready     = m_axi.b_ready;

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

  // --- AXI Read Data Channel (R) ---
  assign m_axi.r_id        = s_axi.r_id;
  assign m_axi.r_data      = s_axi.r_data;
  assign m_axi.r_resp      = s_axi.r_resp;
  assign m_axi.r_last      = s_axi.r_last;
  assign m_axi.r_user      = s_axi.r_user;
  assign m_axi.r_valid     = s_axi.r_valid;
  assign s_axi.r_ready     = m_axi.r_ready;

endmodule