#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define TIMER_REG_CTRL 0x00u
#define TIMER_REG_PSCR 0x04u
#define TIMER_REG_CNT  0x08u
#define TIMER_REG_CMP  0x0cu
#define TIMER_REG_STAT 0x10u

#define TIMER_MULTI_CTRL_MASK 0x000000ffu
#define TIMER_MULTI_PSCR_MASK 0x000fffffu
#define TIMER_MULTI_STAT_TIMEOUT_MASK 0x00000001u
#define TIMER_MULTI_POLL_LIMIT 2048u

#define TIMER_REG(base, offset) (*((volatile uint32_t *)((base) + (offset))))

static void stop_timer(uint32_t base) {
    TIMER_REG(base, TIMER_REG_CTRL) = 0u;
    (void)TIMER_REG(base, TIMER_REG_STAT);
}

static void stop_all_timers(void) {
    stop_timer(MPC_SOC_TIMER0_BASE);
    stop_timer(MPC_SOC_TIMER1_BASE);
    stop_timer(MPC_SOC_TIMER2_BASE);
    stop_timer(MPC_SOC_TIMER3_BASE);
}

static void fail(uint32_t index, char *message) {
    stop_all_timers();
    hal_sys_putstr("timer multi fail: t");
    hal_sys_putchar((char)('0' + index));
    hal_sys_putstr(" ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static uint32_t wait_count_change(uint32_t index, uint32_t base, uint32_t previous, char *message) {
    uint32_t timeout = TIMER_MULTI_POLL_LIMIT;

    while (timeout-- != 0u) {
        uint32_t current = TIMER_REG(base, TIMER_REG_CNT);

        if (current != previous) {
            return current;
        }
    }

    fail(index, message);
    return previous;
}

static void check_timer_reset(uint32_t index, uint32_t base) {
    stop_timer(base);
    if ((TIMER_REG(base, TIMER_REG_CTRL) & TIMER_MULTI_CTRL_MASK) != 0u) {
        fail(index, "ctrl reset");
    }
    if ((TIMER_REG(base, TIMER_REG_PSCR) & TIMER_MULTI_PSCR_MASK) != 0u) {
        fail(index, "pscr reset");
    }
    if (TIMER_REG(base, TIMER_REG_CNT) != 0u) {
        fail(index, "cnt reset");
    }
    if (TIMER_REG(base, TIMER_REG_CMP) != 0u) {
        fail(index, "cmp reset");
    }
    if ((TIMER_REG(base, TIMER_REG_STAT) & TIMER_MULTI_STAT_TIMEOUT_MASK) != 0u) {
        fail(index, "stat reset");
    }
}

static void check_reset_state(void) {
    check_timer_reset(0u, MPC_SOC_TIMER0_BASE);
    check_timer_reset(1u, MPC_SOC_TIMER1_BASE);
    check_timer_reset(2u, MPC_SOC_TIMER2_BASE);
    check_timer_reset(3u, MPC_SOC_TIMER3_BASE);
}

static void check_timer_readback(uint32_t index, uint32_t base, uint32_t pscr, uint32_t cmp) {
    TIMER_REG(base, TIMER_REG_CTRL) = TIMER_CTRL_DOWN_COUNT_MASK;
    TIMER_REG(base, TIMER_REG_PSCR) = pscr;
    TIMER_REG(base, TIMER_REG_CMP) = cmp;

    if ((TIMER_REG(base, TIMER_REG_CTRL) & TIMER_MULTI_CTRL_MASK) != TIMER_CTRL_DOWN_COUNT_MASK) {
        fail(index, "ctrl readback");
    }
    if (TIMER_REG(base, TIMER_REG_PSCR) != pscr) {
        fail(index, "pscr readback");
    }
    if (TIMER_REG(base, TIMER_REG_CMP) != cmp) {
        fail(index, "cmp readback");
    }
}

static void check_independent_readback(void) {
    check_timer_readback(0u, MPC_SOC_TIMER0_BASE, 1u, 0x100u);
    check_timer_readback(1u, MPC_SOC_TIMER1_BASE, 2u, 0x111u);
    check_timer_readback(2u, MPC_SOC_TIMER2_BASE, 3u, 0x122u);
    check_timer_readback(3u, MPC_SOC_TIMER3_BASE, 4u, 0x133u);
    stop_all_timers();
}

static void check_cross_count_zero(uint32_t active) {
    if (active != 0u && TIMER_REG(MPC_SOC_TIMER0_BASE, TIMER_REG_CNT) != 0u) {
        fail(0u, "cross count");
    }
    if (active != 1u && TIMER_REG(MPC_SOC_TIMER1_BASE, TIMER_REG_CNT) != 0u) {
        fail(1u, "cross count");
    }
    if (active != 2u && TIMER_REG(MPC_SOC_TIMER2_BASE, TIMER_REG_CNT) != 0u) {
        fail(2u, "cross count");
    }
    if (active != 3u && TIMER_REG(MPC_SOC_TIMER3_BASE, TIMER_REG_CNT) != 0u) {
        fail(3u, "cross count");
    }
}

static void check_up_count_only(uint32_t index, uint32_t base) {
    uint32_t first;
    uint32_t second;

    stop_all_timers();
    TIMER_REG(base, TIMER_REG_PSCR) = 0u;
    TIMER_REG(base, TIMER_REG_CMP) = 0u;
    TIMER_REG(base, TIMER_REG_CTRL) = TIMER_CTRL_ENABLE_MASK;

    first = TIMER_REG(base, TIMER_REG_CNT);
    second = wait_count_change(index, base, first, "up count");
    if (second <= first) {
        fail(index, "up order");
    }
    check_cross_count_zero(index);
}

static void check_count_one_at_a_time(void) {
    check_up_count_only(0u, MPC_SOC_TIMER0_BASE);
    check_up_count_only(1u, MPC_SOC_TIMER1_BASE);
    check_up_count_only(2u, MPC_SOC_TIMER2_BASE);
    check_up_count_only(3u, MPC_SOC_TIMER3_BASE);
    stop_all_timers();
}

static void check_down_count(uint32_t index, uint32_t base, uint32_t cmp) {
    uint32_t first;
    uint32_t second;

    TIMER_REG(base, TIMER_REG_PSCR) = 0u;
    TIMER_REG(base, TIMER_REG_CMP) = cmp;
    TIMER_REG(base, TIMER_REG_CTRL) = TIMER_CTRL_ENABLE_MASK | TIMER_CTRL_DOWN_COUNT_MASK;

    first = TIMER_REG(base, TIMER_REG_CNT);
    first = wait_count_change(index, base, first, "down start");
    second = wait_count_change(index, base, first, "down count");
    TIMER_REG(base, TIMER_REG_CTRL) = 0u;

    if (first == 0u || second >= first) {
        fail(index, "down order");
    }
}

static void check_independent_down_count(void) {
    stop_all_timers();
    check_down_count(0u, MPC_SOC_TIMER0_BASE, 0x1000u);
    check_down_count(1u, MPC_SOC_TIMER1_BASE, 0x1001u);
    check_down_count(2u, MPC_SOC_TIMER2_BASE, 0x1002u);
    check_down_count(3u, MPC_SOC_TIMER3_BASE, 0x1003u);
    stop_all_timers();
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("timer multi test start\n\r");

    hal_sys_putstr("timer multi step: check reset state for timer0-3\n\r");
    check_reset_state();
    hal_sys_putstr("timer multi step: check independent register readback\n\r");
    check_independent_readback();
    hal_sys_putstr("timer multi step: check one timer counts without cross-starting others\n\r");
    check_count_one_at_a_time();
    hal_sys_putstr("timer multi step: check down count on each timer\n\r");
    check_independent_down_count();

    hal_sys_putstr("timer multi ok\n\r");
    while (1) {
    }
}
