# 仿真与波形

[English](../en/simulation.md)

`dv/verilator/` 是 SoC 级 Verilator 入口。它消费原始 flash 镜像，并默认运行
`SimTop`。`SimTop` 包装 pad 级 `asicTop`，并为 SPI flash、PSRAM、GPIO、UART、
I2C 和 QSPI 引脚连接仿真板级模型。

## 用户命令

```sh
make doctor
make check
make sim APP=hello
make trace
make wave
```

- `check` 运行归档的 `hello` 冒烟
- `sim` 构建所选应用并启动仿真
- `trace` 以 `TRACE=1` 运行 `hello`
- `wave` 打开 `build/wave/SimTop.fst`

指定其他应用或槽位：

```sh
make sim APP=gpio CORE_SEL=0 TRACE=0
make check CASE=uart_poll
```

直接运行 pad 级顶层：

```sh
make sim TOP=asicTop APP=hello
```

## 流程约定

- `build/sw/<board>/<app>/<app>.bin`：仿真消费的原始 flash 镜像
- `hw/filelist/verilator.f`：传给 Verilator 的 RTL file list
- `dv/verilator/csrc/sim_main.cpp`：C++ harness
- `build/verilator/obj_dir_SimTop/VSimTop`：默认仿真器
- `build/log/`：仿真日志
- `build/wave/`：生成的波形

## 当前限制

harness 会把原始二进制镜像加载到 SPI flash 模型。这里应使用 `.bin` 镜像；传入
ELF 文件时，仿真会把 ELF 字节当作 flash 内容加载。

完整 bootrom 回归属于维护者入口：

```sh
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```
