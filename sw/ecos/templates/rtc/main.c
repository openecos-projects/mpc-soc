#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define RTC_POLL_LIMIT 2048u

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_store_gap();
    *reg = value;
}

static void fail(char *message) {
    hal_sys_putstr("rtc fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void wait_lwoff(void) {
    uint32_t timeout = RTC_POLL_LIMIT;

    while (timeout-- != 0u) {
        if ((REG_RTC_SSTA & RTC_SSTA_LWOFF_MASK) != 0u) {
            return;
        }
    }

    fail("lwoff");
}

static void wait_flag(uint32_t mask, char *message) {
    uint32_t timeout = RTC_POLL_LIMIT;

    while (timeout-- != 0u) {
        if ((REG_RTC_ISTA & mask) != 0u) {
            return;
        }
    }

    fail(message);
}

static void check_reset_state(void) {
    if ((REG_RTC_CTRL & 0x1fu) != 0u) {
        fail("ctrl reset");
    }
    if (REG_RTC_PSCR != 0u) {
        fail("pscr reset");
    }
    if (REG_RTC_ALRM != 0u) {
        fail("alrm reset");
    }
    if ((REG_RTC_ISTA & (RTC_ISTA_SCIF_MASK | RTC_ISTA_ALRMIF_MASK | RTC_ISTA_OVIF_MASK)) != 0u) {
        fail("ista reset");
    }
}

static void check_protected_registers(void) {
    write_reg(&REG_RTC_PSCR, 3u);
    if (REG_RTC_PSCR != 0u) {
        fail("pscr unlocked");
    }

    wait_lwoff();
    write_reg(&REG_RTC_CTRL, RTC_CTRL_CMF_MASK);
    write_reg(&REG_RTC_PSCR, 2u);
    write_reg(&REG_RTC_ALRM, 0u);

    if (REG_RTC_PSCR != 2u) {
        fail("pscr readback");
    }
    if (REG_RTC_ALRM != 0u) {
        fail("alrm readback");
    }
}

static void check_flags(void) {
    (void)REG_RTC_ISTA;
    write_reg(&REG_RTC_CTRL, RTC_CTRL_ENABLE_MASK | RTC_CTRL_SCIE_MASK | RTC_CTRL_ALRMIE_MASK);

    wait_flag(RTC_ISTA_ALRMIF_MASK, "alarm flag");
    wait_flag(RTC_ISTA_SCIF_MASK, "tick flag");

    write_reg(&REG_RTC_CTRL, 0u);
    (void)REG_RTC_ISTA;
    if ((REG_RTC_ISTA & (RTC_ISTA_SCIF_MASK | RTC_ISTA_ALRMIF_MASK | RTC_ISTA_OVIF_MASK)) != 0u) {
        fail("flag clear");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("rtc test start\n\r");

    hal_sys_putstr("rtc step: check reset state\n\r");
    check_reset_state();
    hal_sys_putstr("rtc step: check protected register writes\n\r");
    check_protected_registers();
    hal_sys_putstr("rtc step: check tick and alarm flags\n\r");
    check_flags();

    hal_sys_putstr("rtc ok\n\r");
    while (1) {
    }
}
