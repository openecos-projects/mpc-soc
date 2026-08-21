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
- `dev/user-kit.json`: User Kit file and directory allowlist
- `dev/user-kit/`: User Kit top-level READMEs and ignore rules
- `config/`, `hw/`, `dv/`, and `sw/`: the SoC itself. Keep the current hardware,
  verification, and software layout

## Pre-merge checks

```sh
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make -f Makefile.dev export-user-kit
make -f Makefile.dev gen-soc-pkg
git diff --exit-code hw/include/soc_pkg.sv
make -f Makefile.dev config-check
make check
make -f Makefile.dev regress OUTPUT=list STOP_ON_FAIL=1 TRACE=0
```

## Release chain

After a merge and push to `main`:

```text
CI                     -> source, software, Verilator, and bootrom regression
Documentation Pages    -> only the user pages allowed by dev/site-docs.json
User Kit               -> export, test, and publish after full CI succeeds
```

The User Kit workflow only accepts a successful full CI run from a push to the
repository's own `main` branch; pull-request `workflow_run` events are not
eligible. It runs `doctor` and fixed-image `hello` simulation inside
`build/user-kit`, removes generated output, and uploads that same tested
directory. A new version atomically updates `release/user-kit`, creates a
`user-kit-v<version>` tag, and uploads an archive to the matching GitHub
Release. Existing versions remain unchanged.

## Repository settings

Allow workflows to write repository contents under GitHub
`Settings > Actions > General`. The User Kit workflow must be allowed to force
update `release/user-kit` and create tags and GitHub Releases; the branch does
not need to be created manually. It is an orphan release branch and cannot open
a normal pull request directly to `main`.

After changing `dev/user-kit.json`, re-export and verify that the kit contains
no `.github/`, `dev/`, `Makefile.dev`, `mk/dev.mk`, software SDK/build files,
internal tests, or archived images other than `hello`.

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
