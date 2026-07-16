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
    hal_sys_putstr("i2c fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void check_reset_state(void) {
    uint32_t status;

    if (REG_I2C_CTRL != 0u) {
        fail("ctrl reset");
    }
    if (REG_I2C_PSCR != I2C_PSCR_RESET_VALUE) {
        fail("pscr reset");
    }
    if (REG_I2C_TXR != 0u) {
        fail("txr reset");
    }
    if (REG_I2C_RXR != 0u) {
        fail("rxr reset");
    }

    status = REG_I2C_SR;
    if ((status & (I2C_SR_IF_MASK | I2C_SR_TIP_MASK | I2C_SR_AL_MASK)) != 0u) {
        fail("status reset");
    }
}

static void check_register_readback(void) {
    write_reg(&REG_I2C_PSCR, 0x001fu);
    if (REG_I2C_PSCR != 0x001fu) {
        fail("pscr readback");
    }

    write_reg(&REG_I2C_TXR, 0xa5u);
    if (REG_I2C_TXR != 0xa5u) {
        fail("txr readback");
    }

    write_reg(&REG_I2C_CTRL, I2C_CTRL_ENABLE_MASK);
    if (REG_I2C_CTRL != I2C_CTRL_ENABLE_MASK) {
        fail("ctrl enable");
    }
    if ((REG_I2C_CTRL & I2C_CTRL_IRQ_ENABLE_MASK) != 0u) {
        fail("irq enabled");
    }
}

static void check_disabled_command_safe(void) {
    uint32_t status;

    write_reg(&REG_I2C_CTRL, 0u);
    write_reg(&REG_I2C_CMD, I2C_CMD_STA_MASK | I2C_CMD_WR_MASK);

    status = REG_I2C_SR;
    if ((status & (I2C_SR_IF_MASK | I2C_SR_TIP_MASK | I2C_SR_AL_MASK)) != 0u) {
        fail("disabled cmd");
    }
}

static void restore_defaults(void) {
    write_reg(&REG_I2C_CTRL, 0u);
    write_reg(&REG_I2C_PSCR, I2C_PSCR_RESET_VALUE);
    write_reg(&REG_I2C_TXR, 0u);

    if (REG_I2C_CTRL != 0u) {
        fail("restore ctrl");
    }
    if (REG_I2C_PSCR != I2C_PSCR_RESET_VALUE) {
        fail("restore pscr");
    }
    if (REG_I2C_TXR != 0u) {
        fail("restore txr");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("i2c test start\n\r");

    hal_sys_putstr("i2c step: check reset-visible registers\n\r");
    check_reset_state();
    hal_sys_putstr("i2c step: check basic register readback\n\r");
    check_register_readback();
    hal_sys_putstr("i2c step: verify disabled command does not start transfer\n\r");
    check_disabled_command_safe();
    hal_sys_putstr("i2c step: restore disabled defaults\n\r");
    restore_defaults();

    hal_sys_putstr("i2c ok\n\r");
    while (1) {
    }
}
