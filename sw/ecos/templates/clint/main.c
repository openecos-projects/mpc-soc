#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define CLINT_DELAY_NOPS 32u

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_store_gap();
    *reg = value;
}

static void delay_cycles(void) {
    for (uint32_t index = 0u; index < CLINT_DELAY_NOPS; ++index) {
        __asm__ volatile ("nop" ::: "memory");
    }
}

static void fail(char *message) {
    hal_sys_putstr("clint fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void read_mtime(uint32_t *hi, uint32_t *lo) {
    uint32_t first_hi;
    uint32_t second_hi;
    uint32_t low;

    do {
        first_hi = REG_CLINT_MTIME_HI;
        low = REG_CLINT_MTIME_LO;
        second_hi = REG_CLINT_MTIME_HI;
    } while (first_hi != second_hi);

    *hi = second_hi;
    *lo = low;
}

static uint32_t mtime_after(uint32_t hi, uint32_t lo, uint32_t ref_hi, uint32_t ref_lo) {
    return (hi > ref_hi) || ((hi == ref_hi) && (lo > ref_lo));
}

static void check_msip(void) {
    write_reg(&REG_CLINT_MSIP, 0u);
    if (REG_CLINT_MSIP != 0u) {
        fail("msip clear");
    }

    write_reg(&REG_CLINT_MSIP, 1u);
    if (REG_CLINT_MSIP != 1u) {
        fail("msip set");
    }

    write_reg(&REG_CLINT_MSIP, 0xffffffffu);
    if (REG_CLINT_MSIP != 1u) {
        fail("msip width");
    }

    write_reg(&REG_CLINT_MSIP, 0u);
    if (REG_CLINT_MSIP != 0u) {
        fail("msip final");
    }
}

static void check_mtimecmp(void) {
    write_reg(&REG_CLINT_MTIMECMP_LO, 0x89abcdefu);
    write_reg(&REG_CLINT_MTIMECMP_HI, 0x01234567u);

    if (REG_CLINT_MTIMECMP_LO != 0x89abcdefu) {
        fail("mtimecmp low");
    }
    if (REG_CLINT_MTIMECMP_HI != 0x01234567u) {
        fail("mtimecmp high");
    }

    write_reg(&REG_CLINT_MTIMECMP_HI, 0xffffffffu);
    write_reg(&REG_CLINT_MTIMECMP_LO, 0xffffffffu);
}

static void check_mtime(void) {
    uint32_t first_hi;
    uint32_t first_lo;
    uint32_t second_hi;
    uint32_t second_lo;

    read_mtime(&first_hi, &first_lo);
    delay_cycles();
    read_mtime(&second_hi, &second_lo);

    if (!mtime_after(second_hi, second_lo, first_hi, first_lo)) {
        fail("mtime stuck");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("clint test start\n\r");

    hal_sys_putstr("clint step: check msip register\n\r");
    check_msip();
    hal_sys_putstr("clint step: check mtimecmp registers\n\r");
    check_mtimecmp();
    hal_sys_putstr("clint step: check mtime monotonic counter\n\r");
    check_mtime();

    hal_sys_putstr("clint ok\n\r");
    while (1) {
    }
}
