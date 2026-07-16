#include "main.h"

static void fail(char *message) {
    hal_sys_putstr("gpio toggle fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void delay(volatile unsigned int count) {
    while (count-- != 0u) {
    }
}

static void write_and_check(unsigned int value) {
    hal_gpio_set_output(value);
    delay(1000u);
    if ((hal_gpio_get_output() & 0xfu) != (value & 0xfu)) {
        fail("padout readback");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("gpio toggle test start\n\r");

    hal_sys_putstr("gpio toggle step: configure gpio[3:0] as outputs\n\r");
    hal_gpio_set_dir(0xfu);
    if ((hal_gpio_get_dir() & 0xfu) != 0xfu) {
        fail("paddir readback");
    }

    hal_sys_putstr("gpio toggle step: drive walking pattern sequence\n\r");
    write_and_check(0x0u);
    write_and_check(0x5u);
    write_and_check(0xau);
    write_and_check(0x5u);
    write_and_check(0xau);
    write_and_check(0xfu);
    write_and_check(0x0u);

    hal_sys_putstr("gpio toggle ok\n\r");
    while (1) {
    }
}
