#include <stdint.h>

#include "board.h"
#include "hal_sys_uart.h"

#define CRC_POLL_LIMIT 128u
#define CRC_REG_INIT_OFFSET 0x04u
#define CRC_REG_XORV_OFFSET 0x08u
#define CRC_REG_DATA_OFFSET 0x0cu

static void cpu_store_gap(void) {
    __asm__ volatile ("nop\n\tnop\n\tnop\n\tnop" ::: "memory");
}

static __attribute__((noinline)) void write_crc_ctrl(uint32_t value) {
    cpu_store_gap();
    REG_CRC_CTRL = value;
}

static __attribute__((noinline)) void write_crc_reg(uint32_t offset, uint32_t value) {
    volatile uint32_t *reg = (volatile uint32_t *)(MPC_SOC_CRC_BASE + offset);

    cpu_store_gap();
    *reg = value;
}

static void fail(char *message) {
    hal_sys_putstr("crc fail: ");
    hal_sys_putstr(message);
    hal_sys_putstr("\n\r");
    while (1) {
    }
}

static uint32_t crc_run(uint32_t data, uint32_t size, uint32_t mode,
                        uint32_t init, uint32_t xorv,
                        uint32_t revin, uint32_t revout) {
    uint32_t ctrl = CRC_CTRL_ENABLE_MASK;
    uint32_t timeout = CRC_POLL_LIMIT;

    ctrl |= mode << CRC_CTRL_MODE_SHIFT;
    ctrl |= size << CRC_CTRL_SIZE_SHIFT;
    if (revin != 0u) {
        ctrl |= CRC_CTRL_REVIN_MASK;
    }
    if (revout != 0u) {
        ctrl |= CRC_CTRL_REVOUT_MASK;
    }

    write_crc_ctrl(0u);
    write_crc_reg(CRC_REG_INIT_OFFSET, init);
    write_crc_reg(CRC_REG_XORV_OFFSET, xorv);
    write_crc_ctrl(ctrl);
    write_crc_reg(CRC_REG_DATA_OFFSET, data);

    while (timeout-- != 0u) {
        if ((REG_CRC_STAT & CRC_STAT_DONE_MASK) != 0u) {
            return REG_CRC_DATA;
        }
    }

    fail("timeout");
    return 0u;
}

void main(void) {
    hal_sys_uart_init();
    hal_sys_putstr("crc test start\n\r");

    hal_sys_putstr("crc step: crc8 byte calculation\n\r");
    if ((crc_run(0x000000a5u, CRC_SIZE_8, CRC_MODE_CRC8, 0x00u, 0x00u,
                 0u, 0u) & 0x000000ffu) != 0x72u) {
        fail("crc8");
    }

    hal_sys_putstr("crc step: crc16-1021 halfword calculation\n\r");
    if ((crc_run(0x00001234u, CRC_SIZE_16, CRC_MODE_CRC16_1021, 0xffffu, 0x0000u,
                 0u, 0u) & 0x0000ffffu) != 0x0ec9u) {
        fail("crc16-1021");
    }

    hal_sys_putstr("crc step: crc16-8005 reflected calculation\n\r");
    if ((crc_run(0x00123456u, CRC_SIZE_24, CRC_MODE_CRC16_8005, 0xffffu, 0x0000u,
                 1u, 1u) & 0x0000ffffu) != 0xb69cu) {
        fail("crc16-8005");
    }

    hal_sys_putstr("crc step: crc32 reflected calculation\n\r");
    if ((crc_run(0x12345678u, CRC_SIZE_32, CRC_MODE_CRC32, 0xffffffffu, 0xffffffffu,
                 1u, 1u) & 0xffffffffu) != 0x207575d4u) {
        fail("crc32");
    }

    hal_sys_putstr("crc ok\n\r");
    while (1) {
    }
}
