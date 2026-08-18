export const SOC_DATA = {
  "soc": {
    "name": "mpc-soc",
    "top": "asicTop",
    "clockHz": 50000000,
    "reset": "active_high",
    "addressWidth": 32,
    "dataWidth": 32,
    "resetPc": "0x30000000"
  },
  "regions": [
    {
      "name": "flash",
      "base": "0x30000000",
      "size": "0x01000000",
      "kind": "memory",
      "description": "External SPI flash XIP window."
    },
    {
      "name": "psram",
      "base": "0xc0000000",
      "size": "0x01800000",
      "kind": "memory",
      "description": "External PSRAM window, three 8MiB chips."
    },
    {
      "name": "clint",
      "base": "0x02010000",
      "size": "0x00010000",
      "kind": "peripheral",
      "description": "Core-local interruptor."
    },
    {
      "name": "plic",
      "base": "0x0c000000",
      "size": "0x00400000",
      "kind": "peripheral",
      "description": "Platform-level interrupt controller."
    },
    {
      "name": "uart0",
      "base": "0x10000000",
      "size": "0x00001000",
      "kind": "peripheral",
      "irq": "2",
      "description": "UART16550 console."
    },
    {
      "name": "rcu",
      "base": "0x10002000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "Reset and clock control unit."
    },
    {
      "name": "rtc",
      "base": "0x10004000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "Real-time clock."
    },
    {
      "name": "wdg",
      "base": "0x10005000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "Watchdog timer."
    },
    {
      "name": "archinfo",
      "base": "0x10006000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "Architecture information registers."
    },
    {
      "name": "gpio0",
      "base": "0x10100000",
      "size": "0x00001000",
      "kind": "peripheral",
      "irq": "3",
      "description": "GPIO controller."
    },
    {
      "name": "uart1",
      "base": "0x10103000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB4 UART controller."
    },
    {
      "name": "i2c",
      "base": "0x10104000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB4 I2C controller."
    },
    {
      "name": "pwm",
      "base": "0x10106000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "PWM controller."
    },
    {
      "name": "timer0",
      "base": "0x10108000",
      "size": "0x00001000",
      "kind": "peripheral",
      "irq": "1",
      "description": "APB timer."
    },
    {
      "name": "timer1",
      "base": "0x10109000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB timer."
    },
    {
      "name": "timer2",
      "base": "0x1010a000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB timer."
    },
    {
      "name": "timer3",
      "base": "0x1010b000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB timer."
    },
    {
      "name": "qspi",
      "base": "0x10200000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "APB4 QSPI controller."
    },
    {
      "name": "rng",
      "base": "0x10300000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "Pseudo-random number generator."
    },
    {
      "name": "crc",
      "base": "0x10301000",
      "size": "0x00001000",
      "kind": "peripheral",
      "description": "CRC calculation engine."
    }
  ],
  "ips": [
    {
      "name": "CPU core",
      "function": "执行 RISC-V 软件，发起 AXI 访问并接收中断",
      "address": "core slot 0，默认 CORE_SEL=0",
      "status": "冒烟通过",
      "tests": "SoC 启动、基础软件",
      "risk": "指令完整性、异常/特权态、性能、长时间运行"
    },
    {
      "name": "CLINT",
      "function": "软件中断、定时器中断、mtime/mtimecmp",
      "address": "0x0201_0000",
      "status": "冒烟通过",
      "tests": "clint",
      "risk": "多核语义、竞态、边界时序"
    },
    {
      "name": "PLIC",
      "function": "外部中断汇聚、优先级和分发",
      "address": "0x0c00_0000",
      "status": "冒烟通过",
      "tests": "plic",
      "risk": "多源并发、优先级边界、压力场景"
    },
    {
      "name": "UART0 / UART16550",
      "function": "控制台串口、16550 寄存器和 FIFO",
      "address": "0x1000_0000",
      "status": "冒烟通过",
      "tests": "uart_poll、UART 输入",
      "risk": "波特率边界、溢出、错误帧、持续收发"
    },
    {
      "name": "SPI",
      "function": "SPI Flash 接口和 XIP",
      "address": "Flash：0x3000_0000",
      "status": "冒烟通过",
      "tests": "flash_xip、启动取指",
      "risk": "真实器件时序、擦写、掉电恢复、兼容性"
    },
    {
      "name": "RCU",
      "function": "时钟选择、分频和复位控制",
      "address": "0x1000_2000",
      "status": "冒烟通过",
      "tests": "rcu",
      "risk": "动态切换、复位时序、时钟门控"
    },
    {
      "name": "RTC",
      "function": "实时时钟计数",
      "address": "0x1000_4000",
      "status": "冒烟通过",
      "tests": "rtc",
      "risk": "校准、低功耗、跨时钟域、长期漂移"
    },
    {
      "name": "WDG",
      "function": "看门狗计数、超时和复位",
      "address": "0x1000_5000",
      "status": "冒烟通过",
      "tests": "wdg",
      "risk": "复位竞争、时钟异常、系统恢复"
    },
    {
      "name": "ArchInfo",
      "function": "架构和芯片信息寄存器",
      "address": "0x1000_6000",
      "status": "冒烟通过",
      "tests": "archinfo",
      "risk": "配置兼容性、只读属性完整检查"
    },
    {
      "name": "GPIO",
      "function": "GPIO 输入、输出和方向控制",
      "address": "0x1010_0000",
      "status": "冒烟通过",
      "tests": "gpio、gpio_toggle",
      "risk": "方向切换、边沿/中断、PAD 电气特性"
    },
    {
      "name": "UART1",
      "function": "APB4 UART 收发",
      "address": "0x1010_3000",
      "status": "冒烟通过",
      "tests": "uart1",
      "risk": "边界、错误和中断场景"
    },
    {
      "name": "I2C",
      "function": "I2C 主机控制器和开漏接口",
      "address": "0x1010_4000",
      "status": "冒烟通过",
      "tests": "i2c",
      "risk": "多从机、仲裁、ACK/NACK、总线恢复"
    },
    {
      "name": "PWM",
      "function": "4 路 PWM 输出",
      "address": "0x1010_6000",
      "status": "冒烟通过",
      "tests": "pwm",
      "risk": "频率/占空比边界、动态改配、抖动"
    },
    {
      "name": "Timer",
      "function": "APB 定时器，共 4 个实例",
      "address": "0x1010_8000 - 0x1010_b000",
      "status": "冒烟通过",
      "tests": "timer、timer_multi",
      "risk": "溢出、重启、并发、中断边界"
    },
    {
      "name": "QSPI",
      "function": "四线 SPI 控制器",
      "address": "0x1020_0000",
      "status": "冒烟通过",
      "tests": "qspi",
      "risk": "实际传输、模式/时钟、Flash 兼容性"
    },
    {
      "name": "RNG",
      "function": "伪随机数生成",
      "address": "0x1030_0000",
      "status": "冒烟通过",
      "tests": "rng",
      "risk": "随机性统计、种子和重复周期；不代表安全 RNG"
    },
    {
      "name": "CRC",
      "function": "CRC8/CRC16/CRC32 计算",
      "address": "0x1030_1000",
      "status": "冒烟通过",
      "tests": "crc",
      "risk": "全参数组合、连续数据、边界长度"
    },
    {
      "name": "PSRAM 控制器",
      "function": "3 片 PSRAM 访问，总计 24 MiB",
      "address": "0xc000_0000",
      "status": "冒烟通过",
      "tests": "psram_basic",
      "risk": "真实时序、带宽、刷新、温度/电压、长期压力"
    }
  ],
  "ipsEn": [
    {
      "name": "CPU core",
      "function": "Runs RISC-V software, issues AXI traffic, and takes interrupts",
      "address": "core slot 0, default CORE_SEL=0",
      "status": "smoke-pass",
      "tests": "SoC boot, basic software",
      "risk": "instruction completeness, exceptions/privilege, performance, long runs"
    },
    {
      "name": "CLINT",
      "function": "Software interrupt, timer interrupt, mtime/mtimecmp",
      "address": "0x0201_0000",
      "status": "smoke-pass",
      "tests": "clint",
      "risk": "multi-hart semantics, races, timing corners"
    },
    {
      "name": "PLIC",
      "function": "External interrupt aggregation, priority, and delivery",
      "address": "0x0c00_0000",
      "status": "smoke-pass",
      "tests": "plic",
      "risk": "concurrent sources, priority corners, stress"
    },
    {
      "name": "UART0 / UART16550",
      "function": "Console UART, 16550 registers and FIFO",
      "address": "0x1000_0000",
      "status": "smoke-pass",
      "tests": "uart_poll, UART input",
      "risk": "baud corners, overflow, error frames, sustained traffic"
    },
    {
      "name": "SPI",
      "function": "SPI flash interface and XIP",
      "address": "Flash: 0x3000_0000",
      "status": "smoke-pass",
      "tests": "flash_xip, boot fetch",
      "risk": "real-device timing, erase/program, power-loss, compatibility"
    },
    {
      "name": "RCU",
      "function": "Clock select, divide, and reset control",
      "address": "0x1000_2000",
      "status": "smoke-pass",
      "tests": "rcu",
      "risk": "dynamic switching, reset timing, clock gating"
    },
    {
      "name": "RTC",
      "function": "Real-time clock count",
      "address": "0x1000_4000",
      "status": "smoke-pass",
      "tests": "rtc",
      "risk": "calibration, low power, CDC, long-term drift"
    },
    {
      "name": "WDG",
      "function": "Watchdog count, timeout, and reset",
      "address": "0x1000_5000",
      "status": "smoke-pass",
      "tests": "wdg",
      "risk": "reset races, clock faults, system recovery"
    },
    {
      "name": "ArchInfo",
      "function": "Architecture and chip information registers",
      "address": "0x1000_6000",
      "status": "smoke-pass",
      "tests": "archinfo",
      "risk": "configuration compatibility, full read-only checks"
    },
    {
      "name": "GPIO",
      "function": "GPIO input, output, and direction",
      "address": "0x1010_0000",
      "status": "smoke-pass",
      "tests": "gpio, gpio_toggle",
      "risk": "direction changes, edges/interrupts, pad electricals"
    },
    {
      "name": "UART1",
      "function": "APB4 UART transmit and receive",
      "address": "0x1010_3000",
      "status": "smoke-pass",
      "tests": "uart1",
      "risk": "corners, errors, and interrupt cases"
    },
    {
      "name": "I2C",
      "function": "I2C host controller and open-drain interface",
      "address": "0x1010_4000",
      "status": "smoke-pass",
      "tests": "i2c",
      "risk": "multi-slave, arbitration, ACK/NACK, bus recovery"
    },
    {
      "name": "PWM",
      "function": "Four PWM outputs",
      "address": "0x1010_6000",
      "status": "smoke-pass",
      "tests": "pwm",
      "risk": "frequency/duty corners, live reconfig, jitter"
    },
    {
      "name": "Timer",
      "function": "APB timers, four instances",
      "address": "0x1010_8000 - 0x1010_b000",
      "status": "smoke-pass",
      "tests": "timer, timer_multi",
      "risk": "overflow, restart, concurrency, interrupt corners"
    },
    {
      "name": "QSPI",
      "function": "Quad SPI controller",
      "address": "0x1020_0000",
      "status": "smoke-pass",
      "tests": "qspi",
      "risk": "real transfers, mode/clock, flash compatibility"
    },
    {
      "name": "RNG",
      "function": "Pseudo-random generation",
      "address": "0x1030_0000",
      "status": "smoke-pass",
      "tests": "rng",
      "risk": "statistics, seed and period; not a secure RNG"
    },
    {
      "name": "CRC",
      "function": "CRC8/CRC16/CRC32 calculation",
      "address": "0x1030_1000",
      "status": "smoke-pass",
      "tests": "crc",
      "risk": "full parameter combinations, streaming data, edge lengths"
    },
    {
      "name": "PSRAM controller",
      "function": "Three PSRAM chips, 24 MiB total",
      "address": "0xc000_0000",
      "status": "smoke-pass",
      "tests": "psram_basic",
      "risk": "real timing, bandwidth, refresh, PVT, long stress"
    }
  ],
  "generatedFrom": [
    "config/soc.yml",
    "config/memory.yml",
    "docs/cn/ip-readiness.md",
    "docs/en/ip-readiness.md"
  ]
} as const
