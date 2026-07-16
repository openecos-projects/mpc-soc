# mpc-soc

[![CI](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml/badge.svg)](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml)

当前版本：`0.0.1`。版本说明见 [CHANGELOG.md](CHANGELOG.md)。

`mpc-soc` 已迁移为面向 SoC 集成的模板目录，按硬件、验证仿真、软件、配置、文档和输出产物分层组织。

## 目录结构

- `config/`：SoC、地址空间和仿真板级配置。
- `hw/`：硬件源码；`hw/ip/` 存放外设 IP，`hw/common/` 存放公共 RTL，`hw/soc/` 存放 SoC 顶层集成。
- `dv/verilator/`：保留的 Verilator SoC 仿真入口和 C++ harness。
- `sw/ecos/`：本仓库内的 `mpc-soc` BSP 包根目录，合入 ECOS-SDK 时放到 `board/mpc-soc/`。
- `docs/`：架构、地址映射、启动流程、自定义 core 接入和工具链说明。
- `scripts/`：生成、拉取或维护脚本。
- `third_party/`：外部依赖说明，不建议直接提交大型 SDK。
- `build/`：Verilator 产物、软件镜像、日志和波形输出目录。

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
