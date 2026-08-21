# 持续集成

[English](../en/ci.md)

本文只面向 `mpc-soc` 维护者，不属于用户站点内容。

根工程使用 `.github/workflows/ci.yml` 执行 Ubuntu 24.04 单平台 CI。文档站使用
独立的 `.github/workflows/pages.yml`，以 Node.js 构建 VitePress 静态文件。
`.github/workflows/user-kit.yml` 导出并测试用户环境。

## 自动门禁

提交到 `main` 或向 `main` 提交 pull request 时运行：

- Python 脚本语法检查
- `make -f Makefile.dev gen-soc-pkg` 后确认 `hw/include/soc_pkg.sv` 无差异
- 检查当前版本的配置、RTL package 和 BSP 默认时钟均为固定 50 MHz
- `make -f Makefile.dev docs-check`
- 维护者软件构建：`make -C sw BOARD=mpc-soc APP=hello`
- XIP 与 MEM 链接目标的软件配置重建检查
- Verilator 仿真器构建：`make verilate TRACE=0`
- 使用 `done!` 通过条件运行本次源码构建的 `hello` 镜像
- bootrom 回归：`make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0`
- 确认未产生应提交的未跟踪文件

`make lint` 是独立的用户/维护者检查目标，当前不属于 CI 门禁；CI 仍只构建并运行
默认 `CORE_SEL=0` 示例 core。

## 文档站部署

文档、主题或站点构建脚本变化时，`Documentation Pages` 工作流先运行
`make -f Makefile.dev docs-site-check`。pull request 只构建并验证站点；合并到
`main` 后部署到 `https://openecos-projects.github.io/mpc-soc/`。

## User Kit 发布

User Kit workflow 在 pull request 中导出并运行固定 `hello` 镜像 smoke。合并到
`main` 后，只有同一 SHA 的完整 `CI` 成功，才会触发正式导出与发布。新版本更新
orphan `release/user-kit` 分支，并创建不可变的 `user-kit-v<version>` 标签和
GitHub Release 压缩包；已存在的版本不会被覆盖。开发者文件不会进入发行包。
