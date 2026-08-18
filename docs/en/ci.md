# Continuous integration

[中文说明](../cn/ci.md)

This document is for `mpc-soc` maintainers. It is not part of the public user
site.

The root project uses `.github/workflows/ci.yml` for a single-platform Ubuntu
24.04 CI. Documentation uses `.github/workflows/pages.yml` and builds a
VitePress site with Node.js.

## Automatic gates

Pushes and pull requests to `main` run:

- Python syntax checks
- `make gen-soc-pkg` and a check that `hw/include/soc_pkg.sv` is current
- `make -f Makefile.dev docs-check`
- software build: `make sw APP=hello`
- Verilator build: `make verilate TRACE=0`
- bootrom regression: `make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0`
- a check that no commit-worthy untracked files were created

## Documentation deployment

When docs, the theme, or site scripts change, `Documentation Pages` runs
`make -f Makefile.dev docs-site-check`. Pull requests only build and validate
the site. Merges to `main` deploy to
`https://openecos-projects.github.io/mpc-soc/`.
