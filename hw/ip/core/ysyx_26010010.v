module ysyx_26010010_ysyx_26010010 (
  input  wire          io_master_awready,
  output wire          io_master_awvalid,
  output wire [31:0]   io_master_awaddr,
  output wire [3:0]    io_master_awid,
  output wire [7:0]    io_master_awlen,
  output wire [2:0]    io_master_awsize,
  output wire [1:0]    io_master_awburst,
  input  wire          io_master_wready,
  output wire          io_master_wvalid,
  output wire [31:0]   io_master_wdata,
  output wire [3:0]    io_master_wstrb,
  output wire          io_master_wlast,
  output wire          io_master_bready,
  input  wire          io_master_bvalid,
  input  wire [1:0]    io_master_bresp,
  input  wire [3:0]    io_master_bid,
  input  wire          io_master_arready,
  output wire          io_master_arvalid,
  output wire [31:0]   io_master_araddr,
  output wire [3:0]    io_master_arid,
  output wire [7:0]    io_master_arlen,
  output wire [2:0]    io_master_arsize,
  output wire [1:0]    io_master_arburst,
  output wire          io_master_rready,
  input  wire          io_master_rvalid,
  input  wire [1:0]    io_master_rresp,
  input  wire [31:0]   io_master_rdata,
  input  wire          io_master_rlast,
  input  wire [3:0]    io_master_rid,
  output wire          io_slave_awready,
  input  wire          io_slave_awvalid,
  input  wire [31:0]   io_slave_awaddr,
  input  wire [3:0]    io_slave_awid,
  input  wire [7:0]    io_slave_awlen,
  input  wire [2:0]    io_slave_awsize,
  input  wire [1:0]    io_slave_awburst,
  output wire          io_slave_wready,
  input  wire          io_slave_wvalid,
  input  wire [31:0]   io_slave_wdata,
  input  wire [3:0]    io_slave_wstrb,
  input  wire          io_slave_wlast,
  input  wire          io_slave_bready,
  output wire          io_slave_bvalid,
  output wire [1:0]    io_slave_bresp,
  output wire [3:0]    io_slave_bid,
  output wire          io_slave_arready,
  input  wire          io_slave_arvalid,
  input  wire [31:0]   io_slave_araddr,
  input  wire [3:0]    io_slave_arid,
  input  wire [7:0]    io_slave_arlen,
  input  wire [2:0]    io_slave_arsize,
  input  wire [1:0]    io_slave_arburst,
  input  wire          io_slave_rready,
  output wire          io_slave_rvalid,
  output wire [1:0]    io_slave_rresp,
  output wire [31:0]   io_slave_rdata,
  output wire          io_slave_rlast,
  output wire [3:0]    io_slave_rid,
  input  wire          io_interrupt,
  input  wire          clock,
  input  wire          reset
);

  wire                turn_io_master_awready;
  wire                turn_io_master_wready;
  wire                turn_io_master_bvalid;
  wire       [1:0]    turn_io_master_bresp;
  wire       [3:0]    turn_io_master_bid;
  wire                turn_io_master_arready;
  wire                turn_io_master_rvalid;
  wire       [1:0]    turn_io_master_rresp;
  wire       [31:0]   turn_io_master_rdata;
  wire                turn_io_master_rlast;
  wire       [3:0]    turn_io_master_rid;
  wire                turn_io_slave_awvalid;
  wire       [31:0]   turn_io_slave_awaddr;
  wire       [3:0]    turn_io_slave_awid;
  wire       [7:0]    turn_io_slave_awlen;
  wire       [2:0]    turn_io_slave_awsize;
  wire       [1:0]    turn_io_slave_awburst;
  wire                turn_io_slave_wvalid;
  wire       [31:0]   turn_io_slave_wdata;
  wire       [3:0]    turn_io_slave_wstrb;
  wire                turn_io_slave_wlast;
  wire                turn_io_slave_bready;
  wire                turn_io_slave_arvalid;
  wire       [31:0]   turn_io_slave_araddr;
  wire       [3:0]    turn_io_slave_arid;
  wire       [7:0]    turn_io_slave_arlen;
  wire       [2:0]    turn_io_slave_arsize;
  wire       [1:0]    turn_io_slave_arburst;
  wire                turn_io_slave_rready;
  wire                turn_axi_m_ar_valid;
  wire       [31:0]   turn_axi_m_ar_payload_addr;
  wire       [3:0]    turn_axi_m_ar_payload_id;
  wire       [7:0]    turn_axi_m_ar_payload_len;
  wire       [2:0]    turn_axi_m_ar_payload_size;
  wire       [1:0]    turn_axi_m_ar_payload_burst;
  wire                turn_axi_m_aw_valid;
  wire       [31:0]   turn_axi_m_aw_payload_addr;
  wire       [3:0]    turn_axi_m_aw_payload_id;
  wire       [7:0]    turn_axi_m_aw_payload_len;
  wire       [2:0]    turn_axi_m_aw_payload_size;
  wire       [1:0]    turn_axi_m_aw_payload_burst;
  wire                turn_axi_m_w_valid;
  wire       [31:0]   turn_axi_m_w_payload_data;
  wire       [3:0]    turn_axi_m_w_payload_strb;
  wire                turn_axi_m_w_payload_last;
  wire                turn_axi_m_r_ready;
  wire                turn_axi_m_b_ready;
  wire                turn_axi_s_ar_ready;
  wire                turn_axi_s_aw_ready;
  wire                turn_axi_s_w_ready;
  wire                turn_axi_s_r_valid;
  wire       [31:0]   turn_axi_s_r_payload_data;
  wire       [3:0]    turn_axi_s_r_payload_id;
  wire       [1:0]    turn_axi_s_r_payload_resp;
  wire                turn_axi_s_r_payload_last;
  wire                turn_axi_s_b_valid;
  wire       [3:0]    turn_axi_s_b_payload_id;
  wire       [1:0]    turn_axi_s_b_payload_resp;
  wire                soc_axi_m_ar_valid;
  wire       [31:0]   soc_axi_m_ar_payload_addr;
  wire       [3:0]    soc_axi_m_ar_payload_id;
  wire       [7:0]    soc_axi_m_ar_payload_len;
  wire       [2:0]    soc_axi_m_ar_payload_size;
  wire       [1:0]    soc_axi_m_ar_payload_burst;
  wire                soc_axi_m_aw_valid;
  wire       [31:0]   soc_axi_m_aw_payload_addr;
  wire       [3:0]    soc_axi_m_aw_payload_id;
  wire       [7:0]    soc_axi_m_aw_payload_len;
  wire       [2:0]    soc_axi_m_aw_payload_size;
  wire       [1:0]    soc_axi_m_aw_payload_burst;
  wire                soc_axi_m_w_valid;
  wire       [31:0]   soc_axi_m_w_payload_data;
  wire       [3:0]    soc_axi_m_w_payload_strb;
  wire                soc_axi_m_w_payload_last;
  wire                soc_axi_m_r_ready;
  wire                soc_axi_m_b_ready;
  wire                soc_axi_s_ar_ready;
  wire                soc_axi_s_aw_ready;
  wire                soc_axi_s_w_ready;
  wire                soc_axi_s_r_valid;
  wire       [31:0]   soc_axi_s_r_payload_data;
  wire       [3:0]    soc_axi_s_r_payload_id;
  wire       [1:0]    soc_axi_s_r_payload_resp;
  wire                soc_axi_s_r_payload_last;
  wire                soc_axi_s_b_valid;
  wire       [3:0]    soc_axi_s_b_payload_id;
  wire       [1:0]    soc_axi_s_b_payload_resp;

  ysyx_26010010_AXITrun turn (
    .io_master_awready      (turn_io_master_awready          ), //o
    .io_master_awvalid      (io_slave_awvalid                ), //i
    .io_master_awaddr       (io_slave_awaddr[31:0]           ), //i
    .io_master_awid         (io_slave_awid[3:0]              ), //i
    .io_master_awlen        (io_slave_awlen[7:0]             ), //i
    .io_master_awsize       (io_slave_awsize[2:0]            ), //i
    .io_master_awburst      (io_slave_awburst[1:0]           ), //i
    .io_master_wready       (turn_io_master_wready           ), //o
    .io_master_wvalid       (io_slave_wvalid                 ), //i
    .io_master_wdata        (io_slave_wdata[31:0]            ), //i
    .io_master_wstrb        (io_slave_wstrb[3:0]             ), //i
    .io_master_wlast        (io_slave_wlast                  ), //i
    .io_master_bready       (io_slave_bready                 ), //i
    .io_master_bvalid       (turn_io_master_bvalid           ), //o
    .io_master_bresp        (turn_io_master_bresp[1:0]       ), //o
    .io_master_bid          (turn_io_master_bid[3:0]         ), //o
    .io_master_arready      (turn_io_master_arready          ), //o
    .io_master_arvalid      (io_slave_arvalid                ), //i
    .io_master_araddr       (io_slave_araddr[31:0]           ), //i
    .io_master_arid         (io_slave_arid[3:0]              ), //i
    .io_master_arlen        (io_slave_arlen[7:0]             ), //i
    .io_master_arsize       (io_slave_arsize[2:0]            ), //i
    .io_master_arburst      (io_slave_arburst[1:0]           ), //i
    .io_master_rready       (io_slave_rready                 ), //i
    .io_master_rvalid       (turn_io_master_rvalid           ), //o
    .io_master_rresp        (turn_io_master_rresp[1:0]       ), //o
    .io_master_rdata        (turn_io_master_rdata[31:0]      ), //o
    .io_master_rlast        (turn_io_master_rlast            ), //o
    .io_master_rid          (turn_io_master_rid[3:0]         ), //o
    .io_slave_awready       (io_master_awready               ), //i
    .io_slave_awvalid       (turn_io_slave_awvalid           ), //o
    .io_slave_awaddr        (turn_io_slave_awaddr[31:0]      ), //o
    .io_slave_awid          (turn_io_slave_awid[3:0]         ), //o
    .io_slave_awlen         (turn_io_slave_awlen[7:0]        ), //o
    .io_slave_awsize        (turn_io_slave_awsize[2:0]       ), //o
    .io_slave_awburst       (turn_io_slave_awburst[1:0]      ), //o
    .io_slave_wready        (io_master_wready                ), //i
    .io_slave_wvalid        (turn_io_slave_wvalid            ), //o
    .io_slave_wdata         (turn_io_slave_wdata[31:0]       ), //o
    .io_slave_wstrb         (turn_io_slave_wstrb[3:0]        ), //o
    .io_slave_wlast         (turn_io_slave_wlast             ), //o
    .io_slave_bready        (turn_io_slave_bready            ), //o
    .io_slave_bvalid        (io_master_bvalid                ), //i
    .io_slave_bresp         (io_master_bresp[1:0]            ), //i
    .io_slave_bid           (io_master_bid[3:0]              ), //i
    .io_slave_arready       (io_master_arready               ), //i
    .io_slave_arvalid       (turn_io_slave_arvalid           ), //o
    .io_slave_araddr        (turn_io_slave_araddr[31:0]      ), //o
    .io_slave_arid          (turn_io_slave_arid[3:0]         ), //o
    .io_slave_arlen         (turn_io_slave_arlen[7:0]        ), //o
    .io_slave_arsize        (turn_io_slave_arsize[2:0]       ), //o
    .io_slave_arburst       (turn_io_slave_arburst[1:0]      ), //o
    .io_slave_rready        (turn_io_slave_rready            ), //o
    .io_slave_rvalid        (io_master_rvalid                ), //i
    .io_slave_rresp         (io_master_rresp[1:0]            ), //i
    .io_slave_rdata         (io_master_rdata[31:0]           ), //i
    .io_slave_rlast         (io_master_rlast                 ), //i
    .io_slave_rid           (io_master_rid[3:0]              ), //i
    .axi_m_aw_valid         (turn_axi_m_aw_valid             ), //o
    .axi_m_aw_ready         (soc_axi_s_aw_ready              ), //i
    .axi_m_aw_payload_addr  (turn_axi_m_aw_payload_addr[31:0]), //o
    .axi_m_aw_payload_id    (turn_axi_m_aw_payload_id[3:0]   ), //o
    .axi_m_aw_payload_len   (turn_axi_m_aw_payload_len[7:0]  ), //o
    .axi_m_aw_payload_size  (turn_axi_m_aw_payload_size[2:0] ), //o
    .axi_m_aw_payload_burst (turn_axi_m_aw_payload_burst[1:0]), //o
    .axi_m_w_valid          (turn_axi_m_w_valid              ), //o
    .axi_m_w_ready          (soc_axi_s_w_ready               ), //i
    .axi_m_w_payload_data   (turn_axi_m_w_payload_data[31:0] ), //o
    .axi_m_w_payload_strb   (turn_axi_m_w_payload_strb[3:0]  ), //o
    .axi_m_w_payload_last   (turn_axi_m_w_payload_last       ), //o
    .axi_m_b_valid          (soc_axi_s_b_valid               ), //i
    .axi_m_b_ready          (turn_axi_m_b_ready              ), //o
    .axi_m_b_payload_id     (soc_axi_s_b_payload_id[3:0]     ), //i
    .axi_m_b_payload_resp   (soc_axi_s_b_payload_resp[1:0]   ), //i
    .axi_m_ar_valid         (turn_axi_m_ar_valid             ), //o
    .axi_m_ar_ready         (soc_axi_s_ar_ready              ), //i
    .axi_m_ar_payload_addr  (turn_axi_m_ar_payload_addr[31:0]), //o
    .axi_m_ar_payload_id    (turn_axi_m_ar_payload_id[3:0]   ), //o
    .axi_m_ar_payload_len   (turn_axi_m_ar_payload_len[7:0]  ), //o
    .axi_m_ar_payload_size  (turn_axi_m_ar_payload_size[2:0] ), //o
    .axi_m_ar_payload_burst (turn_axi_m_ar_payload_burst[1:0]), //o
    .axi_m_r_valid          (soc_axi_s_r_valid               ), //i
    .axi_m_r_ready          (turn_axi_m_r_ready              ), //o
    .axi_m_r_payload_data   (soc_axi_s_r_payload_data[31:0]  ), //i
    .axi_m_r_payload_id     (soc_axi_s_r_payload_id[3:0]     ), //i
    .axi_m_r_payload_resp   (soc_axi_s_r_payload_resp[1:0]   ), //i
    .axi_m_r_payload_last   (soc_axi_s_r_payload_last        ), //i
    .axi_s_aw_valid         (soc_axi_m_aw_valid              ), //i
    .axi_s_aw_ready         (turn_axi_s_aw_ready             ), //o
    .axi_s_aw_payload_addr  (soc_axi_m_aw_payload_addr[31:0] ), //i
    .axi_s_aw_payload_id    (soc_axi_m_aw_payload_id[3:0]    ), //i
    .axi_s_aw_payload_len   (soc_axi_m_aw_payload_len[7:0]   ), //i
    .axi_s_aw_payload_size  (soc_axi_m_aw_payload_size[2:0]  ), //i
    .axi_s_aw_payload_burst (soc_axi_m_aw_payload_burst[1:0] ), //i
    .axi_s_w_valid          (soc_axi_m_w_valid               ), //i
    .axi_s_w_ready          (turn_axi_s_w_ready              ), //o
    .axi_s_w_payload_data   (soc_axi_m_w_payload_data[31:0]  ), //i
    .axi_s_w_payload_strb   (soc_axi_m_w_payload_strb[3:0]   ), //i
    .axi_s_w_payload_last   (soc_axi_m_w_payload_last        ), //i
    .axi_s_b_valid          (turn_axi_s_b_valid              ), //o
    .axi_s_b_ready          (soc_axi_m_b_ready               ), //i
    .axi_s_b_payload_id     (turn_axi_s_b_payload_id[3:0]    ), //o
    .axi_s_b_payload_resp   (turn_axi_s_b_payload_resp[1:0]  ), //o
    .axi_s_ar_valid         (soc_axi_m_ar_valid              ), //i
    .axi_s_ar_ready         (turn_axi_s_ar_ready             ), //o
    .axi_s_ar_payload_addr  (soc_axi_m_ar_payload_addr[31:0] ), //i
    .axi_s_ar_payload_id    (soc_axi_m_ar_payload_id[3:0]    ), //i
    .axi_s_ar_payload_len   (soc_axi_m_ar_payload_len[7:0]   ), //i
    .axi_s_ar_payload_size  (soc_axi_m_ar_payload_size[2:0]  ), //i
    .axi_s_ar_payload_burst (soc_axi_m_ar_payload_burst[1:0] ), //i
    .axi_s_r_valid          (turn_axi_s_r_valid              ), //o
    .axi_s_r_ready          (soc_axi_m_r_ready               ), //i
    .axi_s_r_payload_data   (turn_axi_s_r_payload_data[31:0] ), //o
    .axi_s_r_payload_id     (turn_axi_s_r_payload_id[3:0]    ), //o
    .axi_s_r_payload_resp   (turn_axi_s_r_payload_resp[1:0]  ), //o
    .axi_s_r_payload_last   (turn_axi_s_r_payload_last       )  //o
  );
  ysyx_26010010_Soc soc (
    .axi_m_aw_valid         (soc_axi_m_aw_valid              ), //o
    .axi_m_aw_ready         (turn_axi_s_aw_ready             ), //i
    .axi_m_aw_payload_addr  (soc_axi_m_aw_payload_addr[31:0] ), //o
    .axi_m_aw_payload_id    (soc_axi_m_aw_payload_id[3:0]    ), //o
    .axi_m_aw_payload_len   (soc_axi_m_aw_payload_len[7:0]   ), //o
    .axi_m_aw_payload_size  (soc_axi_m_aw_payload_size[2:0]  ), //o
    .axi_m_aw_payload_burst (soc_axi_m_aw_payload_burst[1:0] ), //o
    .axi_m_w_valid          (soc_axi_m_w_valid               ), //o
    .axi_m_w_ready          (turn_axi_s_w_ready              ), //i
    .axi_m_w_payload_data   (soc_axi_m_w_payload_data[31:0]  ), //o
    .axi_m_w_payload_strb   (soc_axi_m_w_payload_strb[3:0]   ), //o
    .axi_m_w_payload_last   (soc_axi_m_w_payload_last        ), //o
    .axi_m_b_valid          (turn_axi_s_b_valid              ), //i
    .axi_m_b_ready          (soc_axi_m_b_ready               ), //o
    .axi_m_b_payload_id     (turn_axi_s_b_payload_id[3:0]    ), //i
    .axi_m_b_payload_resp   (turn_axi_s_b_payload_resp[1:0]  ), //i
    .axi_m_ar_valid         (soc_axi_m_ar_valid              ), //o
    .axi_m_ar_ready         (turn_axi_s_ar_ready             ), //i
    .axi_m_ar_payload_addr  (soc_axi_m_ar_payload_addr[31:0] ), //o
    .axi_m_ar_payload_id    (soc_axi_m_ar_payload_id[3:0]    ), //o
    .axi_m_ar_payload_len   (soc_axi_m_ar_payload_len[7:0]   ), //o
    .axi_m_ar_payload_size  (soc_axi_m_ar_payload_size[2:0]  ), //o
    .axi_m_ar_payload_burst (soc_axi_m_ar_payload_burst[1:0] ), //o
    .axi_m_r_valid          (turn_axi_s_r_valid              ), //i
    .axi_m_r_ready          (soc_axi_m_r_ready               ), //o
    .axi_m_r_payload_data   (turn_axi_s_r_payload_data[31:0] ), //i
    .axi_m_r_payload_id     (turn_axi_s_r_payload_id[3:0]    ), //i
    .axi_m_r_payload_resp   (turn_axi_s_r_payload_resp[1:0]  ), //i
    .axi_m_r_payload_last   (turn_axi_s_r_payload_last       ), //i
    .axi_s_aw_valid         (turn_axi_m_aw_valid             ), //i
    .axi_s_aw_ready         (soc_axi_s_aw_ready              ), //o
    .axi_s_aw_payload_addr  (turn_axi_m_aw_payload_addr[31:0]), //i
    .axi_s_aw_payload_id    (turn_axi_m_aw_payload_id[3:0]   ), //i
    .axi_s_aw_payload_len   (turn_axi_m_aw_payload_len[7:0]  ), //i
    .axi_s_aw_payload_size  (turn_axi_m_aw_payload_size[2:0] ), //i
    .axi_s_aw_payload_burst (turn_axi_m_aw_payload_burst[1:0]), //i
    .axi_s_w_valid          (turn_axi_m_w_valid              ), //i
    .axi_s_w_ready          (soc_axi_s_w_ready               ), //o
    .axi_s_w_payload_data   (turn_axi_m_w_payload_data[31:0] ), //i
    .axi_s_w_payload_strb   (turn_axi_m_w_payload_strb[3:0]  ), //i
    .axi_s_w_payload_last   (turn_axi_m_w_payload_last       ), //i
    .axi_s_b_valid          (soc_axi_s_b_valid               ), //o
    .axi_s_b_ready          (turn_axi_m_b_ready              ), //i
    .axi_s_b_payload_id     (soc_axi_s_b_payload_id[3:0]     ), //o
    .axi_s_b_payload_resp   (soc_axi_s_b_payload_resp[1:0]   ), //o
    .axi_s_ar_valid         (turn_axi_m_ar_valid             ), //i
    .axi_s_ar_ready         (soc_axi_s_ar_ready              ), //o
    .axi_s_ar_payload_addr  (turn_axi_m_ar_payload_addr[31:0]), //i
    .axi_s_ar_payload_id    (turn_axi_m_ar_payload_id[3:0]   ), //i
    .axi_s_ar_payload_len   (turn_axi_m_ar_payload_len[7:0]  ), //i
    .axi_s_ar_payload_size  (turn_axi_m_ar_payload_size[2:0] ), //i
    .axi_s_ar_payload_burst (turn_axi_m_ar_payload_burst[1:0]), //i
    .axi_s_r_valid          (soc_axi_s_r_valid               ), //o
    .axi_s_r_ready          (turn_axi_m_r_ready              ), //i
    .axi_s_r_payload_data   (soc_axi_s_r_payload_data[31:0]  ), //o
    .axi_s_r_payload_id     (soc_axi_s_r_payload_id[3:0]     ), //o
    .axi_s_r_payload_resp   (soc_axi_s_r_payload_resp[1:0]   ), //o
    .axi_s_r_payload_last   (soc_axi_s_r_payload_last        ), //o
    .clock                  (clock                           ), //i
    .reset                  (reset                           )  //i
  );
  assign io_master_awvalid = turn_io_slave_awvalid;
  assign io_master_awaddr = turn_io_slave_awaddr;
  assign io_master_awid = turn_io_slave_awid;
  assign io_master_awlen = turn_io_slave_awlen;
  assign io_master_awsize = turn_io_slave_awsize;
  assign io_master_awburst = turn_io_slave_awburst;
  assign io_master_wvalid = turn_io_slave_wvalid;
  assign io_master_wdata = turn_io_slave_wdata;
  assign io_master_wstrb = turn_io_slave_wstrb;
  assign io_master_wlast = turn_io_slave_wlast;
  assign io_master_bready = turn_io_slave_bready;
  assign io_master_arvalid = turn_io_slave_arvalid;
  assign io_master_araddr = turn_io_slave_araddr;
  assign io_master_arid = turn_io_slave_arid;
  assign io_master_arlen = turn_io_slave_arlen;
  assign io_master_arsize = turn_io_slave_arsize;
  assign io_master_arburst = turn_io_slave_arburst;
  assign io_master_rready = turn_io_slave_rready;
  assign io_slave_awready = turn_io_master_awready;
  assign io_slave_wready = turn_io_master_wready;
  assign io_slave_bvalid = turn_io_master_bvalid;
  assign io_slave_bresp = turn_io_master_bresp;
  assign io_slave_bid = turn_io_master_bid;
  assign io_slave_arready = turn_io_master_arready;
  assign io_slave_rvalid = turn_io_master_rvalid;
  assign io_slave_rresp = turn_io_master_rresp;
  assign io_slave_rdata = turn_io_master_rdata;
  assign io_slave_rlast = turn_io_master_rlast;
  assign io_slave_rid = turn_io_master_rid;

endmodule

