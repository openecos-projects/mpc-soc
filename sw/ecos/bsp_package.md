# 支持包说明（ECOS BSP Package）

本文档说明一个 ECOS BSP package 需要包含哪些文件、各文件职责是什么，以及 SDK 如何加载这个包。BSP package 面向未流片芯片、FPGA 原型、仿真平台和外部板卡适配场景，目标是让芯片/板卡支持可以独立于 SDK 主仓库维护。

## 1. 目标

传统板卡适配方式需要把文件直接放进 SDK 的 `board/` 目录，并修改 `ecos-set_board`、`config.mk` 等脚本。BSP package 机制改为由一个独立目录提供板卡支持，SDK 通过 `ecos-board.yml` 识别并加载该目录。

典型使用方式：

```bash
ecos board add /path/to/mychip_bsp
ecos board list
ecos init_project hello -name hello_mychip -target mychip
cd hello_mychip
make alldefconfig
make
```

也可以不注册，直接通过环境变量临时加载：

```bash
ECOS_BOARD_PATH=/path/to/mychip_bsp ecos init_project hello -target mychip
```

## 2. 最小目录结构

一个最小 BSP package 推荐如下：

```text
mychip_bsp/
├── ecos-board.yml
├── Makefile
├── board.h
├── sections.lds
├── start.S
├── board.kconfig
├── driver.kconfig
├── build_conf.mk
└── driver/
    ├── gpio/
    │   └── gpio.c
    ├── sys_uart/
    │   └── sys_uart.c
    └── timer/
        └── timer.c
```

如果芯片启动流程需要二级加载器，可以额外提供：

```text
mychip_bsp/
└── loader/
    ├── start.s
    ├── loader.c
    ├── payload.S
    └── loader.lds
```

## 3. 文件职责

### `ecos-board.yml`

BSP package 的入口描述文件。SDK 使用它发现板卡、匹配 `-target` 参数、定位 Makefile、Kconfig 和构建配置。

示例：

```yaml
schema: 1
id: mychip-fpga
name: MyChip FPGA Prototype
aliases:
  - mychip
  - fpga
category: MyChipFPGA
arch: riscv

files:
  makefile: Makefile
  board_header: board.h
  linker_script: sections.lds
  startup: start.S
  build_conf: build_conf.mk

kconfig:
  board: board.kconfig
  drivers: driver.kconfig

paths:
  loader: loader
```

字段说明：

| 字段 | 必需 | 说明 |
| --- | --- | --- |
| `schema` | 是 | manifest 格式版本，当前为 `1` |
| `id` | 是 | BSP package 的唯一 ID，建议使用小写和 `-` |
| `name` | 是 | 展示名称 |
| `aliases` | 否 | `ecos set_board` 和 `ecos init_project -target` 可使用的短名称 |
| `category` | 是 | Kconfig/Make 使用的板卡分类名，建议与芯片或平台名一致 |
| `arch` | 否 | 架构标记，例如 `riscv` |
| `files.makefile` | 是 | 注入工程根目录的 Makefile |
| `files.board_header` | 是 | 注入工程根目录的 `board.h` |
| `files.linker_script` | 是 | 注入工程根目录的链接脚本 |
| `files.startup` | 否 | 启动汇编文件，例如 `start.S` |
| `files.build_conf` | 是 | 板卡构建配置 |
| `kconfig.board` | 是 | 板卡 Kconfig |
| `kconfig.drivers` | 是 | 驱动 Kconfig |
| `paths.loader` | 否 | 需要复制到工程的 loader 目录 |

当前解析器只支持上述简单 YAML 子集：顶层 `key: value`、一级 section、`aliases` 列表。不建议在字段值中使用复杂 YAML 语法。

### `board.h`

板卡/芯片的基础硬件定义，通常包括：

- MMIO 基地址
- 外设寄存器结构体或寄存器偏移
- 时钟频率默认值
- PSRAM/FLASH 地址常量
- GPIO 编号、复用功能编号
- 板卡相关宏定义

示例内容：

```c
#ifndef __MYCHIP_BOARD_H__
#define __MYCHIP_BOARD_H__

#include <stdint.h>

#define UART0_BASE      0x10000000UL
#define GPIO0_BASE      0x10100000UL
#define TIMER0_BASE     0x10200000UL

#define BOARD_CPU_FREQ_MHZ 50

#endif
```

`board.h` 会被复制到用户工程根目录，应用代码和驱动都可以通过 `#include "board.h"` 使用。

