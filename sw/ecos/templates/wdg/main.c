#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define WDG_DELAY_NOPS 128u

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static void delay_cycles(void) {
    for (uint32_t index = 0u; index < WDG_DELAY_NOPS; ++index) {
        __asm__ volatile ("nop" ::: "memory");
    }
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_store_gap();
    *reg = value;
    cpu_store_gap();
}

static void fail(char *message) {
    hal_sys_putstr("wdg fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static __attribute__((noinline)) void write_unlocked(volatile uint32_t *reg, uint32_t value) {
    write_reg(&REG_WDG_KEY, WDG_KEY_UNLOCK);
    cpu_store_gap();
    write_reg(reg, value);
    cpu_store_gap();
}

static void check_reset_state(void) {
    if ((REG_WDG_CTRL & 0x7u) != 0u) {
        fail("ctrl reset");
    }
    if (REG_WDG_PSCR != 0u) {
        fail("pscr reset");
    }
    if (REG_WDG_CMP != 0u) {
        fail("cmp reset");
    }
    if ((REG_WDG_STAT & WDG_STAT_OVIF_MASK) != 0u) {
        fail("stat reset");
    }
}

static void check_key_protect(void) {
    write_reg(&REG_WDG_CTRL, WDG_CTRL_ENABLE_MASK);
    write_reg(&REG_WDG_PSCR, 0x000abcdeu);
    write_reg(&REG_WDG_CMP, 0x12345678u);

    if ((REG_WDG_CTRL & 0x7u) != 0u) {
        fail("ctrl locked");
    }
    if (REG_WDG_PSCR != 0u) {
        fail("pscr locked");
    }
    if (REG_WDG_CMP != 0u) {
        fail("cmp locked");
    }
}

static void check_unlocked_writes(void) {
    write_unlocked(&REG_WDG_PSCR, 0x000abcdeu);
    if (REG_WDG_PSCR != 0x000abcdeu) {
        fail("pscr readback");
    }
    if (REG_WDG_KEY != 0u) {
        fail("key clear pscr");
    }

    write_unlocked(&REG_WDG_CMP, 0x12345678u);
    if (REG_WDG_CMP != 0x12345678u) {
        fail("cmp readback");
    }

    write_unlocked(&REG_WDG_FEED, WDG_FEED_MASK);
    if ((REG_WDG_FEED & WDG_FEED_MASK) != WDG_FEED_MASK) {
        fail("feed readback");
    }

    write_unlocked(&REG_WDG_CTRL, WDG_CTRL_ENABLE_MASK);
    if ((REG_WDG_CTRL & WDG_CTRL_ENABLE_MASK) == 0u) {
        fail("ctrl enable");
    }

    write_unlocked(&REG_WDG_CTRL, 0u);
    if ((REG_WDG_CTRL & 0x7u) != 0u) {
        fail("ctrl disable");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("wdg test start\n\r");

    hal_sys_putstr("wdg step: check reset state\n\r");
    check_reset_state();
    delay_cycles();
    hal_sys_putstr("wdg step: check locked writes are ignored\n\r");
    check_key_protect();
    delay_cycles();
    hal_sys_putstr("wdg step: check unlocked writes and feed\n\r");
    check_unlocked_writes();

    hal_sys_putstr("wdg ok\n\r");
    while (1) {
    }
}
