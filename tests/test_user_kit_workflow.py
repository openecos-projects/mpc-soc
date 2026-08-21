from __future__ import annotations

import unittest
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[1]
WORKFLOW = ROOT / ".github" / "workflows" / "user-kit.yml"


class UserKitWorkflowTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.workflow = yaml.safe_load(WORKFLOW.read_text(encoding="utf-8"))

    def test_workflow_run_jobs_only_accept_main_pushes_from_this_repository(self) -> None:
        jobs = self.workflow["jobs"]
        for job_name in ("export_and_test", "publish"):
            condition = jobs[job_name]["if"]
            with self.subTest(job=job_name):
                self.assertIn("workflow_run.event == 'push'", condition)
                self.assertIn("workflow_run.head_branch == 'main'", condition)
                self.assertIn(
                    "workflow_run.head_repository.full_name == github.repository",
                    condition,
                )

    def test_tested_directory_is_cleaned_without_reexporting(self) -> None:
        steps = self.workflow["jobs"]["export_and_test"]["steps"]
        clean_step = next(step for step in steps if step.get("name") == "Clean tested user kit")
        self.assertIn("rm -rf build/user-kit/build", clean_step["run"])
        self.assertNotIn("export-user-kit", clean_step["run"])


if __name__ == "__main__":
    unittest.main()
