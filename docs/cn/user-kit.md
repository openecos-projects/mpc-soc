# User Kit 获取与使用

[English](../en/user-kit.md)

User Kit 是 `mpc-soc` 面向 core 接入用户的精简发行版本。开发者在 `main` 维护
完整 SoC、全量回归、CI 和文档站；普通用户只需要获取经过 CI 独立构建和仿真验证
的 `release/user-kit` 分支。

发行包包含固定 SoC RTL、core wrapper 接入点、Verilator harness、公开文档和一个
固定的 `hello` 归档镜像。它不包含软件 SDK、驱动构建、`Makefile.dev`、
`mk/dev.mk`、维护者 CI、站点源码、内部测试或其他归档回归镜像。

## 获取 User Kit

维护者完成首次发布后，直接拉取发行分支，不要 clone `main`：

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git my-mpc-soc
cd my-mpc-soc
```

GitHub Actions 同时提供版本化 artifact。正式版本还会创建不可变的
`user-kit-v<version>` 标签和 GitHub Release 压缩包。正常开发可使用
`release/user-kit` 获取最新版本，需要固定版本时使用版本标签或 Release。

## 建立用户开发分支

`release/user-kit` 在新版本发布时由 CI 更新，不要直接在该分支长期开发：

```sh
git switch -c user/<name>
```

推送到自己的仓库时，把项目仓库保留为只读上游：

```sh
git remote rename origin upstream
git remote add origin https://github.com/<user>/<project>.git
git push -u origin user/<name>
```

## 检查发行环境

需要 Python 3.9+、PyYAML、GNU Make、C++ 编译器和 Verilator 5.050。
当前 User Kit 要求使用该版本，不需要 RISC-V 工具链或 ECOS SDK。

```sh
make doctor
make check
make lint
make sim
```

`make check` 和 `make sim` 都使用发行包内唯一保留的固定 `hello` 镜像。
`make lint` 用于检查用户新增的 core RTL 和 filelist。当前版本不支持在 User Kit
中编译或替换软件和驱动。

core 接入步骤见[用户接入指南](user-guide.md)，地址必须使用
[内存映射](memory-map.md)中已经固化的范围。

## 版本与升级

`SOC_KIT_VERSION` 记录：

- `KIT_FORMAT_VERSION`：User Kit 目录和接口格式版本
- `SOC_VERSION`：`mpc-soc` 版本
- `SOURCE_COMMIT`：生成发行包的 `main` 源码提交

发行分支是没有共享开发历史的 orphan 分支，目前没有自动升级命令。升级时重新
获取干净 User Kit，再迁移自己的 core RTL、wrapper 和必要的 filelist/槽位改动：

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git mpc-soc-new
cp -a my-mpc-soc/hw/ip/core/<my-core> mpc-soc-new/hw/ip/core/
```

迁移后先运行 `make check`，再使用固定镜像验证自己的 core。不要把上游发行分支
强制合并到旧的用户仓库。

## 交付边界

用户应交付 core RTL、wrapper、filelist 增量及必要的槽位连接说明，不要提交
`build/` 生成物，也不要修改固化地址映射。User Kit 与 `main` 没有共享提交历史，
不能直接从用户分支向 `main` 创建普通 PR；维护者应在开发仓库中审查并集成用户
提交内容。
