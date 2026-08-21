.PHONY: help doctor check sim lint verilate trace wave clean

USER_BOOTROM_IMAGE := $(SOC_ROOT)/sw/bootrom/hello/retrosoc_fw.bin

help:
	@printf '%s\n' 'mpc-soc user commands'
	@printf '%s\n' '  make doctor                         Check required tools'
	@printf '%s\n' '  make check [CASE=hello]             Run one archived bootrom smoke'
	@printf '%s\n' '  make lint                           Run Verilator RTL lint'
	@printf '%s\n' '  make sim                            Simulate with the bundled hello image'
	@printf '%s\n' '  make trace                          Simulate the hello image with FST tracing'
	@printf '%s\n' '  make wave                           Open the generated FST in GTKWave'
	@printf '%s\n' '  make clean                          Remove generated build output'

doctor:
	@command -v $(PYTHON) >/dev/null || (printf '%s\n' 'ERROR: Python 3 not found'; exit 127)
	@$(PYTHON) -c 'import sys; raise SystemExit(0 if sys.version_info >= (3, 9) else 1)' || (printf '%s\n' 'ERROR: Python 3.9 or newer is required'; exit 127)
	@$(PYTHON) -c 'import yaml' >/dev/null 2>&1 || (printf '%s\n' \
		'ERROR: PyYAML not found; install python3-yaml or pip install pyyaml'; exit 127)
	@command -v $(CXX) >/dev/null || (printf '%s\n' 'ERROR: C++ compiler not found'; exit 127)
	@command -v $(VERILATOR) >/dev/null || (printf '%s\n' 'ERROR: Verilator not found'; exit 127)
	@actual=$$($(VERILATOR) --version | awk '{print $$2}'); \
	printf 'Python: %s\n' "$$($(PYTHON) --version 2>&1)"; \
	printf 'C++: %s\n' "$$($(CXX) --version | head -n 1)"; \
	printf 'Verilator: %s (required: %s)\n' "$$actual" '$(VERILATOR_REQUIRED_VERSION)'; \
	if [ "$$actual" != '$(VERILATOR_REQUIRED_VERSION)' ]; then \
		printf '%s\n' 'ERROR: Verilator $(VERILATOR_REQUIRED_VERSION) is required' >&2; \
		exit 2; \
	fi

verilate:
	@$(MAKE) -C dv/verilator verilate TOP="$(TOP)" TRACE="$(TRACE)" VERILATOR="$(VERILATOR)"

lint:
	@$(MAKE) -C dv/verilator lint TOP="$(TOP)" FAST_PSRAM="$(FAST_PSRAM)" VERILATOR="$(VERILATOR)"

sim:
	@test -f "$(USER_BOOTROM_IMAGE)" || (printf '%s\n' \
		'ERROR: bundled boot image not found: $(USER_BOOTROM_IMAGE)'; exit 2)
	@$(MAKE) -C dv/verilator sim TOP="$(TOP)" BOARD="mpc-soc" APP="hello" \
		BOOTROM_IMAGE="$(USER_BOOTROM_IMAGE)" MAX_CYCLES="$(MAX_CYCLES)" \
		ALLOW_TIMEOUT="$(ALLOW_TIMEOUT)" TRACE="$(TRACE)" CORE_SEL="$(CORE_SEL)" \
		FAST_PSRAM="$(FAST_PSRAM)" UART_STOP_TEXT="done!" VERILATOR="$(VERILATOR)"

check:
	@$(PYTHON) $(SOC_ROOT)/scripts/verilator_regress.py --cases "$(CASE)" \
		--output "$(if $(filter full,$(OUTPUT)),list,$(OUTPUT))" --core-sel "$(CORE_SEL)" \
		$(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) \
		$(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) \
		$(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)
	@printf '%s\n' 'SOC SMOKE CHECK PASS'

trace:
	@$(MAKE) -f $(SOC_MAKEFILE) sim TRACE=1 CORE_SEL="$(CORE_SEL)" MAX_CYCLES="$(MAX_CYCLES)"

wave:
	@command -v $(GTKWAVE) >/dev/null 2>&1 || (printf '%s\n' \
		'ERROR: GTKWave not found; install it or set GTKWAVE=<command>'; exit 127)
	@test -f "$(WAVE_FILE)" || (printf '%s\n' \
		'ERROR: waveform not found: $(WAVE_FILE)' \
		'Run make trace first.'; exit 2)
	@$(GTKWAVE) "$(WAVE_FILE)" >/dev/null 2>&1 &
	@printf '%s\n' 'Opened waveform: $(WAVE_FILE)'

clean:
	@$(MAKE) -C dv/verilator clean