module ysyx_26010010_Soc (
  output wire          axi_m_aw_valid,
  input  wire          axi_m_aw_ready,
  output wire [31:0]   axi_m_aw_payload_addr,
  output wire [3:0]    axi_m_aw_payload_id,
  output wire [7:0]    axi_m_aw_payload_len,
  output wire [2:0]    axi_m_aw_payload_size,
  output wire [1:0]    axi_m_aw_payload_burst,
  output wire          axi_m_w_valid,
  input  wire          axi_m_w_ready,
  output wire [31:0]   axi_m_w_payload_data,
  output wire [3:0]    axi_m_w_payload_strb,
  output wire          axi_m_w_payload_last,
  input  wire          axi_m_b_valid,
  output wire          axi_m_b_ready,
  input  wire [3:0]    axi_m_b_payload_id,
  input  wire [1:0]    axi_m_b_payload_resp,
  output wire          axi_m_ar_valid,
  input  wire          axi_m_ar_ready,
  output wire [31:0]   axi_m_ar_payload_addr,
  output wire [3:0]    axi_m_ar_payload_id,
  output wire [7:0]    axi_m_ar_payload_len,
  output wire [2:0]    axi_m_ar_payload_size,
  output wire [1:0]    axi_m_ar_payload_burst,
  input  wire          axi_m_r_valid,
  output wire          axi_m_r_ready,
  input  wire [31:0]   axi_m_r_payload_data,
  input  wire [3:0]    axi_m_r_payload_id,
  input  wire [1:0]    axi_m_r_payload_resp,
  input  wire          axi_m_r_payload_last,
  input  wire          axi_s_aw_valid,
  output wire          axi_s_aw_ready,
  input  wire [31:0]   axi_s_aw_payload_addr,
  input  wire [3:0]    axi_s_aw_payload_id,
  input  wire [7:0]    axi_s_aw_payload_len,
  input  wire [2:0]    axi_s_aw_payload_size,
  input  wire [1:0]    axi_s_aw_payload_burst,
  input  wire          axi_s_w_valid,
  output wire          axi_s_w_ready,
  input  wire [31:0]   axi_s_w_payload_data,
  input  wire [3:0]    axi_s_w_payload_strb,
  input  wire          axi_s_w_payload_last,
  output wire          axi_s_b_valid,
  input  wire          axi_s_b_ready,
  output wire [3:0]    axi_s_b_payload_id,
  output wire [1:0]    axi_s_b_payload_resp,
  input  wire          axi_s_ar_valid,
  output wire          axi_s_ar_ready,
  input  wire [31:0]   axi_s_ar_payload_addr,
  input  wire [3:0]    axi_s_ar_payload_id,
  input  wire [7:0]    axi_s_ar_payload_len,
  input  wire [2:0]    axi_s_ar_payload_size,
  input  wire [1:0]    axi_s_ar_payload_burst,
  output wire          axi_s_r_valid,
  input  wire          axi_s_r_ready,
  output wire [31:0]   axi_s_r_payload_data,
  output wire [3:0]    axi_s_r_payload_id,
  output wire [1:0]    axi_s_r_payload_resp,
  output wire          axi_s_r_payload_last,
  input  wire          clock,
  input  wire          reset
);

  wire                cpu_axi_if_ar_valid;
  wire       [31:0]   cpu_axi_if_ar_payload_addr;
  wire       [3:0]    cpu_axi_if_ar_payload_id;
  wire       [7:0]    cpu_axi_if_ar_payload_len;
  wire       [2:0]    cpu_axi_if_ar_payload_size;
  wire       [1:0]    cpu_axi_if_ar_payload_burst;
  wire                cpu_axi_if_aw_valid;
  wire       [31:0]   cpu_axi_if_aw_payload_addr;
  wire       [3:0]    cpu_axi_if_aw_payload_id;
  wire       [7:0]    cpu_axi_if_aw_payload_len;
  wire       [2:0]    cpu_axi_if_aw_payload_size;
  wire       [1:0]    cpu_axi_if_aw_payload_burst;
  wire                cpu_axi_if_w_valid;
  wire       [31:0]   cpu_axi_if_w_payload_data;
  wire       [3:0]    cpu_axi_if_w_payload_strb;
  wire                cpu_axi_if_w_payload_last;
  wire                cpu_axi_if_r_ready;
  wire                cpu_axi_if_b_ready;
  wire                cpu_axi_mem_ar_valid;
  wire       [31:0]   cpu_axi_mem_ar_payload_addr;
  wire       [3:0]    cpu_axi_mem_ar_payload_id;
  wire       [7:0]    cpu_axi_mem_ar_payload_len;
  wire       [2:0]    cpu_axi_mem_ar_payload_size;
  wire       [1:0]    cpu_axi_mem_ar_payload_burst;
  wire                cpu_axi_mem_aw_valid;
  wire       [31:0]   cpu_axi_mem_aw_payload_addr;
  wire       [3:0]    cpu_axi_mem_aw_payload_id;
  wire       [7:0]    cpu_axi_mem_aw_payload_len;
  wire       [2:0]    cpu_axi_mem_aw_payload_size;
  wire       [1:0]    cpu_axi_mem_aw_payload_burst;
  wire                cpu_axi_mem_w_valid;
  wire       [31:0]   cpu_axi_mem_w_payload_data;
  wire       [3:0]    cpu_axi_mem_w_payload_strb;
  wire                cpu_axi_mem_w_payload_last;
  wire                cpu_axi_mem_r_ready;
  wire                cpu_axi_mem_b_ready;
  wire                xbar_axi_m_0_ar_ready;
  wire                xbar_axi_m_0_aw_ready;
  wire                xbar_axi_m_0_w_ready;
  wire                xbar_axi_m_0_r_valid;
  wire       [31:0]   xbar_axi_m_0_r_payload_data;
  wire       [3:0]    xbar_axi_m_0_r_payload_id;
  wire       [1:0]    xbar_axi_m_0_r_payload_resp;
  wire                xbar_axi_m_0_r_payload_last;
  wire                xbar_axi_m_0_b_valid;
  wire       [3:0]    xbar_axi_m_0_b_payload_id;
  wire       [1:0]    xbar_axi_m_0_b_payload_resp;
  wire                xbar_axi_m_1_ar_ready;
  wire                xbar_axi_m_1_aw_ready;
  wire                xbar_axi_m_1_w_ready;
  wire                xbar_axi_m_1_r_valid;
  wire       [31:0]   xbar_axi_m_1_r_payload_data;
  wire       [3:0]    xbar_axi_m_1_r_payload_id;
  wire       [1:0]    xbar_axi_m_1_r_payload_resp;
  wire                xbar_axi_m_1_r_payload_last;
  wire                xbar_axi_m_1_b_valid;
  wire       [3:0]    xbar_axi_m_1_b_payload_id;
  wire       [1:0]    xbar_axi_m_1_b_payload_resp;
  wire                xbar_axi_s_0_ar_valid;
  wire       [31:0]   xbar_axi_s_0_ar_payload_addr;
  wire       [3:0]    xbar_axi_s_0_ar_payload_id;
  wire       [7:0]    xbar_axi_s_0_ar_payload_len;
  wire       [2:0]    xbar_axi_s_0_ar_payload_size;
  wire       [1:0]    xbar_axi_s_0_ar_payload_burst;
  wire                xbar_axi_s_0_aw_valid;
  wire       [31:0]   xbar_axi_s_0_aw_payload_addr;
  wire       [3:0]    xbar_axi_s_0_aw_payload_id;
  wire       [7:0]    xbar_axi_s_0_aw_payload_len;
  wire       [2:0]    xbar_axi_s_0_aw_payload_size;
  wire       [1:0]    xbar_axi_s_0_aw_payload_burst;
  wire                xbar_axi_s_0_w_valid;
  wire       [31:0]   xbar_axi_s_0_w_payload_data;
  wire       [3:0]    xbar_axi_s_0_w_payload_strb;
  wire                xbar_axi_s_0_w_payload_last;
  wire                xbar_axi_s_0_r_ready;
  wire                xbar_axi_s_0_b_ready;
  wire                xbar_axi_s_1_ar_valid;
  wire       [31:0]   xbar_axi_s_1_ar_payload_addr;
  wire       [3:0]    xbar_axi_s_1_ar_payload_id;
  wire       [7:0]    xbar_axi_s_1_ar_payload_len;
  wire       [2:0]    xbar_axi_s_1_ar_payload_size;
  wire       [1:0]    xbar_axi_s_1_ar_payload_burst;
  wire                xbar_axi_s_1_aw_valid;
  wire       [31:0]   xbar_axi_s_1_aw_payload_addr;
  wire       [3:0]    xbar_axi_s_1_aw_payload_id;
  wire       [7:0]    xbar_axi_s_1_aw_payload_len;
  wire       [2:0]    xbar_axi_s_1_aw_payload_size;
  wire       [1:0]    xbar_axi_s_1_aw_payload_burst;
  wire                xbar_axi_s_1_w_valid;
  wire       [31:0]   xbar_axi_s_1_w_payload_data;
  wire       [3:0]    xbar_axi_s_1_w_payload_strb;
  wire                xbar_axi_s_1_w_payload_last;
  wire                xbar_axi_s_1_r_ready;
  wire                xbar_axi_s_1_b_ready;
  wire                clint_axi_ar_ready;
  wire                clint_axi_aw_ready;
  wire                clint_axi_w_ready;
  wire                clint_axi_r_valid;
  wire       [31:0]   clint_axi_r_payload_data;
  wire       [3:0]    clint_axi_r_payload_id;
  wire       [1:0]    clint_axi_r_payload_resp;
  wire                clint_axi_r_payload_last;
  wire                clint_axi_b_valid;
  wire       [3:0]    clint_axi_b_payload_id;
  wire       [1:0]    clint_axi_b_payload_resp;

  ysyx_26010010_test_cpu cpu (
    .axi_if_aw_valid          (cpu_axi_if_aw_valid              ), //o
    .axi_if_aw_ready          (xbar_axi_m_0_aw_ready            ), //i
    .axi_if_aw_payload_addr   (cpu_axi_if_aw_payload_addr[31:0] ), //o
    .axi_if_aw_payload_id     (cpu_axi_if_aw_payload_id[3:0]    ), //o
    .axi_if_aw_payload_len    (cpu_axi_if_aw_payload_len[7:0]   ), //o
    .axi_if_aw_payload_size   (cpu_axi_if_aw_payload_size[2:0]  ), //o
    .axi_if_aw_payload_burst  (cpu_axi_if_aw_payload_burst[1:0] ), //o
    .axi_if_w_valid           (cpu_axi_if_w_valid               ), //o
    .axi_if_w_ready           (xbar_axi_m_0_w_ready             ), //i
    .axi_if_w_payload_data    (cpu_axi_if_w_payload_data[31:0]  ), //o
    .axi_if_w_payload_strb    (cpu_axi_if_w_payload_strb[3:0]   ), //o
    .axi_if_w_payload_last    (cpu_axi_if_w_payload_last        ), //o
    .axi_if_b_valid           (xbar_axi_m_0_b_valid             ), //i
    .axi_if_b_ready           (cpu_axi_if_b_ready               ), //o
    .axi_if_b_payload_id      (xbar_axi_m_0_b_payload_id[3:0]   ), //i
    .axi_if_b_payload_resp    (xbar_axi_m_0_b_payload_resp[1:0] ), //i
    .axi_if_ar_valid          (cpu_axi_if_ar_valid              ), //o
    .axi_if_ar_ready          (xbar_axi_m_0_ar_ready            ), //i
    .axi_if_ar_payload_addr   (cpu_axi_if_ar_payload_addr[31:0] ), //o
    .axi_if_ar_payload_id     (cpu_axi_if_ar_payload_id[3:0]    ), //o
    .axi_if_ar_payload_len    (cpu_axi_if_ar_payload_len[7:0]   ), //o
    .axi_if_ar_payload_size   (cpu_axi_if_ar_payload_size[2:0]  ), //o
    .axi_if_ar_payload_burst  (cpu_axi_if_ar_payload_burst[1:0] ), //o
    .axi_if_r_valid           (xbar_axi_m_0_r_valid             ), //i
    .axi_if_r_ready           (cpu_axi_if_r_ready               ), //o
    .axi_if_r_payload_data    (xbar_axi_m_0_r_payload_data[31:0]), //i
    .axi_if_r_payload_id      (xbar_axi_m_0_r_payload_id[3:0]   ), //i
    .axi_if_r_payload_resp    (xbar_axi_m_0_r_payload_resp[1:0] ), //i
    .axi_if_r_payload_last    (xbar_axi_m_0_r_payload_last      ), //i
    .axi_mem_aw_valid         (cpu_axi_mem_aw_valid             ), //o
    .axi_mem_aw_ready         (xbar_axi_m_1_aw_ready            ), //i
    .axi_mem_aw_payload_addr  (cpu_axi_mem_aw_payload_addr[31:0]), //o
    .axi_mem_aw_payload_id    (cpu_axi_mem_aw_payload_id[3:0]   ), //o
    .axi_mem_aw_payload_len   (cpu_axi_mem_aw_payload_len[7:0]  ), //o
    .axi_mem_aw_payload_size  (cpu_axi_mem_aw_payload_size[2:0] ), //o
    .axi_mem_aw_payload_burst (cpu_axi_mem_aw_payload_burst[1:0]), //o
    .axi_mem_w_valid          (cpu_axi_mem_w_valid              ), //o
    .axi_mem_w_ready          (xbar_axi_m_1_w_ready             ), //i
    .axi_mem_w_payload_data   (cpu_axi_mem_w_payload_data[31:0] ), //o
    .axi_mem_w_payload_strb   (cpu_axi_mem_w_payload_strb[3:0]  ), //o
    .axi_mem_w_payload_last   (cpu_axi_mem_w_payload_last       ), //o
    .axi_mem_b_valid          (xbar_axi_m_1_b_valid             ), //i
    .axi_mem_b_ready          (cpu_axi_mem_b_ready              ), //o
    .axi_mem_b_payload_id     (xbar_axi_m_1_b_payload_id[3:0]   ), //i
    .axi_mem_b_payload_resp   (xbar_axi_m_1_b_payload_resp[1:0] ), //i
    .axi_mem_ar_valid         (cpu_axi_mem_ar_valid             ), //o
    .axi_mem_ar_ready         (xbar_axi_m_1_ar_ready            ), //i
    .axi_mem_ar_payload_addr  (cpu_axi_mem_ar_payload_addr[31:0]), //o
    .axi_mem_ar_payload_id    (cpu_axi_mem_ar_payload_id[3:0]   ), //o
    .axi_mem_ar_payload_len   (cpu_axi_mem_ar_payload_len[7:0]  ), //o
    .axi_mem_ar_payload_size  (cpu_axi_mem_ar_payload_size[2:0] ), //o
    .axi_mem_ar_payload_burst (cpu_axi_mem_ar_payload_burst[1:0]), //o
    .axi_mem_r_valid          (xbar_axi_m_1_r_valid             ), //i
    .axi_mem_r_ready          (cpu_axi_mem_r_ready              ), //o
    .axi_mem_r_payload_data   (xbar_axi_m_1_r_payload_data[31:0]), //i
    .axi_mem_r_payload_id     (xbar_axi_m_1_r_payload_id[3:0]   ), //i
    .axi_mem_r_payload_resp   (xbar_axi_m_1_r_payload_resp[1:0] ), //i
    .axi_mem_r_payload_last   (xbar_axi_m_1_r_payload_last      ), //i
    .clock                    (clock                            ), //i
    .reset                    (reset                            )  //i
  );
  ysyx_26010010_AXIXbar_new xbar (
    .axi_m_0_aw_valid         (cpu_axi_if_aw_valid               ), //i
    .axi_m_0_aw_ready         (xbar_axi_m_0_aw_ready             ), //o
    .axi_m_0_aw_payload_addr  (cpu_axi_if_aw_payload_addr[31:0]  ), //i
    .axi_m_0_aw_payload_id    (cpu_axi_if_aw_payload_id[3:0]     ), //i
    .axi_m_0_aw_payload_len   (cpu_axi_if_aw_payload_len[7:0]    ), //i
    .axi_m_0_aw_payload_size  (cpu_axi_if_aw_payload_size[2:0]   ), //i
    .axi_m_0_aw_payload_burst (cpu_axi_if_aw_payload_burst[1:0]  ), //i
    .axi_m_0_w_valid          (cpu_axi_if_w_valid                ), //i
    .axi_m_0_w_ready          (xbar_axi_m_0_w_ready              ), //o
    .axi_m_0_w_payload_data   (cpu_axi_if_w_payload_data[31:0]   ), //i
    .axi_m_0_w_payload_strb   (cpu_axi_if_w_payload_strb[3:0]    ), //i
    .axi_m_0_w_payload_last   (cpu_axi_if_w_payload_last         ), //i
    .axi_m_0_b_valid          (xbar_axi_m_0_b_valid              ), //o
    .axi_m_0_b_ready          (cpu_axi_if_b_ready                ), //i
    .axi_m_0_b_payload_id     (xbar_axi_m_0_b_payload_id[3:0]    ), //o
    .axi_m_0_b_payload_resp   (xbar_axi_m_0_b_payload_resp[1:0]  ), //o
    .axi_m_0_ar_valid         (cpu_axi_if_ar_valid               ), //i
    .axi_m_0_ar_ready         (xbar_axi_m_0_ar_ready             ), //o
    .axi_m_0_ar_payload_addr  (cpu_axi_if_ar_payload_addr[31:0]  ), //i
    .axi_m_0_ar_payload_id    (cpu_axi_if_ar_payload_id[3:0]     ), //i
    .axi_m_0_ar_payload_len   (cpu_axi_if_ar_payload_len[7:0]    ), //i
    .axi_m_0_ar_payload_size  (cpu_axi_if_ar_payload_size[2:0]   ), //i
    .axi_m_0_ar_payload_burst (cpu_axi_if_ar_payload_burst[1:0]  ), //i
    .axi_m_0_r_valid          (xbar_axi_m_0_r_valid              ), //o
    .axi_m_0_r_ready          (cpu_axi_if_r_ready                ), //i
    .axi_m_0_r_payload_data   (xbar_axi_m_0_r_payload_data[31:0] ), //o
    .axi_m_0_r_payload_id     (xbar_axi_m_0_r_payload_id[3:0]    ), //o
    .axi_m_0_r_payload_resp   (xbar_axi_m_0_r_payload_resp[1:0]  ), //o
    .axi_m_0_r_payload_last   (xbar_axi_m_0_r_payload_last       ), //o
    .axi_m_1_aw_valid         (cpu_axi_mem_aw_valid              ), //i
    .axi_m_1_aw_ready         (xbar_axi_m_1_aw_ready             ), //o
    .axi_m_1_aw_payload_addr  (cpu_axi_mem_aw_payload_addr[31:0] ), //i
    .axi_m_1_aw_payload_id    (cpu_axi_mem_aw_payload_id[3:0]    ), //i
    .axi_m_1_aw_payload_len   (cpu_axi_mem_aw_payload_len[7:0]   ), //i
    .axi_m_1_aw_payload_size  (cpu_axi_mem_aw_payload_size[2:0]  ), //i
    .axi_m_1_aw_payload_burst (cpu_axi_mem_aw_payload_burst[1:0] ), //i
    .axi_m_1_w_valid          (cpu_axi_mem_w_valid               ), //i
    .axi_m_1_w_ready          (xbar_axi_m_1_w_ready              ), //o
    .axi_m_1_w_payload_data   (cpu_axi_mem_w_payload_data[31:0]  ), //i
    .axi_m_1_w_payload_strb   (cpu_axi_mem_w_payload_strb[3:0]   ), //i
    .axi_m_1_w_payload_last   (cpu_axi_mem_w_payload_last        ), //i
    .axi_m_1_b_valid          (xbar_axi_m_1_b_valid              ), //o
    .axi_m_1_b_ready          (cpu_axi_mem_b_ready               ), //i
    .axi_m_1_b_payload_id     (xbar_axi_m_1_b_payload_id[3:0]    ), //o
    .axi_m_1_b_payload_resp   (xbar_axi_m_1_b_payload_resp[1:0]  ), //o
    .axi_m_1_ar_valid         (cpu_axi_mem_ar_valid              ), //i
    .axi_m_1_ar_ready         (xbar_axi_m_1_ar_ready             ), //o
    .axi_m_1_ar_payload_addr  (cpu_axi_mem_ar_payload_addr[31:0] ), //i
    .axi_m_1_ar_payload_id    (cpu_axi_mem_ar_payload_id[3:0]    ), //i
    .axi_m_1_ar_payload_len   (cpu_axi_mem_ar_payload_len[7:0]   ), //i
    .axi_m_1_ar_payload_size  (cpu_axi_mem_ar_payload_size[2:0]  ), //i
    .axi_m_1_ar_payload_burst (cpu_axi_mem_ar_payload_burst[1:0] ), //i
    .axi_m_1_r_valid          (xbar_axi_m_1_r_valid              ), //o
    .axi_m_1_r_ready          (cpu_axi_mem_r_ready               ), //i
    .axi_m_1_r_payload_data   (xbar_axi_m_1_r_payload_data[31:0] ), //o
    .axi_m_1_r_payload_id     (xbar_axi_m_1_r_payload_id[3:0]    ), //o
    .axi_m_1_r_payload_resp   (xbar_axi_m_1_r_payload_resp[1:0]  ), //o
    .axi_m_1_r_payload_last   (xbar_axi_m_1_r_payload_last       ), //o
    .axi_s_0_aw_valid         (xbar_axi_s_0_aw_valid             ), //o
    .axi_s_0_aw_ready         (axi_m_aw_ready                    ), //i
    .axi_s_0_aw_payload_addr  (xbar_axi_s_0_aw_payload_addr[31:0]), //o
    .axi_s_0_aw_payload_id    (xbar_axi_s_0_aw_payload_id[3:0]   ), //o
    .axi_s_0_aw_payload_len   (xbar_axi_s_0_aw_payload_len[7:0]  ), //o
    .axi_s_0_aw_payload_size  (xbar_axi_s_0_aw_payload_size[2:0] ), //o
    .axi_s_0_aw_payload_burst (xbar_axi_s_0_aw_payload_burst[1:0]), //o
    .axi_s_0_w_valid          (xbar_axi_s_0_w_valid              ), //o
    .axi_s_0_w_ready          (axi_m_w_ready                     ), //i
    .axi_s_0_w_payload_data   (xbar_axi_s_0_w_payload_data[31:0] ), //o
    .axi_s_0_w_payload_strb   (xbar_axi_s_0_w_payload_strb[3:0]  ), //o
    .axi_s_0_w_payload_last   (xbar_axi_s_0_w_payload_last       ), //o
    .axi_s_0_b_valid          (axi_m_b_valid                     ), //i
    .axi_s_0_b_ready          (xbar_axi_s_0_b_ready              ), //o
    .axi_s_0_b_payload_id     (axi_m_b_payload_id[3:0]           ), //i
    .axi_s_0_b_payload_resp   (axi_m_b_payload_resp[1:0]         ), //i
    .axi_s_0_ar_valid         (xbar_axi_s_0_ar_valid             ), //o
    .axi_s_0_ar_ready         (axi_m_ar_ready                    ), //i
    .axi_s_0_ar_payload_addr  (xbar_axi_s_0_ar_payload_addr[31:0]), //o
    .axi_s_0_ar_payload_id    (xbar_axi_s_0_ar_payload_id[3:0]   ), //o
    .axi_s_0_ar_payload_len   (xbar_axi_s_0_ar_payload_len[7:0]  ), //o
    .axi_s_0_ar_payload_size  (xbar_axi_s_0_ar_payload_size[2:0] ), //o
    .axi_s_0_ar_payload_burst (xbar_axi_s_0_ar_payload_burst[1:0]), //o
    .axi_s_0_r_valid          (axi_m_r_valid                     ), //i
    .axi_s_0_r_ready          (xbar_axi_s_0_r_ready              ), //o
    .axi_s_0_r_payload_data   (axi_m_r_payload_data[31:0]        ), //i
    .axi_s_0_r_payload_id     (axi_m_r_payload_id[3:0]           ), //i
    .axi_s_0_r_payload_resp   (axi_m_r_payload_resp[1:0]         ), //i
    .axi_s_0_r_payload_last   (axi_m_r_payload_last              ), //i
    .axi_s_1_aw_valid         (xbar_axi_s_1_aw_valid             ), //o
    .axi_s_1_aw_ready         (clint_axi_aw_ready                ), //i
    .axi_s_1_aw_payload_addr  (xbar_axi_s_1_aw_payload_addr[31:0]), //o
    .axi_s_1_aw_payload_id    (xbar_axi_s_1_aw_payload_id[3:0]   ), //o
    .axi_s_1_aw_payload_len   (xbar_axi_s_1_aw_payload_len[7:0]  ), //o
    .axi_s_1_aw_payload_size  (xbar_axi_s_1_aw_payload_size[2:0] ), //o
    .axi_s_1_aw_payload_burst (xbar_axi_s_1_aw_payload_burst[1:0]), //o
    .axi_s_1_w_valid          (xbar_axi_s_1_w_valid              ), //o
    .axi_s_1_w_ready          (clint_axi_w_ready                 ), //i
    .axi_s_1_w_payload_data   (xbar_axi_s_1_w_payload_data[31:0] ), //o
    .axi_s_1_w_payload_strb   (xbar_axi_s_1_w_payload_strb[3:0]  ), //o
    .axi_s_1_w_payload_last   (xbar_axi_s_1_w_payload_last       ), //o
    .axi_s_1_b_valid          (clint_axi_b_valid                 ), //i
    .axi_s_1_b_ready          (xbar_axi_s_1_b_ready              ), //o
    .axi_s_1_b_payload_id     (clint_axi_b_payload_id[3:0]       ), //i
    .axi_s_1_b_payload_resp   (clint_axi_b_payload_resp[1:0]     ), //i
    .axi_s_1_ar_valid         (xbar_axi_s_1_ar_valid             ), //o
    .axi_s_1_ar_ready         (clint_axi_ar_ready                ), //i
    .axi_s_1_ar_payload_addr  (xbar_axi_s_1_ar_payload_addr[31:0]), //o
    .axi_s_1_ar_payload_id    (xbar_axi_s_1_ar_payload_id[3:0]   ), //o
    .axi_s_1_ar_payload_len   (xbar_axi_s_1_ar_payload_len[7:0]  ), //o
    .axi_s_1_ar_payload_size  (xbar_axi_s_1_ar_payload_size[2:0] ), //o
    .axi_s_1_ar_payload_burst (xbar_axi_s_1_ar_payload_burst[1:0]), //o
    .axi_s_1_r_valid          (clint_axi_r_valid                 ), //i
    .axi_s_1_r_ready          (xbar_axi_s_1_r_ready              ), //o
    .axi_s_1_r_payload_data   (clint_axi_r_payload_data[31:0]    ), //i
    .axi_s_1_r_payload_id     (clint_axi_r_payload_id[3:0]       ), //i
    .axi_s_1_r_payload_resp   (clint_axi_r_payload_resp[1:0]     ), //i
    .axi_s_1_r_payload_last   (clint_axi_r_payload_last          ), //i
    .clock                    (clock                             ), //i
    .reset                    (reset                             )  //i
  );
  ysyx_26010010_AXIClint clint (
    .axi_aw_valid         (xbar_axi_s_1_aw_valid             ), //i
    .axi_aw_ready         (clint_axi_aw_ready                ), //o
    .axi_aw_payload_addr  (xbar_axi_s_1_aw_payload_addr[31:0]), //i
    .axi_aw_payload_id    (xbar_axi_s_1_aw_payload_id[3:0]   ), //i
    .axi_aw_payload_len   (xbar_axi_s_1_aw_payload_len[7:0]  ), //i
    .axi_aw_payload_size  (xbar_axi_s_1_aw_payload_size[2:0] ), //i
    .axi_aw_payload_burst (xbar_axi_s_1_aw_payload_burst[1:0]), //i
    .axi_w_valid          (xbar_axi_s_1_w_valid              ), //i
    .axi_w_ready          (clint_axi_w_ready                 ), //o
    .axi_w_payload_data   (xbar_axi_s_1_w_payload_data[31:0] ), //i
    .axi_w_payload_strb   (xbar_axi_s_1_w_payload_strb[3:0]  ), //i
    .axi_w_payload_last   (xbar_axi_s_1_w_payload_last       ), //i
    .axi_b_valid          (clint_axi_b_valid                 ), //o
    .axi_b_ready          (xbar_axi_s_1_b_ready              ), //i
    .axi_b_payload_id     (clint_axi_b_payload_id[3:0]       ), //o
    .axi_b_payload_resp   (clint_axi_b_payload_resp[1:0]     ), //o
    .axi_ar_valid         (xbar_axi_s_1_ar_valid             ), //i
    .axi_ar_ready         (clint_axi_ar_ready                ), //o
    .axi_ar_payload_addr  (xbar_axi_s_1_ar_payload_addr[31:0]), //i
    .axi_ar_payload_id    (xbar_axi_s_1_ar_payload_id[3:0]   ), //i
    .axi_ar_payload_len   (xbar_axi_s_1_ar_payload_len[7:0]  ), //i
    .axi_ar_payload_size  (xbar_axi_s_1_ar_payload_size[2:0] ), //i
    .axi_ar_payload_burst (xbar_axi_s_1_ar_payload_burst[1:0]), //i
    .axi_r_valid          (clint_axi_r_valid                 ), //o
    .axi_r_ready          (xbar_axi_s_1_r_ready              ), //i
    .axi_r_payload_data   (clint_axi_r_payload_data[31:0]    ), //o
    .axi_r_payload_id     (clint_axi_r_payload_id[3:0]       ), //o
    .axi_r_payload_resp   (clint_axi_r_payload_resp[1:0]     ), //o
    .axi_r_payload_last   (clint_axi_r_payload_last          ), //o
    .clock                (clock                             ), //i
    .reset                (reset                             )  //i
  );
  assign axi_m_aw_valid = xbar_axi_s_0_aw_valid;
  assign axi_m_aw_payload_addr = xbar_axi_s_0_aw_payload_addr;
  assign axi_m_aw_payload_id = xbar_axi_s_0_aw_payload_id;
  assign axi_m_aw_payload_len = xbar_axi_s_0_aw_payload_len;
  assign axi_m_aw_payload_size = xbar_axi_s_0_aw_payload_size;
  assign axi_m_aw_payload_burst = xbar_axi_s_0_aw_payload_burst;
  assign axi_m_w_valid = xbar_axi_s_0_w_valid;
  assign axi_m_w_payload_data = xbar_axi_s_0_w_payload_data;
  assign axi_m_w_payload_strb = xbar_axi_s_0_w_payload_strb;
  assign axi_m_w_payload_last = xbar_axi_s_0_w_payload_last;
  assign axi_m_b_ready = xbar_axi_s_0_b_ready;
  assign axi_m_ar_valid = xbar_axi_s_0_ar_valid;
  assign axi_m_ar_payload_addr = xbar_axi_s_0_ar_payload_addr;
  assign axi_m_ar_payload_id = xbar_axi_s_0_ar_payload_id;
  assign axi_m_ar_payload_len = xbar_axi_s_0_ar_payload_len;
  assign axi_m_ar_payload_size = xbar_axi_s_0_ar_payload_size;
  assign axi_m_ar_payload_burst = xbar_axi_s_0_ar_payload_burst;
  assign axi_m_r_ready = xbar_axi_s_0_r_ready;
  assign axi_s_ar_ready = 1'b0;
  assign axi_s_r_valid = 1'b0;
  assign axi_s_r_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign axi_s_r_payload_id = 4'bxxxx;
  assign axi_s_r_payload_resp = 2'bxx;
  assign axi_s_r_payload_last = 1'bx;
  assign axi_s_w_ready = 1'b0;
  assign axi_s_aw_ready = 1'b0;
  assign axi_s_b_valid = 1'b0;
  assign axi_s_b_payload_id = 4'bxxxx;
  assign axi_s_b_payload_resp = 2'bxx;

endmodule

module ysyx_26010010_AXITrun (
  output wire          io_master_awready,
  input  wire          io_master_awvalid,
  input  wire [31:0]   io_master_awaddr,
  input  wire [3:0]    io_master_awid,
  input  wire [7:0]    io_master_awlen,
  input  wire [2:0]    io_master_awsize,
  input  wire [1:0]    io_master_awburst,
  output wire          io_master_wready,
  input  wire          io_master_wvalid,
  input  wire [31:0]   io_master_wdata,
  input  wire [3:0]    io_master_wstrb,
  input  wire          io_master_wlast,
  input  wire          io_master_bready,
  output wire          io_master_bvalid,
  output wire [1:0]    io_master_bresp,
  output wire [3:0]    io_master_bid,
  output wire          io_master_arready,
  input  wire          io_master_arvalid,
  input  wire [31:0]   io_master_araddr,
  input  wire [3:0]    io_master_arid,
  input  wire [7:0]    io_master_arlen,
  input  wire [2:0]    io_master_arsize,
  input  wire [1:0]    io_master_arburst,
  input  wire          io_master_rready,
  output wire          io_master_rvalid,
  output wire [1:0]    io_master_rresp,
  output wire [31:0]   io_master_rdata,
  output wire          io_master_rlast,
  output wire [3:0]    io_master_rid,
  input  wire          io_slave_awready,
  output wire          io_slave_awvalid,
  output wire [31:0]   io_slave_awaddr,
  output wire [3:0]    io_slave_awid,
  output wire [7:0]    io_slave_awlen,
  output wire [2:0]    io_slave_awsize,
  output wire [1:0]    io_slave_awburst,
  input  wire          io_slave_wready,
  output wire          io_slave_wvalid,
  output wire [31:0]   io_slave_wdata,
  output wire [3:0]    io_slave_wstrb,
  output wire          io_slave_wlast,
  output wire          io_slave_bready,
  input  wire          io_slave_bvalid,
  input  wire [1:0]    io_slave_bresp,
  input  wire [3:0]    io_slave_bid,
  input  wire          io_slave_arready,
  output wire          io_slave_arvalid,
  output wire [31:0]   io_slave_araddr,
  output wire [3:0]    io_slave_arid,
  output wire [7:0]    io_slave_arlen,
  output wire [2:0]    io_slave_arsize,
  output wire [1:0]    io_slave_arburst,
  output wire          io_slave_rready,
  input  wire          io_slave_rvalid,
  input  wire [1:0]    io_slave_rresp,
  input  wire [31:0]   io_slave_rdata,
  input  wire          io_slave_rlast,
  input  wire [3:0]    io_slave_rid,
  output wire          axi_m_aw_valid,
  input  wire          axi_m_aw_ready,
  output wire [31:0]   axi_m_aw_payload_addr,
  output wire [3:0]    axi_m_aw_payload_id,
  output wire [7:0]    axi_m_aw_payload_len,
  output wire [2:0]    axi_m_aw_payload_size,
  output wire [1:0]    axi_m_aw_payload_burst,
  output wire          axi_m_w_valid,
  input  wire          axi_m_w_ready,
  output wire [31:0]   axi_m_w_payload_data,
  output wire [3:0]    axi_m_w_payload_strb,
  output wire          axi_m_w_payload_last,
  input  wire          axi_m_b_valid,
  output wire          axi_m_b_ready,
  input  wire [3:0]    axi_m_b_payload_id,
  input  wire [1:0]    axi_m_b_payload_resp,
  output wire          axi_m_ar_valid,
  input  wire          axi_m_ar_ready,
  output wire [31:0]   axi_m_ar_payload_addr,
  output wire [3:0]    axi_m_ar_payload_id,
  output wire [7:0]    axi_m_ar_payload_len,
  output wire [2:0]    axi_m_ar_payload_size,
  output wire [1:0]    axi_m_ar_payload_burst,
  input  wire          axi_m_r_valid,
  output wire          axi_m_r_ready,
  input  wire [31:0]   axi_m_r_payload_data,
  input  wire [3:0]    axi_m_r_payload_id,
  input  wire [1:0]    axi_m_r_payload_resp,
  input  wire          axi_m_r_payload_last,
  input  wire          axi_s_aw_valid,
  output wire          axi_s_aw_ready,
  input  wire [31:0]   axi_s_aw_payload_addr,
  input  wire [3:0]    axi_s_aw_payload_id,
  input  wire [7:0]    axi_s_aw_payload_len,
  input  wire [2:0]    axi_s_aw_payload_size,
  input  wire [1:0]    axi_s_aw_payload_burst,
  input  wire          axi_s_w_valid,
  output wire          axi_s_w_ready,
  input  wire [31:0]   axi_s_w_payload_data,
  input  wire [3:0]    axi_s_w_payload_strb,
  input  wire          axi_s_w_payload_last,
  output wire          axi_s_b_valid,
  input  wire          axi_s_b_ready,
  output wire [3:0]    axi_s_b_payload_id,
  output wire [1:0]    axi_s_b_payload_resp,
  input  wire          axi_s_ar_valid,
  output wire          axi_s_ar_ready,
  input  wire [31:0]   axi_s_ar_payload_addr,
  input  wire [3:0]    axi_s_ar_payload_id,
  input  wire [7:0]    axi_s_ar_payload_len,
  input  wire [2:0]    axi_s_ar_payload_size,
  input  wire [1:0]    axi_s_ar_payload_burst,
  output wire          axi_s_r_valid,
  input  wire          axi_s_r_ready,
  output wire [31:0]   axi_s_r_payload_data,
  output wire [3:0]    axi_s_r_payload_id,
  output wire [1:0]    axi_s_r_payload_resp,
  output wire          axi_s_r_payload_last
);


  assign io_master_awready = axi_m_aw_ready;
  assign axi_m_aw_valid = io_master_awvalid;
  assign axi_m_aw_payload_id = io_master_awid;
  assign axi_m_aw_payload_len = io_master_awlen;
  assign axi_m_aw_payload_size = io_master_awsize;
  assign axi_m_aw_payload_burst = io_master_awburst;
  assign axi_m_aw_payload_addr = io_master_awaddr;
  assign io_master_wready = axi_m_w_ready;
  assign axi_m_w_valid = io_master_wvalid;
  assign axi_m_w_payload_data = io_master_wdata;
  assign axi_m_w_payload_strb = io_master_wstrb;
  assign axi_m_w_payload_last = io_master_wlast;
  assign axi_m_b_ready = io_master_bready;
  assign io_master_bvalid = axi_m_b_valid;
  assign io_master_bresp = axi_m_b_payload_resp;
  assign io_master_bid = axi_m_b_payload_id;
  assign io_master_arready = axi_m_ar_ready;
  assign axi_m_ar_valid = io_master_arvalid;
  assign axi_m_ar_payload_addr = io_master_araddr;
  assign axi_m_ar_payload_id = io_master_arid;
  assign axi_m_ar_payload_len = io_master_arlen;
  assign axi_m_ar_payload_size = io_master_arsize;
  assign axi_m_ar_payload_burst = io_master_arburst;
  assign axi_m_r_ready = io_master_rready;
  assign io_master_rvalid = axi_m_r_valid;
  assign io_master_rresp = axi_m_r_payload_resp;
  assign io_master_rdata = axi_m_r_payload_data;
  assign io_master_rlast = axi_m_r_payload_last;
  assign io_master_rid = axi_m_r_payload_id;
  assign axi_s_aw_ready = io_slave_awready;
  assign io_slave_awvalid = axi_s_aw_valid;
  assign io_slave_awaddr = axi_s_aw_payload_addr;
  assign io_slave_awid = axi_s_aw_payload_id;
  assign io_slave_awlen = axi_s_aw_payload_len;
  assign io_slave_awsize = axi_s_aw_payload_size;
  assign io_slave_awburst = axi_s_aw_payload_burst;
  assign axi_s_w_ready = io_slave_wready;
  assign io_slave_wvalid = axi_s_w_valid;
  assign io_slave_wdata = axi_s_w_payload_data;
  assign io_slave_wstrb = axi_s_w_payload_strb;
  assign io_slave_wlast = axi_s_w_payload_last;
  assign io_slave_bready = axi_s_b_ready;
  assign axi_s_b_valid = io_slave_bvalid;
  assign axi_s_b_payload_resp = io_slave_bresp;
  assign axi_s_b_payload_id = io_slave_bid;
  assign axi_s_ar_ready = io_slave_arready;
  assign io_slave_arvalid = axi_s_ar_valid;
  assign io_slave_araddr = axi_s_ar_payload_addr;
  assign io_slave_arid = axi_s_ar_payload_id;
  assign io_slave_arlen = axi_s_ar_payload_len;
  assign io_slave_arsize = axi_s_ar_payload_size;
  assign io_slave_arburst = axi_s_ar_payload_burst;
  assign io_slave_rready = axi_s_r_ready;
  assign axi_s_r_valid = io_slave_rvalid;
  assign axi_s_r_payload_resp = io_slave_rresp;
  assign axi_s_r_payload_data = io_slave_rdata;
  assign axi_s_r_payload_last = io_slave_rlast;
  assign axi_s_r_payload_id = io_slave_rid;

