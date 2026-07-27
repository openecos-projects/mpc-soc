# mpc-soc

[![CI](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml/badge.svg)](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml)

当前版本：`0.0.1`。版本说明见 [CHANGELOG.md](CHANGELOG.md)。

`mpc-soc` 已迁移为面向 SoC 集成的模板目录，按硬件、验证仿真、软件、配置、文档和输出产物分层组织。

SoC 规格、IP 状态和地址空间展示页：[打开 SoC Overview](docs/site/index.html)。推送到 `main` 后，GitHub Pages 工作流会自动发布该页面。

## 目录结构

- `config/`：SoC、地址空间和仿真板级配置。
- `hw/`：硬件源码；`hw/ip/` 存放外设 IP，`hw/common/` 存放公共 RTL，`hw/soc/` 存放 SoC 顶层集成。
- `dv/verilator/`：保留的 Verilator SoC 仿真入口和 C++ harness。
- `sw/ecos/`：本仓库内的 `mpc-soc` BSP 包根目录，合入 ECOS-SDK 时放到 `board/mpc-soc/`。
- `docs/`：架构、地址映射、启动流程、自定义 core 接入、工具链和 IP 就绪度说明。
- `scripts/`：生成、拉取或维护脚本。
- `third_party/`：外部依赖说明，不建议直接提交大型 SDK。
- `build/`：Verilator 产物、软件镜像、日志和波形输出目录。

## 开源协议

本仓库采用 [Apache License 2.0](LICENSE)，与 `openecos-projects/embedded-sdk` 保持一致。第三方 IP、模型或迁移源码如带有独立授权声明，应同时遵循其原始授权要求。

## 快速命令

```sh
make help
make sw BOARD=mpc-soc APP=hello
make verilate
make sim BOARD=mpc-soc APP=hello
make wave
make clean-build
```

## 仿真流程（Verilator）

默认 Verilator 仿真 top 是 `hw/soc/top/asic_top.v` 中的 `SimTop`。`SimTop` 包装 `asicTop`，并在仿真侧连接 flash、PSRAM、GPIO、UART 等板级模型；`asicTop` 是带 pad 的 SoC 顶层，必要时可通过 `TOP=asicTop` 直接仿真。仿真侧固定输入、fast flash、UART 输入和停止条件由 `dv/verilator/csrc/` 中的 harness 提供。

```sh
make -C dv/verilator verilate
make -C dv/verilator sim BOARD=mpc-soc APP=hello
```

### BootROM 回归测试

运行全部归档用例，或通过 `CASES` 选择一个或多个用例：

```sh
make regress
make regress CASES="asm_hello gpio"
```

常用可选参数：

| 参数 | 默认值 | 说明 |
| --- | --- | --- |
| `CASES="<case> ..."` | 全部用例 | 只运行指定用例，名称可用空格或逗号分隔 |
| `OUTPUT=list` | `full` | 终端只显示各用例的 `PASS/FAIL`、耗时和汇总 |
| `STOP_ON_FAIL=1` | `0` | 首个失败用例结束后停止回归 |
| `MAX_CYCLES=<n>` | 用例配置值 | 覆盖所有用例的最大仿真周期数 |
| `TRACE=1` | `0` | 编译波形支持并生成 FST 波形；改变此值会重建仿真器 |
| `CORE_SEL=<n>` | `0` | 选择待测 core |

例如，以精简列表运行指定用例，并在首次失败时停止：

```sh
make regress CASES="asm_hello gpio" OUTPUT=list STOP_ON_FAIL=1
```

运行单个归档用例也可以使用：

```sh
make bootrom-sim CASE=asm_hello OUTPUT=list
```

每次回归的详细日志和汇总保存在 `build/log/regress/<timestamp>/`。同一组构建参数下，所有用例复用已构建的 Verilator 仿真器；RTL、C++ harness、filelist、`TOP`、`TRACE`、`FAST_PSRAM` 或额外 Verilator flags 变化时才会重新构建。

当前已接入 IP 的功能范围、测试状态和使用边界见 [SoC IP 就绪度说明](docs/ip-readiness.md)。

## 自定义 core 接入

当前 SoC 通过 `CORE_SEL` 选择待测 core，默认 `CORE_SEL=0`。外部用户接入自己的 core 时，应把 RTL 放入 `hw/ip/core/` 或自己的目录，更新 `hw/filelist/verilator.f`，并按 SoC 期望的 AXI master/interrupt 端口接入到 `hw/soc/top/asic_top.v`。详细端口契约和验证步骤见 `docs/custom-core.md`。

## 软件流程（ECOS-SDK）

`sw/ecos/` 现在是可直接合入 ECOS-SDK 主线的 `mpc-soc` 板卡 BSP 包根目录；合入 SDK 时应复制到 `board/mpc-soc/`。本仓库私有构建 wrapper 放在 `sw/Makefile` 和 `sw/ecos.mk`。软件流默认从 `sw/ecos/templates/<app>/` 编译应用，输出到 `build/sw/mpc-soc/<app>/`。可通过变量指定 SDK 和工具链：

```sh
make -C sw info
make -C sw BOARD=mpc-soc APP=hello ECOS_SDK=/path/to/ecos-sdk CROSS_COMPILE=riscv64-unknown-elf-
```

## 仿真入口（IP）

旧的 IP 本地仿真入口已清理；仓库内保留的仿真入口统一收敛到 `dv/verilator/` 的 SoC 级 Verilator 流。IP 的 RTL、模型、testbench 源码仍保留在 `hw/ip/` 下，后续如需 IP 级仿真应新增 Verilator 入口。

## 迁移映射

- `new-ip/<name>/` → `hw/ip/<name>/`
- `new-ip/common/` → `hw/common/`
- `perip/uart16550/` → `hw/ip/uart16550/`
- `perip/spi/` → `hw/ip/spi/legacy_apb/`
- `perip/flash/` → `hw/ip/flash/model/`
- `perip/psram/` → `hw/ip/psram/model/esp_psram64h/`
- `perip/tc_io.v` → `hw/soc/top/tc_io.v`
- `build/ElaborateTop.v` → `hw/soc/top/asic_top.v`

英文版：`README_EN.md`
