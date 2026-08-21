# Example: Hello smoke

[中文说明](../../cn/examples/hello.md)

This is the shortest path to confirm the repository works. It uses the default
`CORE_SEL=0` and the archived `hello` bootrom image, and expects UART output
`done!`.

## Commands

```sh
make doctor
make check
make trace
make wave
```

`check` and `trace` both use the fixed `hello` image in the release; the latter
also generates an FST waveform.

## Expected result

- The command returns 0
- The UART stop text `done!` appears in the log
- `trace` writes a non-empty waveform to `build/wave/SimTop.fst`

If this fails, confirm `make doctor` passes and the fixed `hello` image is
still present. Then follow the [user integration guide](../user-guide.md)
to attach your own core.
