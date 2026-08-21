# 架构说明

[English](../en/architecture.md)

`mpc-soc` 是面向 SoC 集成的 RISC-V 底板：CPU 通过 AXI master 访问 flash / PSRAM，
再经 AXI4 到 APB4 的互连访问外设。默认仿真顶层是 `SimTop`，它包装 pad 级
`asicTop` 并接上板级模型。

## 源码组织

- `hw/soc/top/` 存放 SoC 集成顶层。
- `hw/soc/bus/`、`hw/soc/reset/` 和 `hw/soc/clock/` 预留给 SoC 级总线、复位和时钟集成逻辑。
- `hw/ip/` 存放可复用 IP，每个 IP 可以包含自己的 `rtl/`、`tb/` 或 `dv/`、`driver/` 和 `doc/` 目录。
- `hw/common/` 存放公共 RTL 工具。
- `hw/ip/` 同时保留 SoC 仍在使用的兼容实现，例如 `hw/ip/spi/legacy_apb/`。

## 配置来源

- `config/soc.yml` 记录当前 SoC 顶层、IP 路径和固定的 50 MHz 时钟元数据。
- `config/memory.yml` 记录当前版本的固定地址映射，并生成 RTL package。
- `config/boards/sim.yml` 记录仿真板级的 50 MHz 默认配置。

这些配置在当前版本中是随固化 `asic_top.v` 发布的描述信息，不是用户可重定向 SoC
地址或时钟的配置入口。维护者 CI 会检查各处 50 MHz 固定值没有漂移。

## 集成流程

1. SoC 集成顶层保持在 `hw/soc/top/` 下；新增或重命名模块时同步更新 `hw/filelist/verilator.f`。
2. 顶层总线、时钟、复位和中断连线放在 `hw/soc/` 下。
3. 同步更新 `hw/filelist/soc.f` 和 `hw/filelist/verilator.f`。
4. 当前版本保持固化的地址空间和 50 MHz 时钟；不要通过修改配置文件尝试重定向
   `asic_top.v`。可配置地址空间留到后续版本实现完整链路后支持。

CPU 替换或 bring-up 工作请遵循 [用户接入指南](user-guide.md) 中的 core 槽位和 AXI 接口约定。
