# SoC IP readiness

[中文说明](../cn/ip-readiness.md)

This page records the functional scope, verification status, and limits of the
IPs currently integrated in the SoC. The homepage IP table is generated from
this document and `config/memory.yml`.

The `smoke-pass` label means the IP has been taped out and has passed basic
functional tests. It does not mean corner cases, exceptions, performance, or
long-term stability are complete.

## Integrated IPs

Addresses follow `config/memory.yml` and the [memory map](memory-map.md).

| IP | Function | Address / instance | Status | Tests | Main gaps |
| --- | --- | --- | --- | --- | --- |
| CPU core | Runs RISC-V software, issues AXI traffic, and takes interrupts | core slot 0, default `CORE_SEL=0` | smoke-pass | SoC boot, basic software | instruction completeness, exceptions/privilege, performance, long runs |
| CLINT | Software interrupt, timer interrupt, `mtime/mtimecmp` | `0x0201_0000` | smoke-pass | `clint` | multi-hart semantics, races, timing corners |
| PLIC | External interrupt aggregation, priority, and delivery | `0x0c00_0000` | smoke-pass | `plic` | concurrent sources, priority corners, stress |
| UART0 / UART16550 | Console UART, 16550 registers and FIFO | `0x1000_0000` | smoke-pass | `uart_poll`, UART input | baud corners, overflow, error frames, sustained traffic |
| SPI | SPI flash interface and XIP | Flash: `0x3000_0000` | smoke-pass | `flash_xip`, boot fetch | real-device timing, erase/program, power-loss, compatibility |
| RCU | Clock select, divide, and reset control | `0x1000_2000` | smoke-pass | `rcu` | dynamic switching, reset timing, clock gating |
| RTC | Real-time clock count | `0x1000_4000` | smoke-pass | `rtc` | calibration, low power, CDC, long-term drift |
| WDG | Watchdog count, timeout, and reset | `0x1000_5000` | smoke-pass | `wdg` | reset races, clock faults, system recovery |
| ArchInfo | Architecture and chip information registers | `0x1000_6000` | smoke-pass | `archinfo` | configuration compatibility, full read-only checks |
| GPIO | GPIO input, output, and direction | `0x1010_0000` | smoke-pass | `gpio`, `gpio_toggle` | direction changes, edges/interrupts, pad electricals |
| UART1 | APB4 UART transmit and receive | `0x1010_3000` | smoke-pass | `uart1` | corners, errors, and interrupt cases |
| I2C | I2C host controller and open-drain interface | `0x1010_4000` | smoke-pass | `i2c` | multi-slave, arbitration, ACK/NACK, bus recovery |
| PWM | Four PWM outputs | `0x1010_6000` | smoke-pass | `pwm` | frequency/duty corners, live reconfig, jitter |
| Timer | APB timers, four instances | `0x1010_8000` - `0x1010_b000` | smoke-pass | `timer`, `timer_multi` | overflow, restart, concurrency, interrupt corners |
| QSPI | Quad SPI controller | `0x1020_0000` | smoke-pass | `qspi` | real transfers, mode/clock, flash compatibility |
| RNG | Pseudo-random generation | `0x1030_0000` | smoke-pass | `rng` | statistics, seed and period; not a secure RNG |
| CRC | CRC8/CRC16/CRC32 calculation | `0x1030_1000` | smoke-pass | `crc` | full parameter combinations, streaming data, edge lengths |
| PSRAM controller | Three PSRAM chips, 24 MiB total | `0xc000_0000` | smoke-pass | `psram_basic` | real timing, bandwidth, refresh, PVT, long stress |

## Usage limits

- This release is suitable for SoC bring-up, basic software porting, and
  functional integration.
- `smoke-pass` does not mean every exception, corner, or performance metric is
  verified.
- Production reliability, device compatibility, PVT, and long-term operation
  still need separate confirmation.

The SPI flash and three PSRAM models in simulation only check access paths.
They do not prove real-device or pad electrical behavior.
