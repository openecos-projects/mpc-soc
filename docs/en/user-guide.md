# User integration guide

[中文说明](../cn/user-guide.md)

This guide is for users who want to attach their own RISC-V core to `mpc-soc`
and run SoC-level simulation. Provide the core RTL and a wrapper, then connect
it to an existing slot. You do not need to change peripherals, the software
BSP, or maintainer regression scripts.

Worked examples:

- [Hello smoke](examples/hello.md): run the default core to a console pass
- [PSRAM access](examples/psram.md): check the external memory window

## 1. Check the tools

You need Python 3, GNU Make, a C++ compiler, and Verilator. Verilator 5.050 is
the recommended baseline. Software builds also need `riscv64-unknown-elf-gcc`.

```sh
make doctor
```

## 2. Run the default SoC first

Do not start by editing RTL. Confirm the repository simulates with the default
`CORE_SEL=0`:

```sh
make check
make trace
make wave
```

- `check` runs the archived `hello` bootrom smoke
- `trace` rebuilds `hello` and writes a waveform
- `wave` opens the latest `TRACE=1` FST in GTKWave

## 3. Choose a core slot

The SoC selects the enabled core with `CORE_SEL`:

- `CORE_SEL=0`: `NPC core0` in `hw/soc/top/asic_top.v`
- `CORE_SEL=1`: `ysyx_26010010` core1 in `hw/soc/top/asic_top.v`
- `CORE_SEL=2..15`: bus slots exist, but the core-side signals are tied off

The lowest-risk path is to replace the wrapper on slot 0 or slot 1. To use slot
2 or above, remove the matching tie-off in `asic_top.v`, instantiate your
wrapper, and run with `CORE_SEL=<slot>`.

## 4. Follow the wrapper contract

Each core wrapper must expose:

- `clock`: input, rising-edge
- `reset`: input, active high. Unused slots stay in reset
- `io_interrupt`: one interrupt line from the platform
- `io_master_*`: a 32-bit AXI4-style master
- `io_slave_*`: optional AXI-style slave, tied off when unused

Current master widths:

| Channel | Signals |
| --- | --- |
| AW | `awready`, `awvalid`, `awid[3:0]`, `awaddr[31:0]`, `awlen[7:0]`, `awsize[2:0]`, `awburst[1:0]` |
| W | `wready`, `wvalid`, `wdata[31:0]`, `wstrb[3:0]`, `wlast` |
| B | `bready`, `bvalid`, `bid[3:0]`, `bresp[1:0]` |
| AR | `arready`, `arvalid`, `arid[3:0]`, `araddr[31:0]`, `arlen[7:0]`, `arsize[2:0]`, `arburst[1:0]` |
| R | `rready`, `rvalid`, `rid[3:0]`, `rdata[31:0]`, `rresp[1:0]`, `rlast` |

If your core uses a different bus, adapt it in the wrapper. Keep protocol
conversion inside the wrapper so the rest of the SoC stays untouched.

The repository ships an NPC-style template:

```text
hw/ip/core/npc_wrapper_template.sv
```

Copy it, rename the module, and replace the idle master assignments with your
core instance.

## 5. Connect the RTL

1. Place the core RTL and wrapper under `hw/ip/core/` or another in-repo path.
2. Add the new files to `hw/filelist/verilator.f`. The current core entries are:

```text
../../hw/ip/core/NPC-bstage.sv
../../hw/ip/core/ysyx_26010010.v
```

Required sources must appear before `hw/soc/top/asic_top.v`.
3. Instantiate the wrapper on the target slot and connect
   `_cpu_<slot>_io_master_*` plus `_cmp_io_interrupt_out_<slot>`.
4. Tie off unused optional slave ports in the wrapper or at the instance.

## 6. Validate your core

```sh
make check CASE=hello CORE_SEL=<slot>
make sim APP=hello CORE_SEL=<slot> TRACE=0 MAX_CYCLES=1000
```

After the smoke passes, run the full regression from the maintainer entry:

```sh
make -f Makefile.dev regress CORE_SEL=<slot> OUTPUT=list TRACE=0
make -f Makefile.dev clean-build
```

## 7. Build or reuse software

The default software flow builds `sw/ecos/templates/<app>/` into
`build/sw/mpc-soc/<app>/`. Simulation consumes a raw `.bin` image, not an ELF.

```sh
make sw APP=hello
make sim APP=hello
```

See the [software flow](software.md) for the BSP and SDK details.

## Common mistakes

- Changing RTL without updating `hw/filelist/verilator.f`
- Passing an ELF to the simulator as a flash image
- Using a `CORE_SEL` whose slot is still tied off
- Committing generated files under `build/`

The default Verilator top is `SimTop`. Use `TOP=asicTop` only when debugging
pad-level behavior.
