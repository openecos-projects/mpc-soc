# User integration guide

[中文说明](../cn/user-guide.md)

This guide is for users who want to attach their own RISC-V core to `mpc-soc`
and run SoC-level simulation. Provide the core RTL and a wrapper, then connect
it to an existing slot. You do not need to change peripherals, the fixed
software image, or maintainer regression scripts.

Worked examples:

- [Hello smoke](examples/hello.md): run the default core to a console pass

## 1. Get the User Kit

Regular users should not start from the development `main` branch. Clone the
user release that CI has independently built and simulated, then create your
own development branch:

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git my-mpc-soc
cd my-mpc-soc
git switch -c user/<name>
```

CI force-updates the upstream `release/user-kit` branch, so do not develop on
it directly. See [Getting and using the User Kit](user-kit.md) when pushing to
your own repository, updating the release, or checking the delivery boundary.

## 2. Check the tools

You need Python 3.9+, PyYAML, GNU Make, a C++ compiler, and Verilator 5.050.
The current User Kit requires this exact version. Fixed-image simulation does
not require a RISC-V toolchain or software SDK.

```sh
make doctor
```

## 3. Run the default SoC first

Do not start by editing RTL. Confirm the repository simulates with the default
`CORE_SEL=0`:

```sh
make check
make lint
make trace
make wave
```

- `check` runs the archived `hello` bootrom smoke
- `lint` checks the current RTL/file list and reports structural warnings hidden by simulation compatibility mode
- `trace` reruns the fixed `hello` image and writes a waveform
- `wave` opens the latest `TRACE=1` FST in GTKWave

## 4. Choose a core slot

The SoC selects the enabled core with `CORE_SEL`:

- `CORE_SEL=0`: `NPC core0` in `hw/soc/top/asic_top.v`
- `CORE_SEL=1`: `ysyx_26010010` core1 in `hw/soc/top/asic_top.v`
- `CORE_SEL=2..15`: bus slots exist, but the core-side signals are tied off

The lowest-risk path is to replace the wrapper on slot 0 or slot 1. To use slot
2 or above, remove the matching tie-off in `asic_top.v`, instantiate your
wrapper, and run with `CORE_SEL=<slot>`.

## 5. Follow the wrapper contract

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

## 6. Connect the RTL

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

## 7. Validate your core

```sh
make check CORE_SEL=<slot>
make lint
make sim CORE_SEL=<slot> TRACE=0
```

After the smoke passes, deliver the core changes for the maintainer to run the
full regression in the development repository. `release/user-kit` does not
contain maintainer entry points.

## 8. User-editable content

This release supports users writing and delivering:

- core RTL
- the AXI wrapper
- required entries in `hw/filelist/verilator.f`
- required connections for the selected core slot

The SoC address map, peripheral RTL, fixed `hello` image, software, and drivers
are outside the supported user modification surface. Users who change them are
responsible for their own integration and validation.

## Common mistakes

- Changing RTL without updating `hw/filelist/verilator.f`
- Replacing or deleting the bundled fixed `hello` image
- Using a `CORE_SEL` whose slot is still tied off
- Committing generated files under `build/`

The default Verilator top is `SimTop`. Use `TOP=asicTop` only when debugging
pad-level behavior.