### `sections.lds`

链接脚本，定义固件的内存布局。它至少需要描述：

- 代码段放置区域
- `.rodata`、`.data`、`.bss`
- 栈顶地址
- XIP 或 MEM 模式下的 LMA/VMA 差异

建议把可配置项通过 Kconfig 宏控制，例如：

```ld
#ifdef CONFIG_LINK_TARGET_XIP
/* XIP memory layout */
#else
/* MEM memory layout */
#endif
```

### `start.S`

启动代码，负责进入 C 运行环境。最小职责：

- 设置栈指针
- 清零 `.bss`
- 必要时复制 `.data`
- 执行早期硬件初始化
- 跳转到 `main`

如果平台由仿真器直接初始化内存，也可以先提供简化版本，但必须保证 C 代码执行前栈可用。

### `Makefile`

注入到工程根目录的构建入口。当前 MVP 机制中，BSP package 自己提供 `Makefile`，这样未流片芯片可以快速自定义工具链参数、链接方式和产物格式。

Makefile 推荐遵循以下约定：

```make
CROSS=riscv64-unknown-elf-
BUILD_DIR := build
PROJECT_PATH := $(shell pwd)
CATEGORY := MyChipFPGA

-include configs/config/auto.conf
-include configs/board-package.mk

CFLAGS := -mabi=ilp32 \
          -march=rv32im \
          -ffreestanding \
          -nostdlib

SDK_SRC_PATH :=
include $(BOARD_BUILD_CONF)

FIRMWARE_SRC_PATH := ./start.S ./main.c $(SDK_SRC_PATH)
FIRMWARE_LDS_PATH := ./sections.lds

$(FIRMWARE_NAME):
	@mkdir -p $(BUILD_DIR)
	@$(CROSS)cpp -P $(CFLAGS) -o $(BUILD_DIR)/app.lds $(FIRMWARE_LDS_PATH)
	@$(CROSS)gcc $(CFLAGS) -I./ -T $(BUILD_DIR)/app.lds -o $(BUILD_DIR)/app.elf $(FIRMWARE_SRC_PATH)

-include scripts/config.mk
```

关键点：

- 先包含 `configs/config/auto.conf`，读取 Kconfig 结果。
- 包含 `configs/board-package.mk`，读取 BSP package 路径。
- 通过 `include $(BOARD_BUILD_CONF)` 引入包内 `build_conf.mk`。
- 最后包含 `scripts/config.mk`，提供 `make menuconfig` / `make alldefconfig` 等目标。

### `board.kconfig`

定义板卡或芯片级配置，建议包含：

- 只读平台标识
- CPU 频率
- RAM/FLASH 大小
- 链接目标，例如 XIP/MEM
- 固件名、版本等板级默认值

示例：

```kconfig
menu "System Read-Only Information"
    config MYCHIP_FPGA
        bool
        default y

    config CPU_FREQ_MHZ
        int "CPU frequency MHz"
        default 50
endmenu

menu "Memory Region Selection"
    choice
        prompt "Link target"
        default LINK_TARGET_MEM

        config LINK_TARGET_MEM
            bool "Run in memory"

        config LINK_TARGET_XIP
            bool "Execute in place"
    endchoice
endmenu

menu "Firmware Configuration"
    config FIRMWARE_NAME
        string "Firmware name"
        default "retrosoc_fw"
endmenu
```

### `driver.kconfig`

定义板卡内置外设驱动的开关。建议命名保持 `CONFIG_DRIVER_<NAME>` 风格，这样可以复用现有 `build_conf.mk` 自动扫描逻辑。

示例：

```kconfig
menu "Peripheral Drivers"
    config DRIVER_SYS_UART
        bool "System UART"
        default y

    config DRIVER_GPIO
        bool "GPIO"
        default y

    config DRIVER_TIMER
        bool "Timer"
        default y
endmenu
```

### `build_conf.mk`

根据 Kconfig 结果把 BSP 源码、HAL 头文件、组件和设备驱动加入构建。

推荐结构：

