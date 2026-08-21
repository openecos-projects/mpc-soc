# Getting and using the User Kit

[中文说明](../cn/user-kit.md)

The User Kit is the trimmed `mpc-soc` release for core integration users.
Developers maintain the complete SoC, full regression, CI, and documentation
site on `main`. Regular users only fetch the CI-tested `release/user-kit`
branch.

The release contains the fixed SoC RTL, core wrapper integration points,
Verilator harness, public documentation, and one fixed archived `hello` image.
It excludes the software SDK, driver builds, `Makefile.dev`, `mk/dev.mk`,
maintainer CI, site sources, internal tests, and all other regression images.

## Get the User Kit

After the first maintainer release, clone the release branch instead of
`main`:

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git my-mpc-soc
cd my-mpc-soc
```

GitHub Actions also provides a versioned artifact. Each formal version has an
immutable `user-kit-v<version>` tag and GitHub Release archive. Use
`release/user-kit` for the latest version, or a tag/Release to pin a version.

## Create a user development branch

CI updates `release/user-kit` when a new version is published. Do not develop
on that branch directly:

```sh
git switch -c user/<name>
```

Keep the project repository as a read-only upstream when pushing to your own
repository:

```sh
git remote rename origin upstream
git remote add origin https://github.com/<user>/<project>.git
git push -u origin user/<name>
```

## Check the released environment

The flow requires Python 3.9+, PyYAML, GNU Make, a C++ compiler, and Verilator
5.050. The User Kit requires this exact version. A RISC-V toolchain and ECOS
SDK are not needed.

```sh
make doctor
make check
make lint
make sim
```

`make check` and `make sim` both use the only bundled fixed image, `hello`.
`make lint` checks user-added core RTL and file-list changes. This release does
not support compiling or replacing software and drivers inside the User Kit.

Follow the [user integration guide](user-guide.md). Addresses must use the
fixed ranges in the [memory map](memory-map.md).

## Version and upgrades

`SOC_KIT_VERSION` records:

- `KIT_FORMAT_VERSION`: User Kit directory and interface format
- `SOC_VERSION`: the `mpc-soc` version
- `SOURCE_COMMIT`: the `main` source commit used for the release

The release is currently an orphan branch without shared development history,
so there is no automatic upgrade command. Fetch a clean User Kit and migrate
your core RTL, wrapper, and required filelist or slot changes:

```sh
git clone --branch release/user-kit --single-branch \
  https://github.com/openecos-projects/mpc-soc.git mpc-soc-new
cp -a my-mpc-soc/hw/ip/core/<my-core> mpc-soc-new/hw/ip/core/
```

Run `make check` after migrating, then validate your core with the fixed image. Do
not force-merge the upstream release branch into an existing user repository.

## Delivery boundary

Users should deliver core RTL, the wrapper, filelist changes, and any required
slot connection notes. Do not submit `build/` outputs or modify the fixed
address map. The User Kit and `main` do not share history, so a normal pull
request from a user branch to `main` is not possible. Maintainers review and
integrate the delivered changes in the development repository.
