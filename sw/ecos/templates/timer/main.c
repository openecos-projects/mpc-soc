#include "main.h"

#define TIMER_CTRL_RUN_UP (TIMER_CTRL_ENABLE_MASK)
#define TIMER_CTRL_RUN_DOWN (TIMER_CTRL_ENABLE_MASK | TIMER_CTRL_DOWN_COUNT_MASK)
#define TIMER_CTRL_RUN_DOWN_IRQ (TIMER_CTRL_RUN_DOWN | TIMER_CTRL_IRQ_ENABLE_MASK)
#define TIMER_FAILURE(message) "timer error: " message "\n\rtimer fail\n\r"

#define TIMER_CTRL_MASK 0x000000ffu
#define TIMER_PSCR_MASK 0x000fffffu
#define TIMER_STAT_TIMEOUT_MASK 0x00000001u
#define TIMER_DOWN_CMP 0x10000000u
#define TIMER_TIMEOUT_CMP 16u
#define TIMER_POLL_LIMIT 1024u
#define TIMER_SAMPLE_READS 64u
#define TIMER_MASK_SAMPLE_READS 128u
#define TIMER_STOP_SETTLE_READS 8u
#define TIMER_STABLE_READS 64u

static void fail(char *message) {
    REG_TIMER_0_CTRL = 0u;
    (void)REG_TIMER_0_STAT;
    hal_sys_putstr(message);
    while (1) {
    }
}

static void clear_timer(void) {
    REG_TIMER_0_CTRL = 0u;
    (void)REG_TIMER_0_STAT;
}

static uint32_t sample_cnt(uint32_t reads) {
    uint32_t value = 0u;

    while (reads-- != 0u) {
        value = REG_TIMER_0_CNT;
    }

    return value;
}

static uint32_t wait_cnt_change(uint32_t previous, char *message) {
    uint32_t timeout = TIMER_POLL_LIMIT;

    while (timeout-- != 0u) {
        uint32_t current = REG_TIMER_0_CNT;

        if (current != previous) {
            return current;
        }
    }

    fail(message);
    return previous;
}

static void wait_timeout_flag(char *message) {
    uint32_t timeout = TIMER_POLL_LIMIT;

    while (timeout-- != 0u) {
        if ((REG_TIMER_0_STAT & TIMER_STAT_TIMEOUT_MASK) != 0u) {
            return;
        }
    }

    fail(message);
}

static void check_cnt_stable(char *message) {
    uint32_t expected = sample_cnt(TIMER_STOP_SETTLE_READS);
    uint32_t reads = TIMER_STABLE_READS;

    while (reads-- != 0u) {
        if (REG_TIMER_0_CNT != expected) {
            fail(message);
        }
    }
}

static void check_reset_state(void) {
    if ((REG_TIMER_0_CTRL & TIMER_CTRL_MASK) != 0u) {
        fail(TIMER_FAILURE("ctrl reset"));
    }
    if ((REG_TIMER_0_PSCR & TIMER_PSCR_MASK) != 0u) {
        fail(TIMER_FAILURE("pscr reset"));
    }
    if (REG_TIMER_0_CNT != 0u) {
        fail(TIMER_FAILURE("cnt reset"));
    }
    if (REG_TIMER_0_CMP != 0u) {
        fail(TIMER_FAILURE("cmp reset"));
    }
    if ((REG_TIMER_0_STAT & TIMER_STAT_TIMEOUT_MASK) != 0u) {
        fail(TIMER_FAILURE("stat reset"));
    }
}

static void check_reg_access(void) {
    clear_timer();

    REG_TIMER_0_CTRL = TIMER_CTRL_IRQ_ENABLE_MASK | TIMER_CTRL_DOWN_COUNT_MASK;
    if ((REG_TIMER_0_CTRL & TIMER_CTRL_MASK) !=
        (TIMER_CTRL_IRQ_ENABLE_MASK | TIMER_CTRL_DOWN_COUNT_MASK)) {
        fail(TIMER_FAILURE("ctrl readback"));
    }
    REG_TIMER_0_CTRL = 0u;

    REG_TIMER_0_PSCR = 3u;
    if (REG_TIMER_0_PSCR != 3u) {
        fail(TIMER_FAILURE("pscr readback"));
    }

    REG_TIMER_0_CMP = 0xa5a55a5au;
    if (REG_TIMER_0_CMP != 0xa5a55a5au) {
        fail(TIMER_FAILURE("cmp readback"));
    }

    (void)sample_cnt(TIMER_STABLE_READS);
    clear_timer();
}

