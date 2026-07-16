# 第三方依赖

大型外部依赖应尽量放在 git 历史之外。

推荐的本地目录布局：

```text
third_party/
└── ecos-sdk/      # 本地 SDK checkout 或软链接；体积较大时会被忽略
```

如果 SDK 由其他位置管理，请显式传入路径：

```sh
make -C sw BOARD=mpc-soc APP=hello ECOS_SDK=/path/to/ecos-sdk
```
