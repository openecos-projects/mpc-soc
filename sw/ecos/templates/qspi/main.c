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
    hal_sys_putstr("qspi fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

void main(void) {
    const uint32_t length = (24u << 8) | 8u;
    const uint32_t dummy = (5u << 16) | 3u;
    const uint32_t intcfg = (3u << 8) | 2u;

    hal_sys_uart_init();
    hal_sys_putstr("qspi test start\n\r");

    hal_sys_putstr("qspi step: check idle reset state\n\r");
    if ((REG_QSPI_STATUS & QSPI_STATUS_IDLE_MASK) == 0u) {
        fail("idle");
    }
    if ((REG_QSPI_INTCFG & QSPI_INTCFG_INT_ENABLE_MASK) != 0u) {
        fail("int enable reset");
    }

    hal_sys_putstr("qspi step: check clock divisor readback\n\r");
    write_reg(&REG_QSPI_CLKDIV, 4u);
    if (REG_QSPI_CLKDIV != 4u) {
        fail("clkdiv");
    }

    hal_sys_putstr("qspi step: check command and address readback\n\r");
    write_reg(&REG_QSPI_SPICMD, 0x9fu);
    write_reg(&REG_QSPI_SPIADR, 0x00123456u);
    if (REG_QSPI_SPICMD != 0x9fu || REG_QSPI_SPIADR != 0x00123456u) {
        fail("cmd adr");
    }

    hal_sys_putstr("qspi step: check length and dummy cycle readback\n\r");
    write_reg(&REG_QSPI_SPILEN, length);
    write_reg(&REG_QSPI_SPIDUM, dummy);
    if (REG_QSPI_SPILEN != length || REG_QSPI_SPIDUM != dummy) {
        fail("len dummy");
    }

    hal_sys_putstr("qspi step: check interrupt thresholds stay disabled\n\r");
    write_reg(&REG_QSPI_INTCFG, intcfg);
    if (REG_QSPI_INTCFG != intcfg) {
        fail("intcfg");
    }
    if ((REG_QSPI_INTCFG & QSPI_INTCFG_INT_ENABLE_MASK) != 0u) {
        fail("int enable");
    }

    hal_sys_putstr("qspi step: confirm no transfer was launched\n\r");
    if ((REG_QSPI_STATUS & QSPI_STATUS_IDLE_MASK) == 0u) {
        fail("busy");
    }

    hal_sys_putstr("qspi ok\n\r");
    while (1) {
    }
}
