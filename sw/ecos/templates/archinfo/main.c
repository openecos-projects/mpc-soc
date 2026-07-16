#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

static void fail(char *message) {
    hal_sys_putstr("archinfo fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

void main(void) {
    volatile uint32_t *hole = (volatile uint32_t *)(MPC_SOC_ARCHINFO_BASE + 0x0cu);

    hal_sys_uart_init();
    hal_sys_putstr("archinfo test start\n\r");

    hal_sys_putstr("archinfo step: check SYS identity fields\n\r");
    if (REG_ARCHINFO_SYS != ARCHINFO_SYS_RESET_VALUE) {
        fail("sys");
    }

    hal_sys_putstr("archinfo step: check IDL identity fields\n\r");
    if (REG_ARCHINFO_IDL != ARCHINFO_IDL_RESET_VALUE) {
        fail("idl");
    }

    hal_sys_putstr("archinfo step: check IDH identity fields\n\r");
    if (REG_ARCHINFO_IDH != ARCHINFO_IDH_RESET_VALUE) {
        fail("idh");
    }

    hal_sys_putstr("archinfo step: check unused register reads zero\n\r");
    if (*hole != 0u) {
        fail("hole");
    }

    hal_sys_putstr("archinfo ok\n\r");
    while (1) {
    }
}
