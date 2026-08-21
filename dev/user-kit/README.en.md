# mpc-soc User Kit

[中文说明](README.md)

This is the trimmed `mpc-soc` environment for core integration users. It
contains the fixed SoC, core wrapper integration points, the Verilator
simulation flow, and a fixed `hello` `.bin` image. Software SDK and driver builds,
maintainer CI, the documentation site, and the full archived regression are
intentionally excluded.

## Getting started

```sh
make doctor
make check
make lint
make sim
```

`make check` and `make sim` validate the SoC with the bundled fixed `hello`
image. `make lint` checks the integrated RTL and file list. Users can write
their own core RTL, wrapper, and required slot connections, but this release
does not provide a software or driver build environment.

See the [user integration guide](docs/en/user-guide.md), the fixed
[memory map](docs/en/memory-map.md), and
[getting and updating the User Kit](docs/en/user-kit.md).

`SOC_KIT_VERSION` records the release format, SoC version, and corresponding
maintainer source commit. `release/user-kit` points to the latest release;
each version also has an immutable `user-kit-v<version>` tag and GitHub Release
archive. Create your own development branch first:

```sh
git switch -c user/<name>
```
