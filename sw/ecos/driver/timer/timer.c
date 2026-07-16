#include <hal_timer.h>

#include "board.h"

void hal_timer_stop(void) {
    REG_TIMER_0_CTRL = 0u;
}

void hal_timer_set_prescale(uint32_t value) {
    REG_TIMER_0_PSCR = value;
}

void hal_timer_set_cmp(uint32_t value) {
    REG_TIMER_0_CMP = value;
}

void hal_timer_set_ctrl(uint32_t value) {
    REG_TIMER_0_CTRL = value;
}

uint32_t hal_timer_get_stat(void) {
    return REG_TIMER_0_STAT;
}

void hal_timer_clear(void) {
    while (hal_timer_get_stat() != 0u);
}

void delay_ms(uint32_t value) {
    hal_timer_set_ctrl(TIMER_CTRL_ENABLE_MASK | TIMER_CTRL_IRQ_ENABLE_MASK | TIMER_CTRL_DOWN_COUNT_MASK);
    for (uint32_t index = 0; index < value; ++index) {
        while (hal_timer_get_stat() == 0u);
    }
    hal_timer_stop();
}
