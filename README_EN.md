# mpc-soc

[![CI](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml/badge.svg)](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml)

Current version: `0.0.1`. See the Chinese-first release notes in [CHANGELOG.md](CHANGELOG.md).

`mpc-soc` has been migrated into a SoC integration template organized by hardware, verification, software, configuration, documentation, and generated outputs.

## Directory Layout

- `config/`: SoC, memory-map, and simulation-board configuration.
- `hw/`: hardware sources; `hw/ip/` contains peripheral IP, `hw/common/` contains shared RTL, and `hw/soc/` contains SoC top-level integration.
- `dv/verilator/`: retained Verilator SoC simulation entry and C++ harness.
- `sw/ecos/`: in-repository root of the `mpc-soc` BSP package; place it under `board/mpc-soc/` when merging into ECOS-SDK.
- `docs/`: architecture, memory map, boot flow, custom-core integration, and toolchain notes.
- `scripts/`: generation, fetch, and maintenance scripts.
- `third_party/`: external dependency notes; large SDKs should not be committed directly.
- `build/`: Verilator outputs, software images, logs, and waveforms.

## Quick Commands

```sh
make help
make sw BOARD=mpc-soc APP=hello
make verilate
make sim BOARD=mpc-soc APP=hello
make wave
make clean-build
```

## Verilator Simulation

The default Verilator simulation top is `SimTop` from `hw/soc/top/asic_top.v`. `SimTop` wraps `asicTop` and connects simulation board models for flash, PSRAM, GPIO, and UART. `asicTop` is the pad-level SoC top and can still be simulated directly with `TOP=asicTop` when needed. Simulation-only fixed inputs, fast flash, UART input, and stop conditions are provided by the harness under `dv/verilator/csrc/`.

```sh
make -C dv/verilator verilate
make -C dv/verilator sim BOARD=mpc-soc APP=hello
```

## Custom Core Integration

The SoC selects the tested core through `CORE_SEL`; the default is `CORE_SEL=0`. To plug in a custom core, place the RTL under `hw/ip/core/` or another project directory, update `hw/filelist/verilator.f`, and connect the core to `hw/soc/top/asic_top.v` using the expected AXI master and interrupt contract. See `docs/custom-core.md` for the port contract and validation steps.

## ECOS-SDK Software

`sw/ecos/` is now the `mpc-soc` BSP package root that can be merged into ECOS-SDK under `board/mpc-soc/`. Project-local build wrappers live in `sw/Makefile` and `sw/ecos.mk`. The software flow builds applications from `sw/ecos/templates/<app>/` and writes outputs to `build/sw/mpc-soc/<app>/`. Override the SDK and toolchain paths with variables:

```sh
make -C sw info
make -C sw BOARD=mpc-soc APP=hello ECOS_SDK=/path/to/ecos-sdk CROSS_COMPILE=riscv64-unknown-elf-
```

## IP Simulation Entry

Legacy IP-local simulation launchers have been removed. The retained simulation entry is the SoC-level Verilator flow under `dv/verilator/`. IP RTL, models, and testbench sources remain under `hw/ip/`; add new IP-level simulation through Verilator if needed.

## Migration Map

- `new-ip/<name>/` → `hw/ip/<name>/`
- `new-ip/common/` → `hw/common/`
- `perip/uart16550/` → `hw/ip/uart16550/`
- `perip/spi/` → `hw/ip/spi/legacy_apb/`
- `perip/flash/` → `hw/ip/flash/model/`
- `perip/psram/` → `hw/ip/psram/model/esp_psram64h/`
- `perip/tc_io.v` → `hw/soc/top/tc_io.v`
- `build/ElaborateTop.v` → `hw/soc/top/asic_top.v`
