#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_store_gap();
    *reg = value;
}

static void fail(char *message) {
    hal_sys_putstr("rcu fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

void main(void) {
    uint32_t stat;

    hal_sys_uart_init();
    hal_sys_putstr("rcu test start\n\r");

    hal_sys_putstr("rcu step: check reset register values\n\r");
    if ((REG_RCU_CTRL & RCU_CTRL_MASK) != 0u) {
        fail("ctrl reset");
    }
    if (REG_RCU_RDIV != 0u) {
        fail("rdiv reset");
    }
    stat = REG_RCU_STAT;
    if ((stat & ~RCU_STAT_CLKLOCK_MASK) != 0u) {
        fail("stat reserved");
    }

    hal_sys_putstr("rcu step: check CTRL masked readback\n\r");
    write_reg(&REG_RCU_CTRL, 0x15u);
    if ((REG_RCU_CTRL & RCU_CTRL_MASK) != 0x5u) {
        fail("ctrl readback");
    }

    hal_sys_putstr("rcu step: check RDIV readback\n\r");
    write_reg(&REG_RCU_RDIV, 7u);
    if (REG_RCU_RDIV != 7u) {
        fail("rdiv readback");
    }

    hal_sys_putstr("rcu step: restore safe defaults\n\r");
    write_reg(&REG_RCU_CTRL, 0u);
    write_reg(&REG_RCU_RDIV, 0u);
    if ((REG_RCU_CTRL & RCU_CTRL_MASK) != 0u || REG_RCU_RDIV != 0u) {
        fail("restore");
    }

    hal_sys_putstr("rcu ok\n\r");
    while (1) {
    }
}
