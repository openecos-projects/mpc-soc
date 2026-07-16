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

CONFIG_DRIVER_UART ?= y
CONFIG_DRIVER_GPIO ?= y
CONFIG_DRIVER_TIMER ?= y

BOARD_PACKAGE ?= $(ECOS_SDK_HOME)/board/mpc-soc
BOARD_PACKAGE_DIR := $(BOARD_PACKAGE)
DRIVER_DIR := $(BOARD_PACKAGE)/driver
DRIVER_SUBDIRS := $(notdir $(shell find $(DRIVER_DIR) -mindepth 1 -maxdepth 1 -type d 2>/dev/null))

define driver_template
ifdef CONFIG_DRIVER_$(1)
        SDK_SRC_PATH += $(shell find $(DRIVER_DIR)/$(2) -name "*.[cS]")
endif
endef

$(foreach subdir,$(DRIVER_SUBDIRS), \
    $(eval CONFIG_NAME := $(shell echo $(subdir) | tr '[:lower:]' '[:upper:]')) \
    $(if $(VERBOSE),$(info Auto-load drivers: $(CONFIG_NAME))) \
    $(eval $(call driver_template,$(CONFIG_NAME),$(subdir))) \
)
