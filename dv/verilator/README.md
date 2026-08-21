# 仿真流程（Verilator）

本目录是 SoC 级 Verilator 入口。User Kit 固定使用随包提供的
`sw/bootrom/hello/retrosoc_fw.bin` 原始 flash 镜像。

## 快速开始

```sh
make sim MAX_CYCLES=1000
make wave
```

根目录用户入口是 `make doctor`、`make check`、`make lint`、`make sim`、`make trace` 和 `make wave`。

直接入口：

```sh
make -C dv/verilator sim \
  BOOTROM_IMAGE=../../sw/bootrom/hello/retrosoc_fw.bin \
  UART_STOP_TEXT='done!' MAX_CYCLES=500000
make -C dv/verilator lint
```

## 流程

1. `make sim` 使用发行包中的固定 `hello` 镜像。
2. 仿真默认 Verilate `hw/filelist/verilator.f`，并运行 `build/verilator/obj_dir_SimTop/VSimTop`。
3. harness 接收 `+bootrom=<path>`，把原始二进制加载到 SPI flash DPI 模型，驱动 `clock/reset`，并在 `TRACE=1` 时写出 FST。
4. 日志输出到 `build/log/`；波形输出到 `build/wave/`。

`lint` 使用独立的 Verilator lint 参数，只检查 RTL/filelist，不构建或运行 C++
harness。仿真为了兼容固化顶层而屏蔽的 `CASEINCOMPLETE`、`UNOPTFLAT` 和
`SYNCASYNCNET` 警告会在 lint 输出中保留。

默认 Verilator 顶层是 `SimTop`。它包装 pad 级 `asicTop` 并连接仿真板级模型。只有在 harness 需要直接驱动 pad 级 SoC 顶层时才使用 `TOP=asicTop`。仿真专用板级行为应保留在 `dv/verilator/csrc/` 中，共享 RTL 和 filelist 条目放在 `hw/` 下。
