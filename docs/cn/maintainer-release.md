# 维护者发布流程

[English](../en/maintainer-release.md)

本文只面向 `mpc-soc` 维护者，不属于用户站点内容。

## 仓库边界

- `Makefile`、`mk/common.mk`、`mk/user.mk`：稳定的用户构建入口
- `Makefile.dev`、`mk/dev.mk`：回归、文档站和生成物检查
- `docs/cn/`、`docs/en/`：路径一一对应的双语文档源
- `dev/site/`：VitePress 主题和站点资源，不保存第二份 Markdown
- `dev/site-docs.json`：公共站点页面白名单
- `config/`、`hw/`、`dv/`、`sw/`：SoC 本体，保持现有硬件、验证和软件分层

## 合并前验证

```sh
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make gen-soc-pkg
git diff --exit-code hw/include/soc_pkg.sv
make check
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```

## 发布调用链

合并并 push 到 `main` 后：

```text
CI                     -> 源码、软件、Verilator 和 bootrom 回归
Documentation Pages    -> 仅构建 dev/site-docs.json 允许的用户页面
```

## 历史迁移映射

这些路径只对维护历史有用，不属于用户文档：

- `new-ip/<name>/` → `hw/ip/<name>/`
- `new-ip/common/` → `hw/common/`
- `perip/uart16550/` → `hw/ip/uart16550/`
- `perip/spi/` → `hw/ip/spi/legacy_apb/`
- `perip/flash/` → `hw/ip/flash/model/`
- `perip/psram/` → `hw/ip/psram/model/esp_psram64h/`
- `perip/tc_io.v` → `hw/soc/top/tc_io.v`
- `build/ElaborateTop.v` → `hw/soc/top/asic_top.v`
