from __future__ import annotations

import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SIM_MAIN = ROOT / "dv" / "verilator" / "csrc" / "sim_main.cpp"


class SimulatorTimeoutTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        compiler = shutil.which("c++")
        if compiler is None:
            raise unittest.SkipTest("a C++ compiler is required")

        cls.temp_dir = tempfile.TemporaryDirectory()
        temp = Path(cls.temp_dir.name)
        (temp / "verilated.h").write_text(
            """#pragma once
#include <cstdint>

class VerilatedContext {
 public:
  void commandArgs(int, char**) {}
  bool gotFinish() const { return false; }
  void timeInc(std::uint64_t amount) { time_ += amount; }
  std::uint64_t time() const { return time_; }
  void traceEverOn(bool) {}

 private:
  std::uint64_t time_ = 0;
};

class Verilated {
 public:
  static void gotFinish(bool) {}
};
""",
            encoding="utf-8",
        )
        (temp / "VTest.h").write_text(
            """#pragma once
#include "verilated.h"

class VTest {
 public:
  explicit VTest(VerilatedContext*) {}
  void eval() {}
  void final() {}

  int clock = 0;
  int reset = 0;
};
""",
            encoding="utf-8",
        )
        cls.simulator = temp / "sim-timeout-test"
        subprocess.run(
            [
                compiler,
                "-std=c++17",
                f"-I{temp}",
                '-DSIM_TOP_HEADER="VTest.h"',
                "-DSIM_TOP_CLASS=VTest",
                "-DVM_TRACE=0",
                str(SIM_MAIN),
                "-o",
                str(cls.simulator),
            ],
            check=True,
            capture_output=True,
            text=True,
        )

    @classmethod
    def tearDownClass(cls) -> None:
        cls.temp_dir.cleanup()

    def run_sim(self, *arguments: str) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            [str(self.simulator), "+max-cycles=2", *arguments],
            capture_output=True,
            text=True,
        )

    def test_cycle_limit_without_pass_condition_fails(self) -> None:
        result = self.run_sim()
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
        self.assertIn("SIM FAIL: cycle limit reached", result.stderr)

    def test_stop_condition_timeout_fails(self) -> None:
        result = self.run_sim("+uart-stop-text=never")
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
        self.assertIn("SIM FAIL: UART stop text not observed", result.stderr)

    def test_allow_timeout_does_not_override_stop_condition(self) -> None:
        result = self.run_sim("+uart-stop-text=never", "+allow-timeout=1")
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
        self.assertIn("SIM FAIL: UART stop text not observed", result.stderr)

    def test_cycle_limit_can_be_allowed_for_exploration(self) -> None:
        result = self.run_sim("+allow-timeout=1")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("SIM PASS: allowed cycle limit reached", result.stdout)


if __name__ == "__main__":
    unittest.main()
