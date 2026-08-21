from __future__ import annotations

import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class DoctorVersionTest(unittest.TestCase):
    def run_doctor(self, version: str) -> subprocess.CompletedProcess[str]:
        with tempfile.TemporaryDirectory() as temporary:
            fake_verilator = Path(temporary) / "verilator"
            fake_verilator.write_text(
                f"#!/bin/sh\nprintf '%s\\n' 'Verilator {version} test-build'\n",
                encoding="utf-8",
            )
            fake_verilator.chmod(0o755)
            return subprocess.run(
                ["make", "doctor", f"VERILATOR={fake_verilator}"],
                cwd=ROOT,
                capture_output=True,
                text=True,
            )

    def test_required_verilator_version_passes(self) -> None:
        result = self.run_doctor("5.050")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("Verilator: 5.050 (required: 5.050)", result.stdout)

    def test_older_verilator_version_fails(self) -> None:
        result = self.run_doctor("4.038")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("ERROR: Verilator 5.050 is required", result.stderr)


if __name__ == "__main__":
    unittest.main()
