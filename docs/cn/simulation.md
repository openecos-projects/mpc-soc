# 仿真与波形

[English](../en/simulation.md)

`dv/verilator/` 是 SoC 级 Verilator 入口。它消费原始 flash 镜像，并默认运行
`SimTop`。`SimTop` 包装 pad 级 `asicTop`，并为 SPI flash、PSRAM、GPIO、UART、
I2C 和 QSPI 引脚连接仿真板级模型。

## 用户命令

```sh
make doctor
make check
make lint
make sim
make trace
make wave
```

- `check` 运行归档的 `hello` 冒烟
- `lint` 使用独立于仿真构建的规则检查 RTL 和 filelist
- `sim` 使用固定 `hello` 镜像启动仿真
- `trace` 以 `TRACE=1` 运行 `hello`
- `wave` 打开 `build/wave/SimTop.fst`

达到 `MAX_CYCLES` 默认判定为失败；固定镜像必须在上限前输出 `done!`。
`ALLOW_TIMEOUT=1` 不会覆盖这个已经配置的 UART 通过条件。

`make lint` 会保留仿真兼容模式中屏蔽的状态机、组合环和复位网络警告。警告会输出
供接入 core 时检查，Verilator 语法或语义错误仍会使目标失败。

指定待测 core 槽位：

```sh
make sim CORE_SEL=0 TRACE=0
make check CORE_SEL=0
```

直接运行 pad 级顶层：

```sh
make sim TOP=asicTop
```

## 流程约定

- `sw/bootrom/hello/retrosoc_fw.bin`：User Kit 固定使用的原始 flash 镜像
- `hw/filelist/verilator.f`：传给 Verilator 的 RTL file list
- `dv/verilator/csrc/sim_main.cpp`：C++ harness
- `build/verilator/obj_dir_SimTop/VSimTop`：默认仿真器
- `build/log/`：仿真日志
- `build/wave/`：生成的波形

## 当前限制

harness 会把原始二进制镜像加载到 SPI flash 模型。这里应使用 `.bin` 镜像；传入
ELF 文件时，仿真会把 ELF 字节当作 flash 内容加载。

完整 bootrom 回归由维护者在开发仓库中运行，不属于 User Kit 命令面。
