# mpc-soc User Kit

[English](README.en.md)

这是 `mpc-soc` 面向 core 接入用户的精简发行环境。它包含固定 SoC、core wrapper
接入点、Verilator 仿真链路和固定 `hello` `.bin` 镜像，不包含软件 SDK、驱动构建、维护者
CI、文档站或全量归档回归。

## 开始使用

```sh
make doctor
make check
make lint
make sim
```

`make check` 和 `make sim` 使用随发行包提供的固定 `hello` 镜像验证 SoC；
`make lint` 检查接入后的 RTL 和 filelist。用户可以编写自己的 core RTL、wrapper
及必要的槽位连接，但当前版本不提供软件或驱动编译环境。

core 接入流程见[用户接入指南](docs/cn/user-guide.md)，固化地址空间见
[内存映射](docs/cn/memory-map.md)，User Kit 获取和升级方式见
[User Kit 获取与使用](docs/cn/user-kit.md)。

`SOC_KIT_VERSION` 记录发行格式、SoC 版本和对应的维护者源码提交。上游
`release/user-kit` 指向最新发行版；每个版本同时提供不可变的 `user-kit-v<version>`
标签和 GitHub Release 压缩包。请先创建自己的开发分支：

```sh
git switch -c user/<name>
```
