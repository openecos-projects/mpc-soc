# Simulation and waveforms

[中文说明](../cn/simulation.md)

`dv/verilator/` is the SoC-level Verilator entry. It consumes a raw flash
image and runs `SimTop` by default. `SimTop` wraps pad-level `asicTop` and
connects board models for SPI flash, PSRAM, GPIO, UART, I2C, and QSPI.

## User commands

```sh
make doctor
make check
make lint
make sim
make trace
make wave
```

- `check` runs the archived `hello` smoke
- `lint` checks RTL and the file list with rules separate from the simulation build
- `sim` starts simulation with the fixed `hello` image
- `trace` runs `hello` with `TRACE=1`
- `wave` opens `build/wave/SimTop.fst`

Reaching `MAX_CYCLES` is a failure unless the fixed image has printed `done!`.
`ALLOW_TIMEOUT=1` never overrides this configured UART pass condition.

`make lint` keeps state-machine, combinational-loop, and reset-network warnings
that the simulation compatibility mode suppresses. Warnings are reported for
core integration review; Verilator syntax or semantic errors still fail the target.

Select the core slot under test:

```sh
make sim CORE_SEL=0 TRACE=0
make check CORE_SEL=0
```

Run the pad-level top directly:

```sh
make sim TOP=asicTop
```

## Flow conventions

- `sw/bootrom/hello/retrosoc_fw.bin`: fixed raw flash image used by the User Kit
- `hw/filelist/verilator.f`: RTL file list passed to Verilator
- `dv/verilator/csrc/sim_main.cpp`: C++ harness
- `build/verilator/obj_dir_SimTop/VSimTop`: default simulator
- `build/log/`: simulation logs
- `build/wave/`: generated waveforms

## Current limits

The harness loads a raw binary into the SPI flash model. Use a `.bin` image.
If you pass an ELF, the simulator treats the ELF bytes as flash contents.

Maintainers run the full bootrom regression in the development repository; it
is not part of the User Kit command surface.
