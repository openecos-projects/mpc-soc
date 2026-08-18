# Boot flow

[中文说明](../cn/boot-flow.md)

The Verilator flow reads a raw software image from
`build/sw/<board>/<app>/` and passes it to the simulation harness as
`+bootrom=<path>`.

## Template flow

1. After reset the SoC starts at the reset PC and fetches from SPI flash.
2. The harness receives the raw flash image path through `+bootrom=<path>`.
3. When RTL issues an SPI flash read, the flash DPI model returns bytes from
   that image.
4. Startup code in `sw/ecos/start.S` sets up the stack, clears `.bss`, and
   calls `main`.
5. Platform drivers use the board-package headers under `sw/ecos/`.

Use a `.bin` image for Verilator. If you pass an ELF file, the simulator
loads the ELF container bytes as flash contents.
