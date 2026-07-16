# 自定义 Core 接入

本项目的目标是让用户可以把 CPU core 接入现有 SoC，并运行 SoC 级 Verilator 回归。当前 SoC 通过 `CORE_SEL` 选择启用的 core。

## 当前 Core 槽位

- `CORE_SEL=0`：连接到 `hw/soc/top/asic_top.v` 中的 `NPC core0`。
- `CORE_SEL=1`：连接到 `hw/soc/top/asic_top.v` 中的 `ysyx_26010010_ysyx_26010010 core1`。
- `CORE_SEL=2..15`：总线槽位已存在，但 core 侧信号目前有意 tie off。

最低风险的接入方式是在槽位 0 或槽位 1 替换为自己 core 的 wrapper。若要使用槽位 2 或更高编号，需要在 `hw/soc/top/asic_top.v` 中移除对应 tie-off，例化自己的 core wrapper，并使用 `CORE_SEL=<slot>` 运行。

## 期望 Core 接口约定

SoC 期望每个 core wrapper 暴露以下接口：

- `clock`：输入，上升沿有效。
- `reset`：输入，高有效。SoC 会对未启用的 core 槽位施加复位。
- `io_interrupt`：输入，来自平台中断路径的一根中断线。
- `io_master_*`：一组 32-bit AXI4 master 风格接口。
- `io_slave_*`：可选 AXI slave 风格接口。现有 core 未使用时会 tie off 这一侧。

master 接口当前使用以下位宽：

| 通道 | 信号 |
| --- | --- |
| AW | `awready`, `awvalid`, `awid[3:0]`, `awaddr[31:0]`, `awlen[7:0]`, `awsize[2:0]`, `awburst[1:0]` |
| W | `wready`, `wvalid`, `wdata[31:0]`, `wstrb[3:0]`, `wlast` |
| B | `bready`, `bvalid`, `bid[3:0]`, `bresp[1:0]` |
| AR | `arready`, `arvalid`, `arid[3:0]`, `araddr[31:0]`, `arlen[7:0]`, `arsize[2:0]`, `arburst[1:0]` |
| R | `rready`, `rvalid`, `rid[3:0]`, `rdata[31:0]`, `rresp[1:0]`, `rlast` |

如果你的 core 使用不同的总线形态，请增加 wrapper 模块，把它适配到上述接口约定。协议转换应尽量放在 wrapper 内，并保持 wrapper 小而清晰，避免牵动无关 SoC 逻辑。

## Wrapper 模板

仓库提供一个 NPC 风格的包裹层模板：

```text
hw/ip/core/npc_wrapper_template.sv
```

该模板暴露 SoC 期望的 `clock`、`reset`、`io_interrupt`、`io_master_*` 和 `io_slave_*` 端口。默认实现不会发起 AXI master 访问，slave 侧也保持 tie off；接入真实 core 时应复制该文件、重命名模块，并用你的 core 例化替换模板中的 idle master assignment。

## 文件列表修改

把新的 RTL 文件加入 `hw/filelist/verilator.f`。现有 core RTL 条目如下：

```text
../../hw/ip/core/NPC-bstage.sv
../../hw/ip/core/ysyx_26010010.v
```

自定义 core RTL 可以放在 `hw/ip/core/` 或其他仓库内目录。所有必需源码都应在 `hw/soc/top/asic_top.v` 之前加入 filelist。

## 接入步骤

1. 添加你的 core RTL 和 wrapper。
2. 更新 `hw/filelist/verilator.f`。
3. 在 `hw/soc/top/asic_top.v` 的目标槽位上例化 wrapper。
4. 将 wrapper 的 `io_master_*` 端口连接到对应槽位信号，例如 `_cpu_<slot>_io_master_*`。现有 SoC 选择逻辑会按 `CORE_SEL` 路由启用的槽位。
5. 将槽位中断线，例如 `_cmp_io_interrupt_out_<slot>`，连接到 wrapper 的 `io_interrupt` 输入。
6. 在 wrapper 内部或例化位置 tie off 未使用的可选 slave 端口。
7. 使用目标槽位运行短冒烟测试：

```sh
make sim APP=hello CORE_SEL=<slot> TRACE=0 MAX_CYCLES=1000
```

8. 冒烟测试通过后运行完整回归：

```sh
make regress CORE_SEL=<slot> OUTPUT=list TRACE=0
make clean-build
```

## 备注

- 默认 Verilator 顶层是 `SimTop`，它包装 `asicTop` 并连接仿真板级模型。
- 只有在直接调试 pad 级 SoC 行为时才需要 `TOP=asicTop`。
- 仿真器消费原始 `.bin` 镜像，不消费 ELF 文件。
- 不要提交生成的 `build/` 输出。
