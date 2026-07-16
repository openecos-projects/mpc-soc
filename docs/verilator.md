# 仿真流程（Verilator）

`dv/verilator/` 是 SoC 级 Verilator 入口。它消费原始 flash 镜像，并默认运行 `SimTop`。

`SimTop` 包装 pad 级 `asicTop`，并为 SPI flash、PSRAM、GPIO、UART、I2C 和 QSPI 引脚连接仿真板级模型。只有在明确希望 harness 直接驱动 pad 级顶层时，才使用 `TOP=asicTop`。

## 命令

```sh
# 仿真器默认期望的镜像路径:
#   build/sw/mpc-soc/hello/hello.bin
make sim MAX_CYCLES=1000
make wave
```

等价的直接命令：

```sh
make -C dv/verilator sim BOOTROM_IMAGE=../../build/sw/mpc-soc/hello/hello.bin MAX_CYCLES=1000
```

直接运行 pad 级顶层：

```sh
make sim TOP=asicTop BOOTROM_IMAGE=build/sw/mpc-soc/<app>/<app>.bin
```

使用其他已编译产物：

```sh
make sim BOOTROM_IMAGE=build/sw/mpc-soc/<app>/<app>.bin
```

## 流程约定

- `build/sw/<board>/<app>/<app>.bin`：仿真消费的原始 flash 镜像。
- `hw/filelist/verilator.f`：传给 Verilator 的 RTL file list。
- `dv/verilator/csrc/sim_main.cpp`：C++ harness；把 `+bootrom=` 加载到 SPI flash DPI 模型，驱动 `clock/reset`，并写出 FST 波形。
- `build/verilator/obj_dir_SimTop/VSimTop`：默认 `SimTop` 生成的仿真器。
- `build/verilator/obj_dir_asicTop/VasicTop`：选择 `TOP=asicTop` 时生成的仿真器。
- `build/log/`：仿真日志。
- `build/wave/`：生成的波形。

## 当前限制

harness 会把原始二进制镜像加载到 SPI flash 模型。这里应使用 `.bin` 镜像；传入 ELF 文件时，仿真会把 ELF 字节当作 flash 内容加载。
