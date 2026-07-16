# 版本说明

本文件记录 `mpc-soc` SoC 交付版本。版本说明以中文为第一语言；英文 README 仅作为辅助入口。

## 0.0.1 - 2026-07-16

### 版本定位

`0.0.1` 是 `mpc-soc` 迁移到独立 SoC 集成仓库后的首个交付基线版本。该版本面向源码交付、Verilator 仿真验证、ECOS-SDK BSP 集成和后续自定义 core 接入。

### 交付内容

- 仓库结构已按 SoC 交付边界整理为 `hw/`、`dv/`、`sw/`、`config/`、`docs/`、`scripts/`、`third_party/` 和 `build/`。
- SoC 顶层集成保留 `asicTop` 和仿真包装 `SimTop`，支持 flash、PSRAM、GPIO、UART 等仿真模型接入。
- 硬件源码保留 core、CLINT、PLIC、GPIO、UART、timer、I2C、QSPI、PSRAM、PWM、RTC、RNG、WDT 等主要 IP 目录。
- Verilator SoC 级仿真入口收敛到 `dv/verilator/`，支持构建仿真器、运行 bootrom 镜像、输出日志和波形。
- 软件侧提供 `sw/ecos/` 作为 `mpc-soc` BSP 包根目录，并保留仓库内构建 wrapper。
- bootrom 回归用例覆盖 `archinfo`、`asm_hello`、`clint`、`crc`、`flash_xip`、`gpio`、`gpio_toggle`、`hello`、`i2c`、`plic`、`psram_basic`、`pwm`、`qspi`、`rcu`、`rng`、`rtc`、`sys_uart_input`、`timer`、`timer_multi`、`uart1`、`uart_poll`、`wdg`。
- 项目自有文档已按中文优先整理，覆盖架构、启动流程、地址映射、ECOS-SDK BSP、Verilator、PSRAM 测试和自定义 core 接入。
- GitHub Actions CI 已配置为在 `main` push、pull request 和手动触发时运行。

### 验证状态

当前交付基线通过远端 `CI / SoC smoke` 流程验证，验证项包括：

- Python 脚本语法检查：`python3 -m py_compile scripts/*.py`
- SoC package 生成一致性检查：`make gen-soc-pkg` 后确认 `hw/include/soc_pkg.sv` 无差异
- 软件构建检查：`make -C sw BOARD=mpc-soc APP=hello`
- Verilator 仿真器构建：`make verilate TRACE=0`
- bootrom 完整回归：`make regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0`
- 生成产物忽略规则检查：确认未产生未跟踪的应提交文件，且工作区无差异

### 发布边界

- 本版本交付源码、配置、文档、脚本和 CI 流程，不交付 `build/` 下的本地生成产物。
- 本仓库采用 Apache License 2.0，与 `openecos-projects/embedded-sdk` 保持一致。
- ECOS-SDK 大型外部依赖不随仓库提交；`sw/ecos/` 作为 BSP 包合入 SDK 时应放到 `board/mpc-soc/`。
- `third_party/` 用于记录外部依赖说明，不建议直接提交大型 SDK 或工具链。
- 迁移自外部或第三方 IP 的原始文档不在本版本中整体翻译；项目自有文档已保持中文优先。

### 已知限制

- 当前 CI 使用 GitHub-hosted `ubuntu-24.04` runner 和系统包 Verilator，完整 bootrom regression 耗时约 22 分钟。
- CI 为完整回归配置，不是最短 smoke；后续如果需要更快的 PR 反馈，可单独新增快速检查 workflow。
- 外部或第三方 IP 的授权边界仍需在正式对外交付前逐项复核。
