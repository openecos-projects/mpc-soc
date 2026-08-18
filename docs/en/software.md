# Software flow

[中文说明](../cn/software.md)

`sw/ecos/` is the in-repo `mpc-soc` BSP package root. When merging into
ECOS-SDK, copy or merge it to `$(ECOS_SDK_HOME)/board/mpc-soc/`.

## User commands

```sh
make sw APP=hello
make -C sw info
make -C sw list
make -C sw BOARD=mpc-soc APP=hello ECOS_SDK=/path/to/ecos-sdk CROSS_COMPILE=riscv64-unknown-elf-
```

Override `ARCH_FLAGS` when the SDK toolchain needs a more specific ISA string,
for example `-march=rv32im_zicsr -mabi=ilp32`.

## SDK package contents

- `sw/ecos/ecos-board.yml`: BSP package manifest used by SDK board discovery
- `sw/ecos/Makefile`: SDK board-package build entry
- `sw/ecos/build_conf.mk`: configuration-driven driver selection
- `sw/ecos/board.kconfig`: board, memory, clock, and link-mode Kconfig
- `sw/ecos/driver.kconfig`: peripheral driver Kconfig
- `sw/ecos/board.h`: board register map and declarations
- `sw/ecos/start.S`: firmware startup
- `sw/ecos/sections.lds`: firmware linker script
- `sw/ecos/driver/`: board peripheral drivers
- `sw/ecos/loader/`: optional bootloader wrapper

## Local wrappers

- `sw/Makefile`: local build entry used by this repository
- `sw/ecos.mk`: local SDK and toolchain path adapter
- `build/sw/mpc-soc/<app>/`: generated ELF, binary, dump, and map outputs

Simulation consumes a `.bin` image only. When merging `sw/ecos/` into the SDK,
the destination is `$(ECOS_SDK_HOME)/board/mpc-soc/`.
