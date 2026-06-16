# mpc-soc

`mpc-soc` is a work-in-progress SoC reference directory. It currently contains generated or collected top-level files, existing peripheral IP, and additional IP modules:

- `build/`: current generated or collected top-level related files.
- `perip/`: existing peripheral module sources.
- `new-ip/`: additional or to-be-integrated IP modules, tests, and documentation.

## Current Status

This directory is not a formally completed SoC template and is not the final production version. The code and directory layout are still in a reference, cleanup, verification, and integration stage. Interfaces may not be fully unified, documentation may be incomplete, test coverage may be insufficient, and implementation details may still require changes.

Use this project only as reference material for understanding module organization, peripheral implementations, and possible SoC integration directions. Do not use it directly as a stable template, final course submission template, or production deliverable.

## Usage Notes

- Before reusing any module, check its interfaces, clock and reset behavior, bus protocol, and register definitions.
- Before integrating modules into a new SoC top level, add the required simulation, synthesis, and board-level validation.
- To turn this into a formal template, further work is needed to standardize the directory layout, build scripts, documentation, and regression test flow.

Chinese version: [README.md](README.md)
