#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

static void cpu_bus_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_bus_gap();
    *reg = value;
}

static __attribute__((noinline)) uint32_t read_reg(volatile uint32_t *reg) {
    uint32_t value = *reg;
    cpu_bus_gap();
    return value;
}

static void fail(char *message) {
    hal_sys_putstr("plic fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void expect_reg(char *message, volatile uint32_t *reg, uint32_t mask, uint32_t expected) {
    uint32_t value = read_reg(reg) & mask;

    if (value != (expected & mask)) {
        fail(message);
    }
}

static void check_reset_state(void) {
    expect_reg("ctrl reset", &REG_PLIC_CTRL, PLIC_CTRL_MASK, 0u);
    expect_reg("tm reset", &REG_PLIC_TM, 0xffffffffu, 0u);
    expect_reg("prio1 reset", &REG_PLIC_PRIO1, 0xffffffffu, 0u);
    expect_reg("prio2 reset", &REG_PLIC_PRIO2, 0xffffffffu, 0u);
    expect_reg("prio3 reset", &REG_PLIC_PRIO3, 0xffffffffu, 0u);
    expect_reg("prio4 reset", &REG_PLIC_PRIO4, 0xffffffffu, 0u);
    expect_reg("ie reset", &REG_PLIC_IE, 0xffffffffu, 0u);
    expect_reg("thold reset", &REG_PLIC_THOLD, PLIC_THOLD_MASK, 0u);
}

static void check_basic_readback(void) {
    write_reg(&REG_PLIC_CTRL, 0x6u);
    expect_reg("ctrl readback", &REG_PLIC_CTRL, PLIC_CTRL_MASK, 0x6u);
    if ((read_reg(&REG_PLIC_CTRL) & PLIC_CTRL_EN_MASK) != 0u) {
        fail("ctrl enable");
    }

    write_reg(&REG_PLIC_TM, 0x5a5a5a5au);
    expect_reg("tm readback", &REG_PLIC_TM, 0xffffffffu, 0x5a5a5a5au);

    write_reg(&REG_PLIC_PRIO1, 0x01234567u);
    write_reg(&REG_PLIC_PRIO2, 0x89abcdefu);
    write_reg(&REG_PLIC_PRIO3, 0x76543210u);
    write_reg(&REG_PLIC_PRIO4, 0xfedcba98u);
    expect_reg("prio1 readback", &REG_PLIC_PRIO1, 0xffffffffu, 0x01234567u);
    expect_reg("prio2 readback", &REG_PLIC_PRIO2, 0xffffffffu, 0x89abcdefu);
    expect_reg("prio3 readback", &REG_PLIC_PRIO3, 0xffffffffu, 0x76543210u);
    expect_reg("prio4 readback", &REG_PLIC_PRIO4, 0xffffffffu, 0xfedcba98u);

    write_reg(&REG_PLIC_IE, 0xffffffffu);
    expect_reg("ie irq0 fixed zero", &REG_PLIC_IE, 0xffffffffu, 0xfffffffeu);

    write_reg(&REG_PLIC_THOLD, 0x3fu);
    expect_reg("thold mask", &REG_PLIC_THOLD, PLIC_THOLD_MASK, 0xfu);
}

static void check_read_only_status(void) {
    if ((read_reg(&REG_PLIC_IP) & PLIC_IE_IRQ0_MASK) != 0u) {
        fail("ip irq0");
    }
    if ((read_reg(&REG_PLIC_CLAIMCOMP) & PLIC_CLAIMCOMP_MASK) != 0u) {
        fail("claim idle");
    }
    write_reg(&REG_PLIC_CLAIMCOMP, 0u);
    if ((read_reg(&REG_PLIC_CLAIMCOMP) & PLIC_CLAIMCOMP_MASK) != 0u) {
        fail("complete idle");
    }
}

static void restore_defaults(void) {
    write_reg(&REG_PLIC_CTRL, 0u);
    write_reg(&REG_PLIC_TM, 0u);
    write_reg(&REG_PLIC_PRIO1, 0u);
    write_reg(&REG_PLIC_PRIO2, 0u);
    write_reg(&REG_PLIC_PRIO3, 0u);
    write_reg(&REG_PLIC_PRIO4, 0u);
    write_reg(&REG_PLIC_IE, 0u);
    write_reg(&REG_PLIC_THOLD, 0u);

    expect_reg("restore ctrl", &REG_PLIC_CTRL, PLIC_CTRL_MASK, 0u);
    expect_reg("restore tm", &REG_PLIC_TM, 0xffffffffu, 0u);
    expect_reg("restore ie", &REG_PLIC_IE, 0xffffffffu, 0u);
    expect_reg("restore thold", &REG_PLIC_THOLD, PLIC_THOLD_MASK, 0u);
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("plic test start\n\r");

    hal_sys_putstr("plic step: check reset-visible registers\n\r");
    check_reset_state();
    hal_sys_putstr("plic step: check writable register readback with plic disabled\n\r");
    check_basic_readback();
    hal_sys_putstr("plic step: check read-only pending and idle claim registers\n\r");
    check_read_only_status();
    hal_sys_putstr("plic step: restore disabled defaults\n\r");
    restore_defaults();

    hal_sys_putstr("plic ok\n\r");
    while (1) {
    }
}
