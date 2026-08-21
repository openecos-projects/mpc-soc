module apb4_simple_stub (
    input  wire        apb4_pclk,
    input  wire        apb4_presetn,
    input  wire        apb4_psel,
    input  wire        apb4_penable,
    input  wire        apb4_pwrite,
    input  wire [31:0] apb4_paddr,
    input  wire [2:0]  apb4_pprot,
    input  wire [31:0] apb4_pwdata,
    input  wire [3:0]  apb4_pstrb,
    output wire        apb4_pready,
    output wire        apb4_pslverr,
    output wire [31:0] apb4_prdata
);
  assign apb4_pready = apb4_psel & apb4_penable;
  assign apb4_pslverr = 1'b0;
  assign apb4_prdata = 32'h0;

  wire unused = &{apb4_pclk, apb4_presetn, apb4_pwrite, apb4_paddr, apb4_pprot, apb4_pwdata, apb4_pstrb, 1'b0};
endmodule

`ifndef USE_REAL_CLINT
module apb4_clint (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    output wire clint_tmr_irq_o,
    output wire clint_sfr_irq_o
);
  apb4_simple_stub bus (.*);
  assign clint_tmr_irq_o = 1'b0;
  assign clint_sfr_irq_o = 1'b0;
endmodule
`endif

`ifndef USE_REAL_PLIC
module apb4_plic (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire [31:0] plic_irq_i,
    output wire plic_irq_o
);
  apb4_simple_stub bus (.*);
  assign plic_irq_o = 1'b0;
  wire unused_plic = |plic_irq_i;
endmodule
`endif

`ifndef USE_REAL_RCU
module apb4_rcu (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire rcu_ext_lfosc_clk_i,
    input wire rcu_ext_hfosc_clk_i,
    input wire rcu_ext_audosc_clk_i,
    input wire rcu_ext_rst_n_i,
    input wire rcu_wdt_rst_n_i,
    input wire rcu_pll_en_i,
    input wire [1:0] rcu_clk_cfg_i,
    input wire [4:0] rcu_core_sel_i,
    output wire [4:0] rcu_core_sel_o,
    output wire [6:0] rcu_clk_o,
    output wire rcu_rst_n_o
);
  apb4_simple_stub bus (.*);
  assign rcu_core_sel_o = rcu_core_sel_i;
  assign rcu_clk_o = {7{apb4_pclk}};
  assign rcu_rst_n_o = rcu_ext_rst_n_i & rcu_wdt_rst_n_i;
  wire unused_rcu = &{rcu_ext_lfosc_clk_i, rcu_ext_hfosc_clk_i, rcu_ext_audosc_clk_i, rcu_pll_en_i, rcu_clk_cfg_i, 1'b0};
endmodule
`endif

`ifndef USE_REAL_RTC
module apb4_rtc (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire rtc_rtc_clk_i,
    input wire rtc_rtc_rst_n_i,
    output wire rtc_irq_o
);
  apb4_simple_stub bus (.*);
  assign rtc_irq_o = 1'b0;
  wire unused_rtc = rtc_rtc_clk_i & rtc_rtc_rst_n_i;
endmodule
`endif

`ifndef USE_REAL_WDG
module apb4_wdg (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire wdg_rtc_clk_i,
    output wire wdg_rst_o
);
  apb4_simple_stub bus (.*);
  assign wdg_rst_o = 1'b0;
  wire unused_wdg = wdg_rtc_clk_i;
endmodule
`endif

`ifndef USE_REAL_ARCHINFO
module apb4_archinfo (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata
);
  apb4_simple_stub bus (.*);
endmodule
`endif

`ifndef USE_REAL_GPIO
module apb4_gpio (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire [31:0] gpio_gpio_in_i,
    output wire [31:0] gpio_gpio_out_o,
    output wire [31:0] gpio_gpio_dir_o,
    output wire [31:0] gpio_gpio_alt_in_o,
    input wire [31:0] gpio_gpio_alt_0_out_i,
    input wire [31:0] gpio_gpio_alt_0_dir_i,
    input wire [31:0] gpio_gpio_alt_1_out_i,
    input wire [31:0] gpio_gpio_alt_1_dir_i,
    output wire gpio_irq_o
);
  apb4_simple_stub bus (.*);
  assign gpio_gpio_out_o = 32'h0;
  assign gpio_gpio_dir_o = 32'h0;
  assign gpio_gpio_alt_in_o = gpio_gpio_in_i;
  assign gpio_irq_o = 1'b0;
  wire unused_gpio = |{gpio_gpio_alt_0_out_i, gpio_gpio_alt_0_dir_i, gpio_gpio_alt_1_out_i, gpio_gpio_alt_1_dir_i};
endmodule
`endif

`ifndef USE_REAL_UART
module apb4_uart (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire uart_uart_rx_i,
    output wire uart_uart_tx_o,
    output wire uart_irq_o
);
  apb4_simple_stub bus (.*);
  assign uart_uart_tx_o = 1'b1;
  assign uart_irq_o = 1'b0;
  wire unused_uart = uart_uart_rx_i;
endmodule
`endif

`ifndef USE_REAL_I2C
module apb4_i2c (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire i2c_scl_i,
    output wire i2c_scl_o,
    output wire i2c_scl_dir_o,
    input wire i2c_sda_i,
    output wire i2c_sda_o,
    output wire i2c_sda_dir_o,
    output wire i2c_irq_o
);
  apb4_simple_stub bus (.*);
  assign i2c_scl_o = 1'b1;
  assign i2c_scl_dir_o = 1'b0;
  assign i2c_sda_o = 1'b1;
  assign i2c_sda_dir_o = 1'b0;
  assign i2c_irq_o = 1'b0;
  wire unused_i2c = i2c_scl_i & i2c_sda_i;
endmodule
`endif

`ifndef USE_REAL_PWM
module apb4_pwm (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    output wire [3:0] pwm_pwm_o,
    output wire pwm_irq_o
);
  apb4_simple_stub bus (.*);
  assign pwm_pwm_o = 4'h0;
  assign pwm_irq_o = 1'b0;
endmodule
`endif

`ifndef USE_REAL_TIMER
module apb4_tmr (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    input wire tmr_exclk_i,
    input wire tmr_capch_i,
    output wire tmr_irq_o
);
  apb4_simple_stub bus (.*);
  assign tmr_irq_o = 1'b0;
  wire unused_tmr = tmr_exclk_i & tmr_capch_i;
endmodule
`endif

`ifndef USE_REAL_SPI
module apb4_spi (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata,
    output wire qspi_spi_sck_o,
    output wire [3:0] qspi_spi_nss_o,
    output wire [3:0] qspi_spi_io_en_o,
    input wire [3:0] qspi_spi_io_in_i,
    output wire [3:0] qspi_spi_io_out_o,
    output wire qspi_irq_o
);
  apb4_simple_stub bus (.*);
  assign qspi_spi_sck_o = 1'b0;
  assign qspi_spi_nss_o = 4'hF;
  assign qspi_spi_io_en_o = 4'h0;
  assign qspi_spi_io_out_o = 4'h0;
  assign qspi_irq_o = 1'b0;
  wire unused_qspi = |qspi_spi_io_in_i;
endmodule
`endif

`ifndef USE_REAL_RNG
module apb4_rng (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata
);
  apb4_simple_stub bus (.*);
endmodule
`endif

`ifndef USE_REAL_CRC
module apb4_crc (
    input wire apb4_pclk,
    input wire apb4_presetn,
    input wire apb4_psel,
    input wire apb4_penable,
    input wire apb4_pwrite,
    input wire [31:0] apb4_paddr,
    input wire [2:0] apb4_pprot,
    input wire [31:0] apb4_pwdata,
    input wire [3:0] apb4_pstrb,
    output wire apb4_pready,
    output wire apb4_pslverr,
    output wire [31:0] apb4_prdata
);
  apb4_simple_stub bus (.*);
endmodule
`endif
