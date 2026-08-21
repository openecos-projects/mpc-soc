#!/usr/bin/env bash
set -euo pipefail

verilator_version=5.050
verilator_commit=848d926ebd4addacacd294dc84e35d9d4ae8078c
expected_version="Verilator ${verilator_version}"

if command -v verilator >/dev/null 2>&1 &&
    verilator --version | grep -Fq "$expected_version"; then
    verilator --version
    exit 0
fi

tool_root=${RUNNER_TEMP:-/tmp/mpc-soc-ci-tools}
source_dir="$tool_root/verilator-src-$verilator_version"
install_dir="$tool_root/verilator-$verilator_version"

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    autoconf bison flex g++ git help2man libfl-dev liblz4-dev make perl \
    python3 zlib1g-dev

rm -rf "$source_dir" "$install_dir"
git init "$source_dir"
git -C "$source_dir" remote add origin https://github.com/verilator/verilator.git
git -C "$source_dir" fetch --depth 1 origin "$verilator_commit"
git -C "$source_dir" checkout --detach FETCH_HEAD
test "$(git -C "$source_dir" rev-parse HEAD)" = "$verilator_commit"

(
    cd "$source_dir"
    autoconf
    ./configure --prefix="$install_dir"
    make -j"$(nproc)"
    make install
)

"$install_dir/bin/verilator" --version | grep -F "$expected_version"
printf '%s/bin\n' "$install_dir" >> "$GITHUB_PATH"