```make
ifdef CONFIG_BUILD_OPT_FLAGS
CFLAGS += $(subst ",,$(CONFIG_BUILD_OPT_FLAGS))
endif

ifdef CONFIG_BUILD_DEBUG
CFLAGS += -g -DDEBUG
endif

ifdef CONFIG_FIRMWARE_NAME
FIRMWARE_NAME := $(subst ",,$(CONFIG_FIRMWARE_NAME))
else
FIRMWARE_NAME := main
endif

define driver_template
ifdef CONFIG_DRIVER_$(1)
        SDK_SRC_PATH += $(shell find $(BOARD_PACKAGE)/driver/$(2) -name "*.c")
        CFLAGS += $(addprefix -I,$(shell find $(ECOS_SDK_HOME)/hal/$(2) -type d 2>/dev/null))
endif
endef

DRIVER_DIR := $(BOARD_PACKAGE)/driver
DRIVER_SUBDIRS := $(notdir $(shell find $(DRIVER_DIR) -mindepth 1 -maxdepth 1 -type d 2>/dev/null))

$(foreach subdir,$(DRIVER_SUBDIRS), \
    $(eval CONFIG_NAME := $(shell echo $(subdir) | tr '[:lower:]' '[:upper:]')) \
    $(eval $(call driver_template,$(CONFIG_NAME),$(subdir))) \
)

ifdef CONFIG_LINK_LIBC
SDK_SRC_PATH += $(shell find $(ECOS_SDK_HOME)/components/libc/src -name "*.c")
CFLAGS += -I$(ECOS_SDK_HOME)/components/libc/include
endif

ifdef CONFIG_LINK_LIBGCC
SDK_SRC_PATH += $(shell find $(ECOS_SDK_HOME)/components/libgcc/src -name "*.[cS]")
CFLAGS += -I$(ECOS_SDK_HOME)/components/libgcc/include
endif
```

注意：

- 外部 BSP 自己的驱动路径应使用 `$(BOARD_PACKAGE)`。
- SDK 公共组件、HAL、devices 路径仍使用 `$(ECOS_SDK_HOME)`。
- 如果 BSP 需要接入 `components/TimmoLog`、`sfud`、`fatfs` 等组件，可参考内置板卡的 `build_conf.mk`。

### `driver/`

存放 SoC 内置外设驱动实现。推荐每类外设一个子目录：

```text
driver/
├── gpio/
├── sys_uart/
├── hp_uart/
├── timer/
├── i2c/
├── pwm/
└── qspi/
```

驱动源文件负责把具体寄存器访问适配到 SDK 的 HAL API。比如 `driver/gpio/gpio.c` 实现 `hal/gpio` 所期望的底层函数。

外设驱动和外部设备驱动不要混淆：

- `driver/`：芯片内部外设，例如 UART/GPIO/I2C/SPI 控制器。
- `devices/`：板外设备，例如 ST7735、SGP30、PCF8563。

## 4. SDK 加载流程

### 板卡发现

SDK 会从以下位置扫描 `ecos-board.yml`：

1. `$ECOS_SDK_HOME/board/*/ecos-board.yml`
2. `$ECOS_BOARD_PATH` 指向的文件、目录或目录集合
3. 注册目录，默认是 `~/.ecos/boards/*/ecos-board.yml`

`ECOS_BOARD_PATH` 支持多个路径，用 `:` 分隔：

```bash
export ECOS_BOARD_PATH=/path/to/bsp_a:/path/to/bsp_b
```

### 注册包

```bash
ecos board add /path/to/mychip_bsp
```

当前实现会在 `~/.ecos/boards/` 下创建指向 BSP 目录的软链接，不会复制 BSP 内容。

### 查看包

```bash
ecos board list
ecos board info mychip
```

### 注入工程

```bash
ecos set_board mychip
```

执行后 SDK 会：

1. 根据 `id` 或 `aliases` 找到 BSP package。
2. 复制 `Makefile`、`board.h`、`sections.lds`、`start.S` 等文件到工程根目录。
3. 可选复制 `loader/`。
4. 写入 `.ecos-project`。
5. 生成 `configs/board-package.mk`。

生成的 `configs/board-package.mk` 类似：

```make
BOARD_PACKAGE := /path/to/mychip_bsp
BOARD_ID := mychip-fpga
BOARD_CATEGORY := MyChipFPGA
CATEGORY := MyChipFPGA
BOARD_BUILD_CONF := /path/to/mychip_bsp/build_conf.mk
BOARD_KCONFIG := /path/to/mychip_bsp/board.kconfig
DRIVER_KCONFIG := /path/to/mychip_bsp/driver.kconfig
```

`scripts/config.mk` 会优先读取这些路径，让 `make menuconfig` 和 `make alldefconfig` 加载外部 BSP 的 Kconfig。

## 5. 新 BSP 适配步骤

推荐按以下顺序进行：

