#!/usr/bin/env python3
import argparse
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

try:
    import yaml
except ImportError:
    yaml = None


def load_case_config(case_dir: Path) -> dict:
    config_path = case_dir / "test.yml"
    if not config_path.exists():
        images = sorted(case_dir.glob("*.bin"))
        if not images:
            raise ValueError(f"no test.yml or .bin image found in {case_dir}")
        return {
            "name": case_dir.name,
            "image": images[0].name,
        }

    if yaml is None:
        raise RuntimeError("PyYAML is required to read test.yml")

    with config_path.open("r", encoding="utf-8") as file:
        config = yaml.safe_load(file) or {}

    config.setdefault("name", case_dir.name)
    return config


def split_cases(value: str) -> list[str]:
    return [item for item in value.replace(",", " ").split() if item]


def discover_cases(bootrom_dir: Path, selected: str) -> list[Path]:
    if selected:
        return [bootrom_dir / case for case in split_cases(selected)]

    cases = []
    for path in sorted(bootrom_dir.iterdir()):
        if not path.is_dir():
            continue
        if (path / "test.yml").exists() or list(path.glob("*.bin")):
            cases.append(path)
    return cases


def make_arg(name: str, value) -> str:
    return f"{name}={value}"


def format_duration(seconds: float) -> str:
    if seconds < 60:
        return f"{seconds:.1f}s"
    minutes = int(seconds // 60)
    rest = seconds - minutes * 60
    return f"{minutes}m{rest:04.1f}s"


def make_run_log_dir(root: Path) -> Path:
    base_dir = root / "build" / "log" / "regress"
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    log_dir = base_dir / timestamp
    suffix = 1
    while log_dir.exists():
        log_dir = base_dir / f"{timestamp}-{suffix}"
        suffix += 1
    log_dir.mkdir(parents=True)
    return log_dir


def run_case(args: argparse.Namespace, case_dir: Path) -> tuple[bool, Path, float]:
    started_at = time.monotonic()
    config = load_case_config(case_dir)
    case_name = str(config.get("name") or case_dir.name)
    image = case_dir / str(config.get("image", "main-asm.bin"))
    if not image.exists():
        raise FileNotFoundError(f"{case_name}: boot image not found: {image}")

    uart = config.get("uart") or {}
    max_cycles = args.max_cycles if args.max_cycles is not None else config.get("max_cycles", 500000)
    trace = args.trace if args.trace is not None else int(bool(config.get("trace", False)))
    core_sel = args.core_sel if args.core_sel is not None else config.get("core_sel", 0)
    uart_input = args.uart_input if args.uart_input is not None else uart.get("input", "")
    uart_start_cycle = args.uart_start_cycle if args.uart_start_cycle is not None else uart.get("start_cycle", 10000)
    uart_stop_text = args.uart_stop_text if args.uart_stop_text is not None else uart.get("stop_text", "")
    uart_fail_text = args.uart_fail_text if args.uart_fail_text is not None else uart.get("fail_text", "")
    uart1 = config.get("uart1") or {}
    uart1_expect = args.uart1_expect if args.uart1_expect is not None else uart1.get("expect", "")
    uart1_bit_cycles = args.uart1_bit_cycles if args.uart1_bit_cycles is not None else uart1.get("bit_cycles", "")
    uart1_arm_text = args.uart1_arm_text if args.uart1_arm_text is not None else uart1.get("arm_text", "")
    gpio = config.get("gpio") or {}
    gpio_input = args.gpio_input if args.gpio_input is not None else gpio.get("input", "")
    gpio_drive = args.gpio_drive if args.gpio_drive is not None else gpio.get("drive", "")
    gpio_expect = args.gpio_expect if args.gpio_expect is not None else gpio.get("expect", "")
    gpio_expect_mask = args.gpio_expect_mask if args.gpio_expect_mask is not None else gpio.get("expect_mask", "")
    if isinstance(gpio_expect, list):
        gpio_expect = ",".join(str(item) for item in gpio_expect)

    log_dir = args.log_dir
    log_path = log_dir / f"{case_name}.log"
    make_log_path = log_dir / f"{case_name}.make.log"

    command = [
        "make",
        "-C",
        str(args.root / "dv" / "verilator"),
        "sim",
        make_arg("APP", case_name),
        make_arg("BOOTROM_IMAGE", str(image.resolve())),
        make_arg("MAX_CYCLES", max_cycles),
        make_arg("TRACE", trace),
        make_arg("CORE_SEL", core_sel),
        make_arg("SIM_LOG", str(log_path.resolve())),
    ]

    if uart_input:
        command.append(make_arg("UART_INPUT", uart_input))
        command.append(make_arg("UART_START_CYCLE", uart_start_cycle))
    if uart_stop_text:
        command.append(make_arg("UART_STOP_TEXT", uart_stop_text))
    if uart_fail_text:
        command.append(make_arg("UART_FAIL_TEXT", uart_fail_text))
    if uart1_expect:
        command.append(make_arg("UART1_EXPECT", uart1_expect))
        if uart1_bit_cycles != "":
            command.append(make_arg("UART1_BIT_CYCLES", uart1_bit_cycles))
        if uart1_arm_text:
            command.append(make_arg("UART1_ARM_TEXT", uart1_arm_text))
    if gpio_input != "":
        command.append(make_arg("GPIO_IN", gpio_input))
    if gpio_drive != "":
        command.append(make_arg("GPIO_DRIVE", gpio_drive))
    if gpio_expect:
        command.append(make_arg("GPIO_EXPECT", gpio_expect))
    if gpio_expect_mask != "":
        command.append(make_arg("GPIO_EXPECT_MASK", gpio_expect_mask))

    if args.output == "full":
        print(f"[RUN ] {case_name}", flush=True)
        print(f"      image: {image}", flush=True)
        print(f"      log:   {log_path}", flush=True)
        result = subprocess.run(command, cwd=args.root)
    else:
        result = subprocess.run(command, cwd=args.root, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        make_log_path.write_text(result.stdout or "", encoding="utf-8")
    passed = result.returncode == 0
    elapsed = time.monotonic() - started_at
    if args.output == "list":
        print(f"  [{'PASS' if passed else 'FAIL'}] {case_name:<20} {format_duration(elapsed):>8}", flush=True)
    else:
        print(f"{'PASS' if passed else 'FAIL'} {case_name} {log_path}", flush=True)
    return passed, log_path, elapsed


def main() -> int:
    parser = argparse.ArgumentParser(description="Run archived bootrom images through Verilator")
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--bootrom-dir", type=Path, default=None)
    parser.add_argument("--cases", default="", help="space or comma separated case names")
    parser.add_argument("--stop-on-fail", action="store_true")
    parser.add_argument("--max-cycles", type=int, default=None)
    parser.add_argument("--trace", type=int, choices=(0, 1), default=None)
    parser.add_argument("--core-sel", type=int, default=None)
    parser.add_argument("--uart-input", default=None)
    parser.add_argument("--uart-start-cycle", type=int, default=None)
    parser.add_argument("--uart-stop-text", default=None)
    parser.add_argument("--uart-fail-text", default=None)
    parser.add_argument("--uart1-expect", default=None)
    parser.add_argument("--uart1-bit-cycles", type=int, default=None)
    parser.add_argument("--uart1-arm-text", default=None)
    parser.add_argument("--gpio-input", default=None)
    parser.add_argument("--gpio-drive", default=None)
    parser.add_argument("--gpio-expect", default=None)
    parser.add_argument("--gpio-expect-mask", default=None)
    parser.add_argument("--output", choices=("full", "list"), default="full", help="terminal output mode")
    args = parser.parse_args()

    args.root = args.root.resolve()
    args.log_dir = make_run_log_dir(args.root)
    bootrom_dir = args.bootrom_dir or (args.root / "sw" / "bootrom")
    bootrom_dir = bootrom_dir.resolve()

    if not bootrom_dir.exists():
        print(f"ERROR: bootrom directory not found: {bootrom_dir}", file=sys.stderr)
        return 2

    cases = discover_cases(bootrom_dir, args.cases)
    if not cases:
        print(f"ERROR: no bootrom cases found under {bootrom_dir}", file=sys.stderr)
        return 2

    run_started_at = time.monotonic()
    if args.output == "list":
        print(f"Regression: {len(cases)} case(s)")
        print(f"Logs: {args.log_dir}")
        print("")
        print("Results:")

    results = []
    for case_dir in cases:
        try:
            passed, log_path, elapsed = run_case(args, case_dir)
        except Exception as exc:
            passed = False
            log_path = Path("")
            elapsed = 0.0
            print(f"[FAIL] {case_dir.name}: {exc}", file=sys.stderr)
            if args.output == "list":
                print(f"  [FAIL] {case_dir.name:<20} {format_duration(elapsed):>8}", flush=True)
        results.append((case_dir.name, passed, log_path, elapsed))
        if not passed and args.stop_on_fail:
            break

    summary_path = args.log_dir / "summary.txt"
    with summary_path.open("w", encoding="utf-8") as file:
        for name, passed, log_path, elapsed in results:
            file.write(f"{'PASS' if passed else 'FAIL'} {name} {format_duration(elapsed)} {log_path}\n")

    total = len(results)
    passed_count = sum(1 for _, passed, _, _ in results if passed)
    failed_count = total - passed_count
    pass_rate = (passed_count * 100.0 / total) if total else 0.0
    total_elapsed = time.monotonic() - run_started_at

    if args.output == "full":
        print("")
        print(f"Summary: {summary_path}")
        for name, passed, log_path, elapsed in results:
            print(f"{'PASS' if passed else 'FAIL'} {name} {format_duration(elapsed)} {log_path}")
    else:
        print("")
        print("Summary:")
        print(f"  Total:     {total}")
        print(f"  Passed:    {passed_count}")
        print(f"  Failed:    {failed_count}")
        print(f"  Pass rate: {pass_rate:.1f}%")
        print(f"  Elapsed:   {format_duration(total_elapsed)}")
        print(f"  Logs:      {args.log_dir}")
        print(f"  Summary:   {summary_path}")

    return 0 if all(passed for _, passed, _, _ in results) else 1


if __name__ == "__main__":
    raise SystemExit(main())
