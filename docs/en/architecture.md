# Architecture

[中文说明](../cn/architecture.md)

`mpc-soc` is a RISC-V SoC integration board: the CPU reaches flash and PSRAM
through an AXI master, then reaches peripherals through an AXI4-to-APB4
fabric. The default simulation top is `SimTop`, which wraps pad-level
`asicTop` and attaches board models.

## Source layout

- `hw/soc/top/` holds the SoC integration top.
- `hw/soc/bus/`, `hw/soc/reset/`, and `hw/soc/clock/` are reserved for SoC-level
  bus, reset, and clock integration.
- `hw/ip/` holds reusable IP. Each IP may have its own `rtl/`, `tb/` or `dv/`,
  `driver/`, and `doc/` directories.
- `hw/common/` holds shared RTL helpers.
- `hw/ip/` also keeps compatibility implementations still used by the SoC,
  such as `hw/ip/spi/legacy_apb/`.

## Configuration sources

- `config/soc.yml` describes the template SoC top and selected IP paths.
- `config/memory.yml` is the source of the generated RTL package and C headers.
- `config/boards/sim.yml` describes the default simulation board.

## Integration flow

1. Keep the SoC top under `hw/soc/top/`. Update `hw/filelist/verilator.f` when
   modules are added or renamed.
2. Keep top-level bus, clock, reset, and interrupt wiring under `hw/soc/`.
3. Keep `hw/filelist/soc.f` and `hw/filelist/verilator.f` in sync.
4. When the memory map changes, regenerate `hw/include/soc_pkg.sv` from
   `config/memory.yml` and update `sw/ecos/board.h`.

Follow the [user integration guide](user-guide.md) for core slots and the AXI
port contract.
