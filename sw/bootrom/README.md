# 启动 ROM 镜像

本目录归档 Verilator 回归使用的启动镜像。

每个测试用例应放在独立目录中：

```text
sw/bootrom/<case>/
  test.yml
  <image>.bin
  [可选构建产物: .elf/.txt/.hex/sections.info]
```

`test.yml` 示例：

```yaml
name: asm_hello
image: main-asm.bin
max_cycles: 500000
trace: false
uart:
  input: "0123456789"
  start_cycle: 10000
  stop_text: "done！"
```

运行单个已归档 bootrom：

```sh
make bootrom-sim CASE=asm_hello
```

运行全部已归档 bootrom 用例：

```sh
make regress
```

运行选定用例：

```sh
make regress CASES="asm_hello"
```

当前已归档用例：

| 用例 | 镜像 | 期望 UART |
| --- | --- | --- |
| `archinfo` | `archinfo.bin` | SYS/IDL/IDH 身份和未使用寄存器检查，然后输出 `archinfo ok` |
| `asm_hello` | `main-asm.bin` | `done！` |
| `clint` | `clint.bin` | MSIP、MTIMECMP 和 MTIME 单调性检查，然后输出 `clint ok` |
| `crc` | `crc.bin` | CRC8、CRC16-1021、CRC16-8005 和 CRC32 检查，然后输出 `crc ok` |
| `flash_xip` | `flash_xip.bin` | 明确的 flash 窗口 byte/halfword/word 和 checksum 读取，然后输出 `flash xip ok` |
| `gpio` | `retrosoc_fw.bin` | GPIO 输出 `[0, 1, 2, 3, 0]`、输入 `0x4`，然后输出 `gpio ok` |
| `gpio_toggle` | `retrosoc_fw.bin` | GPIO 输出 `[0, 5, 10, 5, 10, 15, 0]`，然后输出 `gpio toggle ok` |
| `hello` | `retrosoc_fw.bin` | `done!` |
| `i2c` | `i2c.bin` | APB4 I2C reset、寄存器读回、disabled-command 和 restore 检查，然后输出 `i2c ok` |
| `psram_basic` | `retrosoc_fw.bin` | 三片 PSRAM 的边界、中点和 byte/half/word 检查，然后输出 `psram ok` |
| `pwm` | `pwm.bin` | register、counter 读回和 overflow flag 检查，然后输出 `pwm ok` |
| `qspi` | `qspi.bin` | APB4 QSPI idle 和寄存器读回检查，不启动 transfer，然后输出 `qspi ok` |
| `rcu` | `rcu.bin` | CTRL/RDIV/STAT reset、读回和 restore 检查，然后输出 `rcu ok` |
| `rng` | `rng.bin` | seed、非零、变化和 clear 检查，然后输出 `rng ok` |
| `rtc` | `rtc.bin` | 受保护寄存器和 tick/alarm flag 检查，然后输出 `rtc ok` |
| `sys_uart_input` | `retrosoc_fw.bin` | 输入 `abq`，然后输出 `uart input ok` |
| `timer` | `retrosoc_fw.bin` | timer register、count、prescaler、mask、timeout 和 restart 检查，然后输出 `timer ok` |
| `timer_multi` | `timer_multi.bin` | timer0-3 register、独立 count 和 down-count 检查，然后输出 `timer multi ok` |
| `uart_poll` | `uart_poll.bin` | 16550 polling register、raw TX 和 injected RX 检查，然后输出 `uart poll ok` |
| `wdg` | `wdg.bin` | key protection 和受保护寄存器读回检查，然后输出 `wdg ok` |

默认 Verilator 输入：

```sh
build/sw/mpc-soc/hello/hello.bin
```

不重命名产物也可以覆盖输入：

```sh
make sim BOOTROM_IMAGE=sw/bootrom/<your-image>.bin
make -C dv/verilator sim BOOTROM_IMAGE=../../sw/bootrom/<your-image>.bin
```

Verilator harness 会通过 `+bootrom=<file>` 把选中的原始二进制加载到 SPI flash DPI 模型。
