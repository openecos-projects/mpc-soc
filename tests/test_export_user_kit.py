from __future__ import annotations

import os
import shutil
import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "export_user_kit.py"
OUTPUT = ROOT / "build" / "test-user-kit"


class ExportUserKitTest(unittest.TestCase):
    UNTRACKED_TREE_FILE = ROOT / "hw" / "common" / "rtl" / ".user-kit-review-untracked"
    SYMLINK_TREE_FILE = ROOT / "hw" / "common" / "rtl" / ".user-kit-review-link"

    def tearDown(self) -> None:
        shutil.rmtree(OUTPUT, ignore_errors=True)
        self.UNTRACKED_TREE_FILE.unlink(missing_ok=True)
        self.SYMLINK_TREE_FILE.unlink(missing_ok=True)

    def test_export_contains_user_surface_only(self) -> None:
        environment = os.environ.copy()
        environment["SOURCE_SHA"] = "unit-test-source"
        subprocess.run(
            [
                "python3",
                str(SCRIPT),
                "--root",
                str(ROOT),
                "--output",
                str(OUTPUT),
            ],
            check=True,
            capture_output=True,
            text=True,
            env=environment,
        )

        self.assertTrue((OUTPUT / "Makefile").is_file())
        self.assertTrue((OUTPUT / "hw" / "soc" / "top" / "asic_top.v").is_file())
        self.assertTrue((OUTPUT / "sw" / "bootrom" / "hello" / "test.yml").is_file())
        self.assertTrue((OUTPUT / "sw" / "bootrom" / "hello" / "retrosoc_fw.bin").is_file())
        self.assertFalse((OUTPUT / "sw" / "Makefile").exists())
        self.assertFalse((OUTPUT / "sw" / "ecos").exists())
        self.assertFalse((OUTPUT / "sw" / "ecos.mk").exists())
        self.assertFalse((OUTPUT / "scripts" / "gen_soc_pkg.py").exists())
        self.assertFalse((OUTPUT / "Makefile.dev").exists())
        self.assertFalse((OUTPUT / ".github").exists())
        self.assertFalse((OUTPUT / "dev").exists())
        self.assertFalse((OUTPUT / "tests").exists())
        self.assertFalse((OUTPUT / "dv" / "verilator" / "tests").exists())
        self.assertFalse((OUTPUT / "docs" / "cn" / "index.md").exists())
        self.assertFalse((OUTPUT / "docs" / "en" / "index.md").exists())
        self.assertEqual(
            sorted(path.name for path in (OUTPUT / "sw" / "bootrom").iterdir()),
            ["hello"],
        )
        metadata = (OUTPUT / "SOC_KIT_VERSION").read_text(encoding="utf-8")
        self.assertIn("KIT_FORMAT_VERSION=1\n", metadata)
        self.assertIn("SOURCE_COMMIT=unit-test-source\n", metadata)

    def test_export_rejects_output_outside_build(self) -> None:
        result = subprocess.run(
            [
                "python3",
                str(SCRIPT),
                "--root",
                str(ROOT),
                "--output",
                str(ROOT / "user-kit-outside-build"),
            ],
            capture_output=True,
            text=True,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("output must be a child directory of build/", result.stderr)

    def test_export_omits_untracked_tree_files(self) -> None:
        self.UNTRACKED_TREE_FILE.write_text("must not ship\n", encoding="utf-8")
        self.run_export()
        self.assertFalse((OUTPUT / "hw" / "common" / "rtl" / self.UNTRACKED_TREE_FILE.name).exists())

    def test_export_rejects_symlinks(self) -> None:
        try:
            self.SYMLINK_TREE_FILE.symlink_to(ROOT / "LICENSE")
        except (OSError, NotImplementedError) as exc:
            self.skipTest(f"symlinks unavailable: {exc}")
        result = subprocess.run(
            [
                "python3",
                str(SCRIPT),
                "--root",
                str(ROOT),
                "--output",
                str(OUTPUT),
            ],
            capture_output=True,
            text=True,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("contains a symlink", result.stderr)

    def run_export(self) -> None:
        environment = os.environ.copy()
        environment["SOURCE_SHA"] = "unit-test-source"
        subprocess.run(
            [
                "python3",
                str(SCRIPT),
                "--root",
                str(ROOT),
                "--output",
                str(OUTPUT),
            ],
            check=True,
            capture_output=True,
            text=True,
            env=environment,
        )


if __name__ == "__main__":
    unittest.main()
