#!/usr/bin/env python3

from __future__ import annotations

import argparse
import subprocess
from pathlib import Path


IP_LIST = [
    "archinfo",
    "clint",
    "common",
    "crc",
    "gpio",
    "i2c",
    "i2s",
    "plic",
    "ps2",
    "psram",
    "pwm",
    "rcu",
    "rng",
    "rtc",
    "spi",
    "sram",
    "timer",
    "uart",
    "vga",
    "wdg",
]


def repo_root() -> Path:
    return Path(__file__).resolve().parents[1]


def target_path(root: Path, name: str) -> Path:
    if name == "common":
        return root / "hw" / "common"
    return root / "hw" / "ip" / name


def main() -> int:
    parser = argparse.ArgumentParser(description="Fetch OSCC IP repositories into the migrated tree")
    parser.add_argument("--root", type=Path, default=repo_root(), help="mpc-soc repository root")
    parser.add_argument("--https", action="store_true", help="use HTTPS URLs instead of SSH URLs")
    parser.add_argument("--force", action="store_true", help="clone even if the target path exists")
    args = parser.parse_args()

    for name in IP_LIST:
        destination = target_path(args.root, name)
        if destination.exists() and not args.force:
            print(f"skip {name}: {destination} exists")
            continue

        url = f"https://github.com/oscc-ip/{name}.git" if args.https else f"git@github.com:oscc-ip/{name}.git"
        destination.parent.mkdir(parents=True, exist_ok=True)
        command = ["git", "clone", url, str(destination)]
        print("+ " + " ".join(command))
        result = subprocess.run(command, check=False)
        if result.returncode:
            return result.returncode

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