static void check_down_count(void) {
    uint32_t first;
    uint32_t second;

    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = TIMER_DOWN_CMP;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_DOWN;

    first = REG_TIMER_0_CNT;
    first = wait_cnt_change(first, TIMER_FAILURE("down start"));
    second = wait_cnt_change(first, TIMER_FAILURE("down stalled"));
    REG_TIMER_0_CTRL = 0u;

    if (first == 0u || first > TIMER_DOWN_CMP) {
        fail(TIMER_FAILURE("down range"));
    }
    if (second >= first) {
        fail(TIMER_FAILURE("down order"));
    }
    clear_timer();
}

static void check_up_count(void) {
    uint32_t first;
    uint32_t second;

    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = 0u;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_UP;

    first = REG_TIMER_0_CNT;
    first = wait_cnt_change(first, TIMER_FAILURE("up start"));
    second = wait_cnt_change(first, TIMER_FAILURE("up stalled"));
    REG_TIMER_0_CTRL = 0u;

    if (second <= first) {
        fail(TIMER_FAILURE("up order"));
    }
    clear_timer();
}

static void check_stop_restart(void) {
    uint32_t value;

    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = 0u;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_UP;

    value = REG_TIMER_0_CNT;
    (void)wait_cnt_change(value, TIMER_FAILURE("stop start"));

    REG_TIMER_0_CTRL = 0u;
    check_cnt_stable(TIMER_FAILURE("stop unstable"));

    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_UP;
    value = REG_TIMER_0_CNT;
    (void)wait_cnt_change(value, TIMER_FAILURE("restart stalled"));
    clear_timer();
}

static void check_prescaler(void) {
    uint32_t first;
    uint32_t last;
    uint32_t fast_delta;
    uint32_t slow_delta;

    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = 0u;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_UP;

    first = REG_TIMER_0_CNT;
    (void)wait_cnt_change(first, TIMER_FAILURE("prescale fast start"));
    first = REG_TIMER_0_CNT;
    last = sample_cnt(TIMER_SAMPLE_READS);
    REG_TIMER_0_CTRL = 0u;

    if (last <= first) {
        fail(TIMER_FAILURE("prescale fast zero"));
    }
    fast_delta = last - first;

    clear_timer();
    REG_TIMER_0_PSCR = 15u;
    REG_TIMER_0_CMP = 0u;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_UP;

    first = REG_TIMER_0_CNT;
    (void)wait_cnt_change(first, TIMER_FAILURE("prescale slow start"));
    first = REG_TIMER_0_CNT;
    last = sample_cnt(TIMER_SAMPLE_READS);
    REG_TIMER_0_CTRL = 0u;

    if (last <= first) {
        fail(TIMER_FAILURE("prescale slow zero"));
    }
    slow_delta = last - first;

    /* The programmed ratio is 16:1; allow margin for startup and MMIO phase. */
    if (fast_delta < (slow_delta * 4u)) {
        fail(TIMER_FAILURE("prescale ratio"));
    }
    clear_timer();
}

static void check_irq_mask(void) {
    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = 15u;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_DOWN;

    (void)sample_cnt(TIMER_MASK_SAMPLE_READS);
    REG_TIMER_0_CTRL = 0u;

    if ((REG_TIMER_0_STAT & TIMER_STAT_TIMEOUT_MASK) != 0u) {
        fail(TIMER_FAILURE("irq mask"));
    }
    clear_timer();
}

static void check_timeout_restart(void) {
    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = TIMER_TIMEOUT_CMP;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_DOWN_IRQ;

    wait_timeout_flag(TIMER_FAILURE("timeout flag"));
    wait_timeout_flag(TIMER_FAILURE("timeout reload"));

    REG_TIMER_0_CTRL = 0u;
    /* Drain a flag that may reassert between the successful poll and stop. */
    (void)REG_TIMER_0_STAT;
    if ((REG_TIMER_0_STAT & TIMER_STAT_TIMEOUT_MASK) != 0u) {
        fail(TIMER_FAILURE("timeout clear"));
    }

    clear_timer();
    REG_TIMER_0_PSCR = 0u;
    REG_TIMER_0_CMP = TIMER_TIMEOUT_CMP;
    REG_TIMER_0_CTRL = TIMER_CTRL_RUN_DOWN_IRQ;

    wait_timeout_flag(TIMER_FAILURE("timeout restart"));

    REG_TIMER_0_CTRL = 0u;
    (void)REG_TIMER_0_STAT;
    if ((REG_TIMER_0_STAT & TIMER_STAT_TIMEOUT_MASK) != 0u) {
        fail(TIMER_FAILURE("restart clear"));
    }
    clear_timer();
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("timer test start\n\r");
    hal_sys_putstr("timer steps: reset, timeout, register, down/up, stop/restart, prescaler, irq mask\n\r");

    check_reset_state();
    check_timeout_restart();
    check_reg_access();
    check_down_count();
    check_up_count();
    check_stop_restart();
    check_prescaler();
    check_irq_mask();

    hal_sys_putstr("timer ok\n\r");
    while (1) {
    }
}
