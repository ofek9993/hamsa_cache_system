// icache_wrapper.sv

module icache_wrapper
#(
  parameter CORE_FETCH_ADDR_WIDTH     = 32,
  parameter CORE_FETCH_DATA_WIDTH     = 32,
  parameter MEM_FETCH_ADDR_WIDTH      = 32,
  parameter MEM_FETCH_DATA_WIDTH      = 32
)
(
  input  logic                                        clk,
  input  logic                                        rst_n,

  // Interface to the Core
  input  logic                                        core_req_i,
  input  logic [CORE_FETCH_ADDR_WIDTH-1:0]            core_addr_i,
  output logic                                        core_gnt_o,
  output logic                                        core_rvalid_o,
  output logic [CORE_FETCH_DATA_WIDTH-1:0]            core_rdata_o,

  // Interface to the Original SoC's Memory Demux
  output logic                                        mem_req_o,
  output logic [MEM_FETCH_ADDR_WIDTH-1:0]             mem_addr_o,
  input  logic                                        mem_gnt_i,
  input  logic                                        mem_rvalid_i,
  input  logic [MEM_FETCH_DATA_WIDTH-1:0]             mem_rdata_i
);

// --- Mock Cache Wrapper: Direct Passthrough Logic ---
// Pass core requests directly to the memory demux
assign mem_req_o      = core_req_i;
assign mem_addr_o     = core_addr_i;

// Pass memory responses directly back to the core
assign core_gnt_o     = mem_gnt_i;
assign core_rvalid_o  = mem_rvalid_i;
assign core_rdata_o   = mem_rdata_i;

endmodule