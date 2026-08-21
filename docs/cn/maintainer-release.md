# 维护者发布流程

[English](../en/maintainer-release.md)

本文只面向 `mpc-soc` 维护者，不属于用户站点内容。

## 仓库边界

- `Makefile`、`mk/common.mk`、`mk/user.mk`：稳定的用户构建入口
- `Makefile.dev`、`mk/dev.mk`：回归、文档站和生成物检查
- `docs/cn/`、`docs/en/`：路径一一对应的双语文档源
- `dev/site/`：VitePress 主题和站点资源，不保存第二份 Markdown
- `dev/site-docs.json`：公共站点页面白名单
- `dev/user-kit.json`：User Kit 文件和目录白名单
- `dev/user-kit/`：User Kit 顶层 README 与忽略规则
- `config/`、`hw/`、`dv/`、`sw/`：SoC 本体，保持现有硬件、验证和软件分层

## 合并前验证

```sh
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make -f Makefile.dev export-user-kit
make -f Makefile.dev gen-soc-pkg
git diff --exit-code hw/include/soc_pkg.sv
make -f Makefile.dev config-check
make check
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```

## 发布调用链

合并并 push 到 `main` 后：

```text
CI                     -> 源码、软件、Verilator 和 bootrom 回归
Documentation Pages    -> 仅构建 dev/site-docs.json 允许的用户页面
User Kit               -> 在完整 CI 成功后导出、验证并发布版本
```

User Kit workflow 只接受仓库自身 `main` push 对应的完整 CI 成功事件，不接受 PR
触发的 `workflow_run`。它在 `build/user-kit` 中执行 `doctor` 和固定 `hello` 镜像
仿真，清理该目录的生成物后上传同一个已测试目录。只有该 artifact 通过后，publish
job 才会继续。新版本会原子更新 `release/user-kit` 并创建
`user-kit-v<version>` 标签，随后将压缩包发布到对应 GitHub Release；已存在的版本
保持不变。

## 仓库设置

在 GitHub `Settings > Actions > General` 中允许 workflow 写仓库内容。
`release/user-kit` 必须允许 User Kit workflow 强制更新，不需要手工创建该分支。
同时需要允许 workflow 创建标签和 GitHub Release。该分支是按版本更新的 orphan
分支，不能直接用于向 `main` 创建普通 PR。

修改 `dev/user-kit.json` 后必须重新导出，确认包内没有 `.github/`、`dev/`、
`Makefile.dev`、`mk/dev.mk`、软件 SDK/构建文件、内部测试或 `hello` 之外的归档镜像。

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
