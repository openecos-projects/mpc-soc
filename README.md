# mpc-soc

[English](README.en.md)

[![CI](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml/badge.svg)](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml)

当前版本：`0.0.2`。版本说明见 [CHANGELOG.md](CHANGELOG.md)。

`mpc-soc` 给多项目芯片提供可仿真、可跑软件的 RISC-V SoC 底板。当前工具基线是
Verilator 5.050。

文档站：[mpc-soc 文档](https://openecos-projects.github.io/mpc-soc/)。

## 用户流程

普通用户不要直接使用开发分支 `main`。从 CI 生成的发行分支开始：

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git my-mpc-soc
cd my-mpc-soc
git switch -c user/<name>
```

详见 [User Kit 获取与使用](docs/cn/user-kit.md)。

```sh
make doctor
make check
make lint
make sim
make trace
make wave
```

用户把 core 放到 `hw/ip/core/`，按 AXI 契约接入现有槽位，再用 `CORE_SEL`
选择待测 core。完整步骤见[用户接入指南](docs/cn/user-guide.md)，地址空间见
[内存映射](docs/cn/memory-map.md)。

## 仓库边界

- `config/`、`hw/`、`dv/`、`sw/`：SoC 配置、硬件、仿真和维护者软件。
- `docs/cn/`、`docs/en/`：路径一一对应的双语文档源。
- `mk/`、`Makefile`：稳定的用户构建入口。
- `Makefile.dev`：回归、文档站和生成物检查等维护入口。
- `dev/site/`：VitePress 主题和站点资源。
- `scripts/`：生成、检查和维护脚本。
- `third_party/`：外部依赖说明，不建议直接提交大型 SDK。
- `build/`：Verilator 产物、软件镜像、日志和波形，不要提交。

维护者命令通过独立入口执行：

```sh
make -f Makefile.dev dev-help
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make -f Makefile.dev regress
```

完整部署步骤见[维护者发布流程](docs/cn/maintainer-release.md)。
