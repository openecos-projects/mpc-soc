# 用户接入指南

[English](../en/user-guide.md)

这份指南面向要把自己的 RISC-V core 接到 `mpc-soc`，并跑通 SoC 级仿真的用户。
用户只需要准备 core RTL 和 wrapper，按约定接入现有槽位，不必改外设、固定软件
镜像或维护者回归脚本。

完整示例：

- [Hello 冒烟](examples/hello.md)：默认 core 跑通控制台输出

## 1. 获取 User Kit

普通用户不要从开发分支 `main` 开始。先拉取由 CI 独立构建和仿真验证的用户发行
分支，再创建自己的开发分支：

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git my-mpc-soc
cd my-mpc-soc
git switch -c user/<name>
```

上游 `release/user-kit` 会被 CI 强制更新，不要直接在该分支长期开发。需要推送到
自己的仓库、升级发行包或查看交付边界时，参考
[User Kit 获取与使用](user-kit.md)。

## 2. 检查工具

需要 Python 3.9+、PyYAML、GNU Make、C++ 编译器和 Verilator 5.050。
当前 User Kit 要求使用该版本。固定镜像仿真不需要 RISC-V 工具链或软件 SDK。

```sh
make doctor
```

## 3. 先跑通默认 SoC

不要先改 RTL。先确认当前仓库在默认 `CORE_SEL=0` 下可以仿真：

```sh
make check
make lint
make trace
make wave
```

- `check` 运行归档的 `hello` bootrom 冒烟
- `lint` 检查当前 RTL/filelist，并报告仿真兼容模式屏蔽的结构警告
- `trace` 使用固定 `hello` 镜像重新运行仿真并生成波形
- `wave` 用 GTKWave 打开最近一次 `TRACE=1` 生成的 FST

## 4. 选择 core 槽位

当前 SoC 通过 `CORE_SEL` 选择启用的 core：

- `CORE_SEL=0`：`hw/soc/top/asic_top.v` 中的 `NPC core0`
- `CORE_SEL=1`：`hw/soc/top/asic_top.v` 中的 `ysyx_26010010` core1
- `CORE_SEL=2..15`：总线槽位已存在，但 core 侧信号目前有意 tie off

最低风险的接入方式是在槽位 0 或槽位 1 替换为自己 core 的 wrapper。
若要使用槽位 2 或更高编号，需要在 `asic_top.v` 中移除对应 tie-off，
例化自己的 wrapper，并使用 `CORE_SEL=<slot>` 运行。

## 5. 按约定写 wrapper

SoC 期望每个 core wrapper 暴露以下接口：

- `clock`：输入，上升沿有效
- `reset`：输入，高有效。SoC 会对未启用的 core 槽位施加复位
- `io_interrupt`：输入，来自平台中断路径的一根中断线
- `io_master_*`：一组 32-bit AXI4 master 风格接口
- `io_slave_*`：可选 AXI slave 风格接口。现有 core 未使用时会 tie off

master 接口当前使用以下位宽：

| 通道 | 信号 |
| --- | --- |
| AW | `awready`, `awvalid`, `awid[3:0]`, `awaddr[31:0]`, `awlen[7:0]`, `awsize[2:0]`, `awburst[1:0]` |
| W | `wready`, `wvalid`, `wdata[31:0]`, `wstrb[3:0]`, `wlast` |
| B | `bready`, `bvalid`, `bid[3:0]`, `bresp[1:0]` |
| AR | `arready`, `arvalid`, `arid[3:0]`, `araddr[31:0]`, `arlen[7:0]`, `arsize[2:0]`, `arburst[1:0]` |
| R | `rready`, `rvalid`, `rid[3:0]`, `rdata[31:0]`, `rresp[1:0]`, `rlast` |

如果你的 core 使用不同的总线形态，请增加 wrapper，把它适配到上述约定。
协议转换应放在 wrapper 内，避免牵动无关 SoC 逻辑。

仓库提供一个 NPC 风格模板：

```text
hw/ip/core/npc_wrapper_template.sv
```

复制该文件、重命名模块，并用你的 core 例化替换模板中的空闲 master assignment。

## 6. 接入 RTL

1. 把 core RTL 和 wrapper 放到 `hw/ip/core/` 或其他仓库内目录。
2. 把新文件加入 `hw/filelist/verilator.f`。现有条目是：

```text
../../hw/ip/core/NPC-bstage.sv
../../hw/ip/core/ysyx_26010010.v
```

所有必需源码都应出现在 `hw/soc/top/asic_top.v` 之前。
3. 在目标槽位例化 wrapper，连接 `_cpu_<slot>_io_master_*` 和
   `_cmp_io_interrupt_out_<slot>`。
4. 在 wrapper 内部或例化位置 tie off 未使用的可选 slave 端口。

## 7. 验证自己的 core

```sh
make check CORE_SEL=<slot>
make lint
make sim CORE_SEL=<slot> TRACE=0
```

冒烟通过后，把 core 变更交给维护者在开发仓库中运行完整回归。
`release/user-kit` 不包含维护者入口。

## 8. 用户可编写内容

当前版本允许用户编写和交付：

- core RTL
- AXI wrapper
- `hw/filelist/verilator.f` 中的必要条目
- 目标 core 槽位的必要连接

SoC 地址空间、外设 RTL、固定 `hello` 镜像、软件和驱动不属于支持的用户修改面。
若用户自行修改这些内容，需要自行承担集成和验证责任。

## 常见错误

- 改了 RTL 但没更新 `hw/filelist/verilator.f`
- 替换或删除发行包中的固定 `hello` 镜像
- 未启用槽位仍保持 tie-off，却使用了对应 `CORE_SEL`
- 提交了 `build/` 下的生成产物

默认 Verilator 顶层是 `SimTop`。只有调试 pad 级行为时才需要 `TOP=asicTop`。
