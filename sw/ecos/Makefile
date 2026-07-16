# mpc-soc firmware build script

CROSS ?= riscv64-unknown-elf-
BUILD_DIR := build
PROJECT_PATH := $(shell pwd)
ECOS_SDK_HOME ?= $(HOME)/.local/ecos-sdk
CATEGORY := mpc-soc
CLR_RESET := \033[0m
CLR_STEP := \033[1;32m

-include configs/config/auto.conf
-include configs/board-package.mk

BOARD_PACKAGE ?= $(abspath ../..)/ecos

CFLAGS := -mabi=ilp32 \
          -march=rv32im_zifencei \
          -mcmodel=medany \
          -Wl,-Bstatic,--strip-debug \
          -ffreestanding \
          -nostdlib \
          -I./ \
          -I./configs

ifdef CONFIG_LINK_TARGET_XIP
LDFLAGS += -DCONFIG_LINK_TARGET_XIP
CFLAGS += -DCONFIG_LINK_TARGET_XIP
endif

ifdef CONFIG_LINK_TARGET_MEM
LDFLAGS += -DCONFIG_LINK_TARGET_MEM
CFLAGS += -DCONFIG_LINK_TARGET_MEM
endif

ifdef CONFIG_BUILD_OPT_FLAGS
CFLAGS += $(subst ",,$(CONFIG_BUILD_OPT_FLAGS))
endif

ifdef CONFIG_BUILD_DEBUG
CFLAGS += -g -DDEBUG
endif

ifdef CONFIG_BUILD_VERBOSE
VERBOSE := 1
endif

ifdef CONFIG_FIRMWARE_NAME
FIRMWARE_NAME := $(subst ",,$(CONFIG_FIRMWARE_NAME))
else
FIRMWARE_NAME := main
endif

# The mpc-soc board uses sys_uart. Keep old generated configs working.
ifdef CONFIG_DRIVER_UART
CONFIG_DRIVER_SYS_UART := y
CONFIG_DRIVER_UART :=
endif

SDK_SRC_PATH :=

define driver_template
ifdef CONFIG_DRIVER_$(1)
        SDK_SRC_PATH += $(shell find $(BOARD_PACKAGE)/driver/$(2) -name "*.[cS]" 2>/dev/null)
        CFLAGS += $(addprefix -I,$(shell find $(ECOS_SDK_HOME)/hal/$(2) -type d 2>/dev/null))
endif
endef

DRIVER_DIR := $(BOARD_PACKAGE)/driver
DRIVER_SUBDIRS := $(notdir $(shell find $(DRIVER_DIR) -mindepth 1 -maxdepth 1 -type d 2>/dev/null))

$(foreach subdir,$(DRIVER_SUBDIRS), \
    $(eval CONFIG_NAME := $(shell echo $(subdir) | tr '[:lower:]' '[:upper:]')) \
    $(if $(VERBOSE),$(info Auto-load drivers: $(CONFIG_NAME))) \
    $(eval $(call driver_template,$(CONFIG_NAME),$(subdir))) \
)

ifdef CONFIG_COMPONENT_TIMMOLOG
SDK_SRC_PATH += $(shell find $(ECOS_SDK_HOME)/components/TimmoLog/src -name "*.[cS]" 2>/dev/null)
CFLAGS += -I$(ECOS_SDK_HOME)/components/TimmoLog/include
endif

ifdef CONFIG_LINK_LIBC
SDK_SRC_PATH += $(shell find $(ECOS_SDK_HOME)/components/libc/src -name "*.c" 2>/dev/null)
CFLAGS += -I$(ECOS_SDK_HOME)/components/libc/include
endif

ifdef CONFIG_LINK_LIBGCC
SDK_SRC_PATH += $(shell find $(ECOS_SDK_HOME)/components/libgcc/src -name "*.[cS]" 2>/dev/null)
CFLAGS += -I$(ECOS_SDK_HOME)/components/libgcc/include
endif

CFLAGS += $(addprefix -I,$(shell find $(ECOS_SDK_HOME)/devices/*/include -type d 2>/dev/null))

FIRMWARE_SRC_PATH := ./start.S ./main.c $(SDK_SRC_PATH)
LOADER_SRC_PATH := loader/start.s loader/loader.c loader/payload.S $(SDK_SRC_PATH)

FIRMWARE_LDS_PATH := ./sections.lds
LOADER_LDS_PATH := ./loader/loader.lds

-include $(ECOS_SDK_HOME)/tools/scripts/mem_report.mk

$(FIRMWARE_NAME):
	@printf "$(CLR_STEP)Building APP $(FIRMWARE_NAME)...$(CLR_RESET)\n"
	@mkdir -p $(BUILD_DIR)
	@printf "$(CLR_STEP)Preprocess APP linker script...$(CLR_RESET)\n"
	@$(CROSS)cpp -P $(CFLAGS) -o $(BUILD_DIR)/app.lds $(FIRMWARE_LDS_PATH)
	@printf "$(CLR_STEP)Compiling APP...$(CLR_RESET)\n"
	@$(CROSS)gcc $(CFLAGS) -T $(BUILD_DIR)/app.lds -o $(BUILD_DIR)/app.elf $(FIRMWARE_SRC_PATH)
	@$(CROSS)objcopy -O binary $(BUILD_DIR)/app.elf $(BUILD_DIR)/app.bin

ifdef CONFIG_LINK_TARGET_XIP
	@printf "$(CLR_STEP)Skipping Bootloader (Target is XIP)...$(CLR_RESET)\n"
	@$(CROSS)objcopy -O verilog $(BUILD_DIR)/app.elf $(BUILD_DIR)/$(FIRMWARE_NAME).hex
	@sed -i 's/@30000000/@00000000/g' $(BUILD_DIR)/$(FIRMWARE_NAME).hex
	@$(CROSS)objcopy -O binary $(BUILD_DIR)/app.elf $(BUILD_DIR)/$(FIRMWARE_NAME).bin
	@$(CROSS)objdump -d $(BUILD_DIR)/app.elf > $(BUILD_DIR)/$(FIRMWARE_NAME).txt
	$(call show_mem_usage, $(BUILD_DIR)/app.elf)
else
	@printf "$(CLR_STEP)Building Bootloader...$(CLR_RESET)\n"
	@$(CROSS)cpp -P -o $(BUILD_DIR)/loader.lds $(LOADER_LDS_PATH)
	@$(CROSS)gcc $(CFLAGS) -T $(BUILD_DIR)/loader.lds -o $(BUILD_DIR)/loader.elf $(LOADER_SRC_PATH)
	@printf "$(CLR_STEP)Final linking...$(CLR_RESET)\n"
	@$(CROSS)objcopy -O verilog $(BUILD_DIR)/loader.elf $(BUILD_DIR)/$(FIRMWARE_NAME).hex
	@sed -i 's/@30000000/@00000000/g' $(BUILD_DIR)/$(FIRMWARE_NAME).hex
	@$(CROSS)objcopy -O binary $(BUILD_DIR)/loader.elf $(BUILD_DIR)/$(FIRMWARE_NAME).bin
	@$(CROSS)objdump -d $(BUILD_DIR)/loader.elf > $(BUILD_DIR)/$(FIRMWARE_NAME).txt
	$(call show_mem_usage, $(BUILD_DIR)/loader.elf)
endif
	@printf "$(CLR_STEP)Done.$(CLR_RESET)\n"

clean:
	rm -rf $(BUILD_DIR)

clean_config:
	rm -rf configs/generated configs/config configs/.config configs/.config.old

clean_all: clean clean_config

-include scripts/config.mk
.PHONY: $(FIRMWARE_NAME) clean clean_config clean_all
