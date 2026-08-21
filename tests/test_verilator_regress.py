from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from scripts.verilator_regress import discover_cases, resolve_case_image, validate_case_name


class VerilatorRegressionBoundaryTest(unittest.TestCase):
    def test_selected_case_must_be_a_direct_child(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            bootrom_dir = Path(temporary)
            (bootrom_dir / "hello").mkdir()

            with self.assertRaisesRegex(ValueError, "invalid case name"):
                discover_cases(bootrom_dir, "../hello")
            with self.assertRaisesRegex(ValueError, "invalid case name"):
                discover_cases(bootrom_dir, "/tmp/hello")

    def test_selected_case_must_exist(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            with self.assertRaisesRegex(FileNotFoundError, "bootrom case not found"):
                discover_cases(Path(temporary), "missing")

    def test_case_name_is_safe_for_make_and_logs(self) -> None:
        self.assertEqual(validate_case_name("gpio-toggle_1.0"), "gpio-toggle_1.0")
        for value in ("", ".", "..", "case/name", "case name", "name=value"):
            with self.subTest(value=value), self.assertRaises(ValueError):
                validate_case_name(value)

    def test_image_must_be_a_bin_inside_the_case(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            case_dir = Path(temporary) / "hello"
            case_dir.mkdir()
            image = case_dir / "hello.bin"
            image.write_bytes(b"test")

            self.assertEqual(resolve_case_image(case_dir, "hello.bin"), image.resolve())
            for value in ("../outside.bin", "/tmp/outside.bin", "hello.elf"):
                with self.subTest(value=value), self.assertRaises(ValueError):
                    resolve_case_image(case_dir, value)

    def test_image_symlink_cannot_escape_case(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            case_dir = root / "hello"
            case_dir.mkdir()
            outside = root / "outside.bin"
            outside.write_bytes(b"test")
            link = case_dir / "hello.bin"
            try:
                link.symlink_to(outside)
            except (OSError, NotImplementedError) as exc:
                self.skipTest(f"symlinks unavailable: {exc}")

            with self.assertRaisesRegex(ValueError, "outside its case directory"):
                resolve_case_image(case_dir, link.name)


if __name__ == "__main__":
    unittest.main()
