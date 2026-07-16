#include "main.h"

static void put_visible_char(uint8_t ch) {
    if (ch == '\r' || ch == '\n') {
        hal_sys_putstr("<CR>\n");
    } else {
        hal_sys_putchar((char)ch);
        hal_sys_putchar('\n');
    }
}

void main(void) {
    uint32_t count = 0;

    hal_sys_uart_init();
    hal_sys_putstr("uart input test start\n");
    hal_sys_putstr("type characters, finish with q or enter\n");
    hal_sys_putstr("uart input step: wait for injected characters\n");

    while (1) {
        uint8_t ch = hal_sys_getchar();

        hal_sys_putstr("rx ");
        put_visible_char(ch);
        count++;

        if (ch == 'q' || ch == '\r' || ch == '\n') {
            break;
        }
    }

    hal_sys_putstr("uart input step: termination character received\n");
    hal_sys_putstr("uart input ok\n");

    while (1);
}
