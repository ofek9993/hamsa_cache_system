// axi_arbiter_fixed.sv

// This module implements a fixed-priority AXI arbiter for two masters (icache and data).
// It ensures correct propagation of AXI handshake signals, especially 'ready'.
module axi_arbiter_fixed
#(
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 64,
  parameter int unsigned AXI_ID_WIDTH   = 11, // Must be wide enough for arbiter ID + master ID
  parameter int unsigned AXI_USER_WIDTH = 0
)
(
  input logic clk,
  input logic rst_n,

  // Inputs from masters (icache and data path)
  AXI_BUS_INTF.Master s_icache, // Instruction Cache Master
  AXI_BUS_INTF.Master s_data,   // Data Path Master

  // Output to the shared AXI bus (core_master)
  AXI_BUS_INTF.Master m_out
);

  // --- Internal Arbitration Logic ---
  // We'll use a simple priority scheme: icache gets priority if both are valid.
  // This signal indicates which master is currently granted the bus.
  logic select_icache; // 1 if icache is selected, 0 if data is selected

  // Determine which master is currently granted the bus
  // This logic ensures that once a master starts a transaction, it holds the bus
  // until the transaction (burst) is complete (signaled by r_last or b_valid).
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      select_icache <= 1'b0; // Default to data path or idle
    end else begin
      // If a transaction is ongoing, maintain selection
      if ((s_icache.ar_valid && m_out.ar_ready && !s_icache.r_last) ||
          (s_icache.aw_valid && m_out.aw_ready && !s_icache.w_last && !s_icache.b_valid)) begin
        select_icache <= 1'b1;
      end else if ((s_data.ar_valid && m_out.ar_ready && !s_data.r_last) ||
                   (s_data.aw_valid && m_out.aw_ready && !s_data.w_last && !s_data.b_valid)) begin
        select_icache <= 1'b0;
      end else begin
        // No ongoing transaction, arbitrate based on priority
        if (s_icache.ar_valid || s_icache.aw_valid) begin
          select_icache <= 1'b1; // icache has priority
        end else if (s_data.ar_valid || s_data.aw_valid) begin
          select_icache <= 1'b0; // Data if icache is not requesting
        end
        // Else, maintain current selection or go to default (depends on specific arbitration policy)
      end
    end
  end


  // --- AXI Write Address Channel (AW) ---
  assign m_out.aw_id       = select_icache ? s_icache.aw_id       : s_data.aw_id;
  assign m_out.aw_addr     = select_icache ? s_icache.aw_addr     : s_data.aw_addr;
  assign m_out.aw_len      = select_icache ? s_icache.aw_len      : s_data.aw_len;
  assign m_out.aw_size     = select_icache ? s_icache.aw_size     : s_data.aw_size;
  assign m_out.aw_burst    = select_icache ? s_icache.aw_burst    : s_data.aw_burst;
  assign m_out.aw_lock     = select_icache ? s_icache.aw_lock     : s_data.aw_lock;
  assign m_out.aw_cache    = select_icache ? s_icache.aw_cache    : s_data.aw_cache;
  assign m_out.aw_prot     = select_icache ? s_icache.aw_prot     : s_data.aw_prot;
  assign m_out.aw_qos      = select_icache ? s_icache.aw_qos      : s_data.aw_qos;
  assign m_out.aw_region   = select_icache ? s_icache.aw_region   : s_data.aw_region;
  assign m_out.aw_atop     = select_icache ? s_icache.aw_atop     : s_data.aw_atop;
  assign m_out.aw_user     = select_icache ? s_icache.aw_user     : s_data.aw_user;
  assign m_out.aw_valid    = (select_icache ? s_icache.aw_valid : s_data.aw_valid); // Only valid if a master is selected
  
  // Propagate aw_ready back to the selected master, and keep the other low
  assign s_icache.aw_ready = (select_icache && m_out.aw_valid) ? m_out.aw_ready : 1'b0;
  assign s_data.aw_ready   = (!select_icache && m_out.aw_valid) ? m_out.aw_ready : 1'b0;


  // --- AXI Write Data Channel (W) ---
  assign m_out.w_data      = select_icache ? s_icache.w_data      : s_data.w_data;
  assign m_out.w_strb      = select_icache ? s_icache.w_strb      : s_data.w_strb;
  assign m_out.w_last      = select_icache ? s_icache.w_last      : s_data.w_last;
  assign m_out.w_user      = select_icache ? s_icache.w_user      : s_data.w_user;
  assign m_out.w_valid     = (select_icache ? s_icache.w_valid : s_data.w_valid);
  
  assign s_icache.w_ready  = (select_icache && m_out.w_valid) ? m_out.w_ready : 1'b0;
  assign s_data.w_ready    = (!select_icache && m_out.w_valid) ? m_out.w_ready : 1'b0;


  // --- AXI Write Response Channel (B) ---
  assign s_icache.b_id     = m_out.b_id;
  assign s_icache.b_resp   = m_out.b_resp;
  assign s_icache.b_user   = m_out.b_user;
  assign s_icache.b_valid  = m_out.b_valid && select_icache; // Only valid for selected master
  
  assign s_data.b_id       = m_out.b_id;
  assign s_data.b_resp     = m_out.b_resp;
  assign s_data.b_user     = m_out.b_user;
  assign s_data.b_valid    = m_out.b_valid && !select_icache;
  
  assign m_out.b_ready     = (select_icache && s_icache.b_valid) ? s_icache.b_ready :
                             (!select_icache && s_data.b_valid) ? s_data.b_ready : 1'b0;


  // --- AXI Read Address Channel (AR) ---
  assign m_out.ar_id       = select_icache ? s_icache.ar_id       : s_data.ar_id;
  assign m_out.ar_addr     = select_icache ? s_icache.ar_addr     : s_data.ar_addr;
  assign m_out.ar_len      = select_icache ? s_icache.ar_len      : s_data.ar_len;
  assign m_out.ar_size     = select_icache ? s_icache.ar_size     : s_data.ar_size;
  assign m_out.ar_burst    = select_icache ? s_icache.ar_burst    : s_data.ar_burst;
  assign m_out.ar_lock     = select_icache ? s_icache.ar_lock     : s_data.ar_lock;
  assign m_out.ar_cache    = select_icache ? s_icache.ar_cache    : s_data.ar_cache;
  assign m_out.ar_prot     = select_icache ? s_icache.ar_prot     : s_data.ar_prot;
  assign m_out.ar_qos      = select_icache ? s_icache.ar_qos      : s_data.ar_qos;
  assign m_out.ar_region   = select_icache ? s_icache.ar_region   : s_data.ar_region;
  assign m_out.ar_user     = select_icache ? s_icache.ar_user     : s_data.ar_user;
  assign m_out.ar_valid    = (select_icache ? s_icache.ar_valid : s_data.ar_valid);
  
  assign s_icache.ar_ready = (select_icache && m_out.ar_valid) ? m_out.ar_ready : 1'b0;
  assign s_data.ar_ready   = (!select_icache && m_out.ar_valid) ? m_out.ar_ready : 1'b0;


  // --- AXI Read Data Channel (R) ---
  assign s_icache.r_id     = m_out.r_id;
  assign s_icache.r_data   = m_out.r_data;
  assign s_icache.r_resp   = m_out.r_resp;
  assign s_icache.r_last   = m_out.r_last;
  assign s_icache.r_user   = m_out.r_user;
  assign s_icache.r_valid  = m_out.r_valid && select_icache;
  
  assign s_data.r_id       = m_out.r_id;
  assign s_data.r_data     = m_out.r_data;
  assign s_data.r_resp     = m_out.r_resp;
  assign s_data.r_last     = m_out.r_last;
  assign s_data.r_user     = m_out.r_user;
  assign s_data.r_valid    = m_out.r_valid && !select_icache;
  
  assign m_out.r_ready     = (select_icache && s_icache.r_valid) ? s_icache.r_ready :
                             (!select_icache && s_data.r_valid) ? s_data.r_ready : 1'b0;

endmodule