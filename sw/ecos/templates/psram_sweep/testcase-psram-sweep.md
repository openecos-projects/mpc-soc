# 扫描测试（PSRAM）

`psram_sweep` 是手动运行的 SoC 级 PSRAM 地址窗口 sweep。它有意不归档到 `sw/bootrom`，也不属于默认回归集合。

## 覆盖范围

- PSRAM 基地址：`0xc0000000`
- PSRAM 大小：`0x01800000` bytes
- 默认预留运行区：从 PSRAM 基地址开始的 `0x00010000` bytes
- 默认 sweep 步长：`0x00100000` bytes
- 访问类型：先执行 32-bit 写入 pass，再执行 32-bit 读取和检查 pass
- 进度：UART 打印阶段、百分比和当前地址

当前 XIP C runtime 会把 data/stack 放在 PSRAM 中，因此跳过前 64 KiB。对该区域执行破坏性 sweep 可能覆盖正在运行的程序。

## 运行

从仓库根目录执行：

```sh
make sim APP=psram_sweep MAX_CYCLES=200000000 TRACE=0 UART_STOP_TEXT='psram sweep ok'
```

期望的终端进度：

```text
psram sweep test start
base 0xc0000000 size 0x01800000 stride 0x00100000 reserved 0x00010000
psram sweep write 0% addr 0xc0010000
...
psram sweep read 100% addr ...
psram sweep ok
```

## 备注

可以在 `main.c` 中修改 `PSRAM_SWEEP_STRIDE` 来减小步长，但更小的步长会显著增加 SoC 级仿真时间。真正逐 word 的破坏性 sweep 应使用专用 runtime，避免把 stack/data 放在正在测试的 PSRAM 范围内。
