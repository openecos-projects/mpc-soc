#include "main.h"

#if defined(__GNUC__)
#pragma GCC optimize ("O0")
#endif

#ifndef PSRAM_SWEEP_STRIDE
#define PSRAM_SWEEP_STRIDE 0x100000u
#endif

#ifndef PSRAM_SWEEP_RESERVED_SIZE
#define PSRAM_SWEEP_RESERVED_SIZE 0x100000u
#endif

#ifndef PSRAM_SWEEP_PROGRESS_STEP_PERCENT
#define PSRAM_SWEEP_PROGRESS_STEP_PERCENT 5u
#endif

#define PSRAM_SWEEP_TEST_SIZE (MPC_SOC_PSRAM_SIZE - PSRAM_SWEEP_RESERVED_SIZE)
#define PSRAM_SWEEP_POINTS(X) \
    X(0x00000000u, 0xa5a55a5au) \
    X(0x00100000u, 0xa5b55a5au) \
    X(0x00200000u, 0xa5855a5au) \
    X(0x00300000u, 0xa5955a5au) \
    X(0x00400000u, 0xa5e55a5au) \
    X(0x00500000u, 0xa5f55a5au) \
    X(0x00600000u, 0xa5c55a5au) \
    X(0x00700000u, 0xa5d55a5au) \
    X(0x00800000u, 0xa5255a5au) \
    X(0x00900000u, 0xa5355a5au) \
    X(0x00a00000u, 0xa5055a5au) \
    X(0x00b00000u, 0xa5155a5au) \
    X(0x00c00000u, 0xa5655a5au) \
    X(0x00d00000u, 0xa5755a5au) \
    X(0x00e00000u, 0xa5455a5au) \
    X(0x00f00000u, 0xa5555a5au) \
    X(0x01000000u, 0xa4a55a5au) \
    X(0x01100000u, 0xa4b55a5au) \
    X(0x01200000u, 0xa4855a5au) \
    X(0x01300000u, 0xa4955a5au) \
    X(0x01400000u, 0xa4e55a5au) \
    X(0x01500000u, 0xa4f55a5au) \
    X(0x01600000u, 0xa4c55a5au)

static void sweep_putchar(char c) {
    REG_UART_0_TH = (uint8_t)c;
}

static void sweep_putstr(char *str) {
    while (*str != '\0') {
        sweep_putchar(*str++);
    }
}

static void put_hex32(uint32_t value) {
    static const char hex[] = "0123456789abcdef";

    sweep_putstr("0x");
    for (int shift = 28; shift >= 0; shift -= 4) {
        sweep_putchar(hex[(value >> shift) & 0x0fu]);
    }
}

static void put_percent(uint32_t value) {
    switch (value) {
    case 0u: sweep_putstr("0"); break;
    case 5u: sweep_putstr("5"); break;
    case 10u: sweep_putstr("10"); break;
    case 15u: sweep_putstr("15"); break;
    case 20u: sweep_putstr("20"); break;
    case 25u: sweep_putstr("25"); break;
    case 30u: sweep_putstr("30"); break;
    case 35u: sweep_putstr("35"); break;
    case 40u: sweep_putstr("40"); break;
    case 45u: sweep_putstr("45"); break;
    case 50u: sweep_putstr("50"); break;
    case 55u: sweep_putstr("55"); break;
    case 60u: sweep_putstr("60"); break;
    case 65u: sweep_putstr("65"); break;
    case 70u: sweep_putstr("70"); break;
    case 75u: sweep_putstr("75"); break;
    case 80u: sweep_putstr("80"); break;
    case 85u: sweep_putstr("85"); break;
    case 90u: sweep_putstr("90"); break;
    case 95u: sweep_putstr("95"); break;
    default: sweep_putstr("100"); break;
    }
}

static void fail(char *message, uintptr_t address, uint32_t expect, uint32_t actual) {
    sweep_putstr("psram fail: ");
    sweep_putstr(message);
    sweep_putstr(" addr ");
    put_hex32((uint32_t)address);
    sweep_putstr(" expect ");
    put_hex32(expect);
    sweep_putstr(" actual ");
    put_hex32(actual);
    sweep_putstr("\n\r");
    while (1) {
    }
}

static void sweep_write(void) {
    const uintptr_t base = MPC_SOC_PSRAM_BASE + PSRAM_SWEEP_RESERVED_SIZE;

#define WRITE_POINT(offset, pattern) (*(volatile uint32_t *)(base + (offset)) = (pattern));
    PSRAM_SWEEP_POINTS(WRITE_POINT)
#undef WRITE_POINT
}

static void sweep_read(void) {
    const uintptr_t base = MPC_SOC_PSRAM_BASE + PSRAM_SWEEP_RESERVED_SIZE;

#define READ_POINT(offset, pattern) do { \
        uintptr_t address = base + (offset); \
        uint32_t actual = *(volatile uint32_t *)address; \
        if (actual != (pattern)) { \
            fail("word", address, (pattern), actual); \
        } \
    } while (0);
    PSRAM_SWEEP_POINTS(READ_POINT)
#undef READ_POINT
}

void main(void) {
    hal_sys_uart_init();
    sweep_putstr("S\n\r");

    sweep_write();
    sweep_read();

    sweep_putstr("psram sweep ok\n\r");
    while (1) {
    }
}
