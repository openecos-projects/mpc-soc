SOC_ROOT := $(CURDIR)
BOARD ?= mpc-soc
APP ?= hello
TOP ?= SimTop
MAX_CYCLES ?= 500000
TRACE ?= 0
CORE_SEL ?= 0
FAST_PSRAM ?= 1
TEST_APP_DIR := $(SOC_ROOT)/sw/tests/$(APP)
UART_INPUT ?=
UART_STOP_TEXT ?=
UART_FAIL_TEXT ?=
UART1_EXPECT ?=
UART1_BIT_CYCLES ?= 8
UART1_ARM_TEXT ?=
GPIO_IN ?=
GPIO_DRIVE ?=
GPIO_EXPECT ?=
GPIO_EXPECT_MASK ?=

ifeq ($(APP),asm_hello)
ifeq ($(strip $(UART_INPUT)),)
UART_INPUT := 0123456789
endif
ifeq ($(strip $(UART_STOP_TEXT)),)
UART_STOP_TEXT := done！
endif
endif

ifeq ($(APP),psram_sweep)
ifeq ($(strip $(UART_STOP_TEXT)),)
UART_STOP_TEXT := psram sweep ok
endif
ifeq ($(strip $(UART_FAIL_TEXT)),)
UART_FAIL_TEXT := psram fail
endif
endif

ifeq ($(APP),psram_basic)
ifeq ($(strip $(UART_STOP_TEXT)),)
UART_STOP_TEXT := psram ok
endif
ifeq ($(strip $(UART_FAIL_TEXT)),)
UART_FAIL_TEXT := psram fail
endif
endif

ifeq ($(wildcard $(TEST_APP_DIR)/Makefile),)
BOOTROM_DIR ?= $(SOC_ROOT)/build/sw/$(BOARD)/$(APP)
SW_TARGET := sw
else
BOOTROM_DIR ?= $(TEST_APP_DIR)/build
SW_TARGET := test-sw
endif

DEFAULT_BOOTROM_IMAGE = $(shell images=$$(find "$(BOOTROM_DIR)" -maxdepth 1 -type f -name '*.bin' 2>/dev/null | sort); preferred=$$(printf '%s\n' "$$images" | grep -v '/app\.bin$$' | head -n 1); if [ -n "$$preferred" ]; then printf '%s' "$$preferred"; else printf '%s\n' "$$images" | head -n 1; fi)
BOOTROM_IMAGE ?= $(DEFAULT_BOOTROM_IMAGE)
BOOTROM_IMAGE_ABS = $(if $(filter /%,$(BOOTROM_IMAGE)),$(BOOTROM_IMAGE),$(SOC_ROOT)/$(BOOTROM_IMAGE))
BOOTROM_IMAGE_USER_SET := $(filter command line environment override,$(origin BOOTROM_IMAGE))
CASE ?=
CASES ?=
STOP_ON_FAIL ?= 0
OUTPUT ?= full
CLR_RESET := \033[0m
CLR_INFO := \033[1;34m
CLR_ERR := \033[1;31m

.PHONY: help gen-soc-pkg sw test-sw verilate sim bootrom-sim regress wave clean clean-build

help:
	@printf "$(CLR_INFO)mpc-soc template entry$(CLR_RESET)\n\n"
	@printf "$(CLR_INFO)Main targets:$(CLR_RESET)\n"
	@printf "  make gen-soc-pkg\n"
	@printf "  make sw BOARD=mpc-soc APP=hello\n"
	@printf "  make verilate\n"
	@printf "  make sim APP=asm_hello [CORE_SEL=0] [FAST_PSRAM=1]\n"
	@printf "  make bootrom-sim CASE=asm_hello\n"
	@printf "  make regress [CASES='asm_hello'] [OUTPUT=list]\n"
	@printf "  make wave\n"
	@printf "  make clean\n"
	@printf "  make clean-build\n"

gen-soc-pkg:
	@python3 scripts/gen_soc_pkg.py

sw:
	@$(MAKE) -C sw BOARD="$(BOARD)" APP="$(APP)"

test-sw:
	@$(MAKE) -C "sw/tests/$(APP)" APP=main

verilate: gen-soc-pkg
	@$(MAKE) -C dv/verilator verilate TOP="$(TOP)" TRACE="$(TRACE)"

sim: gen-soc-pkg $(SW_TARGET)
	@bootrom_image="$(BOOTROM_IMAGE_ABS)"; \
	if [ -z "$(BOOTROM_IMAGE_USER_SET)" ]; then \
		images=$$(find "$(BOOTROM_DIR)" -maxdepth 1 -type f -name '*.bin' 2>/dev/null | sort); \
		preferred=$$(printf '%s\n' "$$images" | grep -v '/app\.bin$$' | head -n 1); \
		if [ -n "$$preferred" ]; then bootrom_image="$$preferred"; else bootrom_image=$$(printf '%s\n' "$$images" | head -n 1); fi; \
	fi; \
		$(MAKE) -C dv/verilator sim TOP="$(TOP)" BOARD="$(BOARD)" APP="$(APP)" BOOTROM_IMAGE="$$bootrom_image" MAX_CYCLES="$(MAX_CYCLES)" TRACE="$(TRACE)" CORE_SEL="$(CORE_SEL)" FAST_PSRAM="$(FAST_PSRAM)" UART_INPUT="$(UART_INPUT)" UART_STOP_TEXT="$(UART_STOP_TEXT)" UART_FAIL_TEXT="$(UART_FAIL_TEXT)" UART1_EXPECT="$(UART1_EXPECT)" UART1_BIT_CYCLES="$(UART1_BIT_CYCLES)" UART1_ARM_TEXT="$(UART1_ARM_TEXT)" GPIO_IN="$(GPIO_IN)" GPIO_DRIVE="$(GPIO_DRIVE)" GPIO_EXPECT="$(GPIO_EXPECT)" GPIO_EXPECT_MASK="$(GPIO_EXPECT_MASK)"

bootrom-sim:
	@test -n "$(CASE)" || (printf "$(CLR_ERR)ERROR: set CASE=<name>, e.g. make bootrom-sim CASE=asm_hello$(CLR_RESET)\n"; exit 2)
	@python3 scripts/verilator_regress.py --cases "$(CASE)" --output "$(OUTPUT)" --core-sel "$(CORE_SEL)" $(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) $(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) $(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)

regress:
	@python3 scripts/verilator_regress.py --output "$(OUTPUT)" --core-sel "$(CORE_SEL)" $(if $(CASES),--cases "$(CASES)",) $(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) $(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) $(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)

wave:
	@$(MAKE) -C dv/verilator wave

clean:
	@$(MAKE) -C dv/verilator clean
	@$(MAKE) -C sw clean BOARD="$(BOARD)" APP="$(APP)"
	@if [ -d "sw/tests/$(APP)" ]; then $(MAKE) -C "sw/tests/$(APP)" APP=main clean; fi

clean-build:
	@test -n "$(SOC_ROOT)" -a "$(SOC_ROOT)" != "/" || (printf "$(CLR_ERR)ERROR: invalid SOC_ROOT=$(SOC_ROOT)$(CLR_RESET)\n"; exit 2)
	@printf "$(CLR_INFO)Removing $(SOC_ROOT)/build$(CLR_RESET)\n"
	@rm -rf "$(SOC_ROOT)/build"
