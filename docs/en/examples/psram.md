# Example: PSRAM access

[中文说明](../../cn/examples/psram.md)

This example checks that software can reach the external PSRAM window through
the SoC memory path, and that the Verilator PSRAM model returns the written
data.

## Scope

The test covers memory-mapped PSRAM reads and writes at `0xc0000000`.

It does not verify PSRAM bandwidth, timing margin, refresh behavior, or
multi-core coherency.

## Address map

| Region | Base | Size | Expected chip select |
| --- | ---: | ---: | --- |
| PSRAM chip 0 | `0xc0000000` | `0x00800000` | `psram_nss_o[0]` |
| PSRAM chip 1 | `0xc0800000` | `0x00800000` | `psram_nss_o[1]` |
| PSRAM chip 2 | `0xc1000000` | `0x00800000` | `psram_nss_o[2]` |

The reserved PSRAM window is `0xc0000000..0xc17fffff`.

## Preconditions

- `config/memory.yml` defines PSRAM at `0xc0000000` with size `0x01800000`
- `hw/include/soc_pkg.sv` exports `SOC_PSRAM_BASE` and `SOC_PSRAM_SIZE`
- `sw/ecos/board.h` exports `MPC_SOC_PSRAM_BASE` and `MPC_SOC_PSRAM_SIZE`
- Verilator must use a simulation top that connects PSRAM pins to the
  `ESP_PSRAM64H` model
- Covering the full 24 MiB requires three PSRAM models

## Run

```sh
make check CASE=psram_basic
make sim APP=psram_basic
```

The boot image should print `psram test start`, write and read back fixed
patterns, print `psram ok` on success, and print `psram fail` on mismatch.

## Required accesses

| Address | Written value | Purpose |
| ---: | ---: | --- |
| `0xc0000000` | `0x11223344` | first word of chip 0 |
| `0xc0000004` | `0x55667788` | adjacent word, basic byte-lane check |
| `0xc07ffffc` | `0xa5a5a5a5` | last word of chip 0 |

When three PSRAM models are connected, extend the test:

| Address | Written value | Purpose |
| ---: | ---: | --- |
| `0xc0800000` | `0x12345678` | first word of chip 1 |
| `0xc0fffffc` | `0x87654321` | last word of chip 1 |
| `0xc1000000` | `0xdeadbeef` | first word of chip 2 |
| `0xc17ffffc` | `0xcafebabe` | last word of chip 2 |

## Pass criteria

The test passes when UART output contains:

```text
psram test start
psram ok
```

It fails when:

- UART output contains `psram fail`
- simulation times out before `psram ok`
- the PSRAM controller does not assert the expected chip select

The default top is `SimTop`. Use `TOP=asicTop` only for pad-level debug when
the harness explicitly provides PSRAM pin behavior.
