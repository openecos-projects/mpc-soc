// SPDX-License-Identifier: Apache-2.0
//
// Template wrapper for connecting an NPC-style CPU core to mpc-soc.
//
// Usage:
// 1. Copy this file and rename the module for your core slot.
// 2. Replace the idle AXI master assignments with your core instance.
// 3. Keep the external port names aligned with the SoC core slot contract.
// 4. Add the copied wrapper and the core RTL to hw/filelist/verilator.f.

`default_nettype none

module npc_wrapper_template (
  input  wire        clock,
  input  wire        reset,
  input  wire        io_interrupt,

  input  wire        io_master_awready,
  output wire        io_master_awvalid,
  output wire [3:0]  io_master_awid,
  output wire [31:0] io_master_awaddr,
  output wire [7:0]  io_master_awlen,
  output wire [2:0]  io_master_awsize,
  output wire [1:0]  io_master_awburst,

  input  wire        io_master_wready,
  output wire        io_master_wvalid,
  output wire [31:0] io_master_wdata,
  output wire [3:0]  io_master_wstrb,
  output wire        io_master_wlast,

  output wire        io_master_bready,
  input  wire        io_master_bvalid,
  input  wire [3:0]  io_master_bid,
  input  wire [1:0]  io_master_bresp,

  input  wire        io_master_arready,
  output wire        io_master_arvalid,
  output wire [3:0]  io_master_arid,
  output wire [31:0] io_master_araddr,
  output wire [7:0]  io_master_arlen,
  output wire [2:0]  io_master_arsize,
  output wire [1:0]  io_master_arburst,

  output wire        io_master_rready,
  input  wire        io_master_rvalid,
  input  wire [3:0]  io_master_rid,
  input  wire [31:0] io_master_rdata,
  input  wire [1:0]  io_master_rresp,
  input  wire        io_master_rlast,

  output wire        io_slave_awready,
  input  wire        io_slave_awvalid,
  input  wire [3:0]  io_slave_awid,
  input  wire [31:0] io_slave_awaddr,
  input  wire [7:0]  io_slave_awlen,
  input  wire [2:0]  io_slave_awsize,
  input  wire [1:0]  io_slave_awburst,

  output wire        io_slave_wready,
  input  wire        io_slave_wvalid,
  input  wire [31:0] io_slave_wdata,
  input  wire [3:0]  io_slave_wstrb,
  input  wire        io_slave_wlast,

  input  wire        io_slave_bready,
  output wire        io_slave_bvalid,
  output wire [3:0]  io_slave_bid,
  output wire [1:0]  io_slave_bresp,

  output wire        io_slave_arready,
  input  wire        io_slave_arvalid,
  input  wire [3:0]  io_slave_arid,
  input  wire [31:0] io_slave_araddr,
  input  wire [7:0]  io_slave_arlen,
  input  wire [2:0]  io_slave_arsize,
  input  wire [1:0]  io_slave_arburst,

  input  wire        io_slave_rready,
  output wire        io_slave_rvalid,
  output wire [3:0]  io_slave_rid,
  output wire [31:0] io_slave_rdata,
  output wire [1:0]  io_slave_rresp,
  output wire        io_slave_rlast
);

  // Replace this idle master with your NPC/core instance.
  // The external names match the current SoC slot wiring in asic_top.v.
  //
  // Example shape:
  //
  // user_npc u_core (
  //   .clock              (clock),
  //   .reset              (reset),
  //   .io_interrupt       (io_interrupt),
  //   .io_master_awready  (io_master_awready),
  //   .io_master_awvalid  (io_master_awvalid),
  //   ...
  // );

  assign io_master_awvalid = 1'b0;
  assign io_master_awid    = 4'h0;
  assign io_master_awaddr  = 32'h0000_0000;
  assign io_master_awlen   = 8'h00;
  assign io_master_awsize  = 3'h0;
  assign io_master_awburst = 2'h0;

  assign io_master_wvalid  = 1'b0;
  assign io_master_wdata   = 32'h0000_0000;
  assign io_master_wstrb   = 4'h0;
  assign io_master_wlast   = 1'b0;

  assign io_master_bready  = 1'b0;

  assign io_master_arvalid = 1'b0;
  assign io_master_arid    = 4'h0;
  assign io_master_araddr  = 32'h0000_0000;
  assign io_master_arlen   = 8'h00;
  assign io_master_arsize  = 3'h0;
  assign io_master_arburst = 2'h0;

  assign io_master_rready  = 1'b0;

  // The current SoC does not require the core-side AXI slave port.
  // Keep these defaults if your core has no debug/slave interface.
  assign io_slave_awready  = 1'b0;
  assign io_slave_wready   = 1'b0;
  assign io_slave_bvalid   = 1'b0;
  assign io_slave_bid      = 4'h0;
  assign io_slave_bresp    = 2'h0;

  assign io_slave_arready  = 1'b0;
  assign io_slave_rvalid   = 1'b0;
  assign io_slave_rid      = 4'h0;
  assign io_slave_rdata    = 32'h0000_0000;
  assign io_slave_rresp    = 2'h0;
  assign io_slave_rlast    = 1'b0;

  // Keep template inputs visible to lint without affecting synthesis.
  wire unused_template_inputs;
  assign unused_template_inputs = ^{
    clock,
    reset,
    io_interrupt,
    io_master_awready,
    io_master_wready,
    io_master_bvalid,
    io_master_bid,
    io_master_bresp,
    io_master_arready,
    io_master_rvalid,
    io_master_rid,
    io_master_rdata,
    io_master_rresp,
    io_master_rlast,
    io_slave_awvalid,
    io_slave_awid,
    io_slave_awaddr,
    io_slave_awlen,
    io_slave_awsize,
    io_slave_awburst,
    io_slave_wvalid,
    io_slave_wdata,
    io_slave_wstrb,
    io_slave_wlast,
    io_slave_bready,
    io_slave_arvalid,
    io_slave_arid,
    io_slave_araddr,
    io_slave_arlen,
    io_slave_arsize,
    io_slave_arburst,
    io_slave_rready
  };

endmodule

`default_nettype wire
