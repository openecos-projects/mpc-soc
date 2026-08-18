# mpc-soc

[中文说明](README.md)

[![CI](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml/badge.svg)](https://github.com/openecos-projects/mpc-soc/actions/workflows/ci.yml)

Current version: `0.0.1`. See the Chinese-first release notes in
[CHANGELOG.md](CHANGELOG.md).

`mpc-soc` is a simulatable RISC-V SoC board for multi-project chips. The
supported tool baseline is Verilator 5.050.

Documentation site: [mpc-soc docs](https://openecos-projects.github.io/mpc-soc/).

## User workflow

```sh
make doctor
make check
make sim APP=hello
make trace
make wave
```

Place a core under `hw/ip/core/`, connect it through the AXI contract, and
select it with `CORE_SEL`. Follow the
[user integration guide](docs/en/user-guide.md) and the
[memory map](docs/en/memory-map.md).

## Repository boundaries

- `config/`, `hw/`, `dv/`, and `sw/`: SoC configuration, hardware, simulation,
  and software.
- `docs/cn/` and `docs/en/`: path-matched bilingual documentation sources.
- `mk/` and `Makefile`: stable user build interface.
- `Makefile.dev`: regression, documentation, and generated-file maintenance.
- `dev/site/`: VitePress theme and site assets.
- `scripts/`: generation, check, and maintenance scripts.
- `third_party/`: external dependency notes; do not commit large SDKs.
- `build/`: Verilator outputs, software images, logs, and waveforms. Do not
  commit this directory.

Maintainer commands use the separate entry point:

```sh
make -f Makefile.dev dev-help
make -f Makefile.dev docs-check
make -f Makefile.dev docs-site-check
make -f Makefile.dev regress
```

See the [maintainer release process](docs/en/maintainer-release.md) for the
complete deployment workflow.
