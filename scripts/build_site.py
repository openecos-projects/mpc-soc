#!/usr/bin/env python3
"""Generate SoC overview data from YAML and Markdown sources."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def scalar(text: str, key: str) -> str:
    match = re.search(rf"^\s*{re.escape(key)}:\s*(.+)$", text, re.MULTILINE)
    return match.group(1).strip().strip("'\"") if match else ""


def parse_regions(text: str) -> list[dict[str, str]]:
    regions = []
    in_regions = False
    current: dict[str, str] | None = None
    for line in text.splitlines():
        if line.strip() == "regions:":
            in_regions = True
            continue
        if in_regions and line and not line.startswith("  "):
            break
        if not in_regions:
            continue
        region = re.match(r"^  ([\w]+):$", line)
        if region:
            if current:
                regions.append(current)
            current = {"name": region.group(1)}
            continue
        field = re.match(r"^    (base|size|kind|description|irq):\s*(.+)$", line)
        if field and current is not None:
            current[field.group(1)] = field.group(2).strip().strip("'\"")
    if current:
        regions.append(current)
    return regions


def parse_ip_table(text: str) -> list[dict[str, str]]:
    rows = []
    for line in text.splitlines():
        if not line.startswith("|") or line.startswith("| ---") or line.startswith("| IP "):
            continue
        cells = [cell.strip().replace("`", "") for cell in line.strip().strip("|").split("|")]
        if len(cells) == 6:
            rows.append(
                {
                    "name": cells[0],
                    "function": cells[1],
                    "address": cells[2],
                    "status": cells[3],
                    "tests": cells[4],
                    "risk": cells[5],
                }
            )
    return rows


def collect_soc_data(root: Path) -> dict:
    soc = (root / "config" / "soc.yml").read_text(encoding="utf-8")
    memory = (root / "config" / "memory.yml").read_text(encoding="utf-8")
    readiness_cn = (root / "docs" / "cn" / "ip-readiness.md").read_text(encoding="utf-8")
    readiness_en = (root / "docs" / "en" / "ip-readiness.md").read_text(encoding="utf-8")
    return {
        "soc": {
            "name": scalar(soc, "name"),
            "top": scalar(soc, "top_module"),
            "clockHz": int(scalar(soc, "clock_hz") or 0),
            "reset": scalar(soc, "reset"),
            "addressWidth": int(scalar(memory, "address_width") or 0),
            "dataWidth": int(scalar(memory, "data_width") or 0),
            "resetPc": scalar(memory, "pc"),
        },
        "regions": parse_regions(memory),
        "ips": parse_ip_table(readiness_cn),
        "ipsEn": parse_ip_table(readiness_en),
        "generatedFrom": [
            "config/soc.yml",
            "config/memory.yml",
            "docs/cn/ip-readiness.md",
            "docs/en/ip-readiness.md",
        ],
    }


def write_soc_data(root: Path, output: Path) -> Path:
    data = collect_soc_data(root)
    output.parent.mkdir(parents=True, exist_ok=True)
    if output.suffix == ".ts":
        output.write_text(
            "export const SOC_DATA = "
            + json.dumps(data, ensure_ascii=False, indent=2)
            + " as const\n",
            encoding="utf-8",
        )
    elif output.suffix == ".js":
        output.write_text(
            "window.SOC_DATA = " + json.dumps(data, ensure_ascii=False, indent=2) + ";\n",
            encoding="utf-8",
        )
    else:
        output.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return output


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--output",
        type=Path,
        default=ROOT / "dev" / "site" / ".vitepress" / "theme" / "soc-data.ts",
    )
    args = parser.parse_args()
    write_soc_data(ROOT, args.output.resolve())


if __name__ == "__main__":
    main()
