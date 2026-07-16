#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

static void fail(char *message) {
    hal_sys_putstr("rng fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

void main(void) {
    uint32_t first;
    uint32_t changed = 0u;

    hal_sys_uart_init();
    hal_sys_putstr("rng test start\n\r");

    hal_sys_putstr("rng step: enable and seed generator\n\r");
    REG_RNG_CTRL = RNG_CTRL_ENABLE_MASK;
    REG_RNG_SEED = 0x0000fe1cu;
    first = REG_RNG_VAL;

    if (first == 0u) {
        fail("seed");
    }

    hal_sys_putstr("rng step: sample nonzero changing values\n\r");
    for (uint32_t index = 0u; index < 8u; ++index) {
        uint32_t value = REG_RNG_VAL;

        if (value == 0u) {
            fail("zero");
        }
        if (value != first) {
            changed = 1u;
        }
    }

    if (changed == 0u) {
        fail("stuck");
    }

    hal_sys_putstr("rng step: clear seed and output\n\r");
    REG_RNG_SEED = 0u;
    if (REG_RNG_VAL != 0u) {
        fail("clear");
    }

    hal_sys_putstr("rng ok\n\r");
    while (1) {
    }
}
