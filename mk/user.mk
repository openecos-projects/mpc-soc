.PHONY: help doctor check sim sw test-sw verilate gen-soc-pkg trace wave clean

help:
	@printf '%s\n' 'mpc-soc user commands'
	@printf '%s\n' '  make doctor                         Check required tools'
	@printf '%s\n' '  make check [CASE=hello]             Run one archived bootrom smoke'
	@printf '%s\n' '  make sim [APP=hello]                Build software and simulate'
	@printf '%s\n' '  make trace [APP=hello]              Simulate with FST tracing'
	@printf '%s\n' '  make wave                           Open the generated FST in GTKWave'
	@printf '%s\n' '  make sw [APP=hello]                 Build a software image'
	@printf '%s\n' '  make clean                          Remove generated build output'

doctor:
	@command -v $(PYTHON) >/dev/null || (printf '%s\n' 'ERROR: Python 3 not found'; exit 127)
	@command -v $(CXX) >/dev/null || (printf '%s\n' 'ERROR: C++ compiler not found'; exit 127)
	@command -v $(VERILATOR) >/dev/null || (printf '%s\n' 'ERROR: Verilator not found'; exit 127)
	@command -v $(CROSS_COMPILE)gcc >/dev/null || (printf '%s\n' \
		'ERROR: RISC-V toolchain not found: $(CROSS_COMPILE)gcc'; exit 127)
	@actual=$$($(VERILATOR) --version | awk '{print $$2}'); \
	printf 'Python: %s\n' "$$($(PYTHON) --version 2>&1)"; \
	printf 'C++: %s\n' "$$($(CXX) --version | head -n 1)"; \
	printf 'Verilator: %s (recommended: %s)\n' "$$actual" '$(VERILATOR_RECOMMENDED_VERSION)'; \
	printf 'Toolchain: %s\n' "$$($(CROSS_COMPILE)gcc --version | head -n 1)"; \
	if [ "$$actual" != '$(VERILATOR_RECOMMENDED_VERSION)' ]; then \
		printf '%s\n' 'WARNING: Verilator $(VERILATOR_RECOMMENDED_VERSION) is the series baseline'; \
	fi

gen-soc-pkg:
	@$(PYTHON) $(SOC_ROOT)/scripts/gen_soc_pkg.py

sw:
	@$(MAKE) -C sw BOARD="$(BOARD)" APP="$(APP)"

test-sw:
	@$(MAKE) -C "sw/tests/$(APP)" APP=main

verilate: gen-soc-pkg
	@$(MAKE) -C dv/verilator verilate TOP="$(TOP)" TRACE="$(TRACE)" VERILATOR="$(VERILATOR)"

sim: gen-soc-pkg $(SW_TARGET)
	@bootrom_image="$(BOOTROM_IMAGE_ABS)"; \
	if [ -z "$(BOOTROM_IMAGE_USER_SET)" ]; then \
		images=$$(find "$(BOOTROM_DIR)" -maxdepth 1 -type f -name '*.bin' 2>/dev/null | sort); \
		preferred=$$(printf '%s\n' "$$images" | grep -v '/app\.bin$$' | head -n 1); \
		if [ -n "$$preferred" ]; then bootrom_image="$$preferred"; else bootrom_image=$$(printf '%s\n' "$$images" | head -n 1); fi; \
	fi; \
		$(MAKE) -C dv/verilator sim TOP="$(TOP)" BOARD="$(BOARD)" APP="$(APP)" BOOTROM_IMAGE="$$bootrom_image" MAX_CYCLES="$(MAX_CYCLES)" TRACE="$(TRACE)" CORE_SEL="$(CORE_SEL)" FAST_PSRAM="$(FAST_PSRAM)" UART_INPUT="$(UART_INPUT)" UART_STOP_TEXT="$(UART_STOP_TEXT)" UART_FAIL_TEXT="$(UART_FAIL_TEXT)" UART1_EXPECT="$(UART1_EXPECT)" UART1_BIT_CYCLES="$(UART1_BIT_CYCLES)" UART1_ARM_TEXT="$(UART1_ARM_TEXT)" GPIO_IN="$(GPIO_IN)" GPIO_DRIVE="$(GPIO_DRIVE)" GPIO_EXPECT="$(GPIO_EXPECT)" GPIO_EXPECT_MASK="$(GPIO_EXPECT_MASK)" VERILATOR="$(VERILATOR)"

check:
	@$(PYTHON) $(SOC_ROOT)/scripts/verilator_regress.py --cases "$(CASE)" \
		--output "$(if $(filter full,$(OUTPUT)),list,$(OUTPUT))" --core-sel "$(CORE_SEL)" \
		$(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) \
		$(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) \
		$(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)
	@printf '%s\n' 'SOC SMOKE CHECK PASS'

trace:
	@$(MAKE) -f $(SOC_MAKEFILE) sim APP="$(APP)" TRACE=1 CORE_SEL="$(CORE_SEL)" MAX_CYCLES="$(MAX_CYCLES)"

wave:
	@command -v $(GTKWAVE) >/dev/null 2>&1 || (printf '%s\n' \
		'ERROR: GTKWave not found; install it or set GTKWAVE=<command>'; exit 127)
	@test -f "$(WAVE_FILE)" || (printf '%s\n' \
		'ERROR: waveform not found: $(WAVE_FILE)' \
		'Run make trace APP=$(APP) first.'; exit 2)
	@$(GTKWAVE) "$(WAVE_FILE)" >/dev/null 2>&1 &
	@printf '%s\n' 'Opened waveform: $(WAVE_FILE)'

clean:
	@$(MAKE) -C dv/verilator clean
	@$(MAKE) -C sw clean BOARD="$(BOARD)" APP="$(APP)"
	@if [ -d "sw/tests/$(APP)" ]; then $(MAKE) -C "sw/tests/$(APP)" APP=main clean; fi
