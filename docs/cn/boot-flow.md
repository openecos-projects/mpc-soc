# 启动流程

[English](../en/boot-flow.md)

User Kit 的 Verilator 流程读取固定的
`sw/bootrom/hello/retrosoc_fw.bin`，并通过 `+bootrom=<path>` 传给仿真 harness。

## 模板流程

1. 复位后进入 SoC 启动地址，取指路径走 SPI flash。
2. 仿真 harness 通过 `+bootrom=<path>` 传入原始 flash 镜像路径。
3. RTL 发起 SPI flash 读访问时，flash DPI 模型从该镜像读取字节。
4. 固定镜像中的启动代码初始化运行环境并执行 `hello`。
5. 用户接入的 core 通过现有总线和外设路径运行同一个镜像。

当前版本不提供软件 SDK 或驱动构建入口，也不支持替换发行包中的固定镜像。
