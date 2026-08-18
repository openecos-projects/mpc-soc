# Maintainer release process

[中文说明](../cn/maintainer-release.md)

This document is for `mpc-soc` maintainers. It is not part of the public user
site.

## Repository boundaries

- `Makefile`, `mk/common.mk`, and `mk/user.mk`: stable user build entry
- `Makefile.dev` and `mk/dev.mk`: regression, documentation site, and generated
  file checks
- `docs/cn/` and `docs/en/`: path-matched bilingual sources
- `dev/site/`: VitePress theme and site assets, not a second Markdown tree
- `dev/site-docs.json`: public site page allowlist
- `config/`, `hw/`, `dv/`, and `sw/`: the SoC itself. Keep the current hardware,
  verification, and software layout

## Pre-merge checks

```sh
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make gen-soc-pkg
git diff --exit-code hw/include/soc_pkg.sv
make check
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```

## Release chain

After a merge and push to `main`:

```text
CI                     -> source, software, Verilator, and bootrom regression
Documentation Pages    -> only the user pages allowed by dev/site-docs.json
```

## Historical migration map

These paths are maintainer history only and do not belong in user docs:

- `new-ip/<name>/` → `hw/ip/<name>/`
- `new-ip/common/` → `hw/common/`
- `perip/uart16550/` → `hw/ip/uart16550/`
- `perip/spi/` → `hw/ip/spi/legacy_apb/`
- `perip/flash/` → `hw/ip/flash/model/`
- `perip/psram/` → `hw/ip/psram/model/esp_psram64h/`
- `perip/tc_io.v` → `hw/soc/top/tc_io.v`
- `build/ElaborateTop.v` → `hw/soc/top/asic_top.v`
