#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define UART1_TEST_DIV 7u
#define UART1_TEST_BYTE 0x55u
#define UART1_POLL_LIMIT 50000u

static void cpu_bus_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_reg(volatile uint32_t *reg, uint32_t value) {
    cpu_bus_gap();
    *reg = value;
}

static __attribute__((noinline)) uint32_t read_reg(volatile uint32_t *reg) {
    uint32_t value = *reg;
    cpu_bus_gap();
    return value;
}

static void fail(char *message) {
    hal_sys_putstr("uart1 fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void wait_lsr_set(uint32_t mask, char *message) {
    uint32_t timeout = UART1_POLL_LIMIT;

    while (timeout-- != 0u) {
        if ((read_reg(&REG_UART1_LSR) & mask) == mask) {
            return;
        }
    }

    fail(message);
}

static void check_reset_state(void) {
    uint32_t div;
    uint32_t lsr;

    if (read_reg(&REG_UART1_LCR) != 0u) {
        fail("lcr reset");
    }
    hal_sys_putstr("uart1 detail: lcr reset ok\n\r");
    div = read_reg(&REG_UART1_DIV);
    if (div != UART1_DIV_RESET_VALUE) {
        fail("div reset");
    }
    hal_sys_putstr("uart1 detail: div reset ok\n\r");

    lsr = read_reg(&REG_UART1_LSR) & 0x1ffu;
    if ((lsr & UART1_LSR_RESET_VALUE) != UART1_LSR_RESET_VALUE) {
        fail("lsr idle reset");
    }
    if ((lsr & (UART1_LSR_RX_IP_MASK |
                UART1_LSR_TX_IP_MASK |
                UART1_LSR_PE_IP_MASK |
                UART1_LSR_RX_VALID_MASK |
                UART1_LSR_PARITY_ERROR_MASK |
                UART1_LSR_TX_FULL_MASK)) != 0u) {
        fail("lsr active reset");
    }
    hal_sys_putstr("uart1 detail: lsr reset ok\n\r");
}

static void configure_8n1(void) {
    write_reg(&REG_UART1_LCR, 0u);
    write_reg(&REG_UART1_DIV, UART1_TEST_DIV);

    write_reg(&REG_UART1_FCR, 0x3u);
    write_reg(&REG_UART1_FCR, 0x0u);

    write_reg(&REG_UART1_LCR, UART1_LCR_WLS_8BIT);

    if (read_reg(&REG_UART1_DIV) != UART1_TEST_DIV) {
        fail("div readback");
    }
    hal_sys_putstr("uart1 detail: div readback ok\n\r");
    if ((read_reg(&REG_UART1_LCR) & (UART1_LCR_WLS_8BIT |
                                     UART1_LCR_STOP_2BIT_MASK |
                                     UART1_LCR_PARITY_ENABLE_MASK |
                                     UART1_LCR_RX_IRQ_ENABLE_MASK |
                                     UART1_LCR_TX_IRQ_ENABLE_MASK |
                                     UART1_LCR_PE_IRQ_ENABLE_MASK)) != UART1_LCR_WLS_8BIT) {
        fail("lcr 8n1");
    }
    hal_sys_putstr("uart1 detail: lcr 8n1 ok\n\r");
}

static void transmit_protocol_pattern(void) {
    wait_lsr_set(UART1_LSR_THR_EMPTY_MASK, "thr ready before send");
    hal_sys_putstr("uart1 detail: thr ready before send ok\n\r");
    if ((read_reg(&REG_UART1_LSR) & UART1_LSR_TX_FULL_MASK) != 0u) {
        fail("tx full before send");
    }
    hal_sys_putstr("uart1 detail: tx not full before send ok\n\r");

    hal_sys_putstr("uart1 arm: write 0x55 to trx\n\r");
    write_reg(&REG_UART1_TRX, UART1_TEST_BYTE);
    hal_sys_putstr("uart1 detail: wrote 0x55 to trx\n\r");
    wait_lsr_set(UART1_LSR_THR_EMPTY_MASK, "thr empty after send");
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("uart1 test start\n\r");

    hal_sys_putstr("uart1 step: check reset-visible registers\n\r");
    check_reset_state();
    hal_sys_putstr("uart1 step: configure 8n1 and fast divider\n\r");
    configure_8n1();
    hal_sys_putstr("uart1 step: transmit 0x55 protocol pattern on uart1 tx\n\r");
    transmit_protocol_pattern();
    hal_sys_putstr("uart1 step: uart1 tx pattern accepted\n\r");

    hal_sys_putstr("uart1 ok\n\r");
    while (1) {
    }
}
