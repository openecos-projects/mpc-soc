#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define PWM_POLL_LIMIT 2048u

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_store_gap();
    *reg = value;
}

static void fail(char *message) {
    hal_sys_putstr("pwm fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void check_reset_state(void) {
    if ((REG_PWM_CTRL & 0x7u) != 0u) {
        fail("ctrl reset");
    }
    if (REG_PWM_PSCR != 0u) {
        fail("pscr reset");
    }
    if (REG_PWM_CMP != 0u) {
        fail("cmp reset");
    }
    if (REG_PWM_CNT != 0u) {
        fail("cnt reset");
    }
    if ((REG_PWM_STAT & PWM_STAT_OVIF_MASK) != 0u) {
        fail("stat reset");
    }
}

static void check_readback(void) {
    write_reg(&REG_PWM_CTRL, PWM_CTRL_CLEAR_MASK);
    if ((REG_PWM_CTRL & 0x7u) != PWM_CTRL_CLEAR_MASK) {
        fail("ctrl readback");
    }
    write_reg(&REG_PWM_CTRL, 0u);

    write_reg(&REG_PWM_PSCR, 3u);
    write_reg(&REG_PWM_CMP, 16u);
    write_reg(&REG_PWM_CR0, 1u);
    write_reg(&REG_PWM_CR1, 4u);
    write_reg(&REG_PWM_CR2, 8u);
    write_reg(&REG_PWM_CR3, 12u);

    if (REG_PWM_PSCR != 3u) {
        fail("pscr readback");
    }
    if (REG_PWM_CMP != 16u) {
        fail("cmp readback");
    }
    if (REG_PWM_CR0 != 1u || REG_PWM_CR1 != 4u || REG_PWM_CR2 != 8u || REG_PWM_CR3 != 12u) {
        fail("cr readback");
    }
}

static void wait_overflow(void) {
    uint32_t timeout = PWM_POLL_LIMIT;

    while (timeout-- != 0u) {
        if ((REG_PWM_STAT & PWM_STAT_OVIF_MASK) != 0u) {
            return;
        }
    }

    fail("overflow");
}

static void wait_count_nonzero(void) {
    uint32_t timeout = PWM_POLL_LIMIT;

    while (timeout-- != 0u) {
        if (REG_PWM_CNT != 0u) {
            return;
        }
    }

    fail("cnt stuck");
}

static void check_counter_read(void) {
    write_reg(&REG_PWM_CTRL, PWM_CTRL_CLEAR_MASK);
    if (REG_PWM_CNT != 0u) {
        fail("cnt clear");
    }

    write_reg(&REG_PWM_CTRL, 0u);
    write_reg(&REG_PWM_PSCR, 0u);
    write_reg(&REG_PWM_CMP, 16u);
    write_reg(&REG_PWM_CTRL, PWM_CTRL_ENABLE_MASK);

    wait_count_nonzero();
    write_reg(&REG_PWM_CTRL, 0u);
}

static void check_overflow_flag(void) {
    write_reg(&REG_PWM_CTRL, PWM_CTRL_CLEAR_MASK);
    write_reg(&REG_PWM_CTRL, 0u);
    write_reg(&REG_PWM_PSCR, 0u);
    write_reg(&REG_PWM_CMP, 4u);
    write_reg(&REG_PWM_CTRL, PWM_CTRL_ENABLE_MASK | PWM_CTRL_OVIE_MASK);

    wait_overflow();

    write_reg(&REG_PWM_CTRL, 0u);
    (void)REG_PWM_STAT;
    if ((REG_PWM_STAT & PWM_STAT_OVIF_MASK) != 0u) {
        fail("flag clear");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("pwm test start\n\r");

    hal_sys_putstr("pwm step: check reset state\n\r");
    check_reset_state();
    hal_sys_putstr("pwm step: check register readback\n\r");
    check_readback();
    hal_sys_putstr("pwm step: check counter readback\n\r");
    check_counter_read();
    hal_sys_putstr("pwm step: check overflow flag\n\r");
    check_overflow_flag();

    hal_sys_putstr("pwm ok\n\r");
    while (1) {
    }
}
