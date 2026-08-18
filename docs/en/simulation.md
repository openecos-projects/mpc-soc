# Simulation and waveforms

[中文说明](../cn/simulation.md)

`dv/verilator/` is the SoC-level Verilator entry. It consumes a raw flash
image and runs `SimTop` by default. `SimTop` wraps pad-level `asicTop` and
connects board models for SPI flash, PSRAM, GPIO, UART, I2C, and QSPI.

## User commands

```sh
make doctor
make check
make sim APP=hello
make trace
make wave
```

- `check` runs the archived `hello` smoke
- `sim` builds the selected application and starts simulation
- `trace` runs `hello` with `TRACE=1`
- `wave` opens `build/wave/SimTop.fst`

Select another application or slot:

```sh
make sim APP=gpio CORE_SEL=0 TRACE=0
make check CASE=uart_poll
```

Run the pad-level top directly:

```sh
make sim TOP=asicTop APP=hello
```

## Flow conventions

- `build/sw/<board>/<app>/<app>.bin`: raw flash image consumed by simulation
- `hw/filelist/verilator.f`: RTL file list passed to Verilator
- `dv/verilator/csrc/sim_main.cpp`: C++ harness
- `build/verilator/obj_dir_SimTop/VSimTop`: default simulator
- `build/log/`: simulation logs
- `build/wave/`: generated waveforms

## Current limits

The harness loads a raw binary into the SPI flash model. Use a `.bin` image.
If you pass an ELF, the simulator treats the ELF bytes as flash contents.

Full bootrom regression belongs to the maintainer entry:

```sh
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```
