# 示例：Hello 冒烟

[English](../../en/examples/hello.md)

这是确认仓库可用的最短路径。它使用默认 `CORE_SEL=0` 和归档的 `hello`
bootrom 镜像，期望 UART 输出 `done!`。

## 命令

```sh
make doctor
make check
make trace
make wave
```

`check` 等价于：

```sh
make -f Makefile.dev bootrom-sim CASE=hello OUTPUT=list TRACE=0
```

## 期望结果

- 命令返回 0
- 日志中出现 UART 停止文本 `done!`
- `trace` 在 `build/wave/SimTop.fst` 写出非空波形

如果失败，先确认 `make doctor` 通过，并且没有把 ELF 当成 flash 镜像传入。
下一步再看 [用户接入指南](../user-guide.md) 接入自己的 core。