endmodule

module ysyx_26010010_AXIClint (
  input  wire          axi_aw_valid,
  output wire          axi_aw_ready,
  input  wire [31:0]   axi_aw_payload_addr,
  input  wire [3:0]    axi_aw_payload_id,
  input  wire [7:0]    axi_aw_payload_len,
  input  wire [2:0]    axi_aw_payload_size,
  input  wire [1:0]    axi_aw_payload_burst,
  input  wire          axi_w_valid,
  output wire          axi_w_ready,
  input  wire [31:0]   axi_w_payload_data,
  input  wire [3:0]    axi_w_payload_strb,
  input  wire          axi_w_payload_last,
  output wire          axi_b_valid,
  input  wire          axi_b_ready,
  output wire [3:0]    axi_b_payload_id,
  output wire [1:0]    axi_b_payload_resp,
  input  wire          axi_ar_valid,
  output reg           axi_ar_ready,
  input  wire [31:0]   axi_ar_payload_addr,
  input  wire [3:0]    axi_ar_payload_id,
  input  wire [7:0]    axi_ar_payload_len,
  input  wire [2:0]    axi_ar_payload_size,
  input  wire [1:0]    axi_ar_payload_burst,
  output reg           axi_r_valid,
  input  wire          axi_r_ready,
  output reg  [31:0]   axi_r_payload_data,
  output wire [3:0]    axi_r_payload_id,
  output wire [1:0]    axi_r_payload_resp,
  output reg           axi_r_payload_last,
  input  wire          clock,
  input  wire          reset
);
  localparam ysyx_26010010_r_1_BOOT = 2'd0;
  localparam ysyx_26010010_r_1_start = 2'd1;
  localparam ysyx_26010010_r_1_r = 2'd2;

  reg        [63:0]   mtime;
  reg                 flag;
  wire                r_wantExit;
  reg                 r_wantStart;
  wire                r_wantKill;
  reg        [1:0]    r_stateReg;
  reg        [1:0]    r_stateNext;
  wire                axi_ar_fire;
  wire                when_pipCPUTOP_l138;
  wire                axi_r_fire;
  wire                r_onExit_BOOT;
  wire                r_onExit_start;
  wire                r_onExit_r;
  wire                r_onEntry_BOOT;
  wire                r_onEntry_start;
  wire                r_onEntry_r;
  `ifndef SYNTHESIS
  reg [39:0] r_stateReg_string;
  reg [39:0] r_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(r_stateReg)
      ysyx_26010010_r_1_BOOT : r_stateReg_string = "BOOT ";
      ysyx_26010010_r_1_start : r_stateReg_string = "start";
      ysyx_26010010_r_1_r : r_stateReg_string = "r    ";
      default : r_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(r_stateNext)
      ysyx_26010010_r_1_BOOT : r_stateNext_string = "BOOT ";
      ysyx_26010010_r_1_start : r_stateNext_string = "start";
      ysyx_26010010_r_1_r : r_stateNext_string = "r    ";
      default : r_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    axi_r_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(flag) begin
      axi_r_payload_data = mtime[63 : 32];
    end else begin
      axi_r_payload_data = mtime[31 : 0];
    end
  end

  assign axi_r_payload_id = 4'bxxxx;
  assign axi_r_payload_resp = 2'bxx;
  always @(*) begin
    axi_r_payload_last = 1'bx;
    axi_r_payload_last = axi_r_valid;
  end

  assign axi_w_ready = 1'b0;
  assign axi_aw_ready = 1'b0;
  assign axi_b_valid = 1'b0;
  assign axi_b_payload_id = 4'bxxxx;
  assign axi_b_payload_resp = 2'bxx;
  assign r_wantExit = 1'b0;
  always @(*) begin
    r_wantStart = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_1_start : begin
      end
      ysyx_26010010_r_1_r : begin
      end
      default : begin
        r_wantStart = 1'b1;
      end
    endcase
  end

  assign r_wantKill = 1'b0;
  always @(*) begin
    r_stateNext = r_stateReg;
    case(r_stateReg)
      ysyx_26010010_r_1_start : begin
        if(axi_ar_fire) begin
          r_stateNext = ysyx_26010010_r_1_r;
        end
      end
      ysyx_26010010_r_1_r : begin
        if(axi_r_fire) begin
          r_stateNext = ysyx_26010010_r_1_start;
        end
      end
      default : begin
      end
    endcase
    if(r_wantStart) begin
      r_stateNext = ysyx_26010010_r_1_start;
    end
    if(r_wantKill) begin
      r_stateNext = ysyx_26010010_r_1_BOOT;
    end
  end

  assign axi_ar_fire = (axi_ar_valid && axi_ar_ready);
  assign when_pipCPUTOP_l138 = (axi_ar_payload_addr == 32'h20000000);
  assign axi_r_fire = (axi_r_valid && axi_r_ready);
  assign r_onExit_BOOT = ((r_stateNext != ysyx_26010010_r_1_BOOT) && (r_stateReg == ysyx_26010010_r_1_BOOT));
  assign r_onExit_start = ((r_stateNext != ysyx_26010010_r_1_start) && (r_stateReg == ysyx_26010010_r_1_start));
  assign r_onExit_r = ((r_stateNext != ysyx_26010010_r_1_r) && (r_stateReg == ysyx_26010010_r_1_r));
  assign r_onEntry_BOOT = ((r_stateNext == ysyx_26010010_r_1_BOOT) && (r_stateReg != ysyx_26010010_r_1_BOOT));
  assign r_onEntry_start = ((r_stateNext == ysyx_26010010_r_1_start) && (r_stateReg != ysyx_26010010_r_1_start));
  assign r_onEntry_r = ((r_stateNext == ysyx_26010010_r_1_r) && (r_stateReg != ysyx_26010010_r_1_r));
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      mtime <= 64'h0;
      flag <= 1'b0;
      axi_ar_ready <= 1'b1;
      axi_r_valid <= 1'b0;
      r_stateReg <= ysyx_26010010_r_1_BOOT;
    end else begin
      mtime <= (mtime + 64'h0000000000000001);
      axi_r_valid <= 1'b0;
      r_stateReg <= r_stateNext;
      case(r_stateReg)
        ysyx_26010010_r_1_start : begin
          axi_ar_ready <= 1'b1;
          if(axi_ar_fire) begin
            axi_ar_ready <= 1'b0;
            if(when_pipCPUTOP_l138) begin
              flag <= 1'b1;
            end else begin
              flag <= 1'b0;
            end
          end
        end
        ysyx_26010010_r_1_r : begin
          axi_r_valid <= 1'b1;
          if(axi_r_fire) begin
            axi_r_valid <= 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module ysyx_26010010_AXIXbar_new (
  input  wire          axi_m_0_aw_valid,
  output reg           axi_m_0_aw_ready,
  input  wire [31:0]   axi_m_0_aw_payload_addr,
  input  wire [3:0]    axi_m_0_aw_payload_id,
  input  wire [7:0]    axi_m_0_aw_payload_len,
  input  wire [2:0]    axi_m_0_aw_payload_size,
  input  wire [1:0]    axi_m_0_aw_payload_burst,
  input  wire          axi_m_0_w_valid,
  output reg           axi_m_0_w_ready,
  input  wire [31:0]   axi_m_0_w_payload_data,
  input  wire [3:0]    axi_m_0_w_payload_strb,
  input  wire          axi_m_0_w_payload_last,
  output reg           axi_m_0_b_valid,
  input  wire          axi_m_0_b_ready,
  output reg  [3:0]    axi_m_0_b_payload_id,
  output reg  [1:0]    axi_m_0_b_payload_resp,
  input  wire          axi_m_0_ar_valid,
  output reg           axi_m_0_ar_ready,
  input  wire [31:0]   axi_m_0_ar_payload_addr,
  input  wire [3:0]    axi_m_0_ar_payload_id,
  input  wire [7:0]    axi_m_0_ar_payload_len,
  input  wire [2:0]    axi_m_0_ar_payload_size,
  input  wire [1:0]    axi_m_0_ar_payload_burst,
  output reg           axi_m_0_r_valid,
  input  wire          axi_m_0_r_ready,
  output reg  [31:0]   axi_m_0_r_payload_data,
  output reg  [3:0]    axi_m_0_r_payload_id,
  output reg  [1:0]    axi_m_0_r_payload_resp,
  output reg           axi_m_0_r_payload_last,
  input  wire          axi_m_1_aw_valid,
  output reg           axi_m_1_aw_ready,
  input  wire [31:0]   axi_m_1_aw_payload_addr,
  input  wire [3:0]    axi_m_1_aw_payload_id,
  input  wire [7:0]    axi_m_1_aw_payload_len,
  input  wire [2:0]    axi_m_1_aw_payload_size,
  input  wire [1:0]    axi_m_1_aw_payload_burst,
  input  wire          axi_m_1_w_valid,
  output reg           axi_m_1_w_ready,
  input  wire [31:0]   axi_m_1_w_payload_data,
  input  wire [3:0]    axi_m_1_w_payload_strb,
  input  wire          axi_m_1_w_payload_last,
  output reg           axi_m_1_b_valid,
  input  wire          axi_m_1_b_ready,
  output reg  [3:0]    axi_m_1_b_payload_id,
  output reg  [1:0]    axi_m_1_b_payload_resp,
  input  wire          axi_m_1_ar_valid,
  output reg           axi_m_1_ar_ready,
  input  wire [31:0]   axi_m_1_ar_payload_addr,
  input  wire [3:0]    axi_m_1_ar_payload_id,
  input  wire [7:0]    axi_m_1_ar_payload_len,
  input  wire [2:0]    axi_m_1_ar_payload_size,
  input  wire [1:0]    axi_m_1_ar_payload_burst,
  output reg           axi_m_1_r_valid,
  input  wire          axi_m_1_r_ready,
  output reg  [31:0]   axi_m_1_r_payload_data,
  output reg  [3:0]    axi_m_1_r_payload_id,
  output reg  [1:0]    axi_m_1_r_payload_resp,
  output reg           axi_m_1_r_payload_last,
  output reg           axi_s_0_aw_valid,
  input  wire          axi_s_0_aw_ready,
  output reg  [31:0]   axi_s_0_aw_payload_addr,
  output reg  [3:0]    axi_s_0_aw_payload_id,
  output reg  [7:0]    axi_s_0_aw_payload_len,
  output reg  [2:0]    axi_s_0_aw_payload_size,
  output reg  [1:0]    axi_s_0_aw_payload_burst,
  output reg           axi_s_0_w_valid,
  input  wire          axi_s_0_w_ready,
  output reg  [31:0]   axi_s_0_w_payload_data,
  output reg  [3:0]    axi_s_0_w_payload_strb,
  output reg           axi_s_0_w_payload_last,
  input  wire          axi_s_0_b_valid,
  output reg           axi_s_0_b_ready,
  input  wire [3:0]    axi_s_0_b_payload_id,
  input  wire [1:0]    axi_s_0_b_payload_resp,
  output reg           axi_s_0_ar_valid,
  input  wire          axi_s_0_ar_ready,
  output reg  [31:0]   axi_s_0_ar_payload_addr,
  output reg  [3:0]    axi_s_0_ar_payload_id,
  output reg  [7:0]    axi_s_0_ar_payload_len,
  output reg  [2:0]    axi_s_0_ar_payload_size,
  output reg  [1:0]    axi_s_0_ar_payload_burst,
  input  wire          axi_s_0_r_valid,
  output reg           axi_s_0_r_ready,
  input  wire [31:0]   axi_s_0_r_payload_data,
  input  wire [3:0]    axi_s_0_r_payload_id,
  input  wire [1:0]    axi_s_0_r_payload_resp,
  input  wire          axi_s_0_r_payload_last,
  output wire          axi_s_1_aw_valid,
  input  wire          axi_s_1_aw_ready,
  output wire [31:0]   axi_s_1_aw_payload_addr,
  output wire [3:0]    axi_s_1_aw_payload_id,
  output wire [7:0]    axi_s_1_aw_payload_len,
  output wire [2:0]    axi_s_1_aw_payload_size,
  output wire [1:0]    axi_s_1_aw_payload_burst,
  output wire          axi_s_1_w_valid,
  input  wire          axi_s_1_w_ready,
  output wire [31:0]   axi_s_1_w_payload_data,
  output wire [3:0]    axi_s_1_w_payload_strb,
  output wire          axi_s_1_w_payload_last,
  input  wire          axi_s_1_b_valid,
  output wire          axi_s_1_b_ready,
  input  wire [3:0]    axi_s_1_b_payload_id,
  input  wire [1:0]    axi_s_1_b_payload_resp,
  output reg           axi_s_1_ar_valid,
  input  wire          axi_s_1_ar_ready,
  output reg  [31:0]   axi_s_1_ar_payload_addr,
  output reg  [3:0]    axi_s_1_ar_payload_id,
  output reg  [7:0]    axi_s_1_ar_payload_len,
  output reg  [2:0]    axi_s_1_ar_payload_size,
  output reg  [1:0]    axi_s_1_ar_payload_burst,
  input  wire          axi_s_1_r_valid,
  output reg           axi_s_1_r_ready,
  input  wire [31:0]   axi_s_1_r_payload_data,
  input  wire [3:0]    axi_s_1_r_payload_id,
  input  wire [1:0]    axi_s_1_r_payload_resp,
  input  wire          axi_s_1_r_payload_last,
  input  wire          clock,
  input  wire          reset
);
  localparam ysyx_26010010_r_BOOT = 2'd0;
  localparam ysyx_26010010_r_start = 2'd1;
  localparam ysyx_26010010_r_turn = 2'd2;
  localparam ysyx_26010010_w_BOOT = 2'd0;
  localparam ysyx_26010010_w_start = 2'd1;
  localparam ysyx_26010010_w_turn = 2'd2;

  reg                 _zz__zz_axi_s_0_ar_valid;
  reg        [31:0]   _zz__zz_axi_s_0_ar_payload_addr;
  reg        [3:0]    _zz__zz_axi_s_0_ar_payload_id;
  reg        [7:0]    _zz__zz_axi_s_0_ar_payload_len;
  reg        [2:0]    _zz__zz_axi_s_0_ar_payload_size;
  reg        [1:0]    _zz__zz_axi_s_0_ar_payload_burst;
  reg                 _zz__zz_axi_s_0_r_ready;
  reg                 _zz_when_pipCPUTOP_l65;
  reg                 _zz_when_pipCPUTOP_l65_1;
  reg                 _zz__zz_axi_s_0_b_ready;
  reg                 _zz_axi_s_0_aw_valid;
  reg        [31:0]   _zz_axi_s_0_aw_payload_addr;
  reg        [3:0]    _zz_axi_s_0_aw_payload_id;
  reg        [7:0]    _zz_axi_s_0_aw_payload_len;
  reg        [2:0]    _zz_axi_s_0_aw_payload_size;
  reg        [1:0]    _zz_axi_s_0_aw_payload_burst;
  reg                 _zz_axi_s_0_w_valid;
  reg        [31:0]   _zz_axi_s_0_w_payload_data;
  reg        [3:0]    _zz_axi_s_0_w_payload_strb;
  reg                 _zz_axi_s_0_w_payload_last;
  reg                 _zz_when;
  wire                r_wantExit;
  reg                 r_wantStart;
  wire                r_wantKill;
  reg        [0:0]    r_sel_m;
  reg        [0:0]    r_sel_s;
  wire                w_wantExit;
  reg                 w_wantStart;
  wire                w_wantKill;
  reg        [0:0]    w_sel;
  reg        [1:0]    r_stateReg;
  reg        [1:0]    r_stateNext;
  wire                when_pipCPUTOP_l46;
  wire                when_pipCPUTOP_l58;
  wire                _zz_axi_s_0_ar_valid;
  wire       [31:0]   _zz_axi_s_0_ar_payload_addr;
  wire       [3:0]    _zz_axi_s_0_ar_payload_id;
  wire       [7:0]    _zz_axi_s_0_ar_payload_len;
  wire       [2:0]    _zz_axi_s_0_ar_payload_size;
  wire       [1:0]    _zz_axi_s_0_ar_payload_burst;
  wire                _zz_axi_s_0_r_ready;
  wire       [1:0]    _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                when_pipCPUTOP_l65;
  wire                r_onExit_BOOT;
  wire                r_onExit_start;
  wire                r_onExit_turn;
  wire                r_onEntry_BOOT;
  wire                r_onEntry_start;
  wire                r_onEntry_turn;
  reg        [1:0]    w_stateReg;
  reg        [1:0]    w_stateNext;
  wire                _zz_axi_s_0_b_ready;
  wire       [1:0]    _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                w_onExit_BOOT;
  wire                w_onExit_start;
  wire                w_onExit_turn;
  wire                w_onEntry_BOOT;
  wire                w_onEntry_start;
  wire                w_onEntry_turn;
  `ifndef SYNTHESIS
  reg [39:0] r_stateReg_string;
  reg [39:0] r_stateNext_string;
  reg [39:0] w_stateReg_string;
  reg [39:0] w_stateNext_string;
  `endif


  always @(*) begin
    case(r_sel_m)
      1'b0 : begin
        _zz__zz_axi_s_0_ar_valid = axi_m_0_ar_valid;
        _zz__zz_axi_s_0_ar_payload_addr = axi_m_0_ar_payload_addr;
        _zz__zz_axi_s_0_ar_payload_id = axi_m_0_ar_payload_id;
        _zz__zz_axi_s_0_ar_payload_len = axi_m_0_ar_payload_len;
        _zz__zz_axi_s_0_ar_payload_size = axi_m_0_ar_payload_size;
        _zz__zz_axi_s_0_ar_payload_burst = axi_m_0_ar_payload_burst;
        _zz__zz_axi_s_0_r_ready = axi_m_0_r_ready;
        _zz_when_pipCPUTOP_l65 = axi_m_0_r_valid;
        _zz_when_pipCPUTOP_l65_1 = axi_m_0_r_payload_last;
      end
      default : begin
        _zz__zz_axi_s_0_ar_valid = axi_m_1_ar_valid;
        _zz__zz_axi_s_0_ar_payload_addr = axi_m_1_ar_payload_addr;
        _zz__zz_axi_s_0_ar_payload_id = axi_m_1_ar_payload_id;
        _zz__zz_axi_s_0_ar_payload_len = axi_m_1_ar_payload_len;
        _zz__zz_axi_s_0_ar_payload_size = axi_m_1_ar_payload_size;
        _zz__zz_axi_s_0_ar_payload_burst = axi_m_1_ar_payload_burst;
        _zz__zz_axi_s_0_r_ready = axi_m_1_r_ready;
        _zz_when_pipCPUTOP_l65 = axi_m_1_r_valid;
        _zz_when_pipCPUTOP_l65_1 = axi_m_1_r_payload_last;
      end
    endcase
  end

  always @(*) begin
    case(w_sel)
      1'b0 : begin
        _zz__zz_axi_s_0_b_ready = axi_m_0_b_ready;
        _zz_axi_s_0_aw_valid = axi_m_0_aw_valid;
        _zz_axi_s_0_aw_payload_addr = axi_m_0_aw_payload_addr;
        _zz_axi_s_0_aw_payload_id = axi_m_0_aw_payload_id;
        _zz_axi_s_0_aw_payload_len = axi_m_0_aw_payload_len;
        _zz_axi_s_0_aw_payload_size = axi_m_0_aw_payload_size;
        _zz_axi_s_0_aw_payload_burst = axi_m_0_aw_payload_burst;
        _zz_axi_s_0_w_valid = axi_m_0_w_valid;
        _zz_axi_s_0_w_payload_data = axi_m_0_w_payload_data;
        _zz_axi_s_0_w_payload_strb = axi_m_0_w_payload_strb;
        _zz_axi_s_0_w_payload_last = axi_m_0_w_payload_last;
        _zz_when = axi_m_0_b_valid;
      end
      default : begin
        _zz__zz_axi_s_0_b_ready = axi_m_1_b_ready;
        _zz_axi_s_0_aw_valid = axi_m_1_aw_valid;
        _zz_axi_s_0_aw_payload_addr = axi_m_1_aw_payload_addr;
        _zz_axi_s_0_aw_payload_id = axi_m_1_aw_payload_id;
        _zz_axi_s_0_aw_payload_len = axi_m_1_aw_payload_len;
        _zz_axi_s_0_aw_payload_size = axi_m_1_aw_payload_size;
        _zz_axi_s_0_aw_payload_burst = axi_m_1_aw_payload_burst;
        _zz_axi_s_0_w_valid = axi_m_1_w_valid;
        _zz_axi_s_0_w_payload_data = axi_m_1_w_payload_data;
        _zz_axi_s_0_w_payload_strb = axi_m_1_w_payload_strb;
        _zz_axi_s_0_w_payload_last = axi_m_1_w_payload_last;
        _zz_when = axi_m_1_b_valid;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(r_stateReg)
      ysyx_26010010_r_BOOT : r_stateReg_string = "BOOT ";
      ysyx_26010010_r_start : r_stateReg_string = "start";
      ysyx_26010010_r_turn : r_stateReg_string = "turn ";
      default : r_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(r_stateNext)
      ysyx_26010010_r_BOOT : r_stateNext_string = "BOOT ";
      ysyx_26010010_r_start : r_stateNext_string = "start";
      ysyx_26010010_r_turn : r_stateNext_string = "turn ";
      default : r_stateNext_string = "?????";
    endcase
  end
  always @(*) begin
    case(w_stateReg)
      ysyx_26010010_w_BOOT : w_stateReg_string = "BOOT ";
      ysyx_26010010_w_start : w_stateReg_string = "start";
      ysyx_26010010_w_turn : w_stateReg_string = "turn ";
      default : w_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(w_stateNext)
      ysyx_26010010_w_BOOT : w_stateNext_string = "BOOT ";
      ysyx_26010010_w_start : w_stateNext_string = "start";
      ysyx_26010010_w_turn : w_stateNext_string = "turn ";
      default : w_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    axi_m_0_r_valid = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_r_valid = axi_s_1_r_valid;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_r_valid = axi_s_0_r_valid;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_r_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_r_payload_data = axi_s_1_r_payload_data;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_r_payload_data = axi_s_0_r_payload_data;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_r_payload_id = 4'bxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_r_payload_id = axi_s_1_r_payload_id;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_r_payload_id = axi_s_0_r_payload_id;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_r_payload_resp = 2'bxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_r_payload_resp = axi_s_1_r_payload_resp;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_r_payload_resp = axi_s_0_r_payload_resp;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_r_payload_last = 1'bx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_r_payload_last = axi_s_1_r_payload_last;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_r_payload_last = axi_s_0_r_payload_last;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_ar_ready = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_2) begin
            axi_m_0_ar_ready = axi_s_1_ar_ready;
          end
        end else begin
          if(_zz_2) begin
            axi_m_0_ar_ready = axi_s_0_ar_ready;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_w_ready = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_5) begin
          axi_m_0_w_ready = axi_s_0_w_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_aw_ready = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_5) begin
          axi_m_0_aw_ready = axi_s_0_aw_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_b_valid = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_5) begin
          axi_m_0_b_valid = axi_s_0_b_valid;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_b_payload_id = 4'bxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_5) begin
          axi_m_0_b_payload_id = axi_s_0_b_payload_id;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_0_b_payload_resp = 2'bxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_5) begin
          axi_m_0_b_payload_resp = axi_s_0_b_payload_resp;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_r_ready = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_r_ready = _zz_axi_s_0_r_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_valid = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_valid = _zz_axi_s_0_ar_valid;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_payload_addr = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_payload_addr = _zz_axi_s_0_ar_payload_addr;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_payload_id = 4'bxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_payload_id = _zz_axi_s_0_ar_payload_id;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_payload_len = 8'bxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_payload_len = _zz_axi_s_0_ar_payload_len;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_payload_size = 3'bxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_payload_size = _zz_axi_s_0_ar_payload_size;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_ar_payload_burst = 2'bxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(!when_pipCPUTOP_l58) begin
          axi_s_0_ar_payload_burst = _zz_axi_s_0_ar_payload_burst;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_w_valid = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_w_valid = _zz_axi_s_0_w_valid;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_w_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_w_payload_data = _zz_axi_s_0_w_payload_data;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_w_payload_strb = 4'bxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_w_payload_strb = _zz_axi_s_0_w_payload_strb;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_w_payload_last = 1'bx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_w_payload_last = _zz_axi_s_0_w_payload_last;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_valid = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_valid = _zz_axi_s_0_aw_valid;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_payload_addr = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_payload_addr = _zz_axi_s_0_aw_payload_addr;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_payload_id = 4'bxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_payload_id = _zz_axi_s_0_aw_payload_id;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_payload_len = 8'bxxxxxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_payload_len = _zz_axi_s_0_aw_payload_len;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_payload_size = 3'bxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_payload_size = _zz_axi_s_0_aw_payload_size;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_aw_payload_burst = 2'bxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_aw_payload_burst = _zz_axi_s_0_aw_payload_burst;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_0_b_ready = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        axi_s_0_b_ready = _zz_axi_s_0_b_ready;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_r_valid = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_r_valid = axi_s_1_r_valid;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_r_valid = axi_s_0_r_valid;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_r_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_r_payload_data = axi_s_1_r_payload_data;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_r_payload_data = axi_s_0_r_payload_data;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_r_payload_id = 4'bxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_r_payload_id = axi_s_1_r_payload_id;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_r_payload_id = axi_s_0_r_payload_id;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_r_payload_resp = 2'bxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_r_payload_resp = axi_s_1_r_payload_resp;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_r_payload_resp = axi_s_0_r_payload_resp;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_r_payload_last = 1'bx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_r_payload_last = axi_s_1_r_payload_last;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_r_payload_last = axi_s_0_r_payload_last;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_ar_ready = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          if(_zz_3) begin
            axi_m_1_ar_ready = axi_s_1_ar_ready;
          end
        end else begin
          if(_zz_3) begin
            axi_m_1_ar_ready = axi_s_0_ar_ready;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_w_ready = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_6) begin
          axi_m_1_w_ready = axi_s_0_w_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_aw_ready = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_6) begin
          axi_m_1_aw_ready = axi_s_0_aw_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_b_valid = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_6) begin
          axi_m_1_b_valid = axi_s_0_b_valid;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_b_payload_id = 4'bxxxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_6) begin
          axi_m_1_b_payload_id = axi_s_0_b_payload_id;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_m_1_b_payload_resp = 2'bxx;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
        if(_zz_6) begin
          axi_m_1_b_payload_resp = axi_s_0_b_payload_resp;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_r_ready = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_r_ready = _zz_axi_s_0_r_ready;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_valid = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_valid = _zz_axi_s_0_ar_valid;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_payload_addr = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_payload_addr = _zz_axi_s_0_ar_payload_addr;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_payload_id = 4'bxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_payload_id = _zz_axi_s_0_ar_payload_id;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_payload_len = 8'bxxxxxxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_payload_len = _zz_axi_s_0_ar_payload_len;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_payload_size = 3'bxxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_payload_size = _zz_axi_s_0_ar_payload_size;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_s_1_ar_payload_burst = 2'bxx;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l58) begin
          axi_s_1_ar_payload_burst = _zz_axi_s_0_ar_payload_burst;
        end
      end
      default : begin
      end
    endcase
  end

  assign axi_s_1_w_valid = 1'b0;
  assign axi_s_1_w_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign axi_s_1_w_payload_strb = 4'bxxxx;
  assign axi_s_1_w_payload_last = 1'bx;
  assign axi_s_1_aw_valid = 1'b0;
  assign axi_s_1_aw_payload_addr = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign axi_s_1_aw_payload_id = 4'bxxxx;
  assign axi_s_1_aw_payload_len = 8'bxxxxxxxx;
  assign axi_s_1_aw_payload_size = 3'bxxx;
  assign axi_s_1_aw_payload_burst = 2'bxx;
  assign axi_s_1_b_ready = 1'b0;
  assign r_wantExit = 1'b0;
  always @(*) begin
    r_wantStart = 1'b0;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
      end
      ysyx_26010010_r_turn : begin
      end
      default : begin
        r_wantStart = 1'b1;
      end
    endcase
  end

  assign r_wantKill = 1'b0;
  assign w_wantExit = 1'b0;
  always @(*) begin
    w_wantStart = 1'b0;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
      end
      ysyx_26010010_w_turn : begin
      end
      default : begin
        w_wantStart = 1'b1;
      end
    endcase
  end

  assign w_wantKill = 1'b0;
  always @(*) begin
    r_stateNext = r_stateReg;
    case(r_stateReg)
      ysyx_26010010_r_start : begin
        if(axi_m_1_ar_valid) begin
          r_stateNext = ysyx_26010010_r_turn;
        end else begin
          if(axi_m_0_ar_valid) begin
            r_stateNext = ysyx_26010010_r_turn;
          end
        end
      end
      ysyx_26010010_r_turn : begin
        if(when_pipCPUTOP_l65) begin
          r_stateNext = ysyx_26010010_r_start;
        end
      end
      default : begin
      end
    endcase
    if(r_wantStart) begin
      r_stateNext = ysyx_26010010_r_start;
    end
    if(r_wantKill) begin
      r_stateNext = ysyx_26010010_r_BOOT;
    end
  end

  assign when_pipCPUTOP_l46 = ((32'h02000000 <= axi_m_1_ar_payload_addr) && (axi_m_1_ar_payload_addr <= 32'h0200ffff));
  assign when_pipCPUTOP_l58 = (r_sel_s == 1'b1);
  assign _zz_axi_s_0_ar_valid = _zz__zz_axi_s_0_ar_valid;
  assign _zz_axi_s_0_ar_payload_addr = _zz__zz_axi_s_0_ar_payload_addr;
  assign _zz_axi_s_0_ar_payload_id = _zz__zz_axi_s_0_ar_payload_id;
  assign _zz_axi_s_0_ar_payload_len = _zz__zz_axi_s_0_ar_payload_len;
  assign _zz_axi_s_0_ar_payload_size = _zz__zz_axi_s_0_ar_payload_size;
  assign _zz_axi_s_0_ar_payload_burst = _zz__zz_axi_s_0_ar_payload_burst;
  assign _zz_axi_s_0_r_ready = _zz__zz_axi_s_0_r_ready;
  assign _zz_1 = ({1'd0,1'b1} <<< r_sel_m);
  assign _zz_2 = _zz_1[0];
  assign _zz_3 = _zz_1[1];
  assign when_pipCPUTOP_l65 = ((_zz_when_pipCPUTOP_l65 && _zz_axi_s_0_r_ready) && _zz_when_pipCPUTOP_l65_1);
  assign r_onExit_BOOT = ((r_stateNext != ysyx_26010010_r_BOOT) && (r_stateReg == ysyx_26010010_r_BOOT));
  assign r_onExit_start = ((r_stateNext != ysyx_26010010_r_start) && (r_stateReg == ysyx_26010010_r_start));
  assign r_onExit_turn = ((r_stateNext != ysyx_26010010_r_turn) && (r_stateReg == ysyx_26010010_r_turn));
  assign r_onEntry_BOOT = ((r_stateNext == ysyx_26010010_r_BOOT) && (r_stateReg != ysyx_26010010_r_BOOT));
  assign r_onEntry_start = ((r_stateNext == ysyx_26010010_r_start) && (r_stateReg != ysyx_26010010_r_start));
  assign r_onEntry_turn = ((r_stateNext == ysyx_26010010_r_turn) && (r_stateReg != ysyx_26010010_r_turn));
  always @(*) begin
    w_stateNext = w_stateReg;
    case(w_stateReg)
      ysyx_26010010_w_start : begin
        if(axi_m_1_aw_valid) begin
          w_stateNext = ysyx_26010010_w_turn;
        end
      end
      ysyx_26010010_w_turn : begin
        if((_zz_when && _zz_axi_s_0_b_ready)) begin
          w_stateNext = ysyx_26010010_w_start;
        end
      end
      default : begin
      end
    endcase
    if(w_wantStart) begin
      w_stateNext = ysyx_26010010_w_start;
    end
    if(w_wantKill) begin
      w_stateNext = ysyx_26010010_w_BOOT;
    end
  end

  assign _zz_axi_s_0_b_ready = _zz__zz_axi_s_0_b_ready;
  assign _zz_4 = ({1'd0,1'b1} <<< w_sel);
  assign _zz_5 = _zz_4[0];
  assign _zz_6 = _zz_4[1];
  assign w_onExit_BOOT = ((w_stateNext != ysyx_26010010_w_BOOT) && (w_stateReg == ysyx_26010010_w_BOOT));
  assign w_onExit_start = ((w_stateNext != ysyx_26010010_w_start) && (w_stateReg == ysyx_26010010_w_start));
  assign w_onExit_turn = ((w_stateNext != ysyx_26010010_w_turn) && (w_stateReg == ysyx_26010010_w_turn));
  assign w_onEntry_BOOT = ((w_stateNext == ysyx_26010010_w_BOOT) && (w_stateReg != ysyx_26010010_w_BOOT));
  assign w_onEntry_start = ((w_stateNext == ysyx_26010010_w_start) && (w_stateReg != ysyx_26010010_w_start));
  assign w_onEntry_turn = ((w_stateNext == ysyx_26010010_w_turn) && (w_stateReg != ysyx_26010010_w_turn));
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      r_sel_m <= 1'b0;
      r_sel_s <= 1'b0;
      w_sel <= 1'b0;
      r_stateReg <= ysyx_26010010_r_BOOT;
      w_stateReg <= ysyx_26010010_w_BOOT;
    end else begin
      r_stateReg <= r_stateNext;
      case(r_stateReg)
        ysyx_26010010_r_start : begin
          if(axi_m_1_ar_valid) begin
            r_sel_m <= 1'b1;
            if(when_pipCPUTOP_l46) begin
              r_sel_s <= 1'b1;
            end else begin
              r_sel_s <= 1'b0;
            end
          end else begin
            if(axi_m_0_ar_valid) begin
              r_sel_m <= 1'b0;
              r_sel_s <= 1'b0;
            end
          end
        end
        ysyx_26010010_r_turn : begin
        end
        default : begin
        end
      endcase
      w_stateReg <= w_stateNext;
      case(w_stateReg)
        ysyx_26010010_w_start : begin
          if(axi_m_1_aw_valid) begin
            w_sel <= 1'b1;
          end
        end
        ysyx_26010010_w_turn : begin
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module ysyx_26010010_test_cpu (
  output wire          axi_if_aw_valid,
  input  wire          axi_if_aw_ready,
  output wire [31:0]   axi_if_aw_payload_addr,
  output wire [3:0]    axi_if_aw_payload_id,
  output wire [7:0]    axi_if_aw_payload_len,
  output wire [2:0]    axi_if_aw_payload_size,
  output wire [1:0]    axi_if_aw_payload_burst,
  output wire          axi_if_w_valid,
  input  wire          axi_if_w_ready,
  output wire [31:0]   axi_if_w_payload_data,
  output wire [3:0]    axi_if_w_payload_strb,
  output wire          axi_if_w_payload_last,
  input  wire          axi_if_b_valid,
  output wire          axi_if_b_ready,
  input  wire [3:0]    axi_if_b_payload_id,
  input  wire [1:0]    axi_if_b_payload_resp,
  output wire          axi_if_ar_valid,
  input  wire          axi_if_ar_ready,
  output wire [31:0]   axi_if_ar_payload_addr,
  output wire [3:0]    axi_if_ar_payload_id,
  output wire [7:0]    axi_if_ar_payload_len,
  output wire [2:0]    axi_if_ar_payload_size,
  output wire [1:0]    axi_if_ar_payload_burst,
  input  wire          axi_if_r_valid,
  output wire          axi_if_r_ready,
  input  wire [31:0]   axi_if_r_payload_data,
  input  wire [3:0]    axi_if_r_payload_id,
  input  wire [1:0]    axi_if_r_payload_resp,
  input  wire          axi_if_r_payload_last,
  output wire          axi_mem_aw_valid,
  input  wire          axi_mem_aw_ready,
  output wire [31:0]   axi_mem_aw_payload_addr,
  output wire [3:0]    axi_mem_aw_payload_id,
  output wire [7:0]    axi_mem_aw_payload_len,
  output wire [2:0]    axi_mem_aw_payload_size,
  output wire [1:0]    axi_mem_aw_payload_burst,
  output wire          axi_mem_w_valid,
  input  wire          axi_mem_w_ready,
  output wire [31:0]   axi_mem_w_payload_data,
  output wire [3:0]    axi_mem_w_payload_strb,
  output wire          axi_mem_w_payload_last,
  input  wire          axi_mem_b_valid,
  output wire          axi_mem_b_ready,
  input  wire [3:0]    axi_mem_b_payload_id,
  input  wire [1:0]    axi_mem_b_payload_resp,
  output wire          axi_mem_ar_valid,
  input  wire          axi_mem_ar_ready,
  output wire [31:0]   axi_mem_ar_payload_addr,
  output wire [3:0]    axi_mem_ar_payload_id,
  output wire [7:0]    axi_mem_ar_payload_len,
  output wire [2:0]    axi_mem_ar_payload_size,
  output wire [1:0]    axi_mem_ar_payload_burst,
  input  wire          axi_mem_r_valid,
  output wire          axi_mem_r_ready,
  input  wire [31:0]   axi_mem_r_payload_data,
  input  wire [3:0]    axi_mem_r_payload_id,
  input  wire [1:0]    axi_mem_r_payload_resp,
  input  wire          axi_mem_r_payload_last,
  input  wire          clock,
  input  wire          reset
);
  localparam ysyx_26010010_RVCode_ADD = 6'd0;
  localparam ysyx_26010010_RVCode_SUB = 6'd1;
  localparam ysyx_26010010_RVCode_AND_1 = 6'd2;
  localparam ysyx_26010010_RVCode_OR_1 = 6'd3;
  localparam ysyx_26010010_RVCode_XOR_1 = 6'd4;
  localparam ysyx_26010010_RVCode_SLL_1 = 6'd5;
  localparam ysyx_26010010_RVCode_SRL_1 = 6'd6;
  localparam ysyx_26010010_RVCode_SRA_1 = 6'd7;
  localparam ysyx_26010010_RVCode_SLT = 6'd8;
  localparam ysyx_26010010_RVCode_SLTU = 6'd9;
  localparam ysyx_26010010_RVCode_ADDI = 6'd10;
  localparam ysyx_26010010_RVCode_XORI = 6'd11;
  localparam ysyx_26010010_RVCode_ORI = 6'd12;
  localparam ysyx_26010010_RVCode_ANDI = 6'd13;
  localparam ysyx_26010010_RVCode_SLLI = 6'd14;
  localparam ysyx_26010010_RVCode_SRLI = 6'd15;
  localparam ysyx_26010010_RVCode_SRAI = 6'd16;
  localparam ysyx_26010010_RVCode_SLTI = 6'd17;
  localparam ysyx_26010010_RVCode_SLTIU = 6'd18;
  localparam ysyx_26010010_RVCode_LB = 6'd19;
  localparam ysyx_26010010_RVCode_LH = 6'd20;
  localparam ysyx_26010010_RVCode_LW = 6'd21;
  localparam ysyx_26010010_RVCode_LBU = 6'd22;
  localparam ysyx_26010010_RVCode_LHU = 6'd23;
  localparam ysyx_26010010_RVCode_JALR = 6'd24;
  localparam ysyx_26010010_RVCode_ECALL = 6'd25;
  localparam ysyx_26010010_RVCode_EBREAK = 6'd26;
  localparam ysyx_26010010_RVCode_MRET = 6'd27;
  localparam ysyx_26010010_RVCode_FENCEI = 6'd28;
  localparam ysyx_26010010_RVCode_SW = 6'd29;
  localparam ysyx_26010010_RVCode_SH = 6'd30;
  localparam ysyx_26010010_RVCode_SB = 6'd31;
  localparam ysyx_26010010_RVCode_BEQ = 6'd32;
  localparam ysyx_26010010_RVCode_BNE = 6'd33;
  localparam ysyx_26010010_RVCode_BLT = 6'd34;
  localparam ysyx_26010010_RVCode_BGE = 6'd35;
  localparam ysyx_26010010_RVCode_BLTU = 6'd36;
  localparam ysyx_26010010_RVCode_BGEU = 6'd37;
  localparam ysyx_26010010_RVCode_LUI = 6'd38;
  localparam ysyx_26010010_RVCode_AUIPC = 6'd39;
  localparam ysyx_26010010_RVCode_JAL = 6'd40;
  localparam ysyx_26010010_RVCode_CSRRW = 6'd41;
  localparam ysyx_26010010_RVCode_CSRRS = 6'd42;
  localparam ysyx_26010010_RVCode_CSRRC = 6'd43;
  localparam ysyx_26010010_RVCode_CSRRWI = 6'd44;
  localparam ysyx_26010010_RVCode_CSRRSI = 6'd45;
  localparam ysyx_26010010_RVCode_CSRRCI = 6'd46;
  localparam ysyx_26010010_MEM_MEMt_w_BOOT = 2'd0;
  localparam ysyx_26010010_MEM_MEMt_w_start = 2'd1;
  localparam ysyx_26010010_MEM_MEMt_w_w = 2'd2;
  localparam ysyx_26010010_MEM_MEMt_w_b = 2'd3;
  localparam ysyx_26010010_MEM_MEMt_r_BOOT = 3'd0;
  localparam ysyx_26010010_MEM_MEMt_r_start = 3'd1;
  localparam ysyx_26010010_MEM_MEMt_r_ar = 3'd2;
  localparam ysyx_26010010_MEM_MEMt_r_r = 3'd3;
  localparam ysyx_26010010_MEM_MEMt_r_delay = 3'd4;

  reg                 EX_EXt_ebreak_ebreak_flag;
  reg        [31:0]   WB_csr_w_data;
  reg                 WB_csr_w_valid;
  reg        [11:0]   WB_csr_csr_wsel;
  reg        [11:0]   WB_csr_csr_rsel;
  wire                IF_axi_if_axi_ar_valid;
  wire       [31:0]   IF_axi_if_axi_ar_payload_addr;
  wire       [3:0]    IF_axi_if_axi_ar_payload_id;
  wire       [7:0]    IF_axi_if_axi_ar_payload_len;
  wire       [2:0]    IF_axi_if_axi_ar_payload_size;
  wire       [1:0]    IF_axi_if_axi_ar_payload_burst;
  wire                IF_axi_if_axi_aw_valid;
  wire       [31:0]   IF_axi_if_axi_aw_payload_addr;
  wire       [3:0]    IF_axi_if_axi_aw_payload_id;
  wire       [7:0]    IF_axi_if_axi_aw_payload_len;
  wire       [2:0]    IF_axi_if_axi_aw_payload_size;
  wire       [1:0]    IF_axi_if_axi_aw_payload_burst;
  wire                IF_axi_if_axi_w_valid;
  wire       [31:0]   IF_axi_if_axi_w_payload_data;
  wire       [3:0]    IF_axi_if_axi_w_payload_strb;
  wire                IF_axi_if_axi_w_payload_last;
  wire                IF_axi_if_axi_r_ready;
  wire                IF_axi_if_axi_b_ready;
  wire                IF_axi_if_code_valid;
  wire       [31:0]   IF_axi_if_code_payload;
  wire       [31:0]   WB_csr_r_data;
  wire       [11:0]   _zz_ID_IDt_imm_I;
  wire       [11:0]   _zz_ID_IDt_imm_S;
  wire       [12:0]   _zz_ID_IDt_imm_B;
  wire       [20:0]   _zz_ID_IDt_imm_J;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_1;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_2;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_3;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_4;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_5;
  wire       [62:0]   _zz_pip_ctrl_3_down_RD_6;
  wire       [62:0]   _zz_pip_ctrl_3_down_RD_7;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_8;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_9;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_10;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_11;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_12;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_13;
  wire       [0:0]    _zz_pip_ctrl_3_down_RD_14;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_15;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_16;
  wire       [0:0]    _zz_pip_ctrl_3_down_RD_17;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_18;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_19;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_20;
  wire       [62:0]   _zz_pip_ctrl_3_down_RD_21;
  wire       [62:0]   _zz_pip_ctrl_3_down_RD_22;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_23;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_24;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_25;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_26;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_27;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_28;
  wire       [0:0]    _zz_pip_ctrl_3_down_RD_29;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_30;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_31;
  wire       [0:0]    _zz_pip_ctrl_3_down_RD_32;
  wire       [15:0]   _zz_pip_ctrl_3_down_RD_33;
  wire       [7:0]    _zz_pip_ctrl_3_down_RD_34;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_35;
  wire       [31:0]   _zz_when_RVFun_l62;
  wire       [31:0]   _zz_when_RVFun_l62_1;
  wire       [31:0]   _zz_when_RVFun_l63;
  wire       [31:0]   _zz_when_RVFun_l63_1;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_36;
  wire       [31:0]   _zz_pip_ctrl_3_down_RD_37;
  wire       [6:0]    _zz_MEM_MEMt_w_strb;
  wire       [62:0]   _zz_MEM_MEMt_w_data;
  wire       [4:0]    _zz_MEM_MEMt_w_data_1;
  wire       [4:0]    _zz_MEM_MEMt_r_data;
  wire       [3:0]    _zz__zz_1;
  wire       [4:0]    _zz__zz_1_1;
  reg        [31:0]   _zz_WB_gpr_rdata;
  wire       [3:0]    _zz_WB_gpr_rdata_1;
  wire       [3:0]    _zz__zz_2;
  wire       [4:0]    _zz__zz_2_1;
  wire       [4:0]    _zz_w_data;
  wire       [31:0]   _zz_w_data_1;
  wire       [31:0]   _zz_w_data_2;
  reg        [31:0]   _zz_id_rs1;
  wire       [3:0]    _zz_id_rs1_1;
  reg        [31:0]   _zz_id_rs2;
  wire       [3:0]    _zz_id_rs2_1;
  wire       [31:0]   _zz_pip_ctrl_4_down_RD;
  wire       [7:0]    _zz_pip_ctrl_4_down_RD_1;
  wire       [31:0]   _zz_pip_ctrl_4_down_RD_2;
  wire       [7:0]    _zz_pip_ctrl_4_down_RD_3;
  wire       [31:0]   _zz_pip_ctrl_4_down_RD_4;
  wire       [15:0]   _zz_pip_ctrl_4_down_RD_5;
  wire       [31:0]   _zz_pip_ctrl_4_down_RD_6;
  wire       [15:0]   _zz_pip_ctrl_4_down_RD_7;
  wire                pip_ctrl_4_up_isCancel;
  wire                pip_ctrl_4_up_isReady;
  wire                pip_ctrl_3_up_isCancel;
  wire                pip_ctrl_3_up_isReady;
  wire                pip_ctrl_2_up_isCancel;
  wire                pip_ctrl_2_up_isReady;
  wire                pip_ctrl_4_down_isReady;
  wire       [11:0]   pip_ctrl_4_down_CSR_sel;
  reg                 pip_ctrl_4_down_RD_valid;
  wire       [4:0]    pip_ctrl_4_down_RD_sel;
  wire       [4:0]    pip_ctrl_4_down_CSR_rs1_imm;
  wire       [5:0]    pip_ctrl_4_down_IDtoEX_fun;
  wire       [4:0]    pip_ctrl_4_down_IDtoEX_rd_sel;
  wire       [31:0]   pip_ctrl_4_down_IDtoEX_imm;
  wire       [31:0]   pip_ctrl_4_down_IDtoEX_rs1;
  wire       [31:0]   pip_ctrl_4_down_IDtoEX_rs2;
  wire       [31:0]   pip_ctrl_4_down_PC;
  wire       [31:0]   pip_ctrl_4_down_CODE;
  wire                pip_ctrl_4_down_isValid;
  reg        [11:0]   pip_ctrl_5_up_CSR_sel;
  reg                 pip_ctrl_5_up_CSR_valid;
  reg        [4:0]    pip_ctrl_5_up_CSR_rs1_imm;
  reg        [5:0]    pip_ctrl_5_up_IDtoEX_fun;
  reg        [4:0]    pip_ctrl_5_up_IDtoEX_rd_sel;
  reg        [31:0]   pip_ctrl_5_up_IDtoEX_imm;
  reg        [31:0]   pip_ctrl_5_up_IDtoEX_rs1;
  reg        [31:0]   pip_ctrl_5_up_IDtoEX_rs2;
  wire                pip_ctrl_4_up_isValid;
  wire       [4:0]    pip_ctrl_3_down_CSR_rs1_imm;
  wire                pip_ctrl_3_down_isValid;
  wire                pip_ctrl_3_down_isReady;
  reg        [11:0]   pip_ctrl_4_up_CSR_sel;
  reg                 pip_ctrl_4_up_CSR_valid;
  reg                 pip_ctrl_4_up_MEM_unsigned;
  reg        [3:0]    pip_ctrl_4_up_MEM_mask;
  reg                 pip_ctrl_4_up_MEM_write_valid;
  reg                 pip_ctrl_4_up_MEM_read_valid;
  reg        [31:0]   pip_ctrl_4_up_MEM_addr;
  reg                 pip_ctrl_4_up_RD_valid;
  reg        [31:0]   pip_ctrl_4_up_RD;
  reg        [4:0]    pip_ctrl_4_up_RD_sel;
  reg        [4:0]    pip_ctrl_4_up_CSR_rs1_imm;
  reg        [5:0]    pip_ctrl_4_up_IDtoEX_fun;
  reg        [4:0]    pip_ctrl_4_up_IDtoEX_rd_sel;
  reg        [31:0]   pip_ctrl_4_up_IDtoEX_imm;
  reg        [31:0]   pip_ctrl_4_up_IDtoEX_rs1;
  reg        [31:0]   pip_ctrl_4_up_IDtoEX_rs2;
  reg        [31:0]   pip_ctrl_4_up_PC;
  reg        [31:0]   pip_ctrl_4_up_CODE;
  wire                pip_ctrl_3_up_isValid;
  wire       [31:0]   pip_ctrl_2_down_PC;
  wire                pip_ctrl_2_down_isValid;
  wire                pip_ctrl_2_down_isReady;
  reg        [4:0]    pip_ctrl_3_up_CSR_rs1_imm;
  reg        [5:0]    pip_ctrl_3_up_IDtoEX_fun;
  reg        [4:0]    pip_ctrl_3_up_IDtoEX_rd_sel;
  reg        [31:0]   pip_ctrl_3_up_IDtoEX_imm;
  reg        [31:0]   pip_ctrl_3_up_IDtoEX_rs1;
  reg        [31:0]   pip_ctrl_3_up_IDtoEX_rs2;
  reg        [31:0]   pip_ctrl_3_up_PC;
  reg        [31:0]   pip_ctrl_3_up_CODE;
  wire                pip_ctrl_2_up_isValid;
  wire                pip_ctrl_1_down_isValid;
  wire                pip_ctrl_1_down_isReady;
  reg        [31:0]   pip_ctrl_2_up_PC;
  reg        [31:0]   pip_ctrl_2_up_CODE;
  wire                pip_ctrl_5_down_valid;
  reg                 pip_ctrl_5_up_valid;
  reg                 pip_ctrl_4_down_valid;
  reg                 pip_ctrl_3_down_valid;
  reg                 pip_ctrl_3_up_valid;
  reg                 pip_ctrl_2_down_valid;
  reg                 pip_ctrl_2_up_valid;
  reg                 pip_ctrl_1_down_valid;
  reg                 pip_ctrl_1_up_ready;
  reg                 pip_ctrl_1_down_ready;
  reg                 pip_ctrl_2_up_ready;
  wire                pip_ctrl_2_up_cancel;
  reg                 pip_ctrl_2_down_ready;
  wire                pip_ctrl_3_up_ready;
  wire                pip_ctrl_3_up_cancel;
  reg                 pip_ctrl_3_down_ready;
  reg                 pip_ctrl_4_up_ready;
  wire                pip_ctrl_4_up_cancel;
  reg                 _zz_pip_ctrl_1_haltRequest_pipCPU_l768;
  wire       [31:0]   pip_ctrl_3_down_CODE;
  reg        [31:0]   pip_ctrl_5_up_CODE;
  wire       [31:0]   pip_ctrl_5_down_CODE;
  reg        [31:0]   pip_ctrl_5_CODE_bypass;
  reg        [31:0]   pip_ctrl_5_up_PC;
  reg        [31:0]   pip_ctrl_5_PC_bypass;
  reg                 pip_ctrl_5_up_RD_valid;
  reg                 pip_ctrl_5_RD_valid_bypass;
  reg        [4:0]    pip_ctrl_5_up_RD_sel;
  reg        [4:0]    pip_ctrl_5_RD_sel_bypass;
  reg        [31:0]   pip_ctrl_5_up_RD;
  reg        [31:0]   pip_ctrl_5_RD_bypass;
  reg                 _zz_pip_ctrl_2_haltRequest_pipCPU_l744;
  reg                 _zz_pip_ctrl_4_throwWhen_pipCPU_l729;
  reg                 _zz_pip_ctrl_3_throwWhen_pipCPU_l728;
  reg                 _zz_pip_ctrl_2_throwWhen_pipCPU_l727;
  reg                 _zz_pip_ctrl_4_throwWhen_pipCPU_l719;
  reg                 _zz_pip_ctrl_3_throwWhen_pipCPU_l718;
  reg                 _zz_pip_ctrl_2_throwWhen_pipCPU_l717;
  wire       [31:0]   pip_ctrl_5_down_PC;
  wire       [5:0]    pip_ctrl_5_down_IDtoEX_fun;
  wire       [4:0]    pip_ctrl_5_down_IDtoEX_rd_sel;
  wire       [31:0]   pip_ctrl_5_down_IDtoEX_imm;
  wire       [31:0]   pip_ctrl_5_down_IDtoEX_rs1;
  wire       [31:0]   pip_ctrl_5_down_IDtoEX_rs2;
  wire       [11:0]   pip_ctrl_5_down_CSR_sel;
  wire                pip_ctrl_5_down_CSR_valid;
  wire       [4:0]    pip_ctrl_5_down_CSR_rs1_imm;
  wire       [31:0]   pip_ctrl_5_down_RD;
  wire                pip_ctrl_4_down_CSR_valid;
  wire       [4:0]    pip_ctrl_5_down_RD_sel;
  wire                pip_ctrl_5_down_RD_valid;
  reg                 _zz_pip_ctrl_4_haltRequest_pipCPU_l372;
  reg                 _zz_pip_ctrl_4_haltRequest_pipCPU_l371;
  reg                 _zz_pip_ctrl_4_haltRequest_pipCPU_l370;
  reg                 pip_ctrl_4_up_valid;
  wire                pip_ctrl_4_up_isFiring;
  reg        [31:0]   pip_ctrl_4_down_RD;
  wire       [3:0]    pip_ctrl_4_down_MEM_mask;
  wire       [31:0]   pip_ctrl_4_down_MEM_addr;
  wire                pip_ctrl_4_down_MEM_unsigned;
  wire                pip_ctrl_4_down_MEM_read_valid;
  wire                pip_ctrl_4_down_MEM_write_valid;
  wire                pip_ctrl_3_up_isFiring;
  wire       [11:0]   pip_ctrl_3_down_CSR_sel;
  reg                 pip_ctrl_3_down_CSR_valid;
  reg                 pip_ctrl_3_down_MEM_unsigned;
  reg        [3:0]    pip_ctrl_3_down_MEM_mask;
  reg                 pip_ctrl_3_down_MEM_write_valid;
  reg                 pip_ctrl_3_down_MEM_read_valid;
  reg        [31:0]   pip_ctrl_3_down_MEM_addr;
  wire       [31:0]   pip_ctrl_3_down_PC;
  reg                 pip_ctrl_3_down_RD_valid;
  reg        [31:0]   pip_ctrl_3_down_RD;
  wire       [4:0]    pip_ctrl_3_down_RD_sel;
  wire       [5:0]    pip_ctrl_3_down_IDtoEX_fun;
  wire       [4:0]    pip_ctrl_3_down_IDtoEX_rd_sel;
  wire       [31:0]   pip_ctrl_3_down_IDtoEX_imm;
  wire       [31:0]   pip_ctrl_3_down_IDtoEX_rs1;
  wire       [31:0]   pip_ctrl_3_down_IDtoEX_rs2;
  wire       [4:0]    pip_ctrl_2_down_CSR_rs1_imm;
  wire                pip_ctrl_2_up_isFiring;
  wire       [31:0]   pip_ctrl_2_down_CODE;
  reg        [5:0]    pip_ctrl_2_down_IDtoEX_fun;
  reg        [4:0]    pip_ctrl_2_down_IDtoEX_rd_sel;
  reg        [31:0]   pip_ctrl_2_down_IDtoEX_imm;
  wire       [31:0]   pip_ctrl_2_down_IDtoEX_rs1;
  wire       [31:0]   pip_ctrl_2_down_IDtoEX_rs2;
  wire       [31:0]   pip_ctrl_1_down_PC;
  wire       [31:0]   pip_ctrl_1_down_CODE;
  wire                pip_ctrl_1_down_isFiring;
  wire                pip_ctrl_1_up_valid;
  reg        [31:0]   gpr_reg_0;
  reg        [31:0]   gpr_reg_1;
  reg        [31:0]   gpr_reg_2;
  reg        [31:0]   gpr_reg_3;
  reg        [31:0]   gpr_reg_4;
  reg        [31:0]   gpr_reg_5;
  reg        [31:0]   gpr_reg_6;
  reg        [31:0]   gpr_reg_7;
  reg        [31:0]   gpr_reg_8;
  reg        [31:0]   gpr_reg_9;
  reg        [31:0]   gpr_reg_10;
  reg        [31:0]   gpr_reg_11;
  reg        [31:0]   gpr_reg_12;
  reg        [31:0]   gpr_reg_13;
  reg        [31:0]   gpr_reg_14;
  wire       [31:0]   gpr_0;
  wire       [31:0]   gpr_1;
  wire       [31:0]   gpr_2;
  wire       [31:0]   gpr_3;
  wire       [31:0]   gpr_4;
  wire       [31:0]   gpr_5;
  wire       [31:0]   gpr_6;
  wire       [31:0]   gpr_7;
  wire       [31:0]   gpr_8;
  wire       [31:0]   gpr_9;
  wire       [31:0]   gpr_10;
  wire       [31:0]   gpr_11;
  wire       [31:0]   gpr_12;
  wire       [31:0]   gpr_13;
  wire       [31:0]   gpr_14;
  wire       [31:0]   gpr_15;
  reg        [31:0]   EXtoIF_nPC;
  reg                 EXtoIF_valid;
  reg                 fence_i;
  wire       [31:0]   IF_addr;
  wire                IF_code_valid;
  wire                IF_code_ready;
  wire       [31:0]   IF_code_payload;
  reg        [31:0]   IF_IFt_pc;
  wire                when_pipCPU_l29;
  reg        [31:0]   id_rs1;
  reg        [31:0]   id_rs2;
  reg        [4:0]    id_rs1_sel;
  reg        [4:0]    id_rs2_sel;
  wire       [4:0]    ID_IDt_rs1_t;
  wire       [4:0]    ID_IDt_rs2_t;
  wire       [4:0]    ID_IDt_rd_t;
  wire       [31:0]   ID_IDt_imm_I;
  wire       [31:0]   ID_IDt_imm_U;
  wire       [31:0]   ID_IDt_imm_S;
  wire       [31:0]   ID_IDt_imm_B;
  wire       [31:0]   ID_IDt_imm_J;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun;
  reg                 ID_IDt_error_flag;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_1;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_2;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_3;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_4;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_5;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_6;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_7;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_8;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_9;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_10;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_11;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_12;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_13;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_14;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_15;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_16;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_17;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_18;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_19;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_20;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_21;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_22;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_23;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_24;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_25;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_26;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_27;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_28;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_29;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_30;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_31;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_32;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_33;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_34;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_35;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_36;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_37;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_38;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_39;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_40;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_41;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_42;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_43;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_44;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_45;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_46;
  wire       [5:0]    _zz_pip_ctrl_2_down_IDtoEX_fun_47;
  reg        [31:0]   EX_EXt_nPC;
  reg                 EX_EXt_nPC_valid;
  wire                when_RVFun_l60;
  wire                when_RVFun_l61;
  wire                when_RVFun_l62;
  wire                when_RVFun_l63;
  wire                when_RVFun_l64;
  wire                when_RVFun_l65;
  wire                when_pipCPU_l318;
  reg                 axi_mem_aw_valid_1;
  wire                axi_mem_aw_ready_1;
  reg        [31:0]   axi_mem_aw_payload_addr_1;
  reg        [3:0]    axi_mem_aw_payload_id_1;
  reg        [7:0]    axi_mem_aw_payload_len_1;
  reg        [2:0]    axi_mem_aw_payload_size_1;
  wire       [1:0]    axi_mem_aw_payload_burst_1;
  reg                 axi_mem_w_valid_1;
  wire                axi_mem_w_ready_1;
  reg        [31:0]   axi_mem_w_payload_data_1;
  reg        [3:0]    axi_mem_w_payload_strb_1;
  reg                 axi_mem_w_payload_last_1;
  wire                axi_mem_b_valid_1;
  reg                 axi_mem_b_ready_1;
  wire       [3:0]    axi_mem_b_payload_id_1;
  wire       [1:0]    axi_mem_b_payload_resp_1;
  reg                 axi_mem_ar_valid_1;
  wire                axi_mem_ar_ready_1;
  reg        [31:0]   axi_mem_ar_payload_addr_1;
  reg        [3:0]    axi_mem_ar_payload_id_1;
  reg        [7:0]    axi_mem_ar_payload_len_1;
  reg        [2:0]    axi_mem_ar_payload_size_1;
  wire       [1:0]    axi_mem_ar_payload_burst_1;
  wire                axi_mem_r_valid_1;
  reg                 axi_mem_r_ready_1;
  wire       [31:0]   axi_mem_r_payload_data_1;
  wire       [3:0]    axi_mem_r_payload_id_1;
  wire       [1:0]    axi_mem_r_payload_resp_1;
  wire                axi_mem_r_payload_last_1;
  wire       [1:0]    MEM_MEMt_addrl;
  wire       [3:0]    MEM_MEMt_w_strb;
  wire       [31:0]   MEM_MEMt_w_data;
  wire       [31:0]   MEM_MEMt_r_data;
  reg                 MEM_MEMt_w_flag;
  reg                 MEM_MEMt_r_flag;
  reg                 MEM_MEMt_once_flag;
  wire                when_pipCPU_l370;
  wire                pip_ctrl_4_haltRequest_pipCPU_l370;
  wire                when_pipCPU_l371;
  wire                pip_ctrl_4_haltRequest_pipCPU_l371;
  wire                when_pipCPU_l372;
  wire                pip_ctrl_4_haltRequest_pipCPU_l372;
  wire                MEM_MEMt_w_wantExit;
  reg                 MEM_MEMt_w_wantStart;
  wire                MEM_MEMt_w_wantKill;
  wire                MEM_MEMt_r_wantExit;
  reg                 MEM_MEMt_r_wantStart;
  wire                MEM_MEMt_r_wantKill;
  wire                when_pipCPU_l687;
  wire       [15:0]   _zz_1;
  wire       [31:0]   WB_gpr_rdata;
  reg                 WB_csr_flag;
  wire                when_pipCPU_l707;
  wire       [15:0]   _zz_2;
  wire                pip_ctrl_2_throwWhen_pipCPU_l717;
  wire                pip_ctrl_3_throwWhen_pipCPU_l718;
  wire                pip_ctrl_4_throwWhen_pipCPU_l719;
  wire                pip_ctrl_2_throwWhen_pipCPU_l727;
  wire                pip_ctrl_3_throwWhen_pipCPU_l728;
  wire                pip_ctrl_4_throwWhen_pipCPU_l729;
  wire                when_pipCPU_l743;
  wire                pip_ctrl_2_haltRequest_pipCPU_l744;
  reg                 pass_valid;
  wire                when_pipCPU_l762;
  wire                when_pipCPU_l764;
  wire                when_pipCPU_l767;
  wire                pip_ctrl_1_haltRequest_pipCPU_l768;
  reg                 EXtoIF_valid_regNext;
  wire                pip_ctrl_2_throwWhen_pipCPU_l771;
  wire                pip_ctrl_4_up_forgetOne;
  wire                pip_ctrl_3_up_forgetOne;
  wire                pip_ctrl_2_up_forgetOne;
  wire                when_StageLink_l71;
  wire                when_StageLink_l71_1;
  wire                when_StageLink_l71_2;
  wire                when_CtrlLink_l191;
  wire                when_CtrlLink_l191_1;
  wire                when_CtrlLink_l198;
  wire                when_CtrlLink_l198_1;
  wire                when_CtrlLink_l191_2;
  wire                when_CtrlLink_l198_2;
  reg        [1:0]    MEM_MEMt_w_stateReg;
  reg        [1:0]    MEM_MEMt_w_stateNext;
  wire                axi_mem_aw_fire;
  wire                axi_mem_b_fire;
  wire                MEM_MEMt_w_onExit_BOOT;
  wire                MEM_MEMt_w_onExit_start;
  wire                MEM_MEMt_w_onExit_w;
  wire                MEM_MEMt_w_onExit_b;
  wire                MEM_MEMt_w_onEntry_BOOT;
  wire                MEM_MEMt_w_onEntry_start;
  wire                MEM_MEMt_w_onEntry_w;
  wire                MEM_MEMt_w_onEntry_b;
  reg        [2:0]    MEM_MEMt_r_stateReg;
  reg        [2:0]    MEM_MEMt_r_stateNext;
  wire                axi_mem_ar_fire;
  wire                axi_mem_r_fire;
  wire                MEM_MEMt_r_onExit_BOOT;
  wire                MEM_MEMt_r_onExit_start;
  wire                MEM_MEMt_r_onExit_ar;
  wire                MEM_MEMt_r_onExit_r;
  wire                MEM_MEMt_r_onExit_delay;
  wire                MEM_MEMt_r_onEntry_BOOT;
  wire                MEM_MEMt_r_onEntry_start;
  wire                MEM_MEMt_r_onEntry_ar;
  wire                MEM_MEMt_r_onEntry_r;
  wire                MEM_MEMt_r_onEntry_delay;
  `ifndef SYNTHESIS
  reg [47:0] pip_ctrl_4_down_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_5_up_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_4_up_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_3_up_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_5_down_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_3_down_IDtoEX_fun_string;
  reg [47:0] pip_ctrl_2_down_IDtoEX_fun_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_1_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_2_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_3_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_4_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_5_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_6_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_7_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_8_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_9_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_10_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_11_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_12_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_13_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_14_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_15_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_16_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_17_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_18_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_19_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_20_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_21_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_22_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_23_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_24_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_25_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_26_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_27_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_28_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_29_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_30_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_31_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_32_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_33_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_34_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_35_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_36_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_37_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_38_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_39_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_40_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_41_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_42_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_43_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_44_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_45_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_46_string;
  reg [47:0] _zz_pip_ctrl_2_down_IDtoEX_fun_47_string;
  reg [39:0] MEM_MEMt_w_stateReg_string;
  reg [39:0] MEM_MEMt_w_stateNext_string;
  reg [39:0] MEM_MEMt_r_stateReg_string;
  reg [39:0] MEM_MEMt_r_stateNext_string;
  `endif


  assign _zz_ID_IDt_imm_I = pip_ctrl_2_down_CODE[31 : 20];
  assign _zz_ID_IDt_imm_S = {pip_ctrl_2_down_CODE[31 : 25],pip_ctrl_2_down_CODE[11 : 7]};
  assign _zz_ID_IDt_imm_B = {pip_ctrl_2_down_CODE[31],{pip_ctrl_2_down_CODE[7],{pip_ctrl_2_down_CODE[30 : 25],{pip_ctrl_2_down_CODE[11 : 8],1'b0}}}};
  assign _zz_ID_IDt_imm_J = {pip_ctrl_2_down_CODE[31],{pip_ctrl_2_down_CODE[19 : 12],{pip_ctrl_2_down_CODE[20],{pip_ctrl_2_down_CODE[30 : 21],1'b0}}}};
  assign _zz_pip_ctrl_3_down_RD = ($signed(_zz_pip_ctrl_3_down_RD_1) + $signed(_zz_pip_ctrl_3_down_RD_2));
  assign _zz_pip_ctrl_3_down_RD_1 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_2 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_3 = ($signed(_zz_pip_ctrl_3_down_RD_4) - $signed(_zz_pip_ctrl_3_down_RD_5));
  assign _zz_pip_ctrl_3_down_RD_4 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_5 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_6 = _zz_pip_ctrl_3_down_RD_7;
  assign _zz_pip_ctrl_3_down_RD_7 = ({31'd0,pip_ctrl_3_down_IDtoEX_rs1} <<< _zz_pip_ctrl_3_down_RD_8[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_8 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_9 = (pip_ctrl_3_down_IDtoEX_rs1 >>> _zz_pip_ctrl_3_down_RD_10[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_10 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_11 = ($signed(_zz_pip_ctrl_3_down_RD_12) >>> _zz_pip_ctrl_3_down_RD_13[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_12 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_13 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_14 = ($signed(_zz_pip_ctrl_3_down_RD_15) < $signed(_zz_pip_ctrl_3_down_RD_16));
  assign _zz_pip_ctrl_3_down_RD_15 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_16 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_pip_ctrl_3_down_RD_17 = (pip_ctrl_3_down_IDtoEX_rs1 < pip_ctrl_3_down_IDtoEX_rs2);
  assign _zz_pip_ctrl_3_down_RD_18 = ($signed(_zz_pip_ctrl_3_down_RD_19) + $signed(_zz_pip_ctrl_3_down_RD_20));
  assign _zz_pip_ctrl_3_down_RD_19 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_20 = pip_ctrl_3_down_IDtoEX_imm;
  assign _zz_pip_ctrl_3_down_RD_21 = _zz_pip_ctrl_3_down_RD_22;
  assign _zz_pip_ctrl_3_down_RD_22 = ({31'd0,pip_ctrl_3_down_IDtoEX_rs1} <<< _zz_pip_ctrl_3_down_RD_23[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_23 = pip_ctrl_3_down_IDtoEX_imm;
  assign _zz_pip_ctrl_3_down_RD_24 = (pip_ctrl_3_down_IDtoEX_rs1 >>> _zz_pip_ctrl_3_down_RD_25[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_25 = pip_ctrl_3_down_IDtoEX_imm;
  assign _zz_pip_ctrl_3_down_RD_26 = ($signed(_zz_pip_ctrl_3_down_RD_27) >>> _zz_pip_ctrl_3_down_RD_28[4 : 0]);
  assign _zz_pip_ctrl_3_down_RD_27 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_28 = pip_ctrl_3_down_IDtoEX_imm;
  assign _zz_pip_ctrl_3_down_RD_29 = ($signed(_zz_pip_ctrl_3_down_RD_30) < $signed(_zz_pip_ctrl_3_down_RD_31));
  assign _zz_pip_ctrl_3_down_RD_30 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_31 = pip_ctrl_3_down_IDtoEX_imm;
  assign _zz_pip_ctrl_3_down_RD_32 = (pip_ctrl_3_down_IDtoEX_rs1 < pip_ctrl_3_down_IDtoEX_imm);
  assign _zz_pip_ctrl_3_down_RD_33 = pip_ctrl_3_down_IDtoEX_rs2[15 : 0];
  assign _zz_pip_ctrl_3_down_RD_34 = pip_ctrl_3_down_IDtoEX_rs2[7 : 0];
  assign _zz_pip_ctrl_3_down_RD_35 = (pip_ctrl_3_down_PC + 32'h00000004);
  assign _zz_when_RVFun_l62 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_when_RVFun_l62_1 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_when_RVFun_l63 = pip_ctrl_3_down_IDtoEX_rs2;
  assign _zz_when_RVFun_l63_1 = pip_ctrl_3_down_IDtoEX_rs1;
  assign _zz_pip_ctrl_3_down_RD_36 = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
  assign _zz_pip_ctrl_3_down_RD_37 = (pip_ctrl_3_down_PC + 32'h00000004);
  assign _zz_MEM_MEMt_w_strb = ({3'd0,pip_ctrl_4_down_MEM_mask} <<< MEM_MEMt_addrl);
  assign _zz_MEM_MEMt_w_data = ({31'd0,pip_ctrl_4_down_RD} <<< _zz_MEM_MEMt_w_data_1);
  assign _zz_MEM_MEMt_w_data_1 = ({3'd0,MEM_MEMt_addrl} <<< 2'd3);
  assign _zz_MEM_MEMt_r_data = ({3'd0,MEM_MEMt_addrl} <<< 2'd3);
  assign _zz__zz_1_1 = (pip_ctrl_5_down_RD_sel - 5'h01);
  assign _zz__zz_1 = _zz__zz_1_1[3:0];
  assign _zz_WB_gpr_rdata_1 = pip_ctrl_5_down_CSR_rs1_imm[3:0];
  assign _zz__zz_2_1 = (pip_ctrl_5_down_RD_sel - 5'h01);
  assign _zz__zz_2 = _zz__zz_2_1[3:0];
  assign _zz_w_data = pip_ctrl_5_down_CSR_rs1_imm;
  assign _zz_w_data_1 = {27'd0, pip_ctrl_5_down_CSR_rs1_imm};
  assign _zz_w_data_2 = {27'd0, pip_ctrl_5_down_CSR_rs1_imm};
  assign _zz_id_rs1_1 = id_rs1_sel[3:0];
  assign _zz_id_rs2_1 = id_rs2_sel[3:0];
  assign _zz_pip_ctrl_4_down_RD_1 = MEM_MEMt_r_data[7 : 0];
  assign _zz_pip_ctrl_4_down_RD = {24'd0, _zz_pip_ctrl_4_down_RD_1};
  assign _zz_pip_ctrl_4_down_RD_3 = MEM_MEMt_r_data[7 : 0];
  assign _zz_pip_ctrl_4_down_RD_2 = {{24{_zz_pip_ctrl_4_down_RD_3[7]}}, _zz_pip_ctrl_4_down_RD_3};
  assign _zz_pip_ctrl_4_down_RD_5 = MEM_MEMt_r_data[15 : 0];
  assign _zz_pip_ctrl_4_down_RD_4 = {16'd0, _zz_pip_ctrl_4_down_RD_5};
  assign _zz_pip_ctrl_4_down_RD_7 = MEM_MEMt_r_data[15 : 0];
  assign _zz_pip_ctrl_4_down_RD_6 = {{16{_zz_pip_ctrl_4_down_RD_7[15]}}, _zz_pip_ctrl_4_down_RD_7};
  ysyx_26010010_Icache IF_axi_if (
    .axi_aw_valid         (IF_axi_if_axi_aw_valid             ), //o
    .axi_aw_ready         (axi_if_aw_ready                    ), //i
    .axi_aw_payload_addr  (IF_axi_if_axi_aw_payload_addr[31:0]), //o
    .axi_aw_payload_id    (IF_axi_if_axi_aw_payload_id[3:0]   ), //o
    .axi_aw_payload_len   (IF_axi_if_axi_aw_payload_len[7:0]  ), //o
    .axi_aw_payload_size  (IF_axi_if_axi_aw_payload_size[2:0] ), //o
    .axi_aw_payload_burst (IF_axi_if_axi_aw_payload_burst[1:0]), //o
    .axi_w_valid          (IF_axi_if_axi_w_valid              ), //o
    .axi_w_ready          (axi_if_w_ready                     ), //i
    .axi_w_payload_data   (IF_axi_if_axi_w_payload_data[31:0] ), //o
    .axi_w_payload_strb   (IF_axi_if_axi_w_payload_strb[3:0]  ), //o
    .axi_w_payload_last   (IF_axi_if_axi_w_payload_last       ), //o
    .axi_b_valid          (axi_if_b_valid                     ), //i
    .axi_b_ready          (IF_axi_if_axi_b_ready              ), //o
    .axi_b_payload_id     (axi_if_b_payload_id[3:0]           ), //i
    .axi_b_payload_resp   (axi_if_b_payload_resp[1:0]         ), //i
    .axi_ar_valid         (IF_axi_if_axi_ar_valid             ), //o
    .axi_ar_ready         (axi_if_ar_ready                    ), //i
    .axi_ar_payload_addr  (IF_axi_if_axi_ar_payload_addr[31:0]), //o
    .axi_ar_payload_id    (IF_axi_if_axi_ar_payload_id[3:0]   ), //o
    .axi_ar_payload_len   (IF_axi_if_axi_ar_payload_len[7:0]  ), //o
    .axi_ar_payload_size  (IF_axi_if_axi_ar_payload_size[2:0] ), //o
    .axi_ar_payload_burst (IF_axi_if_axi_ar_payload_burst[1:0]), //o
    .axi_r_valid          (axi_if_r_valid                     ), //i
    .axi_r_ready          (IF_axi_if_axi_r_ready              ), //o
    .axi_r_payload_data   (axi_if_r_payload_data[31:0]        ), //i
    .axi_r_payload_id     (axi_if_r_payload_id[3:0]           ), //i
    .axi_r_payload_resp   (axi_if_r_payload_resp[1:0]         ), //i
    .axi_r_payload_last   (axi_if_r_payload_last              ), //i
    .addr                 (IF_addr[31:0]                      ), //i
    .code_valid           (IF_axi_if_code_valid               ), //o
    .code_ready           (IF_code_ready                      ), //i
    .code_payload         (IF_axi_if_code_payload[31:0]       ), //o
    .fence_i              (fence_i                            ), //i
    .clock                (clock                              ), //i
    .reset                (reset                              )  //i
  );
  ysyx_26010010_ebreak_fun EX_EXt_ebreak (
    .ebreak_flag (EX_EXt_ebreak_ebreak_flag)  //i
  );
  ysyx_26010010_CSR WB_csr (
    .w_data   (WB_csr_w_data[31:0]  ), //i
    .w_valid  (WB_csr_w_valid       ), //i
    .r_data   (WB_csr_r_data[31:0]  ), //o
    .csr_wsel (WB_csr_csr_wsel[11:0]), //i
    .csr_rsel (WB_csr_csr_rsel[11:0]), //i
    .clock    (clock                ), //i
    .reset    (reset                )  //i
  );
  always @(*) begin
    case(_zz_WB_gpr_rdata_1)
      4'b0000 : _zz_WB_gpr_rdata = gpr_0;
      4'b0001 : _zz_WB_gpr_rdata = gpr_1;
      4'b0010 : _zz_WB_gpr_rdata = gpr_2;
      4'b0011 : _zz_WB_gpr_rdata = gpr_3;
      4'b0100 : _zz_WB_gpr_rdata = gpr_4;
      4'b0101 : _zz_WB_gpr_rdata = gpr_5;
      4'b0110 : _zz_WB_gpr_rdata = gpr_6;
      4'b0111 : _zz_WB_gpr_rdata = gpr_7;
      4'b1000 : _zz_WB_gpr_rdata = gpr_8;
      4'b1001 : _zz_WB_gpr_rdata = gpr_9;
      4'b1010 : _zz_WB_gpr_rdata = gpr_10;
      4'b1011 : _zz_WB_gpr_rdata = gpr_11;
      4'b1100 : _zz_WB_gpr_rdata = gpr_12;
      4'b1101 : _zz_WB_gpr_rdata = gpr_13;
      4'b1110 : _zz_WB_gpr_rdata = gpr_14;
      default : _zz_WB_gpr_rdata = gpr_15;
    endcase
  end

  always @(*) begin
    case(_zz_id_rs1_1)
      4'b0000 : _zz_id_rs1 = gpr_0;
      4'b0001 : _zz_id_rs1 = gpr_1;
      4'b0010 : _zz_id_rs1 = gpr_2;
      4'b0011 : _zz_id_rs1 = gpr_3;
      4'b0100 : _zz_id_rs1 = gpr_4;
      4'b0101 : _zz_id_rs1 = gpr_5;
      4'b0110 : _zz_id_rs1 = gpr_6;
      4'b0111 : _zz_id_rs1 = gpr_7;
      4'b1000 : _zz_id_rs1 = gpr_8;
      4'b1001 : _zz_id_rs1 = gpr_9;
      4'b1010 : _zz_id_rs1 = gpr_10;
      4'b1011 : _zz_id_rs1 = gpr_11;
      4'b1100 : _zz_id_rs1 = gpr_12;
      4'b1101 : _zz_id_rs1 = gpr_13;
      4'b1110 : _zz_id_rs1 = gpr_14;
      default : _zz_id_rs1 = gpr_15;
    endcase
  end

  always @(*) begin
    case(_zz_id_rs2_1)
      4'b0000 : _zz_id_rs2 = gpr_0;
      4'b0001 : _zz_id_rs2 = gpr_1;
      4'b0010 : _zz_id_rs2 = gpr_2;
      4'b0011 : _zz_id_rs2 = gpr_3;
      4'b0100 : _zz_id_rs2 = gpr_4;
      4'b0101 : _zz_id_rs2 = gpr_5;
      4'b0110 : _zz_id_rs2 = gpr_6;
      4'b0111 : _zz_id_rs2 = gpr_7;
      4'b1000 : _zz_id_rs2 = gpr_8;
      4'b1001 : _zz_id_rs2 = gpr_9;
      4'b1010 : _zz_id_rs2 = gpr_10;
      4'b1011 : _zz_id_rs2 = gpr_11;
      4'b1100 : _zz_id_rs2 = gpr_12;
      4'b1101 : _zz_id_rs2 = gpr_13;
      4'b1110 : _zz_id_rs2 = gpr_14;
      default : _zz_id_rs2 = gpr_15;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(pip_ctrl_4_down_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_4_down_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_4_down_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_4_down_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_4_down_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_4_down_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_4_down_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_4_down_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_4_down_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_4_down_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_4_down_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_4_down_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_4_down_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_4_down_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_4_down_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_4_down_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_4_down_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_4_down_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_4_down_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_4_down_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_4_down_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_4_down_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_4_down_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_4_down_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_4_down_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_4_down_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_4_down_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_4_down_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_4_down_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_4_down_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_4_down_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_4_down_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_4_down_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_4_down_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_4_down_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_4_down_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_4_down_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_4_down_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_4_down_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_4_down_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_4_down_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_4_down_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_4_down_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_4_down_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_5_up_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_5_up_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_5_up_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_5_up_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_5_up_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_5_up_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_5_up_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_5_up_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_5_up_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_5_up_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_5_up_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_5_up_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_5_up_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_5_up_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_5_up_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_5_up_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_5_up_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_5_up_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_5_up_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_5_up_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_5_up_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_5_up_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_5_up_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_5_up_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_5_up_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_5_up_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_5_up_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_5_up_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_5_up_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_5_up_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_5_up_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_5_up_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_5_up_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_5_up_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_5_up_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_5_up_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_5_up_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_5_up_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_5_up_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_5_up_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_5_up_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_5_up_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_5_up_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_5_up_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_4_up_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_4_up_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_4_up_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_4_up_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_4_up_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_4_up_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_4_up_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_4_up_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_4_up_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_4_up_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_4_up_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_4_up_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_4_up_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_4_up_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_4_up_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_4_up_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_4_up_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_4_up_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_4_up_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_4_up_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_4_up_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_4_up_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_4_up_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_4_up_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_4_up_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_4_up_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_4_up_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_4_up_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_4_up_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_4_up_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_4_up_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_4_up_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_4_up_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_4_up_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_4_up_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_4_up_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_4_up_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_4_up_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_4_up_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_4_up_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_4_up_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_4_up_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_4_up_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_4_up_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_3_up_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_3_up_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_3_up_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_3_up_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_3_up_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_3_up_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_3_up_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_3_up_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_3_up_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_3_up_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_3_up_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_3_up_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_3_up_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_3_up_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_3_up_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_3_up_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_3_up_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_3_up_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_3_up_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_3_up_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_3_up_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_3_up_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_3_up_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_3_up_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_3_up_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_3_up_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_3_up_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_3_up_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_3_up_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_3_up_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_3_up_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_3_up_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_3_up_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_3_up_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_3_up_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_3_up_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_3_up_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_3_up_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_3_up_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_3_up_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_3_up_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_3_up_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_3_up_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_3_up_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_5_down_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_5_down_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_5_down_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_5_down_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_5_down_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_5_down_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_5_down_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_5_down_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_5_down_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_5_down_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_5_down_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_5_down_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_5_down_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_5_down_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_5_down_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_5_down_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_5_down_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_5_down_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_5_down_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_5_down_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_5_down_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_5_down_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_5_down_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_5_down_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_5_down_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_5_down_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_5_down_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_5_down_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_5_down_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_5_down_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_5_down_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_5_down_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_5_down_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_5_down_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_5_down_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_5_down_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_5_down_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_5_down_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_5_down_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_5_down_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_5_down_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_5_down_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_5_down_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_5_down_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_3_down_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_3_down_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_3_down_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_3_down_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_3_down_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_3_down_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_3_down_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_3_down_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_3_down_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_3_down_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_3_down_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_3_down_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_3_down_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_3_down_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_3_down_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_3_down_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_3_down_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_3_down_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_3_down_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_3_down_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_3_down_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_3_down_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_3_down_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_3_down_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_3_down_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_3_down_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_3_down_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_3_down_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_3_down_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_3_down_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_3_down_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_3_down_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_3_down_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_3_down_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_3_down_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_3_down_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_3_down_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_3_down_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_3_down_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_3_down_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_3_down_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_3_down_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_3_down_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_3_down_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(pip_ctrl_2_down_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : pip_ctrl_2_down_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : pip_ctrl_2_down_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : pip_ctrl_2_down_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : pip_ctrl_2_down_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : pip_ctrl_2_down_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : pip_ctrl_2_down_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : pip_ctrl_2_down_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : pip_ctrl_2_down_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : pip_ctrl_2_down_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : pip_ctrl_2_down_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : pip_ctrl_2_down_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : pip_ctrl_2_down_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : pip_ctrl_2_down_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : pip_ctrl_2_down_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : pip_ctrl_2_down_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : pip_ctrl_2_down_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : pip_ctrl_2_down_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : pip_ctrl_2_down_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : pip_ctrl_2_down_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : pip_ctrl_2_down_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : pip_ctrl_2_down_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : pip_ctrl_2_down_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : pip_ctrl_2_down_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : pip_ctrl_2_down_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : pip_ctrl_2_down_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : pip_ctrl_2_down_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : pip_ctrl_2_down_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : pip_ctrl_2_down_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : pip_ctrl_2_down_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : pip_ctrl_2_down_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : pip_ctrl_2_down_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : pip_ctrl_2_down_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : pip_ctrl_2_down_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : pip_ctrl_2_down_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : pip_ctrl_2_down_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : pip_ctrl_2_down_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : pip_ctrl_2_down_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : pip_ctrl_2_down_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : pip_ctrl_2_down_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : pip_ctrl_2_down_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : pip_ctrl_2_down_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : pip_ctrl_2_down_IDtoEX_fun_string = "CSRRCI";
      default : pip_ctrl_2_down_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_1)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_2)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_3)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_3_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_4)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_4_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_5)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_5_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_6)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_6_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_7)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_7_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_8)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_8_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_9)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_9_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_10)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_10_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_11)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_11_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_12)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_12_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_13)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_13_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_14)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_14_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_15)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_15_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_16)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_16_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_17)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_17_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_18)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_18_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_19)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_19_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_20)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_20_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_21)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_21_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_22)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_22_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_23)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_23_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_24)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_24_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_25)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_25_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_26)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_26_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_27)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_27_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_28)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_28_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_29)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_29_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_30)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_30_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_31)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_31_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_32)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_32_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_33)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_33_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_34)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_34_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_35)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_35_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_36)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_36_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_37)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_37_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_38)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_38_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_39)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_39_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_40)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_40_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_41)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_41_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_42)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_42_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_43)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_43_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_44)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_44_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_45)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_45_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_46)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_46_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_pip_ctrl_2_down_IDtoEX_fun_47)
      ysyx_26010010_RVCode_ADD : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "ADD   ";
      ysyx_26010010_RVCode_SUB : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SUB   ";
      ysyx_26010010_RVCode_AND_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "AND_1 ";
      ysyx_26010010_RVCode_OR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "OR_1  ";
      ysyx_26010010_RVCode_XOR_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "XOR_1 ";
      ysyx_26010010_RVCode_SLL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLL_1 ";
      ysyx_26010010_RVCode_SRL_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SRL_1 ";
      ysyx_26010010_RVCode_SRA_1 : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SRA_1 ";
      ysyx_26010010_RVCode_SLT : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLT   ";
      ysyx_26010010_RVCode_SLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLTU  ";
      ysyx_26010010_RVCode_ADDI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "ADDI  ";
      ysyx_26010010_RVCode_XORI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "XORI  ";
      ysyx_26010010_RVCode_ORI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "ORI   ";
      ysyx_26010010_RVCode_ANDI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "ANDI  ";
      ysyx_26010010_RVCode_SLLI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLLI  ";
      ysyx_26010010_RVCode_SRLI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SRLI  ";
      ysyx_26010010_RVCode_SRAI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SRAI  ";
      ysyx_26010010_RVCode_SLTI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLTI  ";
      ysyx_26010010_RVCode_SLTIU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SLTIU ";
      ysyx_26010010_RVCode_LB : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LB    ";
      ysyx_26010010_RVCode_LH : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LH    ";
      ysyx_26010010_RVCode_LW : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LW    ";
      ysyx_26010010_RVCode_LBU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LBU   ";
      ysyx_26010010_RVCode_LHU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LHU   ";
      ysyx_26010010_RVCode_JALR : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "JALR  ";
      ysyx_26010010_RVCode_ECALL : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "ECALL ";
      ysyx_26010010_RVCode_EBREAK : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "EBREAK";
      ysyx_26010010_RVCode_MRET : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "MRET  ";
      ysyx_26010010_RVCode_FENCEI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "FENCEI";
      ysyx_26010010_RVCode_SW : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SW    ";
      ysyx_26010010_RVCode_SH : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SH    ";
      ysyx_26010010_RVCode_SB : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "SB    ";
      ysyx_26010010_RVCode_BEQ : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BEQ   ";
      ysyx_26010010_RVCode_BNE : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BNE   ";
      ysyx_26010010_RVCode_BLT : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BLT   ";
      ysyx_26010010_RVCode_BGE : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BGE   ";
      ysyx_26010010_RVCode_BLTU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BLTU  ";
      ysyx_26010010_RVCode_BGEU : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "BGEU  ";
      ysyx_26010010_RVCode_LUI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "LUI   ";
      ysyx_26010010_RVCode_AUIPC : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "AUIPC ";
      ysyx_26010010_RVCode_JAL : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "JAL   ";
      ysyx_26010010_RVCode_CSRRW : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRW ";
      ysyx_26010010_RVCode_CSRRS : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRS ";
      ysyx_26010010_RVCode_CSRRC : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRC ";
      ysyx_26010010_RVCode_CSRRWI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRWI";
      ysyx_26010010_RVCode_CSRRSI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRSI";
      ysyx_26010010_RVCode_CSRRCI : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "CSRRCI";
      default : _zz_pip_ctrl_2_down_IDtoEX_fun_47_string = "??????";
    endcase
  end
  always @(*) begin
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_BOOT : MEM_MEMt_w_stateReg_string = "BOOT ";
      ysyx_26010010_MEM_MEMt_w_start : MEM_MEMt_w_stateReg_string = "start";
      ysyx_26010010_MEM_MEMt_w_w : MEM_MEMt_w_stateReg_string = "w    ";
      ysyx_26010010_MEM_MEMt_w_b : MEM_MEMt_w_stateReg_string = "b    ";
      default : MEM_MEMt_w_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(MEM_MEMt_w_stateNext)
      ysyx_26010010_MEM_MEMt_w_BOOT : MEM_MEMt_w_stateNext_string = "BOOT ";
      ysyx_26010010_MEM_MEMt_w_start : MEM_MEMt_w_stateNext_string = "start";
      ysyx_26010010_MEM_MEMt_w_w : MEM_MEMt_w_stateNext_string = "w    ";
      ysyx_26010010_MEM_MEMt_w_b : MEM_MEMt_w_stateNext_string = "b    ";
      default : MEM_MEMt_w_stateNext_string = "?????";
    endcase
  end
  always @(*) begin
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_BOOT : MEM_MEMt_r_stateReg_string = "BOOT ";
      ysyx_26010010_MEM_MEMt_r_start : MEM_MEMt_r_stateReg_string = "start";
      ysyx_26010010_MEM_MEMt_r_ar : MEM_MEMt_r_stateReg_string = "ar   ";
      ysyx_26010010_MEM_MEMt_r_r : MEM_MEMt_r_stateReg_string = "r    ";
      ysyx_26010010_MEM_MEMt_r_delay : MEM_MEMt_r_stateReg_string = "delay";
      default : MEM_MEMt_r_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(MEM_MEMt_r_stateNext)
      ysyx_26010010_MEM_MEMt_r_BOOT : MEM_MEMt_r_stateNext_string = "BOOT ";
      ysyx_26010010_MEM_MEMt_r_start : MEM_MEMt_r_stateNext_string = "start";
      ysyx_26010010_MEM_MEMt_r_ar : MEM_MEMt_r_stateNext_string = "ar   ";
      ysyx_26010010_MEM_MEMt_r_r : MEM_MEMt_r_stateNext_string = "r    ";
      ysyx_26010010_MEM_MEMt_r_delay : MEM_MEMt_r_stateNext_string = "delay";
      default : MEM_MEMt_r_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    _zz_pip_ctrl_1_haltRequest_pipCPU_l768 = 1'b0;
    if(when_pipCPU_l767) begin
      _zz_pip_ctrl_1_haltRequest_pipCPU_l768 = 1'b1;
    end
  end

  assign pip_ctrl_5_down_CODE = pip_ctrl_5_CODE_bypass;
  always @(*) begin
    pip_ctrl_5_CODE_bypass = pip_ctrl_5_up_CODE;
    if(pip_ctrl_3_up_isFiring) begin
      pip_ctrl_5_CODE_bypass = pip_ctrl_3_down_CODE;
    end
  end

  assign pip_ctrl_5_down_PC = pip_ctrl_5_PC_bypass;
  always @(*) begin
    pip_ctrl_5_PC_bypass = pip_ctrl_5_up_PC;
    if(pip_ctrl_3_up_isFiring) begin
      pip_ctrl_5_PC_bypass = pip_ctrl_3_down_PC;
    end
  end

  assign pip_ctrl_5_down_RD_valid = pip_ctrl_5_RD_valid_bypass;
  always @(*) begin
    pip_ctrl_5_RD_valid_bypass = pip_ctrl_5_up_RD_valid;
    if(pip_ctrl_3_up_isFiring) begin
      pip_ctrl_5_RD_valid_bypass = pip_ctrl_3_down_RD_valid;
    end
  end

  assign pip_ctrl_5_down_RD_sel = pip_ctrl_5_RD_sel_bypass;
  always @(*) begin
    pip_ctrl_5_RD_sel_bypass = pip_ctrl_5_up_RD_sel;
    if(pip_ctrl_3_up_isFiring) begin
      pip_ctrl_5_RD_sel_bypass = pip_ctrl_3_down_RD_sel;
    end
  end

  assign pip_ctrl_5_down_RD = pip_ctrl_5_RD_bypass;
  always @(*) begin
    pip_ctrl_5_RD_bypass = pip_ctrl_5_up_RD;
    if(pip_ctrl_3_up_isFiring) begin
      pip_ctrl_5_RD_bypass = pip_ctrl_3_down_RD;
    end
  end

  always @(*) begin
    _zz_pip_ctrl_2_haltRequest_pipCPU_l744 = 1'b0;
    if(when_pipCPU_l743) begin
      _zz_pip_ctrl_2_haltRequest_pipCPU_l744 = 1'b1;
    end
  end

  always @(*) begin
    _zz_pip_ctrl_4_throwWhen_pipCPU_l729 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_MRET : begin
          _zz_pip_ctrl_4_throwWhen_pipCPU_l729 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_3_throwWhen_pipCPU_l728 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_MRET : begin
          _zz_pip_ctrl_3_throwWhen_pipCPU_l728 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_2_throwWhen_pipCPU_l727 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_MRET : begin
          _zz_pip_ctrl_2_throwWhen_pipCPU_l727 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_4_throwWhen_pipCPU_l719 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          _zz_pip_ctrl_4_throwWhen_pipCPU_l719 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_3_throwWhen_pipCPU_l718 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          _zz_pip_ctrl_3_throwWhen_pipCPU_l718 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_2_throwWhen_pipCPU_l717 = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          _zz_pip_ctrl_2_throwWhen_pipCPU_l717 = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_pip_ctrl_4_haltRequest_pipCPU_l372 = 1'b0;
    if(when_pipCPU_l372) begin
      _zz_pip_ctrl_4_haltRequest_pipCPU_l372 = 1'b1;
    end
  end

  always @(*) begin
    _zz_pip_ctrl_4_haltRequest_pipCPU_l371 = 1'b0;
    if(when_pipCPU_l371) begin
      _zz_pip_ctrl_4_haltRequest_pipCPU_l371 = 1'b1;
    end
  end

  always @(*) begin
    _zz_pip_ctrl_4_haltRequest_pipCPU_l370 = 1'b0;
    if(when_pipCPU_l370) begin
      _zz_pip_ctrl_4_haltRequest_pipCPU_l370 = 1'b1;
    end
  end

  assign gpr_0 = 32'h0;
  assign gpr_1 = gpr_reg_0;
  assign gpr_2 = gpr_reg_1;
  assign gpr_3 = gpr_reg_2;
  assign gpr_4 = gpr_reg_3;
  assign gpr_5 = gpr_reg_4;
  assign gpr_6 = gpr_reg_5;
  assign gpr_7 = gpr_reg_6;
  assign gpr_8 = gpr_reg_7;
  assign gpr_9 = gpr_reg_8;
  assign gpr_10 = gpr_reg_9;
  assign gpr_11 = gpr_reg_10;
  assign gpr_12 = gpr_reg_11;
  assign gpr_13 = gpr_reg_12;
  assign gpr_14 = gpr_reg_13;
  assign gpr_15 = gpr_reg_14;
  assign axi_if_aw_valid = IF_axi_if_axi_aw_valid;
  assign axi_if_aw_payload_addr = IF_axi_if_axi_aw_payload_addr;
  assign axi_if_aw_payload_id = IF_axi_if_axi_aw_payload_id;
  assign axi_if_aw_payload_len = IF_axi_if_axi_aw_payload_len;
  assign axi_if_aw_payload_size = IF_axi_if_axi_aw_payload_size;
  assign axi_if_aw_payload_burst = IF_axi_if_axi_aw_payload_burst;
  assign axi_if_w_valid = IF_axi_if_axi_w_valid;
  assign axi_if_w_payload_data = IF_axi_if_axi_w_payload_data;
  assign axi_if_w_payload_strb = IF_axi_if_axi_w_payload_strb;
  assign axi_if_w_payload_last = IF_axi_if_axi_w_payload_last;
  assign axi_if_b_ready = IF_axi_if_axi_b_ready;
  assign axi_if_ar_valid = IF_axi_if_axi_ar_valid;
  assign axi_if_ar_payload_addr = IF_axi_if_axi_ar_payload_addr;
  assign axi_if_ar_payload_id = IF_axi_if_axi_ar_payload_id;
  assign axi_if_ar_payload_len = IF_axi_if_axi_ar_payload_len;
  assign axi_if_ar_payload_size = IF_axi_if_axi_ar_payload_size;
  assign axi_if_ar_payload_burst = IF_axi_if_axi_ar_payload_burst;
  assign axi_if_r_ready = IF_axi_if_axi_r_ready;
  assign IF_code_valid = IF_axi_if_code_valid;
  assign IF_code_payload = IF_axi_if_code_payload;
  assign pip_ctrl_1_up_valid = 1'b1;
  assign when_pipCPU_l29 = (pip_ctrl_1_down_isFiring && IF_code_valid);
  assign IF_addr = IF_IFt_pc;
  assign IF_code_ready = 1'b1;
  assign pip_ctrl_1_down_CODE = IF_code_payload;
  assign pip_ctrl_1_down_PC = IF_IFt_pc;
  assign ID_IDt_rs1_t = pip_ctrl_2_down_CODE[19 : 15];
  assign ID_IDt_rs2_t = pip_ctrl_2_down_CODE[24 : 20];
  assign ID_IDt_rd_t = pip_ctrl_2_down_CODE[11 : 7];
  assign ID_IDt_imm_I = {{20{_zz_ID_IDt_imm_I[11]}}, _zz_ID_IDt_imm_I};
  assign ID_IDt_imm_U = {pip_ctrl_2_down_CODE[31 : 12],12'h0};
  assign ID_IDt_imm_S = {{20{_zz_ID_IDt_imm_S[11]}}, _zz_ID_IDt_imm_S};
  assign ID_IDt_imm_B = {{19{_zz_ID_IDt_imm_B[12]}}, _zz_ID_IDt_imm_B};
  assign ID_IDt_imm_J = {{11{_zz_ID_IDt_imm_J[20]}}, _zz_ID_IDt_imm_J};
  assign _zz_pip_ctrl_2_down_IDtoEX_fun = 6'h0;
  always @(*) begin
    pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_1;
        end
        32'b0100000??????????000?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_2;
        end
        32'b0000000??????????111?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_3;
        end
        32'b0000000??????????110?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_4;
        end
        32'b0000000??????????100?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_5;
        end
        32'b0000000??????????001?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_6;
        end
        32'b0000000??????????101?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_7;
        end
        32'b0100000??????????101?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_8;
        end
        32'b0000000??????????010?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_9;
        end
        32'b0000000??????????011?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_10;
        end
        32'b?????????????????000?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_11;
        end
        32'b?????????????????100?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_12;
        end
        32'b?????????????????110?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_13;
        end
        32'b?????????????????111?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_14;
        end
        32'b0000000??????????001?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_15;
        end
        32'b0000000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_16;
        end
        32'b0100000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_17;
        end
        32'b?????????????????010?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_18;
        end
        32'b?????????????????011?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_19;
        end
        32'b?????????????????000?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_20;
        end
        32'b?????????????????001?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_21;
        end
        32'b?????????????????010?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_22;
        end
        32'b?????????????????100?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_23;
        end
        32'b?????????????????101?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_24;
        end
        32'b?????????????????000?????1100111 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_25;
        end
        32'h30200073 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_26;
        end
        32'h0000100f : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_27;
        end
        32'h00100073 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_28;
        end
        32'h00000073 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_29;
        end
        32'b?????????????????010?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_30;
        end
        32'b?????????????????001?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_31;
        end
        32'b?????????????????000?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_32;
        end
        32'b?????????????????000?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_33;
        end
        32'b?????????????????001?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_34;
        end
        32'b?????????????????100?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_35;
        end
        32'b?????????????????101?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_36;
        end
        32'b?????????????????110?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_37;
        end
        32'b?????????????????111?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_38;
        end
        32'b?????????????????????????0110111 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_39;
        end
        32'b?????????????????????????0010111 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_40;
        end
        32'b?????????????????????????1101111 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_41;
        end
        32'b?????????????????001?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_42;
        end
        32'b?????????????????010?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_43;
        end
        32'b?????????????????011?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_44;
        end
        32'b?????????????????101?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_45;
        end
        32'b?????????????????110?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_46;
        end
        32'b?????????????????111?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_fun = _zz_pip_ctrl_2_down_IDtoEX_fun_47;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_2_down_IDtoEX_imm = 32'h0;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
        end
        32'b0100000??????????000?????0110011 : begin
        end
        32'b0000000??????????111?????0110011 : begin
        end
        32'b0000000??????????110?????0110011 : begin
        end
        32'b0000000??????????100?????0110011 : begin
        end
        32'b0000000??????????001?????0110011 : begin
        end
        32'b0000000??????????101?????0110011 : begin
        end
        32'b0100000??????????101?????0110011 : begin
        end
        32'b0000000??????????010?????0110011 : begin
        end
        32'b0000000??????????011?????0110011 : begin
        end
        32'b?????????????????000?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????100?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????110?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????111?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b0000000??????????001?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b0000000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b0100000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????010?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????011?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????000?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????001?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????010?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????100?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????101?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????000?????1100111 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'h30200073 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'h0000100f : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'h00100073 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'h00000073 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????010?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_S;
        end
        32'b?????????????????001?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_S;
        end
        32'b?????????????????000?????0100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_S;
        end
        32'b?????????????????000?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????001?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????100?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????101?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????110?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????111?????1100011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_B;
        end
        32'b?????????????????????????0110111 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_U;
        end
        32'b?????????????????????????0010111 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_U;
        end
        32'b?????????????????????????1101111 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_J;
        end
        32'b?????????????????001?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????010?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????011?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????101?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????110?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        32'b?????????????????111?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_imm = ID_IDt_imm_I;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_2_down_IDtoEX_rd_sel = 5'h0;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0100000??????????000?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????111?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????110?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????100?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????001?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????101?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0100000??????????101?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????010?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????011?????0110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????000?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????100?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????110?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????111?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????001?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0000000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b0100000??????????101?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????010?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????011?????0010011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????000?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????001?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????010?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????100?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????101?????0000011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????000?????1100111 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'h30200073 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'h0000100f : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'h00100073 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'h00000073 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????010?????0100011 : begin
        end
        32'b?????????????????001?????0100011 : begin
        end
        32'b?????????????????000?????0100011 : begin
        end
        32'b?????????????????000?????1100011 : begin
        end
        32'b?????????????????001?????1100011 : begin
        end
        32'b?????????????????100?????1100011 : begin
        end
        32'b?????????????????101?????1100011 : begin
        end
        32'b?????????????????110?????1100011 : begin
        end
        32'b?????????????????111?????1100011 : begin
        end
        32'b?????????????????????????0110111 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????????????0010111 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????????????1101111 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????001?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????010?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????011?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????101?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????110?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        32'b?????????????????111?????1110011 : begin
          pip_ctrl_2_down_IDtoEX_rd_sel = ID_IDt_rd_t;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    id_rs1_sel = 5'h0;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0100000??????????000?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????111?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????110?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????100?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????001?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????101?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0100000??????????101?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????010?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????011?????0110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????000?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????100?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????110?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????111?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????001?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0000000??????????101?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b0100000??????????101?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????010?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????011?????0010011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????000?????0000011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????001?????0000011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????010?????0000011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????100?????0000011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????101?????0000011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????000?????1100111 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'h30200073 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'h0000100f : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'h00100073 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'h00000073 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????010?????0100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????001?????0100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????000?????0100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????000?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????001?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????100?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????101?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????110?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????111?????1100011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????????????0110111 : begin
        end
        32'b?????????????????????????0010111 : begin
        end
        32'b?????????????????????????1101111 : begin
        end
        32'b?????????????????001?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????010?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????011?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????101?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????110?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        32'b?????????????????111?????1110011 : begin
          id_rs1_sel = ID_IDt_rs1_t;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    id_rs2_sel = 5'h0;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0100000??????????000?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????111?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????110?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????100?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????001?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????101?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0100000??????????101?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????010?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b0000000??????????011?????0110011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????000?????0010011 : begin
        end
        32'b?????????????????100?????0010011 : begin
        end
        32'b?????????????????110?????0010011 : begin
        end
        32'b?????????????????111?????0010011 : begin
        end
        32'b0000000??????????001?????0010011 : begin
        end
        32'b0000000??????????101?????0010011 : begin
        end
        32'b0100000??????????101?????0010011 : begin
        end
        32'b?????????????????010?????0010011 : begin
        end
        32'b?????????????????011?????0010011 : begin
        end
        32'b?????????????????000?????0000011 : begin
        end
        32'b?????????????????001?????0000011 : begin
        end
        32'b?????????????????010?????0000011 : begin
        end
        32'b?????????????????100?????0000011 : begin
        end
        32'b?????????????????101?????0000011 : begin
        end
        32'b?????????????????000?????1100111 : begin
        end
        32'h30200073 : begin
        end
        32'h0000100f : begin
        end
        32'h00100073 : begin
        end
        32'h00000073 : begin
        end
        32'b?????????????????010?????0100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????001?????0100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????000?????0100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????000?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????001?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????100?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????101?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????110?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????111?????1100011 : begin
          id_rs2_sel = ID_IDt_rs2_t;
        end
        32'b?????????????????????????0110111 : begin
        end
        32'b?????????????????????????0010111 : begin
        end
        32'b?????????????????????????1101111 : begin
        end
        32'b?????????????????001?????1110011 : begin
        end
        32'b?????????????????010?????1110011 : begin
        end
        32'b?????????????????011?????1110011 : begin
        end
        32'b?????????????????101?????1110011 : begin
        end
        32'b?????????????????110?????1110011 : begin
        end
        32'b?????????????????111?????1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    ID_IDt_error_flag = 1'b0;
    if(pip_ctrl_2_up_isFiring) begin
      casez(pip_ctrl_2_down_CODE)
        32'b0000000??????????000?????0110011 : begin
        end
        32'b0100000??????????000?????0110011 : begin
        end
        32'b0000000??????????111?????0110011 : begin
        end
        32'b0000000??????????110?????0110011 : begin
        end
        32'b0000000??????????100?????0110011 : begin
        end
        32'b0000000??????????001?????0110011 : begin
        end
        32'b0000000??????????101?????0110011 : begin
        end
        32'b0100000??????????101?????0110011 : begin
        end
        32'b0000000??????????010?????0110011 : begin
        end
        32'b0000000??????????011?????0110011 : begin
        end
        32'b?????????????????000?????0010011 : begin
        end
        32'b?????????????????100?????0010011 : begin
        end
        32'b?????????????????110?????0010011 : begin
        end
        32'b?????????????????111?????0010011 : begin
        end
        32'b0000000??????????001?????0010011 : begin
        end
        32'b0000000??????????101?????0010011 : begin
        end
        32'b0100000??????????101?????0010011 : begin
        end
        32'b?????????????????010?????0010011 : begin
        end
        32'b?????????????????011?????0010011 : begin
        end
        32'b?????????????????000?????0000011 : begin
        end
        32'b?????????????????001?????0000011 : begin
        end
        32'b?????????????????010?????0000011 : begin
        end
        32'b?????????????????100?????0000011 : begin
        end
        32'b?????????????????101?????0000011 : begin
        end
        32'b?????????????????000?????1100111 : begin
        end
        32'h30200073 : begin
        end
        32'h0000100f : begin
        end
        32'h00100073 : begin
        end
        32'h00000073 : begin
        end
        32'b?????????????????010?????0100011 : begin
        end
        32'b?????????????????001?????0100011 : begin
        end
        32'b?????????????????000?????0100011 : begin
        end
        32'b?????????????????000?????1100011 : begin
        end
        32'b?????????????????001?????1100011 : begin
        end
        32'b?????????????????100?????1100011 : begin
        end
        32'b?????????????????101?????1100011 : begin
        end
        32'b?????????????????110?????1100011 : begin
        end
        32'b?????????????????111?????1100011 : begin
        end
        32'b?????????????????????????0110111 : begin
        end
        32'b?????????????????????????0010111 : begin
        end
        32'b?????????????????????????1101111 : begin
        end
        32'b?????????????????001?????1110011 : begin
        end
        32'b?????????????????010?????1110011 : begin
        end
        32'b?????????????????011?????1110011 : begin
        end
        32'b?????????????????101?????1110011 : begin
        end
        32'b?????????????????110?????1110011 : begin
        end
        32'b?????????????????111?????1110011 : begin
        end
        default : begin
          ID_IDt_error_flag = 1'b1;
        end
      endcase
    end
  end

  assign _zz_pip_ctrl_2_down_IDtoEX_fun_1 = ysyx_26010010_RVCode_ADD;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_2 = ysyx_26010010_RVCode_SUB;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_3 = ysyx_26010010_RVCode_AND_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_4 = ysyx_26010010_RVCode_OR_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_5 = ysyx_26010010_RVCode_XOR_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_6 = ysyx_26010010_RVCode_SLL_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_7 = ysyx_26010010_RVCode_SRL_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_8 = ysyx_26010010_RVCode_SRA_1;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_9 = ysyx_26010010_RVCode_SLT;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_10 = ysyx_26010010_RVCode_SLTU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_11 = ysyx_26010010_RVCode_ADDI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_12 = ysyx_26010010_RVCode_XORI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_13 = ysyx_26010010_RVCode_ORI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_14 = ysyx_26010010_RVCode_ANDI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_15 = ysyx_26010010_RVCode_SLLI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_16 = ysyx_26010010_RVCode_SRLI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_17 = ysyx_26010010_RVCode_SRAI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_18 = ysyx_26010010_RVCode_SLTI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_19 = ysyx_26010010_RVCode_SLTIU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_20 = ysyx_26010010_RVCode_LB;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_21 = ysyx_26010010_RVCode_LH;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_22 = ysyx_26010010_RVCode_LW;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_23 = ysyx_26010010_RVCode_LBU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_24 = ysyx_26010010_RVCode_LHU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_25 = ysyx_26010010_RVCode_JALR;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_26 = ysyx_26010010_RVCode_MRET;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_27 = ysyx_26010010_RVCode_FENCEI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_28 = ysyx_26010010_RVCode_EBREAK;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_29 = ysyx_26010010_RVCode_ECALL;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_30 = ysyx_26010010_RVCode_SW;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_31 = ysyx_26010010_RVCode_SH;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_32 = ysyx_26010010_RVCode_SB;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_33 = ysyx_26010010_RVCode_BEQ;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_34 = ysyx_26010010_RVCode_BNE;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_35 = ysyx_26010010_RVCode_BLT;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_36 = ysyx_26010010_RVCode_BGE;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_37 = ysyx_26010010_RVCode_BLTU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_38 = ysyx_26010010_RVCode_BGEU;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_39 = ysyx_26010010_RVCode_LUI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_40 = ysyx_26010010_RVCode_AUIPC;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_41 = ysyx_26010010_RVCode_JAL;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_42 = ysyx_26010010_RVCode_CSRRW;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_43 = ysyx_26010010_RVCode_CSRRS;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_44 = ysyx_26010010_RVCode_CSRRC;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_45 = ysyx_26010010_RVCode_CSRRWI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_46 = ysyx_26010010_RVCode_CSRRSI;
  assign _zz_pip_ctrl_2_down_IDtoEX_fun_47 = ysyx_26010010_RVCode_CSRRCI;
  assign pip_ctrl_2_down_IDtoEX_rs1 = id_rs1;
  assign pip_ctrl_2_down_IDtoEX_rs2 = id_rs2;
  assign pip_ctrl_2_down_CSR_rs1_imm = pip_ctrl_2_down_CODE[19 : 15];
  always @(*) begin
    pip_ctrl_3_down_MEM_addr = 32'h0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_LH : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_LW : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_LBU : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_LHU : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_SW : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_SH : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_SB : begin
          pip_ctrl_3_down_MEM_addr = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_3_down_MEM_read_valid = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
          pip_ctrl_3_down_MEM_read_valid = 1'b1;
        end
        ysyx_26010010_RVCode_LH : begin
          pip_ctrl_3_down_MEM_read_valid = 1'b1;
        end
        ysyx_26010010_RVCode_LW : begin
          pip_ctrl_3_down_MEM_read_valid = 1'b1;
        end
        ysyx_26010010_RVCode_LBU : begin
          pip_ctrl_3_down_MEM_read_valid = 1'b1;
        end
        ysyx_26010010_RVCode_LHU : begin
          pip_ctrl_3_down_MEM_read_valid = 1'b1;
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_3_down_MEM_write_valid = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
          pip_ctrl_3_down_MEM_write_valid = 1'b1;
        end
        ysyx_26010010_RVCode_SH : begin
          pip_ctrl_3_down_MEM_write_valid = 1'b1;
        end
        ysyx_26010010_RVCode_SB : begin
          pip_ctrl_3_down_MEM_write_valid = 1'b1;
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_3_down_MEM_mask = 4'b0000;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
          pip_ctrl_3_down_MEM_mask = 4'b0001;
        end
        ysyx_26010010_RVCode_LH : begin
          pip_ctrl_3_down_MEM_mask = 4'b0011;
        end
        ysyx_26010010_RVCode_LW : begin
          pip_ctrl_3_down_MEM_mask = 4'b1111;
        end
        ysyx_26010010_RVCode_LBU : begin
          pip_ctrl_3_down_MEM_mask = 4'b0001;
        end
        ysyx_26010010_RVCode_LHU : begin
          pip_ctrl_3_down_MEM_mask = 4'b0011;
        end
        ysyx_26010010_RVCode_SW : begin
          pip_ctrl_3_down_MEM_mask = 4'b1111;
        end
        ysyx_26010010_RVCode_SH : begin
          pip_ctrl_3_down_MEM_mask = 4'b0011;
        end
        ysyx_26010010_RVCode_SB : begin
          pip_ctrl_3_down_MEM_mask = 4'b0001;
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_3_down_MEM_unsigned = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
          pip_ctrl_3_down_MEM_unsigned = 1'b1;
        end
        ysyx_26010010_RVCode_LHU : begin
          pip_ctrl_3_down_MEM_unsigned = 1'b1;
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  assign pip_ctrl_3_down_CSR_sel = pip_ctrl_3_down_IDtoEX_imm[11 : 0];
  always @(*) begin
    pip_ctrl_3_down_CSR_valid = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_MRET : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_CSRRW : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_CSRRS : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_CSRRC : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_CSRRWI : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        ysyx_26010010_RVCode_CSRRSI : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
        default : begin
          pip_ctrl_3_down_CSR_valid = 1'b1;
        end
      endcase
    end
  end

  assign pip_ctrl_3_down_RD_sel = pip_ctrl_3_down_IDtoEX_rd_sel;
  always @(*) begin
    pip_ctrl_3_down_RD = 32'h0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD;
        end
        ysyx_26010010_RVCode_SUB : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_3;
        end
        ysyx_26010010_RVCode_AND_1 : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 & pip_ctrl_3_down_IDtoEX_rs2);
        end
        ysyx_26010010_RVCode_OR_1 : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 | pip_ctrl_3_down_IDtoEX_rs2);
        end
        ysyx_26010010_RVCode_XOR_1 : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 ^ pip_ctrl_3_down_IDtoEX_rs2);
        end
        ysyx_26010010_RVCode_SLL_1 : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_6[31:0];
        end
        ysyx_26010010_RVCode_SRL_1 : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_9;
        end
        ysyx_26010010_RVCode_SRA_1 : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_11;
        end
        ysyx_26010010_RVCode_SLT : begin
          pip_ctrl_3_down_RD = {31'd0, _zz_pip_ctrl_3_down_RD_14};
        end
        ysyx_26010010_RVCode_SLTU : begin
          pip_ctrl_3_down_RD = {31'd0, _zz_pip_ctrl_3_down_RD_17};
        end
        ysyx_26010010_RVCode_ADDI : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_18;
        end
        ysyx_26010010_RVCode_XORI : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 ^ pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_ORI : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 | pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_ANDI : begin
          pip_ctrl_3_down_RD = (pip_ctrl_3_down_IDtoEX_rs1 & pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_SLLI : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_21[31:0];
        end
        ysyx_26010010_RVCode_SRLI : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_24;
        end
        ysyx_26010010_RVCode_SRAI : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_26;
        end
        ysyx_26010010_RVCode_SLTI : begin
          pip_ctrl_3_down_RD = {31'd0, _zz_pip_ctrl_3_down_RD_29};
        end
        ysyx_26010010_RVCode_SLTIU : begin
          pip_ctrl_3_down_RD = {31'd0, _zz_pip_ctrl_3_down_RD_32};
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
          pip_ctrl_3_down_RD = pip_ctrl_3_down_IDtoEX_rs2;
        end
        ysyx_26010010_RVCode_SH : begin
          pip_ctrl_3_down_RD = {16'd0, _zz_pip_ctrl_3_down_RD_33};
        end
        ysyx_26010010_RVCode_SB : begin
          pip_ctrl_3_down_RD = {24'd0, _zz_pip_ctrl_3_down_RD_34};
        end
        ysyx_26010010_RVCode_JALR : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_35;
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
          pip_ctrl_3_down_RD = pip_ctrl_3_down_IDtoEX_imm;
        end
        ysyx_26010010_RVCode_AUIPC : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_36;
        end
        ysyx_26010010_RVCode_JAL : begin
          pip_ctrl_3_down_RD = _zz_pip_ctrl_3_down_RD_37;
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    pip_ctrl_3_down_RD_valid = 1'b1;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_LH : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_LW : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_LBU : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_LHU : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_SW : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_SH : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_SB : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_BNE : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_BLT : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_BGE : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_BLTU : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_BGEU : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_ECALL : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_MRET : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_CSRRW : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_CSRRS : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_CSRRC : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_CSRRWI : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        ysyx_26010010_RVCode_CSRRSI : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
        default : begin
          pip_ctrl_3_down_RD_valid = 1'b0;
        end
      endcase
    end
    if(when_pipCPU_l318) begin
      pip_ctrl_3_down_RD_valid = 1'b0;
    end
  end

  always @(*) begin
    EX_EXt_nPC = 32'h0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
          EX_EXt_nPC = (pip_ctrl_3_down_IDtoEX_rs1 + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_BEQ : begin
          if(when_RVFun_l60) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_BNE : begin
          if(when_RVFun_l61) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_BLT : begin
          if(when_RVFun_l62) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_BGE : begin
          if(when_RVFun_l63) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_BLTU : begin
          if(when_RVFun_l64) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_BGEU : begin
          if(when_RVFun_l65) begin
            EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
          end
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
          EX_EXt_nPC = (pip_ctrl_3_down_PC + pip_ctrl_3_down_IDtoEX_imm);
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
          EX_EXt_nPC = (pip_ctrl_3_down_PC + 32'h00000004);
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    EX_EXt_nPC_valid = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
          EX_EXt_nPC_valid = 1'b1;
        end
        ysyx_26010010_RVCode_BEQ : begin
          if(when_RVFun_l60) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_BNE : begin
          if(when_RVFun_l61) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_BLT : begin
          if(when_RVFun_l62) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_BGE : begin
          if(when_RVFun_l63) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_BLTU : begin
          if(when_RVFun_l64) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_BGEU : begin
          if(when_RVFun_l65) begin
            EX_EXt_nPC_valid = 1'b1;
          end
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
          EX_EXt_nPC_valid = 1'b1;
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
          EX_EXt_nPC_valid = 1'b1;
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    EX_EXt_ebreak_ebreak_flag = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
          EX_EXt_ebreak_ebreak_flag = 1'b1;
        end
        ysyx_26010010_RVCode_FENCEI : begin
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    fence_i = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      case(pip_ctrl_3_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ADD : begin
        end
        ysyx_26010010_RVCode_SUB : begin
        end
        ysyx_26010010_RVCode_AND_1 : begin
        end
        ysyx_26010010_RVCode_OR_1 : begin
        end
        ysyx_26010010_RVCode_XOR_1 : begin
        end
        ysyx_26010010_RVCode_SLL_1 : begin
        end
        ysyx_26010010_RVCode_SRL_1 : begin
        end
        ysyx_26010010_RVCode_SRA_1 : begin
        end
        ysyx_26010010_RVCode_SLT : begin
        end
        ysyx_26010010_RVCode_SLTU : begin
        end
        ysyx_26010010_RVCode_ADDI : begin
        end
        ysyx_26010010_RVCode_XORI : begin
        end
        ysyx_26010010_RVCode_ORI : begin
        end
        ysyx_26010010_RVCode_ANDI : begin
        end
        ysyx_26010010_RVCode_SLLI : begin
        end
        ysyx_26010010_RVCode_SRLI : begin
        end
        ysyx_26010010_RVCode_SRAI : begin
        end
        ysyx_26010010_RVCode_SLTI : begin
        end
        ysyx_26010010_RVCode_SLTIU : begin
        end
        ysyx_26010010_RVCode_LB : begin
        end
        ysyx_26010010_RVCode_LH : begin
        end
        ysyx_26010010_RVCode_LW : begin
        end
        ysyx_26010010_RVCode_LBU : begin
        end
        ysyx_26010010_RVCode_LHU : begin
        end
        ysyx_26010010_RVCode_SW : begin
        end
        ysyx_26010010_RVCode_SH : begin
        end
        ysyx_26010010_RVCode_SB : begin
        end
        ysyx_26010010_RVCode_JALR : begin
        end
        ysyx_26010010_RVCode_BEQ : begin
        end
        ysyx_26010010_RVCode_BNE : begin
        end
        ysyx_26010010_RVCode_BLT : begin
        end
        ysyx_26010010_RVCode_BGE : begin
        end
        ysyx_26010010_RVCode_BLTU : begin
        end
        ysyx_26010010_RVCode_BGEU : begin
        end
        ysyx_26010010_RVCode_LUI : begin
        end
        ysyx_26010010_RVCode_AUIPC : begin
        end
        ysyx_26010010_RVCode_JAL : begin
        end
        ysyx_26010010_RVCode_EBREAK : begin
        end
        ysyx_26010010_RVCode_FENCEI : begin
          fence_i = 1'b1;
        end
        ysyx_26010010_RVCode_ECALL : begin
        end
        ysyx_26010010_RVCode_MRET : begin
        end
        ysyx_26010010_RVCode_CSRRW : begin
        end
        ysyx_26010010_RVCode_CSRRS : begin
        end
        ysyx_26010010_RVCode_CSRRC : begin
        end
        ysyx_26010010_RVCode_CSRRWI : begin
        end
        ysyx_26010010_RVCode_CSRRSI : begin
        end
        default : begin
        end
      endcase
    end
  end

  assign when_RVFun_l60 = (pip_ctrl_3_down_IDtoEX_rs1 == pip_ctrl_3_down_IDtoEX_rs2);
  assign when_RVFun_l61 = (pip_ctrl_3_down_IDtoEX_rs1 != pip_ctrl_3_down_IDtoEX_rs2);
  assign when_RVFun_l62 = ($signed(_zz_when_RVFun_l62) < $signed(_zz_when_RVFun_l62_1));
  assign when_RVFun_l63 = ($signed(_zz_when_RVFun_l63) <= $signed(_zz_when_RVFun_l63_1));
  assign when_RVFun_l64 = (pip_ctrl_3_down_IDtoEX_rs1 < pip_ctrl_3_down_IDtoEX_rs2);
  assign when_RVFun_l65 = (pip_ctrl_3_down_IDtoEX_rs2 <= pip_ctrl_3_down_IDtoEX_rs1);
  always @(*) begin
    EXtoIF_nPC = EX_EXt_nPC;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          EXtoIF_nPC = WB_csr_r_data;
        end
        ysyx_26010010_RVCode_MRET : begin
          EXtoIF_nPC = WB_csr_r_data;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    EXtoIF_valid = EX_EXt_nPC_valid;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          EXtoIF_valid = 1'b1;
        end
        ysyx_26010010_RVCode_MRET : begin
          EXtoIF_valid = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  assign when_pipCPU_l318 = (! pip_ctrl_3_up_isFiring);
  assign axi_mem_aw_valid = axi_mem_aw_valid_1;
  assign axi_mem_aw_ready_1 = axi_mem_aw_ready;
  assign axi_mem_aw_payload_addr = axi_mem_aw_payload_addr_1;
  assign axi_mem_aw_payload_id = axi_mem_aw_payload_id_1;
  assign axi_mem_aw_payload_len = axi_mem_aw_payload_len_1;
  assign axi_mem_aw_payload_size = axi_mem_aw_payload_size_1;
  assign axi_mem_aw_payload_burst = axi_mem_aw_payload_burst_1;
  assign axi_mem_w_valid = axi_mem_w_valid_1;
  assign axi_mem_w_ready_1 = axi_mem_w_ready;
  assign axi_mem_w_payload_data = axi_mem_w_payload_data_1;
  assign axi_mem_w_payload_strb = axi_mem_w_payload_strb_1;
  assign axi_mem_w_payload_last = axi_mem_w_payload_last_1;
  assign axi_mem_b_valid_1 = axi_mem_b_valid;
  assign axi_mem_b_ready = axi_mem_b_ready_1;
  assign axi_mem_b_payload_id_1 = axi_mem_b_payload_id;
  assign axi_mem_b_payload_resp_1 = axi_mem_b_payload_resp;
  assign axi_mem_ar_valid = axi_mem_ar_valid_1;
  assign axi_mem_ar_ready_1 = axi_mem_ar_ready;
  assign axi_mem_ar_payload_addr = axi_mem_ar_payload_addr_1;
  assign axi_mem_ar_payload_id = axi_mem_ar_payload_id_1;
  assign axi_mem_ar_payload_len = axi_mem_ar_payload_len_1;
  assign axi_mem_ar_payload_size = axi_mem_ar_payload_size_1;
  assign axi_mem_ar_payload_burst = axi_mem_ar_payload_burst_1;
  assign axi_mem_r_valid_1 = axi_mem_r_valid;
  assign axi_mem_r_ready = axi_mem_r_ready_1;
  assign axi_mem_r_payload_data_1 = axi_mem_r_payload_data;
  assign axi_mem_r_payload_id_1 = axi_mem_r_payload_id;
  assign axi_mem_r_payload_resp_1 = axi_mem_r_payload_resp;
  assign axi_mem_r_payload_last_1 = axi_mem_r_payload_last;
  assign MEM_MEMt_addrl = pip_ctrl_4_down_MEM_addr[1 : 0];
  assign MEM_MEMt_w_strb = _zz_MEM_MEMt_w_strb[3:0];
  assign MEM_MEMt_w_data = _zz_MEM_MEMt_w_data[31:0];
  assign MEM_MEMt_r_data = (axi_mem_r_payload_data_1 >>> _zz_MEM_MEMt_r_data);
  always @(*) begin
    axi_mem_aw_valid_1 = 1'b0;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_aw_valid_1 = 1'b1;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_aw_payload_addr_1 = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_aw_payload_addr_1 = pip_ctrl_4_down_MEM_addr;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_aw_payload_id_1 = 4'bxxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_aw_payload_id_1 = 4'b0000;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_aw_payload_len_1 = 8'bxxxxxxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_aw_payload_len_1 = 8'h0;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_aw_payload_size_1 = 3'bxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        case(pip_ctrl_4_down_MEM_mask)
          4'b0001 : begin
            axi_mem_aw_payload_size_1 = 3'b000;
          end
          4'b0011 : begin
            axi_mem_aw_payload_size_1 = 3'b001;
          end
          default : begin
            axi_mem_aw_payload_size_1 = 3'b010;
          end
        endcase
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  assign axi_mem_aw_payload_burst_1 = 2'bxx;
  always @(*) begin
    axi_mem_w_valid_1 = 1'b0;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_w_valid_1 = 1'b1;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_w_payload_data_1 = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_w_payload_data_1 = MEM_MEMt_w_data;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_w_payload_strb_1 = 4'bxxxx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_w_payload_strb_1 = MEM_MEMt_w_strb;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_w_payload_last_1 = 1'bx;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        axi_mem_w_payload_last_1 = 1'b1;
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_b_ready_1 = 1'b0;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
        axi_mem_b_ready_1 = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_ar_valid_1 = 1'b0;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        axi_mem_ar_valid_1 = 1'b1;
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_ar_payload_addr_1 = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        axi_mem_ar_payload_addr_1 = pip_ctrl_4_down_MEM_addr;
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_ar_payload_id_1 = 4'bxxxx;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        axi_mem_ar_payload_id_1 = 4'b0000;
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_ar_payload_len_1 = 8'bxxxxxxxx;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        axi_mem_ar_payload_len_1 = 8'h0;
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_mem_ar_payload_size_1 = 3'bxxx;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        case(pip_ctrl_4_down_MEM_mask)
          4'b0001 : begin
            axi_mem_ar_payload_size_1 = 3'b000;
          end
          4'b0011 : begin
            axi_mem_ar_payload_size_1 = 3'b001;
          end
          default : begin
            axi_mem_ar_payload_size_1 = 3'b010;
          end
        endcase
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  assign axi_mem_ar_payload_burst_1 = 2'bxx;
  always @(*) begin
    axi_mem_r_ready_1 = 1'b0;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
        axi_mem_r_ready_1 = 1'b1;
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  assign when_pipCPU_l370 = ((pip_ctrl_4_up_valid && pip_ctrl_4_down_MEM_write_valid) && MEM_MEMt_once_flag);
  assign pip_ctrl_4_haltRequest_pipCPU_l370 = _zz_pip_ctrl_4_haltRequest_pipCPU_l370;
  assign when_pipCPU_l371 = ((pip_ctrl_4_up_valid && pip_ctrl_4_down_MEM_read_valid) && MEM_MEMt_once_flag);
  assign pip_ctrl_4_haltRequest_pipCPU_l371 = _zz_pip_ctrl_4_haltRequest_pipCPU_l371;
  assign when_pipCPU_l372 = (MEM_MEMt_w_flag || MEM_MEMt_r_flag);
  assign pip_ctrl_4_haltRequest_pipCPU_l372 = _zz_pip_ctrl_4_haltRequest_pipCPU_l372;
  assign MEM_MEMt_w_wantExit = 1'b0;
  always @(*) begin
    MEM_MEMt_w_wantStart = 1'b0;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
      end
      default : begin
        MEM_MEMt_w_wantStart = 1'b1;
      end
    endcase
  end

  assign MEM_MEMt_w_wantKill = 1'b0;
  assign MEM_MEMt_r_wantExit = 1'b0;
  always @(*) begin
    MEM_MEMt_r_wantStart = 1'b0;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
        MEM_MEMt_r_wantStart = 1'b1;
      end
    endcase
  end

  assign MEM_MEMt_r_wantKill = 1'b0;
  assign when_pipCPU_l687 = ((pip_ctrl_5_down_RD_valid && (pip_ctrl_5_down_RD_sel != 5'h0)) && (! pip_ctrl_4_down_CSR_valid));
  assign _zz_1 = ({15'd0,1'b1} <<< _zz__zz_1);
  assign WB_gpr_rdata = _zz_WB_gpr_rdata;
  always @(*) begin
    WB_csr_w_valid = pip_ctrl_5_down_CSR_valid;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_MRET : begin
          WB_csr_w_valid = 1'b0;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    WB_csr_csr_wsel = pip_ctrl_5_down_CSR_sel;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          WB_csr_csr_wsel = 12'h341;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    WB_csr_csr_rsel = pip_ctrl_5_down_CSR_sel;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          WB_csr_csr_rsel = 12'h305;
        end
        ysyx_26010010_RVCode_MRET : begin
          WB_csr_csr_rsel = 12'h341;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    WB_csr_w_data = 32'h0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          WB_csr_w_data = pip_ctrl_5_down_PC;
        end
        ysyx_26010010_RVCode_CSRRW : begin
          WB_csr_w_data = WB_gpr_rdata;
        end
        ysyx_26010010_RVCode_CSRRS : begin
          WB_csr_w_data = (WB_gpr_rdata | WB_csr_r_data);
        end
        ysyx_26010010_RVCode_CSRRC : begin
          WB_csr_w_data = (WB_csr_r_data & (~ WB_gpr_rdata));
        end
        ysyx_26010010_RVCode_CSRRWI : begin
          WB_csr_w_data = {27'd0, _zz_w_data};
        end
        ysyx_26010010_RVCode_CSRRSI : begin
          WB_csr_w_data = (WB_gpr_rdata | _zz_w_data_1);
        end
        ysyx_26010010_RVCode_CSRRCI : begin
          WB_csr_w_data = (WB_csr_r_data & (~ _zz_w_data_2));
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    WB_csr_flag = 1'b0;
    if(pip_ctrl_5_down_CSR_valid) begin
      case(pip_ctrl_5_down_IDtoEX_fun)
        ysyx_26010010_RVCode_ECALL : begin
          WB_csr_flag = 1'b1;
        end
        ysyx_26010010_RVCode_MRET : begin
          WB_csr_flag = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  assign when_pipCPU_l707 = (pip_ctrl_5_down_RD_sel != 5'h0);
  assign _zz_2 = ({15'd0,1'b1} <<< _zz__zz_2);
  assign pip_ctrl_2_throwWhen_pipCPU_l717 = _zz_pip_ctrl_2_throwWhen_pipCPU_l717;
  assign pip_ctrl_3_throwWhen_pipCPU_l718 = _zz_pip_ctrl_3_throwWhen_pipCPU_l718;
  assign pip_ctrl_4_throwWhen_pipCPU_l719 = _zz_pip_ctrl_4_throwWhen_pipCPU_l719;
  assign pip_ctrl_2_throwWhen_pipCPU_l727 = _zz_pip_ctrl_2_throwWhen_pipCPU_l727;
  assign pip_ctrl_3_throwWhen_pipCPU_l728 = _zz_pip_ctrl_3_throwWhen_pipCPU_l728;
  assign pip_ctrl_4_throwWhen_pipCPU_l729 = _zz_pip_ctrl_4_throwWhen_pipCPU_l729;
  assign when_pipCPU_l743 = ((((pip_ctrl_3_down_MEM_read_valid || pip_ctrl_4_down_MEM_read_valid) || pip_ctrl_3_down_CSR_valid) || pip_ctrl_4_down_CSR_valid) || pip_ctrl_5_down_CSR_valid);
  assign pip_ctrl_2_haltRequest_pipCPU_l744 = _zz_pip_ctrl_2_haltRequest_pipCPU_l744;
  always @(*) begin
    pass_valid = 1'b0;
    if(pip_ctrl_3_up_isFiring) begin
      pass_valid = 1'b1;
    end
  end

  assign when_pipCPU_l762 = (((id_rs1_sel == pip_ctrl_5_down_RD_sel) && (pip_ctrl_5_down_RD_sel != 5'h0)) && pip_ctrl_5_down_RD_valid);
  always @(*) begin
    if(when_pipCPU_l762) begin
      id_rs1 = pip_ctrl_5_down_RD;
    end else begin
      id_rs1 = _zz_id_rs1;
    end
  end

  assign when_pipCPU_l764 = (((id_rs2_sel == pip_ctrl_5_down_RD_sel) && (pip_ctrl_5_down_RD_sel != 5'h0)) && pip_ctrl_5_down_RD_valid);
  always @(*) begin
    if(when_pipCPU_l764) begin
      id_rs2 = pip_ctrl_5_down_RD;
    end else begin
      id_rs2 = _zz_id_rs2;
    end
  end

  assign when_pipCPU_l767 = (! IF_code_valid);
  assign pip_ctrl_1_haltRequest_pipCPU_l768 = _zz_pip_ctrl_1_haltRequest_pipCPU_l768;
  assign pip_ctrl_2_throwWhen_pipCPU_l771 = (EXtoIF_valid_regNext || EXtoIF_valid);
  assign pip_ctrl_4_up_forgetOne = (|{pip_ctrl_4_throwWhen_pipCPU_l729,pip_ctrl_4_throwWhen_pipCPU_l719});
  assign pip_ctrl_4_up_cancel = (|{pip_ctrl_4_throwWhen_pipCPU_l729,pip_ctrl_4_throwWhen_pipCPU_l719});
  assign pip_ctrl_3_up_forgetOne = (|{pip_ctrl_3_throwWhen_pipCPU_l728,pip_ctrl_3_throwWhen_pipCPU_l718});
  assign pip_ctrl_3_up_cancel = (|{pip_ctrl_3_throwWhen_pipCPU_l728,pip_ctrl_3_throwWhen_pipCPU_l718});
  assign pip_ctrl_2_up_forgetOne = (|{pip_ctrl_2_throwWhen_pipCPU_l771,{pip_ctrl_2_throwWhen_pipCPU_l727,pip_ctrl_2_throwWhen_pipCPU_l717}});
  assign pip_ctrl_2_up_cancel = (|{pip_ctrl_2_throwWhen_pipCPU_l771,{pip_ctrl_2_throwWhen_pipCPU_l727,pip_ctrl_2_throwWhen_pipCPU_l717}});
  always @(*) begin
    pip_ctrl_1_down_ready = pip_ctrl_2_up_ready;
    if(when_StageLink_l71) begin
      pip_ctrl_1_down_ready = 1'b1;
    end
  end

  assign when_StageLink_l71 = (! pip_ctrl_2_up_isValid);
  always @(*) begin
    pip_ctrl_2_down_ready = pip_ctrl_3_up_ready;
    if(when_StageLink_l71_1) begin
      pip_ctrl_2_down_ready = 1'b1;
    end
  end

  assign when_StageLink_l71_1 = (! pip_ctrl_3_up_isValid);
  always @(*) begin
    pip_ctrl_3_down_ready = pip_ctrl_4_up_ready;
    if(when_StageLink_l71_2) begin
      pip_ctrl_3_down_ready = 1'b1;
    end
  end

  assign when_StageLink_l71_2 = (! pip_ctrl_4_up_isValid);
  always @(*) begin
    pip_ctrl_1_down_valid = pip_ctrl_1_up_valid;
    if(when_CtrlLink_l191) begin
      pip_ctrl_1_down_valid = 1'b0;
    end
  end

  always @(*) begin
    pip_ctrl_1_up_ready = pip_ctrl_1_down_isReady;
    if(when_CtrlLink_l191) begin
      pip_ctrl_1_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l191 = (|pip_ctrl_1_haltRequest_pipCPU_l768);
  always @(*) begin
    pip_ctrl_2_down_valid = pip_ctrl_2_up_valid;
    if(when_CtrlLink_l191_1) begin
      pip_ctrl_2_down_valid = 1'b0;
    end
    if(when_CtrlLink_l198) begin
      pip_ctrl_2_down_valid = 1'b0;
    end
  end

  always @(*) begin
    pip_ctrl_2_up_ready = pip_ctrl_2_down_isReady;
    if(when_CtrlLink_l191_1) begin
      pip_ctrl_2_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l191_1 = (|pip_ctrl_2_haltRequest_pipCPU_l744);
  assign when_CtrlLink_l198 = (|{pip_ctrl_2_throwWhen_pipCPU_l771,{pip_ctrl_2_throwWhen_pipCPU_l727,pip_ctrl_2_throwWhen_pipCPU_l717}});
  assign pip_ctrl_2_down_CODE = pip_ctrl_2_up_CODE;
  assign pip_ctrl_2_down_PC = pip_ctrl_2_up_PC;
  always @(*) begin
    pip_ctrl_3_down_valid = pip_ctrl_3_up_valid;
    if(when_CtrlLink_l198_1) begin
      pip_ctrl_3_down_valid = 1'b0;
    end
  end

  assign pip_ctrl_3_up_ready = pip_ctrl_3_down_isReady;
  assign when_CtrlLink_l198_1 = (|{pip_ctrl_3_throwWhen_pipCPU_l728,pip_ctrl_3_throwWhen_pipCPU_l718});
  assign pip_ctrl_3_down_CODE = pip_ctrl_3_up_CODE;
  assign pip_ctrl_3_down_PC = pip_ctrl_3_up_PC;
  assign pip_ctrl_3_down_IDtoEX_fun = pip_ctrl_3_up_IDtoEX_fun;
  assign pip_ctrl_3_down_IDtoEX_rd_sel = pip_ctrl_3_up_IDtoEX_rd_sel;
  assign pip_ctrl_3_down_IDtoEX_imm = pip_ctrl_3_up_IDtoEX_imm;
  assign pip_ctrl_3_down_IDtoEX_rs1 = pip_ctrl_3_up_IDtoEX_rs1;
  assign pip_ctrl_3_down_IDtoEX_rs2 = pip_ctrl_3_up_IDtoEX_rs2;
  assign pip_ctrl_3_down_CSR_rs1_imm = pip_ctrl_3_up_CSR_rs1_imm;
  always @(*) begin
    pip_ctrl_4_down_valid = pip_ctrl_4_up_valid;
    if(when_CtrlLink_l191_2) begin
      pip_ctrl_4_down_valid = 1'b0;
    end
    if(when_CtrlLink_l198_2) begin
      pip_ctrl_4_down_valid = 1'b0;
    end
  end

  always @(*) begin
    pip_ctrl_4_up_ready = pip_ctrl_4_down_isReady;
    if(when_CtrlLink_l191_2) begin
      pip_ctrl_4_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l191_2 = (|{pip_ctrl_4_haltRequest_pipCPU_l372,{pip_ctrl_4_haltRequest_pipCPU_l371,pip_ctrl_4_haltRequest_pipCPU_l370}});
  assign when_CtrlLink_l198_2 = (|{pip_ctrl_4_throwWhen_pipCPU_l729,pip_ctrl_4_throwWhen_pipCPU_l719});
  assign pip_ctrl_4_down_CODE = pip_ctrl_4_up_CODE;
  assign pip_ctrl_4_down_PC = pip_ctrl_4_up_PC;
  assign pip_ctrl_4_down_IDtoEX_fun = pip_ctrl_4_up_IDtoEX_fun;
  assign pip_ctrl_4_down_IDtoEX_rd_sel = pip_ctrl_4_up_IDtoEX_rd_sel;
  assign pip_ctrl_4_down_IDtoEX_imm = pip_ctrl_4_up_IDtoEX_imm;
  assign pip_ctrl_4_down_IDtoEX_rs1 = pip_ctrl_4_up_IDtoEX_rs1;
  assign pip_ctrl_4_down_IDtoEX_rs2 = pip_ctrl_4_up_IDtoEX_rs2;
  assign pip_ctrl_4_down_CSR_rs1_imm = pip_ctrl_4_up_CSR_rs1_imm;
  assign pip_ctrl_4_down_RD_sel = pip_ctrl_4_up_RD_sel;
  always @(*) begin
    pip_ctrl_4_down_RD = pip_ctrl_4_up_RD;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
        if(axi_mem_r_fire) begin
          case(pip_ctrl_4_down_MEM_mask)
            4'b0001 : begin
              pip_ctrl_4_down_RD = (pip_ctrl_4_down_MEM_unsigned ? _zz_pip_ctrl_4_down_RD : _zz_pip_ctrl_4_down_RD_2);
            end
            4'b0011 : begin
              pip_ctrl_4_down_RD = (pip_ctrl_4_down_MEM_unsigned ? _zz_pip_ctrl_4_down_RD_4 : _zz_pip_ctrl_4_down_RD_6);
            end
            default : begin
              pip_ctrl_4_down_RD = MEM_MEMt_r_data;
            end
          endcase
        end
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    pip_ctrl_4_down_RD_valid = pip_ctrl_4_up_RD_valid;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
        if(axi_mem_r_fire) begin
          pip_ctrl_4_down_RD_valid = 1'b1;
        end
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
      end
      default : begin
      end
    endcase
  end

  assign pip_ctrl_4_down_MEM_addr = pip_ctrl_4_up_MEM_addr;
  assign pip_ctrl_4_down_MEM_read_valid = pip_ctrl_4_up_MEM_read_valid;
  assign pip_ctrl_4_down_MEM_write_valid = pip_ctrl_4_up_MEM_write_valid;
  assign pip_ctrl_4_down_MEM_mask = pip_ctrl_4_up_MEM_mask;
  assign pip_ctrl_4_down_MEM_unsigned = pip_ctrl_4_up_MEM_unsigned;
  assign pip_ctrl_4_down_CSR_valid = pip_ctrl_4_up_CSR_valid;
  assign pip_ctrl_4_down_CSR_sel = pip_ctrl_4_up_CSR_sel;
  assign pip_ctrl_5_down_valid = pip_ctrl_5_up_valid;
  assign pip_ctrl_5_down_IDtoEX_fun = pip_ctrl_5_up_IDtoEX_fun;
  assign pip_ctrl_5_down_IDtoEX_rd_sel = pip_ctrl_5_up_IDtoEX_rd_sel;
  assign pip_ctrl_5_down_IDtoEX_imm = pip_ctrl_5_up_IDtoEX_imm;
  assign pip_ctrl_5_down_IDtoEX_rs1 = pip_ctrl_5_up_IDtoEX_rs1;
  assign pip_ctrl_5_down_IDtoEX_rs2 = pip_ctrl_5_up_IDtoEX_rs2;
  assign pip_ctrl_5_down_CSR_rs1_imm = pip_ctrl_5_up_CSR_rs1_imm;
  assign pip_ctrl_5_down_CSR_valid = pip_ctrl_5_up_CSR_valid;
  assign pip_ctrl_5_down_CSR_sel = pip_ctrl_5_up_CSR_sel;
  assign pip_ctrl_1_down_isFiring = (pip_ctrl_1_down_isValid && pip_ctrl_1_down_isReady);
  assign pip_ctrl_1_down_isValid = pip_ctrl_1_down_valid;
  assign pip_ctrl_1_down_isReady = pip_ctrl_1_down_ready;
  assign pip_ctrl_2_up_isFiring = ((pip_ctrl_2_up_isValid && pip_ctrl_2_up_isReady) && (! pip_ctrl_2_up_isCancel));
  assign pip_ctrl_2_up_isValid = pip_ctrl_2_up_valid;
  assign pip_ctrl_2_up_isReady = pip_ctrl_2_up_ready;
  assign pip_ctrl_2_up_isCancel = pip_ctrl_2_up_cancel;
  assign pip_ctrl_2_down_isValid = pip_ctrl_2_down_valid;
  assign pip_ctrl_2_down_isReady = pip_ctrl_2_down_ready;
  assign pip_ctrl_3_up_isFiring = ((pip_ctrl_3_up_isValid && pip_ctrl_3_up_isReady) && (! pip_ctrl_3_up_isCancel));
  assign pip_ctrl_3_up_isValid = pip_ctrl_3_up_valid;
  assign pip_ctrl_3_up_isReady = pip_ctrl_3_up_ready;
  assign pip_ctrl_3_up_isCancel = pip_ctrl_3_up_cancel;
  assign pip_ctrl_3_down_isValid = pip_ctrl_3_down_valid;
  assign pip_ctrl_3_down_isReady = pip_ctrl_3_down_ready;
  assign pip_ctrl_4_up_isFiring = ((pip_ctrl_4_up_isValid && pip_ctrl_4_up_isReady) && (! pip_ctrl_4_up_isCancel));
  assign pip_ctrl_4_up_isValid = pip_ctrl_4_up_valid;
  assign pip_ctrl_4_up_isReady = pip_ctrl_4_up_ready;
  assign pip_ctrl_4_up_isCancel = pip_ctrl_4_up_cancel;
  assign pip_ctrl_4_down_isValid = pip_ctrl_4_down_valid;
  assign pip_ctrl_4_down_isReady = 1'b1;
  always @(*) begin
    MEM_MEMt_w_stateNext = MEM_MEMt_w_stateReg;
    case(MEM_MEMt_w_stateReg)
      ysyx_26010010_MEM_MEMt_w_start : begin
        if(MEM_MEMt_w_flag) begin
          MEM_MEMt_w_stateNext = ysyx_26010010_MEM_MEMt_w_w;
        end
      end
      ysyx_26010010_MEM_MEMt_w_w : begin
        if(axi_mem_aw_fire) begin
          MEM_MEMt_w_stateNext = ysyx_26010010_MEM_MEMt_w_b;
        end
      end
      ysyx_26010010_MEM_MEMt_w_b : begin
        if(axi_mem_b_fire) begin
          MEM_MEMt_w_stateNext = ysyx_26010010_MEM_MEMt_w_start;
        end
      end
      default : begin
      end
    endcase
    if(MEM_MEMt_w_wantStart) begin
      MEM_MEMt_w_stateNext = ysyx_26010010_MEM_MEMt_w_start;
    end
    if(MEM_MEMt_w_wantKill) begin
      MEM_MEMt_w_stateNext = ysyx_26010010_MEM_MEMt_w_BOOT;
    end
  end

  assign axi_mem_aw_fire = (axi_mem_aw_valid_1 && axi_mem_aw_ready_1);
  assign axi_mem_b_fire = (axi_mem_b_valid_1 && axi_mem_b_ready_1);
  assign MEM_MEMt_w_onExit_BOOT = ((MEM_MEMt_w_stateNext != ysyx_26010010_MEM_MEMt_w_BOOT) && (MEM_MEMt_w_stateReg == ysyx_26010010_MEM_MEMt_w_BOOT));
  assign MEM_MEMt_w_onExit_start = ((MEM_MEMt_w_stateNext != ysyx_26010010_MEM_MEMt_w_start) && (MEM_MEMt_w_stateReg == ysyx_26010010_MEM_MEMt_w_start));
  assign MEM_MEMt_w_onExit_w = ((MEM_MEMt_w_stateNext != ysyx_26010010_MEM_MEMt_w_w) && (MEM_MEMt_w_stateReg == ysyx_26010010_MEM_MEMt_w_w));
  assign MEM_MEMt_w_onExit_b = ((MEM_MEMt_w_stateNext != ysyx_26010010_MEM_MEMt_w_b) && (MEM_MEMt_w_stateReg == ysyx_26010010_MEM_MEMt_w_b));
  assign MEM_MEMt_w_onEntry_BOOT = ((MEM_MEMt_w_stateNext == ysyx_26010010_MEM_MEMt_w_BOOT) && (MEM_MEMt_w_stateReg != ysyx_26010010_MEM_MEMt_w_BOOT));
  assign MEM_MEMt_w_onEntry_start = ((MEM_MEMt_w_stateNext == ysyx_26010010_MEM_MEMt_w_start) && (MEM_MEMt_w_stateReg != ysyx_26010010_MEM_MEMt_w_start));
  assign MEM_MEMt_w_onEntry_w = ((MEM_MEMt_w_stateNext == ysyx_26010010_MEM_MEMt_w_w) && (MEM_MEMt_w_stateReg != ysyx_26010010_MEM_MEMt_w_w));
  assign MEM_MEMt_w_onEntry_b = ((MEM_MEMt_w_stateNext == ysyx_26010010_MEM_MEMt_w_b) && (MEM_MEMt_w_stateReg != ysyx_26010010_MEM_MEMt_w_b));
  always @(*) begin
    MEM_MEMt_r_stateNext = MEM_MEMt_r_stateReg;
    case(MEM_MEMt_r_stateReg)
      ysyx_26010010_MEM_MEMt_r_start : begin
        if(MEM_MEMt_r_flag) begin
          MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_ar;
        end
      end
      ysyx_26010010_MEM_MEMt_r_ar : begin
        if(axi_mem_ar_fire) begin
          MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_r;
        end
      end
      ysyx_26010010_MEM_MEMt_r_r : begin
        if(axi_mem_r_fire) begin
          MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_delay;
        end
      end
      ysyx_26010010_MEM_MEMt_r_delay : begin
        MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_start;
      end
      default : begin
      end
    endcase
    if(MEM_MEMt_r_wantStart) begin
      MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_start;
    end
    if(MEM_MEMt_r_wantKill) begin
      MEM_MEMt_r_stateNext = ysyx_26010010_MEM_MEMt_r_BOOT;
    end
  end

  assign axi_mem_ar_fire = (axi_mem_ar_valid_1 && axi_mem_ar_ready_1);
  assign axi_mem_r_fire = (axi_mem_r_valid_1 && axi_mem_r_ready_1);
  assign MEM_MEMt_r_onExit_BOOT = ((MEM_MEMt_r_stateNext != ysyx_26010010_MEM_MEMt_r_BOOT) && (MEM_MEMt_r_stateReg == ysyx_26010010_MEM_MEMt_r_BOOT));
  assign MEM_MEMt_r_onExit_start = ((MEM_MEMt_r_stateNext != ysyx_26010010_MEM_MEMt_r_start) && (MEM_MEMt_r_stateReg == ysyx_26010010_MEM_MEMt_r_start));
  assign MEM_MEMt_r_onExit_ar = ((MEM_MEMt_r_stateNext != ysyx_26010010_MEM_MEMt_r_ar) && (MEM_MEMt_r_stateReg == ysyx_26010010_MEM_MEMt_r_ar));
  assign MEM_MEMt_r_onExit_r = ((MEM_MEMt_r_stateNext != ysyx_26010010_MEM_MEMt_r_r) && (MEM_MEMt_r_stateReg == ysyx_26010010_MEM_MEMt_r_r));
  assign MEM_MEMt_r_onExit_delay = ((MEM_MEMt_r_stateNext != ysyx_26010010_MEM_MEMt_r_delay) && (MEM_MEMt_r_stateReg == ysyx_26010010_MEM_MEMt_r_delay));
  assign MEM_MEMt_r_onEntry_BOOT = ((MEM_MEMt_r_stateNext == ysyx_26010010_MEM_MEMt_r_BOOT) && (MEM_MEMt_r_stateReg != ysyx_26010010_MEM_MEMt_r_BOOT));
  assign MEM_MEMt_r_onEntry_start = ((MEM_MEMt_r_stateNext == ysyx_26010010_MEM_MEMt_r_start) && (MEM_MEMt_r_stateReg != ysyx_26010010_MEM_MEMt_r_start));
  assign MEM_MEMt_r_onEntry_ar = ((MEM_MEMt_r_stateNext == ysyx_26010010_MEM_MEMt_r_ar) && (MEM_MEMt_r_stateReg != ysyx_26010010_MEM_MEMt_r_ar));
  assign MEM_MEMt_r_onEntry_r = ((MEM_MEMt_r_stateNext == ysyx_26010010_MEM_MEMt_r_r) && (MEM_MEMt_r_stateReg != ysyx_26010010_MEM_MEMt_r_r));
  assign MEM_MEMt_r_onEntry_delay = ((MEM_MEMt_r_stateNext == ysyx_26010010_MEM_MEMt_r_delay) && (MEM_MEMt_r_stateReg != ysyx_26010010_MEM_MEMt_r_delay));
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      gpr_reg_0 <= 32'h0;
      gpr_reg_1 <= 32'h0;
      gpr_reg_2 <= 32'h0;
      gpr_reg_3 <= 32'h0;
      gpr_reg_4 <= 32'h0;
      gpr_reg_5 <= 32'h0;
      gpr_reg_6 <= 32'h0;
      gpr_reg_7 <= 32'h0;
      gpr_reg_8 <= 32'h0;
      gpr_reg_9 <= 32'h0;
      gpr_reg_10 <= 32'h0;
      gpr_reg_11 <= 32'h0;
      gpr_reg_12 <= 32'h0;
      gpr_reg_13 <= 32'h0;
      gpr_reg_14 <= 32'h0;
      IF_IFt_pc <= 32'h30000000;
      MEM_MEMt_w_flag <= 1'b0;
      MEM_MEMt_r_flag <= 1'b0;
      MEM_MEMt_once_flag <= 1'b0;
      pip_ctrl_2_up_valid <= 1'b0;
      pip_ctrl_3_up_valid <= 1'b0;
      pip_ctrl_4_up_valid <= 1'b0;
      pip_ctrl_5_up_valid <= 1'b0;
      MEM_MEMt_w_stateReg <= ysyx_26010010_MEM_MEMt_w_BOOT;
      MEM_MEMt_r_stateReg <= ysyx_26010010_MEM_MEMt_r_BOOT;
    end else begin
      if(EXtoIF_valid) begin
        IF_IFt_pc <= EXtoIF_nPC;
      end else begin
        if(when_pipCPU_l29) begin
          IF_IFt_pc <= (IF_IFt_pc + 32'h00000004);
        end
      end
      if(pip_ctrl_4_up_isFiring) begin
        MEM_MEMt_once_flag <= 1'b1;
      end
      if(when_pipCPU_l370) begin
        MEM_MEMt_w_flag <= 1'b1;
        MEM_MEMt_once_flag <= 1'b0;
      end
      if(when_pipCPU_l371) begin
        MEM_MEMt_r_flag <= 1'b1;
        MEM_MEMt_once_flag <= 1'b0;
      end
      if(when_pipCPU_l687) begin
        if(_zz_1[0]) begin
          gpr_reg_0 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[1]) begin
          gpr_reg_1 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[2]) begin
          gpr_reg_2 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[3]) begin
          gpr_reg_3 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[4]) begin
          gpr_reg_4 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[5]) begin
          gpr_reg_5 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[6]) begin
          gpr_reg_6 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[7]) begin
          gpr_reg_7 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[8]) begin
          gpr_reg_8 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[9]) begin
          gpr_reg_9 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[10]) begin
          gpr_reg_10 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[11]) begin
          gpr_reg_11 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[12]) begin
          gpr_reg_12 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[13]) begin
          gpr_reg_13 <= pip_ctrl_5_down_RD;
        end
        if(_zz_1[14]) begin
          gpr_reg_14 <= pip_ctrl_5_down_RD;
        end
      end
      if(pip_ctrl_5_down_CSR_valid) begin
        if(when_pipCPU_l707) begin
          if(_zz_2[0]) begin
            gpr_reg_0 <= WB_csr_r_data;
          end
          if(_zz_2[1]) begin
            gpr_reg_1 <= WB_csr_r_data;
          end
          if(_zz_2[2]) begin
            gpr_reg_2 <= WB_csr_r_data;
          end
          if(_zz_2[3]) begin
            gpr_reg_3 <= WB_csr_r_data;
          end
          if(_zz_2[4]) begin
            gpr_reg_4 <= WB_csr_r_data;
          end
          if(_zz_2[5]) begin
            gpr_reg_5 <= WB_csr_r_data;
          end
          if(_zz_2[6]) begin
            gpr_reg_6 <= WB_csr_r_data;
          end
          if(_zz_2[7]) begin
            gpr_reg_7 <= WB_csr_r_data;
          end
          if(_zz_2[8]) begin
            gpr_reg_8 <= WB_csr_r_data;
          end
          if(_zz_2[9]) begin
            gpr_reg_9 <= WB_csr_r_data;
          end
          if(_zz_2[10]) begin
            gpr_reg_10 <= WB_csr_r_data;
          end
          if(_zz_2[11]) begin
            gpr_reg_11 <= WB_csr_r_data;
          end
          if(_zz_2[12]) begin
            gpr_reg_12 <= WB_csr_r_data;
          end
          if(_zz_2[13]) begin
            gpr_reg_13 <= WB_csr_r_data;
          end
          if(_zz_2[14]) begin
            gpr_reg_14 <= WB_csr_r_data;
          end
        end
      end
      if(pip_ctrl_2_up_forgetOne) begin
        pip_ctrl_2_up_valid <= 1'b0;
      end
      if(pip_ctrl_1_down_isReady) begin
        pip_ctrl_2_up_valid <= pip_ctrl_1_down_isValid;
      end
      if(pip_ctrl_3_up_forgetOne) begin
        pip_ctrl_3_up_valid <= 1'b0;
      end
      if(pip_ctrl_2_down_isReady) begin
        pip_ctrl_3_up_valid <= pip_ctrl_2_down_isValid;
      end
      if(pip_ctrl_4_up_forgetOne) begin
        pip_ctrl_4_up_valid <= 1'b0;
      end
      if(pip_ctrl_3_down_isReady) begin
        pip_ctrl_4_up_valid <= pip_ctrl_3_down_isValid;
      end
      pip_ctrl_5_up_valid <= pip_ctrl_4_down_isValid;
      MEM_MEMt_w_stateReg <= MEM_MEMt_w_stateNext;
      if(MEM_MEMt_w_onEntry_start) begin
        MEM_MEMt_w_flag <= 1'b0;
      end
      MEM_MEMt_r_stateReg <= MEM_MEMt_r_stateNext;
      if(MEM_MEMt_r_onEntry_start) begin
        MEM_MEMt_r_flag <= 1'b0;
      end
    end
  end

  always @(posedge clock) begin
    EXtoIF_valid_regNext <= EXtoIF_valid;
    if(pip_ctrl_1_down_isReady) begin
      pip_ctrl_2_up_CODE <= pip_ctrl_1_down_CODE;
      pip_ctrl_2_up_PC <= pip_ctrl_1_down_PC;
    end
    if(pip_ctrl_2_down_isReady) begin
      pip_ctrl_3_up_CODE <= pip_ctrl_2_down_CODE;
      pip_ctrl_3_up_PC <= pip_ctrl_2_down_PC;
      pip_ctrl_3_up_IDtoEX_fun <= pip_ctrl_2_down_IDtoEX_fun;
      pip_ctrl_3_up_IDtoEX_rd_sel <= pip_ctrl_2_down_IDtoEX_rd_sel;
      pip_ctrl_3_up_IDtoEX_imm <= pip_ctrl_2_down_IDtoEX_imm;
      pip_ctrl_3_up_IDtoEX_rs1 <= pip_ctrl_2_down_IDtoEX_rs1;
      pip_ctrl_3_up_IDtoEX_rs2 <= pip_ctrl_2_down_IDtoEX_rs2;
      pip_ctrl_3_up_CSR_rs1_imm <= pip_ctrl_2_down_CSR_rs1_imm;
    end
    if(pip_ctrl_3_down_isReady) begin
      pip_ctrl_4_up_CODE <= pip_ctrl_3_down_CODE;
      pip_ctrl_4_up_PC <= pip_ctrl_3_down_PC;
      pip_ctrl_4_up_IDtoEX_fun <= pip_ctrl_3_down_IDtoEX_fun;
      pip_ctrl_4_up_IDtoEX_rd_sel <= pip_ctrl_3_down_IDtoEX_rd_sel;
      pip_ctrl_4_up_IDtoEX_imm <= pip_ctrl_3_down_IDtoEX_imm;
      pip_ctrl_4_up_IDtoEX_rs1 <= pip_ctrl_3_down_IDtoEX_rs1;
      pip_ctrl_4_up_IDtoEX_rs2 <= pip_ctrl_3_down_IDtoEX_rs2;
      pip_ctrl_4_up_CSR_rs1_imm <= pip_ctrl_3_down_CSR_rs1_imm;
      pip_ctrl_4_up_RD_sel <= pip_ctrl_3_down_RD_sel;
      pip_ctrl_4_up_RD <= pip_ctrl_3_down_RD;
      pip_ctrl_4_up_RD_valid <= pip_ctrl_3_down_RD_valid;
      pip_ctrl_4_up_MEM_addr <= pip_ctrl_3_down_MEM_addr;
      pip_ctrl_4_up_MEM_read_valid <= pip_ctrl_3_down_MEM_read_valid;
      pip_ctrl_4_up_MEM_write_valid <= pip_ctrl_3_down_MEM_write_valid;
      pip_ctrl_4_up_MEM_mask <= pip_ctrl_3_down_MEM_mask;
      pip_ctrl_4_up_MEM_unsigned <= pip_ctrl_3_down_MEM_unsigned;
      pip_ctrl_4_up_CSR_valid <= pip_ctrl_3_down_CSR_valid;
      pip_ctrl_4_up_CSR_sel <= pip_ctrl_3_down_CSR_sel;
    end
    pip_ctrl_5_up_CODE <= pip_ctrl_4_down_CODE;
    pip_ctrl_5_up_PC <= pip_ctrl_4_down_PC;
    pip_ctrl_5_up_IDtoEX_fun <= pip_ctrl_4_down_IDtoEX_fun;
    pip_ctrl_5_up_IDtoEX_rd_sel <= pip_ctrl_4_down_IDtoEX_rd_sel;
    pip_ctrl_5_up_IDtoEX_imm <= pip_ctrl_4_down_IDtoEX_imm;
    pip_ctrl_5_up_IDtoEX_rs1 <= pip_ctrl_4_down_IDtoEX_rs1;
    pip_ctrl_5_up_IDtoEX_rs2 <= pip_ctrl_4_down_IDtoEX_rs2;
    pip_ctrl_5_up_CSR_rs1_imm <= pip_ctrl_4_down_CSR_rs1_imm;
    pip_ctrl_5_up_RD_sel <= pip_ctrl_4_down_RD_sel;
    pip_ctrl_5_up_RD <= pip_ctrl_4_down_RD;
    pip_ctrl_5_up_RD_valid <= pip_ctrl_4_down_RD_valid;
    pip_ctrl_5_up_CSR_valid <= pip_ctrl_4_down_CSR_valid;
    pip_ctrl_5_up_CSR_sel <= pip_ctrl_4_down_CSR_sel;
  end


endmodule

module ysyx_26010010_CSR (
  input  wire [31:0]   w_data,
  input  wire          w_valid,
  output reg  [31:0]   r_data,
  input  wire [11:0]   csr_wsel,
  input  wire [11:0]   csr_rsel,
  input  wire          clock,
  input  wire          reset
);

  reg        [31:0]   debug_data_0;
  reg        [31:0]   debug_data_1;
  reg        [31:0]   debug_data_2;
  reg        [31:0]   debug_data_3;
  reg        [31:0]   mstatus;
  reg        [31:0]   mcause;
  reg        [31:0]   mepc;
  reg        [31:0]   mtvec;

  ysyx_26010010_my_debug debug (
    .data_0 (debug_data_0[31:0]), //i
    .data_1 (debug_data_1[31:0]), //i
    .data_2 (debug_data_2[31:0]), //i
    .data_3 (debug_data_3[31:0]), //i
    .clock  (clock             )  //i
  );
  always @(*) begin
    case(csr_rsel)
      12'h300 : begin
        r_data = mstatus;
      end
      12'h305 : begin
        r_data = mtvec;
      end
      12'h342 : begin
        r_data = mcause;
      end
      12'h341 : begin
        r_data = mepc;
      end
      12'hf11 : begin
        r_data = 32'h79737978;
      end
      12'hf12 : begin
        r_data = 32'h018ce19a;
      end
      default : begin
        r_data = 32'h0;
      end
    endcase
  end

  always @(*) begin
    debug_data_0 = mtvec;
    if(w_valid) begin
      case(csr_wsel)
        12'h300 : begin
        end
        12'h305 : begin
          debug_data_0 = w_data;
        end
        12'h342 : begin
        end
        12'h341 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_data_1 = mcause;
    if(w_valid) begin
      case(csr_wsel)
        12'h300 : begin
        end
        12'h305 : begin
        end
        12'h342 : begin
          debug_data_1 = w_data;
        end
        12'h341 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_data_2 = mstatus;
    if(w_valid) begin
      case(csr_wsel)
        12'h300 : begin
          debug_data_2 = w_data;
        end
        12'h305 : begin
        end
        12'h342 : begin
        end
        12'h341 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_data_3 = mepc;
    if(w_valid) begin
      case(csr_wsel)
        12'h300 : begin
        end
        12'h305 : begin
        end
        12'h342 : begin
        end
        12'h341 : begin
          debug_data_3 = w_data;
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clock or posedge reset) begin
    if(reset) begin
      mstatus <= 32'h00001800;
      mcause <= 32'h0000000b;
      mepc <= 32'h0;
      mtvec <= 32'h30000000;
    end else begin
      if(w_valid) begin
        case(csr_wsel)
          12'h300 : begin
            mstatus <= w_data;
          end
          12'h305 : begin
            mtvec <= w_data;
          end
          12'h342 : begin
            mcause <= w_data;
          end
          12'h341 : begin
            mepc <= w_data;
          end
          default : begin
          end
        endcase
      end
    end
  end


endmodule

module ysyx_26010010_Icache (
  output wire          axi_aw_valid,
  input  wire          axi_aw_ready,
  output wire [31:0]   axi_aw_payload_addr,
  output wire [3:0]    axi_aw_payload_id,
  output wire [7:0]    axi_aw_payload_len,
  output wire [2:0]    axi_aw_payload_size,
  output wire [1:0]    axi_aw_payload_burst,
  output wire          axi_w_valid,
  input  wire          axi_w_ready,
  output wire [31:0]   axi_w_payload_data,
  output wire [3:0]    axi_w_payload_strb,
  output wire          axi_w_payload_last,
  input  wire          axi_b_valid,
  output wire          axi_b_ready,
  input  wire [3:0]    axi_b_payload_id,
  input  wire [1:0]    axi_b_payload_resp,
  output reg           axi_ar_valid,
  input  wire          axi_ar_ready,
  output reg  [31:0]   axi_ar_payload_addr,
  output wire [3:0]    axi_ar_payload_id,
  output wire [7:0]    axi_ar_payload_len,
  output wire [2:0]    axi_ar_payload_size,
  output wire [1:0]    axi_ar_payload_burst,
  input  wire          axi_r_valid,
  output reg           axi_r_ready,
  input  wire [31:0]   axi_r_payload_data,
  input  wire [3:0]    axi_r_payload_id,
  input  wire [1:0]    axi_r_payload_resp,
  input  wire          axi_r_payload_last,
  input  wire [31:0]   addr,
  output reg           code_valid,
  input  wire          code_ready,
  output reg  [31:0]   code_payload,
  input  wire          fence_i,
  input  wire          clock,
  input  wire          reset
);
  localparam ysyx_26010010_s_BOOT = 2'd0;
  localparam ysyx_26010010_s_start = 2'd1;
  localparam ysyx_26010010_s_axi_r = 2'd2;

  wire       [0:0]    _zz_when;
  reg                 when_Phase_l774;
  reg                 cache_valid_0;
  wire       [29:0]   pc_tag;
  wire       [0:0]    pc_r_addr;
  reg        [29:0]   cache_tag;
  reg                 fence_i_flag;
  wire                s_wantExit;
  reg                 s_wantStart;
  wire                s_wantKill;
  reg        [29:0]   s_pc_tag_reg;
  reg        [0:0]    s_axi_r_cnt;
  reg                 s_axi_r_ar_flag;
  reg        [1:0]    s_stateReg;
  reg        [1:0]    s_stateNext;
  wire                when_Icache_l70;
  wire                when_Icache_l75;
  wire                when_Icache_l69;
  wire                axi_ar_fire;
  wire                axi_r_fire;
  wire                when_Icache_l103;
  wire                s_onExit_BOOT;
  wire                s_onExit_start;
  wire                s_onExit_axi_r;
  wire                s_onEntry_BOOT;
  wire                s_onEntry_start;
  wire                s_onEntry_axi_r;
  wire       [31:0]   _zz_code_payload;
  reg        [31:0]   _zz_code_payload_1;
  `ifndef SYNTHESIS
  reg [39:0] s_stateReg_string;
  reg [39:0] s_stateNext_string;
  `endif


  assign _zz_when = 1'b1;
  `ifndef SYNTHESIS
  always @(*) begin
    case(s_stateReg)
      ysyx_26010010_s_BOOT : s_stateReg_string = "BOOT ";
      ysyx_26010010_s_start : s_stateReg_string = "start";
      ysyx_26010010_s_axi_r : s_stateReg_string = "axi_r";
      default : s_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(s_stateNext)
      ysyx_26010010_s_BOOT : s_stateNext_string = "BOOT ";
      ysyx_26010010_s_start : s_stateNext_string = "start";
      ysyx_26010010_s_axi_r : s_stateNext_string = "axi_r";
      default : s_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    when_Phase_l774 = 1'b0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
      end
      ysyx_26010010_s_axi_r : begin
        if(axi_r_fire) begin
          when_Phase_l774 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign axi_w_valid = 1'b0;
  assign axi_w_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign axi_w_payload_strb = 4'bxxxx;
  assign axi_w_payload_last = 1'bx;
  assign axi_aw_valid = 1'b0;
  assign axi_aw_payload_addr = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign axi_aw_payload_id = 4'bxxxx;
  assign axi_aw_payload_len = 8'bxxxxxxxx;
  assign axi_aw_payload_size = 3'bxxx;
  assign axi_aw_payload_burst = 2'bxx;
  assign axi_b_ready = 1'b0;
  assign axi_ar_payload_id = 4'b0000;
  always @(*) begin
    axi_ar_valid = 1'b0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
      end
      ysyx_26010010_s_axi_r : begin
        axi_ar_valid = (! s_axi_r_ar_flag);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    axi_ar_payload_addr = 32'h0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
      end
      ysyx_26010010_s_axi_r : begin
        axi_ar_payload_addr = {s_pc_tag_reg,2'b00};
      end
      default : begin
      end
    endcase
  end

  assign axi_ar_payload_len = 8'h0;
  assign axi_ar_payload_size = 3'b010;
  assign axi_ar_payload_burst = 2'b00;
  always @(*) begin
    code_payload = 32'h0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
        if(!fence_i) begin
          if(when_Icache_l69) begin
            if(!when_Icache_l70) begin
              if(!when_Icache_l75) begin
                code_payload = _zz_code_payload;
              end
            end
          end
        end
      end
      ysyx_26010010_s_axi_r : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    code_valid = 1'b0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
        code_valid = 1'b0;
        if(!fence_i) begin
          if(when_Icache_l69) begin
            if(!when_Icache_l70) begin
              if(!when_Icache_l75) begin
                code_valid = 1'b1;
              end
            end
          end
        end
      end
      ysyx_26010010_s_axi_r : begin
      end
      default : begin
      end
    endcase
  end

  assign pc_tag = addr[31 : 2];
  assign pc_r_addr = (1'b0 + 1'b0);
  assign s_wantExit = 1'b0;
  always @(*) begin
    s_wantStart = 1'b0;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
      end
      ysyx_26010010_s_axi_r : begin
      end
      default : begin
        s_wantStart = 1'b1;
      end
    endcase
  end

  assign s_wantKill = 1'b0;
  always @(*) begin
    s_stateNext = s_stateReg;
    case(s_stateReg)
      ysyx_26010010_s_start : begin
        if(fence_i) begin
          s_stateNext = ysyx_26010010_s_axi_r;
        end else begin
          if(when_Icache_l69) begin
            if(when_Icache_l70) begin
              s_stateNext = ysyx_26010010_s_axi_r;
            end else begin
              if(when_Icache_l75) begin
                s_stateNext = ysyx_26010010_s_axi_r;
              end
            end
          end
        end
      end
      ysyx_26010010_s_axi_r : begin
        if(axi_r_fire) begin
          if(when_Icache_l103) begin
            s_stateNext = ysyx_26010010_s_start;
          end
        end
      end
      default : begin
      end
    endcase
    if(s_wantStart) begin
      s_stateNext = ysyx_26010010_s_start;
    end
    if(s_wantKill) begin
      s_stateNext = ysyx_26010010_s_BOOT;
    end
  end

  assign when_Icache_l70 = (cache_tag != pc_tag);
  assign when_Icache_l75 = (! cache_valid_0);
  assign when_Icache_l69 = 1'b1;
  assign axi_ar_fire = (axi_ar_valid && axi_ar_ready);
  assign axi_r_fire = (axi_r_valid && axi_r_ready);
  assign when_Icache_l103 = (s_axi_r_cnt == 1'b0);
  assign s_onExit_BOOT = ((s_stateNext != ysyx_26010010_s_BOOT) && (s_stateReg == ysyx_26010010_s_BOOT));
  assign s_onExit_start = ((s_stateNext != ysyx_26010010_s_start) && (s_stateReg == ysyx_26010010_s_start));
  assign s_onExit_axi_r = ((s_stateNext != ysyx_26010010_s_axi_r) && (s_stateReg == ysyx_26010010_s_axi_r));
  assign s_onEntry_BOOT = ((s_stateNext == ysyx_26010010_s_BOOT) && (s_stateReg != ysyx_26010010_s_BOOT));
  assign s_onEntry_start = ((s_stateNext == ysyx_26010010_s_start) && (s_stateReg != ysyx_26010010_s_start));
  assign s_onEntry_axi_r = ((s_stateNext == ysyx_26010010_s_axi_r) && (s_stateReg != ysyx_26010010_s_axi_r));
  assign _zz_code_payload = _zz_code_payload_1;
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      axi_r_ready <= 1'b0;
      cache_valid_0 <= 1'b0;
      cache_tag <= 30'h0;
      fence_i_flag <= 1'b0;
      s_pc_tag_reg <= 30'h0;
      s_axi_r_cnt <= 1'b0;
      s_axi_r_ar_flag <= 1'b0;
      s_stateReg <= ysyx_26010010_s_BOOT;
    end else begin
      if(fence_i) begin
        fence_i_flag <= 1'b1;
      end
      s_stateReg <= s_stateNext;
      case(s_stateReg)
        ysyx_26010010_s_start : begin
          if(fence_i) begin
            cache_valid_0 <= 1'b0;
          end else begin
            if(when_Icache_l69) begin
              if(when_Icache_l70) begin
                cache_tag <= pc_tag;
                cache_valid_0 <= 1'b0;
              end
            end
          end
        end
        ysyx_26010010_s_axi_r : begin
          if(axi_ar_fire) begin
            s_axi_r_ar_flag <= 1'b1;
          end
          if(axi_r_fire) begin
            s_axi_r_cnt <= (s_axi_r_cnt + 1'b1);
            if(when_Icache_l103) begin
              axi_r_ready <= 1'b0;
              if(_zz_when[0]) begin
                cache_valid_0 <= (! fence_i_flag);
              end
              fence_i_flag <= 1'b0;
            end
          end else begin
            axi_r_ready <= 1'b1;
          end
        end
        default : begin
        end
      endcase
      if(s_onEntry_axi_r) begin
        s_pc_tag_reg <= pc_tag;
        s_axi_r_cnt <= 1'b0;
        s_axi_r_ar_flag <= 1'b0;
      end
    end
  end

  always @(posedge clock) begin
    if(when_Phase_l774) begin
      _zz_code_payload_1 <= axi_r_payload_data;
    end
  end


endmodule

module ysyx_26010010_my_debug (
  input  wire [31:0]   data_0,
  input  wire [31:0]   data_1,
  input  wire [31:0]   data_2,
  input  wire [31:0]   data_3,
  input  wire          clock
);


  ysyx_26010010_debug_fun debug_fun (
    .clk  (clock       ), //i
    .addr (32'h00000023), //i
    .data (data_0[31:0])  //i
  );
  ysyx_26010010_debug_fun debug_fun_1 (
    .clk  (clock       ), //i
    .addr (32'h00000024), //i
    .data (data_1[31:0])  //i
  );
  ysyx_26010010_debug_fun debug_fun_2 (
    .clk  (clock       ), //i
    .addr (32'h00000025), //i
    .data (data_2[31:0])  //i
  );
  ysyx_26010010_debug_fun debug_fun_3 (
    .clk  (clock       ), //i
    .addr (32'h00000026), //i
    .data (data_3[31:0])  //i
  );

endmodule


module ysyx_26010010_debug_fun(
  input               clk,
  input         [31:0]addr,
  input         [31:0]data
);
`ifndef SYNTHESIS

  `ifndef USE_IVERILOG

import "DPI-C" function void debug(input int addr,input int data);
always @(posedge clk)
begin
    debug(addr,data);
end
  `else
always @(posedge clk)
begin
    $sys_ctr(addr,data);
end

  `endif
`endif


endmodule



module ysyx_26010010_ebreak_fun(
  input ebreak_flag
);

`ifndef SYNTHESIS
  `ifndef USE_IVERILOG
import "DPI-C" function void ebreak(input int test);
always@(*)
begin
  if(ebreak_flag)
    ebreak(1);
end

  `else
always@(*)
begin
  if(ebreak_flag)
    $sys_ctr(32'd800,32'd1);
end

  `endif
`endif

endmodule
