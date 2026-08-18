# 持续集成

[English](../en/ci.md)

本文只面向 `mpc-soc` 维护者，不属于用户站点内容。

根工程使用 `.github/workflows/ci.yml` 执行 Ubuntu 24.04 单平台 CI。文档站使用
独立的 `.github/workflows/pages.yml`，以 Node.js 构建 VitePress 静态文件。

## 自动门禁

提交到 `main` 或向 `main` 提交 pull request 时运行：

- Python 脚本语法检查
- `make gen-soc-pkg` 后确认 `hw/include/soc_pkg.sv` 无差异
- `make -f Makefile.dev docs-check`
- 软件构建：`make sw APP=hello`
- Verilator 仿真器构建：`make verilate TRACE=0`
- bootrom 回归：`make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0`
- 确认未产生应提交的未跟踪文件

## 文档站部署

文档、主题或站点构建脚本变化时，`Documentation Pages` 工作流先运行
`make -f Makefile.dev docs-site-check`。pull request 只构建并验证站点；合并到
`main` 后部署到 `https://openecos-projects.github.io/mpc-soc/`。
