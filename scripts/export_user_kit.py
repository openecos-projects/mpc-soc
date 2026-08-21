#!/usr/bin/env python3
"""Export the supported user-facing mpc-soc development environment."""

from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
from pathlib import Path


def resolve_child(root: Path, value: object, context: str) -> Path:
    if not isinstance(value, str) or not value:
        raise ValueError(f"{context}: expected a non-empty relative path")
    relative = Path(value)
    if relative.is_absolute() or ".." in relative.parts:
        raise ValueError(f"{context}: path escapes its root: {value}")
    candidate = (root / relative).resolve()
    try:
        candidate.relative_to(root.resolve())
    except ValueError as exc:
        raise ValueError(f"{context}: path escapes its root: {value}") from exc
    return candidate


def string_list(value: object, context: str) -> list[str]:
    if not isinstance(value, list) or not all(
        isinstance(item, str) and item for item in value
    ):
        raise ValueError(f"{context}: expected an array of non-empty strings")
    return value


def tracked_paths(root: Path, source_name: str) -> set[Path]:
    result = subprocess.run(
        ["git", "ls-files", "-z", "--", source_name],
        cwd=root,
        check=True,
        capture_output=True,
    )
    return {
        Path(os.fsdecode(path))
        for path in result.stdout.split(b"\0")
        if path
    }


def reject_symlinks(source: Path) -> None:
    if source.is_symlink():
        raise ValueError(f"user-kit source must not be a symlink: {source}")
    if source.is_dir():
        for path in source.rglob("*"):
            if path.is_symlink():
                raise ValueError(f"user-kit source contains a symlink: {path}")


def copy_entry(
    root: Path, output: Path, source_name: str, target_name: str | None = None
) -> None:
    source = resolve_child(root, source_name, "source")
    target = resolve_child(output, target_name or source_name, "destination")
    if not source.exists():
        raise FileNotFoundError(f"user-kit source does not exist: {source_name}")
    reject_symlinks(root / source_name)
    target.parent.mkdir(parents=True, exist_ok=True)
    if source.is_dir():
        allowed = tracked_paths(root, source_name)
        if not allowed:
            raise ValueError(f"user-kit source directory has no tracked files: {source_name}")

        def ignore_untracked(directory: str, names: list[str]) -> list[str]:
            directory_path = Path(directory).resolve()
            ignored: list[str] = []
            for name in names:
                path = directory_path / name
                relative = path.relative_to(root)
                if path.is_dir():
                    if not any(item == relative or relative in item.parents for item in allowed):
                        ignored.append(name)
                elif relative not in allowed:
                    ignored.append(name)
            return ignored

        shutil.copytree(source, target, ignore=ignore_untracked)
    else:
        shutil.copy2(source, target)


def copy_public_docs(root: Path, output: Path, config: object) -> None:
    if not isinstance(config, dict) or set(config) != {"manifest", "exclude"}:
        raise ValueError("public_docs: expected only manifest and exclude")
    manifest = resolve_child(root, config["manifest"], "public_docs.manifest")
    docs_config = json.loads(manifest.read_text(encoding="utf-8"))
    if not isinstance(docs_config, dict) or set(docs_config) != {"pages"}:
        raise ValueError(f"{manifest}: expected an object containing only pages")
    pages = string_list(docs_config["pages"], f"{manifest}.pages")
    excluded = set(string_list(config["exclude"], "public_docs.exclude"))
    unknown_exclusions = excluded - set(pages)
    if unknown_exclusions:
        names = ", ".join(sorted(unknown_exclusions))
        raise ValueError(f"public_docs.exclude: pages are not published: {names}")
    for page in pages:
        page_path = Path(page)
        if page_path.is_absolute() or ".." in page_path.parts or page_path.suffix != ".md":
            raise ValueError(f"{manifest}: invalid page entry: {page!r}")
        if page in excluded:
            continue
        for locale in ("cn", "en"):
            copy_entry(root, output, str(Path("docs") / locale / page_path))


def write_metadata(root: Path, output: Path, destination: object) -> None:
    metadata = resolve_child(output, destination, "metadata")
    version = (root / "VERSION").read_text(encoding="utf-8").strip()
    source_commit = os.environ.get("SOURCE_SHA") or os.environ.get("GITHUB_SHA") or "unknown"
    metadata.parent.mkdir(parents=True, exist_ok=True)
    metadata.write_text(
        "KIT_FORMAT_VERSION=1\n"
        f"SOC_VERSION={version}\n"
        f"SOURCE_COMMIT={source_commit}\n",
        encoding="utf-8",
    )


def export_user_kit(root: Path, output: Path, manifest: Path) -> None:
    root = root.resolve()
    output = output.resolve()
    build_root = (root / "build").resolve()
    manifest = manifest.resolve()
    if output == build_root or build_root not in output.parents:
        raise ValueError("output must be a child directory of build/")

    config = json.loads(manifest.read_text(encoding="utf-8"))
    expected = {"files", "trees", "public_docs", "overrides", "metadata"}
    if not isinstance(config, dict) or set(config) != expected:
        raise ValueError(f"{manifest}: expected only {', '.join(sorted(expected))}")

    files = string_list(config["files"], "files")
    trees = string_list(config["trees"], "trees")
    overrides = config["overrides"]
    if not isinstance(overrides, list):
        raise ValueError("overrides: expected an array")

    shutil.rmtree(output, ignore_errors=True)
    output.mkdir(parents=True)
    for source in files:
        copy_entry(root, output, source)
    for source in trees:
        copy_entry(root, output, source)
    copy_public_docs(root, output, config["public_docs"])
    for index, override in enumerate(overrides):
        if not isinstance(override, dict) or set(override) != {"source", "destination"}:
            raise ValueError(f"overrides[{index}]: expected only source and destination")
        copy_entry(root, output, override["source"], override["destination"])
    write_metadata(root, output, config["metadata"])


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--manifest", type=Path)
    args = parser.parse_args()
    root = args.root.resolve()
    manifest = (args.manifest or root / "dev" / "user-kit.json").resolve()
    try:
        export_user_kit(root, args.output, manifest)
    except (FileNotFoundError, json.JSONDecodeError, OSError, ValueError) as exc:
        parser.error(str(exc))
    print(f"Exported user kit to {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