1. 准备 `board.h`，先定义 UART、GPIO、Timer、内存区域等最小寄存器和地址。
2. 准备 `sections.lds`，确保固件可以链接到仿真/FPGA 可加载地址。
3. 准备 `start.S`，确保栈、`.bss`、`.data` 初始化正确。
4. 准备 `Makefile`，先让 `main.c` 能编译链接。
5. 准备 `board.kconfig`，至少提供平台标识、固件名、链接模式。
6. 准备 `driver.kconfig`，先打开 `SYS_UART`、`GPIO`、`TIMER` 等基础驱动。
7. 准备 `build_conf.mk`，把 BSP 驱动和 SDK 公共组件加入构建。
8. 实现最小串口驱动，使 `hello` 模板可以输出日志。
9. 注册 BSP 并创建测试工程。
10. 逐步补充 I2C、PWM、QSPI、RTC 等外设驱动。

最小可用标准：

- `ecos board info <alias>` 能找到包。
- `ecos init_project hello -target <alias>` 能创建工程。
- `make alldefconfig` 能生成 `configs/config/auto.conf`。
- `make` 能生成 ELF/BIN/HEX 中至少一种产物。
- 串口 hello 或仿真日志能证明 `main()` 正常运行。

## 6. 未流片芯片建议分层

未流片阶段建议把 BSP 分成三层：

```text
mychip_bsp/
├── board.h / sections.lds / start.S
├── board.kconfig / driver.kconfig / build_conf.mk
└── driver/
```

第一层：启动与内存布局

- 由前端/验证环境决定加载地址、栈地址、ROM/RAM 映射。
- 优先保证固件能启动到 `main()`。

第二层：配置与构建

- 用 Kconfig 固化当前 FPGA/仿真参数。
- 用 `build_conf.mk` 控制哪些驱动参与构建。

第三层：外设驱动

- 先实现 `sys_uart`，保证可观测性。
- 再实现 `timer`，保证延时和 tick。
- 再实现 `gpio`，方便板级 smoke test。
- 最后适配复杂外设。

这样前端工程师只需要维护一个小包，SDK 的模板、Kconfig、组件库、HAL 头文件和构建工具都可以复用。

## 7. 与内置板卡的关系

内置板卡也可以视为 BSP package。当前已经为以下板卡提供 `ecos-board.yml`：

- `StarrySkyC2`，alias: `c2`
- `StarrySkyL3_1`，alias: `l3_1`
- `StarrySkyL4`，alias: `l4`

旧板卡或旧工程仍可走原有 fallback 逻辑。也就是说，新增 BSP package 机制不会要求所有历史板卡一次性迁移。

## 8. 常见问题

### `ecos board list` 看不到外部 BSP

检查：

- BSP 目录下是否有 `ecos-board.yml`
- 是否执行过 `ecos board add /path/to/bsp`
- 或者是否设置了 `ECOS_BOARD_PATH`

### `ecos set_board` 报缺文件

检查 `ecos-board.yml` 的 `files` 字段。`makefile`、`board_header`、`linker_script`、`build_conf` 是核心文件，路径必须相对 BSP 目录存在。

### `make alldefconfig` 读到错误板卡

检查工程内 `configs/board-package.mk` 是否存在，且其中：

```make
BOARD_KCONFIG := /path/to/bsp/board.kconfig
DRIVER_KCONFIG := /path/to/bsp/driver.kconfig
```

路径是否指向当前 BSP。

### 编译找不到驱动源码

检查 `build_conf.mk` 是否使用了 `$(BOARD_PACKAGE)` 定位外部 BSP 驱动目录。外部 BSP 不应该把自己的驱动路径写死到 SDK 主仓库。

### 模板没有对应板卡目录

普通 C 工程会优先使用 `templates/<template>/<target>`，不存在时可以回退到 `templates/<template>/common` 或 `templates/<template>/c2` 作为种子，然后由 `ecos set_board` 注入 BSP 文件。汇编工程通常强依赖板卡目录，建议单独提供模板。

## 9. 参考命令

```bash
# 查看内置和已注册 BSP
ecos board list

# 查看某个 BSP 详情
ecos board info c2

# 注册外部 BSP
ecos board add /path/to/mychip_bsp

# 创建工程
ecos init_project hello -name hello_mychip -target mychip

# 切换已有工程到外部 BSP
cd hello_mychip
ecos set_board mychip

# 生成默认配置
make alldefconfig

# 编译
make
```
