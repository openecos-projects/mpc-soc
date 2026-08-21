SHELL := /bin/bash

SOC_ROOT := $(CURDIR)
SOC_MAKEFILE := $(firstword $(MAKEFILE_LIST))
TOP ?= SimTop
MAX_CYCLES ?= 500000
ALLOW_TIMEOUT ?= 0
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
VERILATOR_REQUIRED_VERSION := 5.050
DOCS_SITE_ROOT := $(SOC_ROOT)/dev/site
DOCS_SITE_SOURCE := $(SOC_ROOT)/build/docs-site

WAVE_FILE ?= $(SOC_ROOT)/build/wave/$(TOP).fst
CLR_RESET := \033[0m
CLR_INFO := \033[1;34m
CLR_ERR := \033[1;31m
