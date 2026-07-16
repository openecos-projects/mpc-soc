#include <hal_uart.h>

#include "board.h"

void hal_uart_init(uint32_t baud) {
    if (baud == 0u) {
        return;
    }

    (void)baud;
    REG_UART_0_LC = REG_UART_0_LC | 0x80u;
    REG_UART_0_TH = 13u;
    REG_UART_0_IE = 0u;
    REG_UART_0_FC = 0x07u;
    REG_UART_0_LC = 0x03u;
}

void hal_uart_putchar(char c) {
    if (c == '\n') {
        while ((REG_UART_0_LS & UART_LS_THR_EMPTY_MASK) == 0u);
        REG_UART_0_TH = (uint8_t)'\r';
    }
    while ((REG_UART_0_LS & UART_LS_THR_EMPTY_MASK) == 0u);
    REG_UART_0_TH = (uint8_t)c;
}

void hal_uart_putstr(const char *str) {
    while (str != 0 && *str != '\0') {
        hal_uart_putchar(*str++);
    }
}

int hal_uart_getchar(void) {
    if ((REG_UART_0_LS & UART_LS_DATA_READY_MASK) == 0u) {
        return -1;
    }
    return (int)REG_UART_0_RB;
}
