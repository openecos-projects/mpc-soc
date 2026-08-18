SHELL := /bin/bash

SOC_ROOT := $(CURDIR)
SOC_MAKEFILE := $(firstword $(MAKEFILE_LIST))
BOARD ?= mpc-soc
APP ?= hello
TOP ?= SimTop
MAX_CYCLES ?= 500000
TRACE ?= 0
CORE_SEL ?= 0
FAST_PSRAM ?= 1
CASE ?= hello
CASES ?=
STOP_ON_FAIL ?= 0
OUTPUT ?= full
PYTHON ?= python3
VERILATOR ?= verilator
GTKWAVE ?= gtkwave
CXX ?= c++
CROSS_COMPILE ?= riscv64-unknown-elf-
VERILATOR_RECOMMENDED_VERSION := 5.050
DOCS_SITE_ROOT := $(SOC_ROOT)/dev/site
DOCS_SITE_SOURCE := $(SOC_ROOT)/build/docs-site

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
WAVE_FILE ?= $(SOC_ROOT)/build/wave/$(TOP).fst
CLR_RESET := \033[0m
CLR_INFO := \033[1;34m
CLR_ERR := \033[1;31m
