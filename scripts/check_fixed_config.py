#!/usr/bin/env python3
from __future__ import annotations

import re
import sys
from pathlib import Path

try:
    import yaml
except ImportError as exc:
    raise SystemExit("ERROR: PyYAML is required; install python3-yaml or pyyaml") from exc


FIXED_CLOCK_HZ = 50_000_000
FIXED_CLOCK_MHZ = 50
ROOT = Path(__file__).resolve().parents[1]


def yaml_clock(path: Path) -> int:
    with path.open("r", encoding="utf-8") as file:
        data = yaml.safe_load(file)
    if not isinstance(data, dict) or not isinstance(data.get("clock_hz"), int):
        raise ValueError(f"{path}: clock_hz must be an integer")
    return data["clock_hz"]


def matched_int(path: Path, pattern: str, label: str) -> int:
    match = re.search(pattern, path.read_text(encoding="utf-8"), re.MULTILINE)
    if match is None:
        raise ValueError(f"{path}: cannot find {label}")
    return int(match.group(1))


def main() -> int:
    try:
        checks = [
            ("config/soc.yml clock_hz", yaml_clock(ROOT / "config" / "soc.yml"), FIXED_CLOCK_HZ),
            (
                "config/boards/sim.yml clock_hz",
                yaml_clock(ROOT / "config" / "boards" / "sim.yml"),
                FIXED_CLOCK_HZ,
            ),
            (
                "hw/include/soc_pkg.sv SOC_CLOCK_HZ",
                matched_int(
                    ROOT / "hw" / "include" / "soc_pkg.sv",
                    r"^\s*localparam int unsigned SOC_CLOCK_HZ = (\d+);",
                    "SOC_CLOCK_HZ",
                ),
                FIXED_CLOCK_HZ,
            ),
            (
                "sw/ecos/board.h MPC_SOC_CLOCK_HZ",
                matched_int(
                    ROOT / "sw" / "ecos" / "board.h",
                    r"^#define\s+MPC_SOC_CLOCK_HZ\s+(\d+)u",
                    "MPC_SOC_CLOCK_HZ",
                ),
                FIXED_CLOCK_HZ,
            ),
            (
                "sw/Makefile CPU_FREQ_MHZ default",
                matched_int(
                    ROOT / "sw" / "Makefile",
                    r"^CPU_FREQ_MHZ\s*\?=\s*(\d+)",
                    "CPU_FREQ_MHZ",
                ),
                FIXED_CLOCK_MHZ,
            ),
            (
                "sw/Makefile TIMER_FREQ_MHZ default",
                matched_int(
                    ROOT / "sw" / "Makefile",
                    r"^TIMER_FREQ_MHZ\s*\?=\s*(\d+)",
                    "TIMER_FREQ_MHZ",
                ),
                FIXED_CLOCK_MHZ,
            ),
        ]
    except (OSError, ValueError, yaml.YAMLError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    failures = []
    for label, actual, expected in checks:
        if actual != expected:
            failures.append(f"{label}: expected {expected}, got {actual}")

    if failures:
        for failure in failures:
            print(f"ERROR: {failure}", file=sys.stderr)
        return 1

    print("fixed SoC clock configuration: 50 MHz")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
