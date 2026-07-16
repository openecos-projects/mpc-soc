#include "main.h"

static void fail(char *message) {
    hal_sys_putstr("gpio fail: ");
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
    if ((hal_gpio_get_output() & 0x3u) != (value & 0x3u)) {
        fail("padout readback");
    }
}

void main(void) {
    const unsigned int input_mask = 0xcu;
    const unsigned int expected_input = 0x4u;

    hal_sys_uart_init();
    hal_sys_putstr("gpio soc test start\n\r");

    hal_sys_putstr("gpio step: configure gpio[1:0] as outputs\n\r");
    hal_gpio_set_dir(0x3u);
    if ((hal_gpio_get_dir() & 0xfu) != 0x3u) {
        fail("paddir readback");
    }

    hal_sys_putstr("gpio step: drive output sequence 0,1,2,3,0\n\r");
    write_and_check(0x0u);
    write_and_check(0x1u);
    write_and_check(0x2u);
    write_and_check(0x3u);
    write_and_check(0x0u);

    hal_sys_putstr("gpio step: sample externally driven input bits\n\r");
    delay(1000u);
    if ((hal_gpio_get_input() & input_mask) != expected_input) {
        fail("padin external drive");
    }

    hal_sys_putstr("gpio ok\n\r");
    while (1) {
    }
}
