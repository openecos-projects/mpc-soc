# Memory map

[中文说明](../cn/memory-map.md)

The current map is fixed in `asic_top.v` and mirrored in `config/memory.yml`,
`hw/include/soc_pkg.sv`, and `sw/ecos/board.h`. The homepage address cards are
generated from the configuration record.

| Region | Base | Size | Description |
| --- | ---: | ---: | --- |
| flash | `0x3000_0000` | `0x0100_0000` | External SPI flash XIP window |
| psram | `0xc000_0000` | `0x0180_0000` | Main software MEM region, three 8 MiB chips |
| clint | `0x0201_0000` | `0x0001_0000` | Core-local interruptor |
| plic | `0x0c00_0000` | `0x0040_0000` | Platform-level interrupt controller |
| uart0 | `0x1000_0000` | `0x0000_1000` | Console UART placeholder |
| rcu | `0x1000_2000` | `0x0000_1000` | Reset and clock control unit |
| rtc | `0x1000_4000` | `0x0000_1000` | Real-time clock |
| wdg | `0x1000_5000` | `0x0000_1000` | Watchdog timer |
| archinfo | `0x1000_6000` | `0x0000_1000` | Architecture information registers |
| gpio0 | `0x1010_0000` | `0x0000_1000` | GPIO controller |
| uart1 | `0x1010_3000` | `0x0000_1000` | APB4 UART controller |
| i2c | `0x1010_4000` | `0x0000_1000` | APB4 I2C controller |
| pwm | `0x1010_6000` | `0x0000_1000` | PWM controller |
| timer0 | `0x1010_8000` | `0x0000_1000` | APB timer |
| timer1 | `0x1010_9000` | `0x0000_1000` | APB timer |
| timer2 | `0x1010_a000` | `0x0000_1000` | APB timer |
| timer3 | `0x1010_b000` | `0x0000_1000` | APB timer |
| qspi | `0x1020_0000` | `0x0000_1000` | APB4 QSPI controller |
| rng | `0x1030_0000` | `0x0000_1000` | Pseudo-random number generator |
| crc | `0x1030_1000` | `0x0000_1000` | CRC calculation engine |

This release supports only the fixed addresses in the table. Core integrations
must use them and must not customize the address space by editing configuration,
software headers, or `asic_top.v`. Configurable addressing is deferred to a
later release.
