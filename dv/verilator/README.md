# 仿真流程（Verilator）

本目录是 SoC 级 Verilator 入口。流程从 `build/sw/<board>/<app>/` 读取原始 flash 镜像。

## 快速开始

```sh
# 如有需要，先构建软件:
#   make -C sw BOARD=mpc-soc APP=hello
make sim MAX_CYCLES=1000
make wave
```

直接入口：

```sh
make -C dv/verilator sim BOOTROM_IMAGE=../../build/sw/mpc-soc/hello/hello.bin MAX_CYCLES=1000
```

## 流程

1. 软件构建到 `build/sw/<board>/<app>/`。
2. `make sim` 默认 Verilate `hw/filelist/verilator.f`，并运行 `build/verilator/obj_dir_SimTop/VSimTop`。
3. harness 接收 `+bootrom=<path>`，把原始二进制加载到 SPI flash DPI 模型，驱动 `clock/reset`，并在 `TRACE=1` 时写出 FST。
4. 日志输出到 `build/log/`；波形输出到 `build/wave/`。

默认 Verilator 顶层是 `SimTop`。它包装 pad 级 `asicTop` 并连接仿真板级模型。只有在 harness 需要直接驱动 pad 级 SoC 顶层时才使用 `TOP=asicTop`。仿真专用板级行为应保留在 `dv/verilator/csrc/` 中，共享 RTL 和 filelist 条目放在 `hw/` 下。
