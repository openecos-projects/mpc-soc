# Boot flow

[中文说明](../cn/boot-flow.md)

The User Kit Verilator flow reads the fixed
`sw/bootrom/hello/retrosoc_fw.bin` image and passes it to the simulation
harness as `+bootrom=<path>`.

## Template flow

1. After reset the SoC starts at the reset PC and fetches from SPI flash.
2. The harness receives the raw flash image path through `+bootrom=<path>`.
3. When RTL issues an SPI flash read, the flash DPI model returns bytes from
   that image.
4. Startup code in the fixed image initializes the runtime and executes
   `hello`.
5. A user-integrated core runs the same image through the existing bus and
   peripheral paths.

This release does not provide software SDK or driver build entry points, and
does not support replacing the fixed image shipped in the User Kit.
