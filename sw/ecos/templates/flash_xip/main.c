#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

static const uint32_t flash_pattern[4] __attribute__((aligned(4), used, section(".rodata.flash_xip_pattern"))) = {
    0x01234567u,
    0x89abcdefu,
    0xa5a55a5au,
    0x0f1e2d3cu,
};

static void fail(char *message) {
    hal_sys_putstr("flash xip fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static void check_address_range(void) {
    uintptr_t address = (uintptr_t)flash_pattern;

    if (address < (uintptr_t)MPC_SOC_BOOTROM_BASE) {
        fail("range low");
    }
    if (address >= ((uintptr_t)MPC_SOC_BOOTROM_BASE + (uintptr_t)MPC_SOC_BOOTROM_SIZE)) {
        fail("range high");
    }
}

static void check_word_reads(void) {
    volatile const uint32_t *word = flash_pattern;

    if (word[0] != 0x01234567u) {
        fail("word0");
    }
    if (word[1] != 0x89abcdefu) {
        fail("word1");
    }
    if (word[2] != 0xa5a55a5au) {
        fail("word2");
    }
    if (word[3] != 0x0f1e2d3cu) {
        fail("word3");
    }
}

static void check_half_reads(void) {
    volatile const uint16_t *half = (volatile const uint16_t *)flash_pattern;

    if (half[0] != 0x4567u || half[1] != 0x0123u) {
        fail("half0");
    }
    if (half[2] != 0xcdefu || half[3] != 0x89abu) {
        fail("half1");
    }
}

static void check_byte_reads(void) {
    volatile const uint8_t *byte = (volatile const uint8_t *)flash_pattern;

    if (byte[0] != 0x67u || byte[1] != 0x45u || byte[2] != 0x23u || byte[3] != 0x01u) {
        fail("byte0");
    }
    if (byte[4] != 0xefu || byte[5] != 0xcdu || byte[6] != 0xabu || byte[7] != 0x89u) {
        fail("byte1");
    }
    if (byte[15] != 0x0fu) {
        fail("byte tail");
    }
}

static void check_checksum(void) {
    volatile const uint32_t *word = flash_pattern;
    uint32_t checksum = 0u;

    for (uint32_t index = 0u; index < 4u; ++index) {
        checksum = (checksum << 5) ^ (checksum >> 27) ^ word[index];
    }

    if (checksum != 0xb63158dfu) {
        fail("checksum");
    }
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("flash xip test start\n\r");

    hal_sys_putstr("flash xip step: check pattern is linked into flash window\n\r");
    check_address_range();
    hal_sys_putstr("flash xip step: check word reads\n\r");
    check_word_reads();
    hal_sys_putstr("flash xip step: check halfword reads\n\r");
    check_half_reads();
    hal_sys_putstr("flash xip step: check byte reads\n\r");
    check_byte_reads();
    hal_sys_putstr("flash xip step: check repeated checksum reads\n\r");
    check_checksum();

    hal_sys_putstr("flash xip ok\n\r");
    while (1) {
    }
}
