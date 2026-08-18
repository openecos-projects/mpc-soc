# 示例：PSRAM 访问

[English](../../en/examples/psram.md)

验证软件可以通过 SoC 内存路径访问外部 PSRAM 窗口，并且 Verilator PSRAM 模型
可以正确返回已写入的数据。

## 范围

本测试覆盖 `0xc0000000` 处的 memory-mapped PSRAM 读写。

本测试不验证 PSRAM 带宽、时序裕量、刷新行为或多核一致性。

## 地址映射

| 区域 | 基地址 | 大小 | 期望片选 |
| --- | ---: | ---: | --- |
| PSRAM 片 0 | `0xc0000000` | `0x00800000` | `psram_nss_o[0]` |
| PSRAM 片 1 | `0xc0800000` | `0x00800000` | `psram_nss_o[1]` |
| PSRAM 片 2 | `0xc1000000` | `0x00800000` | `psram_nss_o[2]` |

完整预留 PSRAM 窗口为 `0xc0000000..0xc17fffff`。

## 前置条件

- `config/memory.yml` 将 PSRAM 定义为基地址 `0xc0000000`、大小 `0x01800000`
- `hw/include/soc_pkg.sv` 导出 `SOC_PSRAM_BASE` 和 `SOC_PSRAM_SIZE`
- `sw/ecos/board.h` 导出 `MPC_SOC_PSRAM_BASE` 和 `MPC_SOC_PSRAM_SIZE`
- Verilator 必须使用会把 PSRAM 引脚连接到 `ESP_PSRAM64H` 模型的仿真顶层
- 若要覆盖完整 24MiB，仿真顶层必须例化三个 PSRAM 模型

## 运行

```sh
make check CASE=psram_basic
make sim APP=psram_basic
```

启动镜像应打印 `psram test start`，写入并读回固定 pattern，成功时打印
`psram ok`，失败时打印 `psram fail`。

## 必需访问

| 地址 | 写入值 | 目的 |
| ---: | ---: | --- |
| `0xc0000000` | `0x11223344` | 片 0 的首个字 |
| `0xc0000004` | `0x55667788` | 相邻字，用于基本字节通道检查 |
| `0xc07ffffc` | `0xa5a5a5a5` | 片 0 的最后一个字 |

连接三个 PSRAM 模型时，将测试扩展为：

| 地址 | 写入值 | 目的 |
| ---: | ---: | --- |
| `0xc0800000` | `0x12345678` | 片 1 的首个字 |
| `0xc0fffffc` | `0x87654321` | 片 1 的最后一个字 |
| `0xc1000000` | `0xdeadbeef` | 片 2 的首个字 |
| `0xc17ffffc` | `0xcafebabe` | 片 2 的最后一个字 |

## 通过标准

当 UART 输出包含以下内容时，测试通过：

```text
psram test start
psram ok
```

以下情况判定失败：

- UART 输出包含 `psram fail`
- 仿真在输出 `psram ok` 前超时
- PSRAM 控制器没有对被访问地址拉起期望的片选

默认顶层是 `SimTop`。只有在 pad 级调试且 harness 会显式提供 PSRAM 引脚行为时，
才使用 `TOP=asicTop`。
