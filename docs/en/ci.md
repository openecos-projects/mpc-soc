# Continuous integration

[中文说明](../cn/ci.md)

This document is for `mpc-soc` maintainers. It is not part of the public user
site.

The root project uses `.github/workflows/ci.yml` for a single-platform Ubuntu
24.04 CI. Documentation uses `.github/workflows/pages.yml` and builds a
VitePress site with Node.js. `.github/workflows/user-kit.yml` exports and tests
the user environment.

## Automatic gates

Pushes and pull requests to `main` run:

- Python syntax checks
- `make -f Makefile.dev gen-soc-pkg` and a check that `hw/include/soc_pkg.sv` is current
- a check that configuration, RTL package, and BSP defaults remain fixed at 50 MHz
- `make -f Makefile.dev docs-check`
- maintainer software build: `make -C sw BOARD=mpc-soc APP=hello`
- software configuration rebuild check for XIP and MEM link targets
- Verilator build: `make verilate TRACE=0`
- source-built `hello` simulation with the `done!` pass condition
- bootrom regression: `make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0`
- a check that no commit-worthy untracked files were created

`make lint` is a separate user/maintainer target and is not currently a CI gate.
CI continues to build and run only the default `CORE_SEL=0` example core.

## Documentation deployment

When docs, the theme, or site scripts change, `Documentation Pages` runs
`make -f Makefile.dev docs-site-check`. Pull requests only build and validate
the site. Merges to `main` deploy to
`https://openecos-projects.github.io/mpc-soc/`.

## User Kit publishing

The User Kit workflow exports the package and runs the fixed `hello` image in
pull requests. After a merge to `main`, publication starts only after the full
`CI` workflow succeeds for the same SHA. A new version updates the orphan
`release/user-kit` branch and creates an immutable `user-kit-v<version>` tag
and GitHub Release archive. Existing versions are never overwritten, and
developer-only files never enter the release.
