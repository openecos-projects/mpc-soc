#ifndef __MPC_SOC_BOARD_H__
#define __MPC_SOC_BOARD_H__

#include <stdint.h>

#define MPC_SOC_BOARD_NAME              "mpc-soc"
#define MPC_SOC_XLEN                    32u
#define MPC_SOC_CLOCK_HZ                50000000u
#define MPC_SOC_UART_BAUD               115200u

/* ========================== 内存映射 ====================================== */
#define MPC_SOC_BOOTROM_BASE            0x30000000u
#define MPC_SOC_BOOTROM_SIZE            0x01000000u
#define MPC_SOC_PSRAM_BASE              0xC0000000u
#define MPC_SOC_PSRAM_SIZE              0x01800000u
#define MPC_SOC_MEM_BASE                MPC_SOC_PSRAM_BASE
#define MPC_SOC_MEM_SIZE                MPC_SOC_PSRAM_SIZE

/* ========================== 外设基地址 ==================================== */
#define MPC_SOC_UART0_BASE              0x10000000u
#define MPC_SOC_RCU_BASE                0x10002000u
#define MPC_SOC_RTC_BASE                0x10004000u
#define MPC_SOC_WDG_BASE                0x10005000u
#define MPC_SOC_ARCHINFO_BASE           0x10006000u
#define MPC_SOC_GPIO0_BASE              0x10100000u
#define MPC_SOC_UART1_BASE              0x10103000u
#define MPC_SOC_I2C_BASE                0x10104000u
#define MPC_SOC_PWM_BASE                0x10106000u
#define MPC_SOC_TIMER0_BASE             0x10108000u
#define MPC_SOC_TIMER1_BASE             0x10109000u
#define MPC_SOC_TIMER2_BASE             0x1010A000u
#define MPC_SOC_TIMER3_BASE             0x1010B000u
#define MPC_SOC_QSPI_BASE               0x10200000u
#define MPC_SOC_CLINT_BASE              0x02010000u
#define MPC_SOC_PLIC_BASE               0x0C000000u
#define MPC_SOC_RNG_BASE                0x10300000u
#define MPC_SOC_CRC_BASE                0x10301000u

/* ========================== 中断号 ======================================== */
#define MPC_SOC_IRQ_TIMER0              1u
#define MPC_SOC_IRQ_UART0               2u
#define MPC_SOC_IRQ_GPIO0               3u
#define MPC_SOC_IRQ_SOFTWARE            4u
#define MPC_SOC_IRQ_EXTERNAL            5u

/* ========================== PLIC 寄存器组 ================================= */
#define REG_PLIC_CTRL                   (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x00u)))
#define REG_PLIC_TM                     (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x04u)))
#define REG_PLIC_PRIO1                  (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x08u)))
#define REG_PLIC_PRIO2                  (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x0Cu)))
#define REG_PLIC_PRIO3                  (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x10u)))
#define REG_PLIC_PRIO4                  (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x14u)))
#define REG_PLIC_IP                     (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x18u)))
#define REG_PLIC_IE                     (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x1Cu)))
#define REG_PLIC_THOLD                  (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x20u)))
#define REG_PLIC_CLAIMCOMP              (*((volatile uint32_t *)(MPC_SOC_PLIC_BASE + 0x24u)))

#define PLIC_CTRL_EN_MASK               0x00000001u
#define PLIC_CTRL_TNM_MASK              0x0000000eu
#define PLIC_CTRL_MASK                  0x0000000fu
#define PLIC_IE_IRQ0_MASK               0x00000001u
#define PLIC_THOLD_MASK                 0x0000000fu
#define PLIC_CLAIMCOMP_MASK             0x0000001fu

/* ========================== UART_0 寄存器组 =============================== */
#define REG_UART_0_RB                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x00u)))
#define REG_UART_0_TH                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x00u)))
#define REG_UART_0_DLL                  (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x00u)))
#define REG_UART_0_IE                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x01u)))
#define REG_UART_0_DLM                  (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x01u)))
#define REG_UART_0_II                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x02u)))
#define REG_UART_0_FC                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x02u)))
#define REG_UART_0_LC                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x03u)))
#define REG_UART_0_MC                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x04u)))
#define REG_UART_0_LS                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x05u)))
#define REG_UART_0_MS                   (*((volatile uint8_t *)(MPC_SOC_UART0_BASE + 0x06u)))

#define UART_LS_DATA_READY_MASK         0x01u
#define UART_LS_THR_EMPTY_MASK          0x20u
#define UART_LS_TX_EMPTY_MASK           0x40u
#define UART_LC_8N1_VALUE               0x03u
#define UART_LC_DLAB_MASK               0x80u

/* ========================== UART_1 寄存器组 =============================== */
#define REG_UART1_LCR                   (*((volatile uint32_t *)(MPC_SOC_UART1_BASE + 0x00u)))
#define REG_UART1_DIV                   (*((volatile uint32_t *)(MPC_SOC_UART1_BASE + 0x04u)))
#define REG_UART1_TRX                   (*((volatile uint32_t *)(MPC_SOC_UART1_BASE + 0x08u)))
#define REG_UART1_FCR                   (*((volatile uint32_t *)(MPC_SOC_UART1_BASE + 0x0Cu)))
#define REG_UART1_LSR                   (*((volatile uint32_t *)(MPC_SOC_UART1_BASE + 0x10u)))

#define UART1_LCR_RX_IRQ_ENABLE_MASK    0x00000001u
#define UART1_LCR_TX_IRQ_ENABLE_MASK    0x00000002u
#define UART1_LCR_PE_IRQ_ENABLE_MASK    0x00000004u
#define UART1_LCR_WLS_SHIFT             3u
#define UART1_LCR_WLS_8BIT              (3u << UART1_LCR_WLS_SHIFT)
#define UART1_LCR_STOP_2BIT_MASK        0x00000020u
#define UART1_LCR_PARITY_ENABLE_MASK    0x00000040u
#define UART1_DIV_RESET_VALUE           0x00000002u
#define UART1_LSR_RX_IP_MASK            0x00000001u
#define UART1_LSR_TX_IP_MASK            0x00000002u
#define UART1_LSR_PE_IP_MASK            0x00000004u
#define UART1_LSR_RX_VALID_MASK         0x00000008u
#define UART1_LSR_PARITY_ERROR_MASK     0x00000010u
#define UART1_LSR_THR_EMPTY_MASK        0x00000020u
#define UART1_LSR_TX_EMPTY_MASK         0x00000040u
#define UART1_LSR_RX_EMPTY_MASK         0x00000080u
#define UART1_LSR_TX_FULL_MASK          0x00000100u
#define UART1_LSR_RESET_VALUE           0x000000e0u

/* ========================== RCU 寄存器组 ================================== */
#define REG_RCU_CTRL                    (*((volatile uint32_t *)(MPC_SOC_RCU_BASE + 0x00u)))
#define REG_RCU_RDIV                    (*((volatile uint32_t *)(MPC_SOC_RCU_BASE + 0x04u)))
#define REG_RCU_STAT                    (*((volatile uint32_t *)(MPC_SOC_RCU_BASE + 0x08u)))

#define RCU_CTRL_MASK                   0x0000000fu
#define RCU_STAT_CLKLOCK_MASK           0x00000001u

/* ========================== ARCHINFO 寄存器组 ============================= */
#define REG_ARCHINFO_SYS                (*((volatile uint32_t *)(MPC_SOC_ARCHINFO_BASE + 0x00u)))
#define REG_ARCHINFO_IDL                (*((volatile uint32_t *)(MPC_SOC_ARCHINFO_BASE + 0x04u)))
#define REG_ARCHINFO_IDH                (*((volatile uint32_t *)(MPC_SOC_ARCHINFO_BASE + 0x08u)))

#define ARCHINFO_SYS_RESET_VALUE        0x000f1010u
#define ARCHINFO_IDL_RESET_VALUE        0xffff2022u
#define ARCHINFO_IDH_RESET_VALUE        0x00ffffffu

/* ========================== GPIO_0 寄存器组 =============================== */
#define REG_GPIO_0_PADDIR               (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x00u)))
#define REG_GPIO_0_PADIN                (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x04u)))
#define REG_GPIO_0_PADOUT               (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x08u)))
#define REG_GPIO_0_INTEN                (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x0Cu)))
#define REG_GPIO_0_INTTYPE0             (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x10u)))
#define REG_GPIO_0_INTTYPE1             (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x14u)))
#define REG_GPIO_0_INTSTAT              (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x18u)))
#define REG_GPIO_0_IOFCFG               (*((volatile uint32_t *)(MPC_SOC_GPIO0_BASE + 0x1Cu)))

/* ========================== I2C 寄存器组 ================================== */
#define REG_I2C_CTRL                    (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x00u)))
#define REG_I2C_PSCR                    (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x04u)))
#define REG_I2C_TXR                     (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x08u)))
#define REG_I2C_RXR                     (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x0Cu)))
#define REG_I2C_CMD                     (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x10u)))
#define REG_I2C_SR                      (*((volatile uint32_t *)(MPC_SOC_I2C_BASE + 0x14u)))

#define I2C_CTRL_IRQ_ENABLE_MASK        0x00000040u
#define I2C_CTRL_ENABLE_MASK            0x00000080u
#define I2C_PSCR_RESET_VALUE            0x0000ffffu
#define I2C_CMD_IACK_MASK               0x00000001u
#define I2C_CMD_ACK_MASK                0x00000008u
#define I2C_CMD_WR_MASK                 0x00000010u
#define I2C_CMD_RD_MASK                 0x00000020u
#define I2C_CMD_STO_MASK                0x00000040u
#define I2C_CMD_STA_MASK                0x00000080u
#define I2C_SR_IF_MASK                  0x00000001u
#define I2C_SR_TIP_MASK                 0x00000002u
#define I2C_SR_AL_MASK                  0x00000020u
#define I2C_SR_BUSY_MASK                0x00000040u
#define I2C_SR_RXACK_MASK               0x00000080u

/* ========================== TIMER_0 寄存器组 ============================== */
#define REG_TIMER_0_CTRL                (*((volatile uint32_t *)(MPC_SOC_TIMER0_BASE + 0x00u)))
#define REG_TIMER_0_PSCR                (*((volatile uint32_t *)(MPC_SOC_TIMER0_BASE + 0x04u)))
#define REG_TIMER_0_CNT                 (*((volatile uint32_t *)(MPC_SOC_TIMER0_BASE + 0x08u)))
#define REG_TIMER_0_CMP                 (*((volatile uint32_t *)(MPC_SOC_TIMER0_BASE + 0x0Cu)))
#define REG_TIMER_0_STAT                (*((volatile uint32_t *)(MPC_SOC_TIMER0_BASE + 0x10u)))
#define REG_TIMER_1_CTRL                (*((volatile uint32_t *)(MPC_SOC_TIMER1_BASE + 0x00u)))
#define REG_TIMER_1_PSCR                (*((volatile uint32_t *)(MPC_SOC_TIMER1_BASE + 0x04u)))
#define REG_TIMER_1_CNT                 (*((volatile uint32_t *)(MPC_SOC_TIMER1_BASE + 0x08u)))
#define REG_TIMER_1_CMP                 (*((volatile uint32_t *)(MPC_SOC_TIMER1_BASE + 0x0Cu)))
#define REG_TIMER_1_STAT                (*((volatile uint32_t *)(MPC_SOC_TIMER1_BASE + 0x10u)))
#define REG_TIMER_2_CTRL                (*((volatile uint32_t *)(MPC_SOC_TIMER2_BASE + 0x00u)))
#define REG_TIMER_2_PSCR                (*((volatile uint32_t *)(MPC_SOC_TIMER2_BASE + 0x04u)))
#define REG_TIMER_2_CNT                 (*((volatile uint32_t *)(MPC_SOC_TIMER2_BASE + 0x08u)))
#define REG_TIMER_2_CMP                 (*((volatile uint32_t *)(MPC_SOC_TIMER2_BASE + 0x0Cu)))
#define REG_TIMER_2_STAT                (*((volatile uint32_t *)(MPC_SOC_TIMER2_BASE + 0x10u)))
#define REG_TIMER_3_CTRL                (*((volatile uint32_t *)(MPC_SOC_TIMER3_BASE + 0x00u)))
#define REG_TIMER_3_PSCR                (*((volatile uint32_t *)(MPC_SOC_TIMER3_BASE + 0x04u)))
#define REG_TIMER_3_CNT                 (*((volatile uint32_t *)(MPC_SOC_TIMER3_BASE + 0x08u)))
#define REG_TIMER_3_CMP                 (*((volatile uint32_t *)(MPC_SOC_TIMER3_BASE + 0x0Cu)))
#define REG_TIMER_3_STAT                (*((volatile uint32_t *)(MPC_SOC_TIMER3_BASE + 0x10u)))

#define TIMER_CTRL_IRQ_ENABLE_MASK      0x00000001u
#define TIMER_CTRL_ENABLE_MASK          0x00000004u
#define TIMER_CTRL_DOWN_COUNT_MASK      0x00000008u

/* ========================== RTC 寄存器组 ================================== */
#define REG_RTC_CTRL                    (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x00u)))
#define REG_RTC_PSCR                    (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x04u)))
#define REG_RTC_CNT                     (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x08u)))
#define REG_RTC_ALRM                    (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x0Cu)))
#define REG_RTC_ISTA                    (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x10u)))
#define REG_RTC_SSTA                    (*((volatile uint32_t *)(MPC_SOC_RTC_BASE + 0x14u)))

#define RTC_CTRL_CMF_MASK               0x00000001u
#define RTC_CTRL_SCIE_MASK              0x00000002u
#define RTC_CTRL_ALRMIE_MASK            0x00000004u
#define RTC_CTRL_OVIE_MASK              0x00000008u
#define RTC_CTRL_ENABLE_MASK            0x00000010u
#define RTC_ISTA_SCIF_MASK              0x00000001u
#define RTC_ISTA_ALRMIF_MASK            0x00000002u
#define RTC_ISTA_OVIF_MASK              0x00000004u
#define RTC_SSTA_RSYNF_MASK             0x00000001u
#define RTC_SSTA_LWOFF_MASK             0x00000002u

/* ========================== WDG 寄存器组 ================================== */
#define REG_WDG_CTRL                    (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x00u)))
#define REG_WDG_PSCR                    (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x04u)))
#define REG_WDG_CNT                     (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x08u)))
#define REG_WDG_CMP                     (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x0Cu)))
#define REG_WDG_STAT                    (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x10u)))
#define REG_WDG_KEY                     (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x14u)))
#define REG_WDG_FEED                    (*((volatile uint32_t *)(MPC_SOC_WDG_BASE + 0x18u)))

#define WDG_KEY_UNLOCK                  0x5f3759dfu
#define WDG_CTRL_OVIE_MASK              0x00000001u
#define WDG_CTRL_ETR_MASK               0x00000002u
#define WDG_CTRL_ENABLE_MASK            0x00000004u
#define WDG_STAT_OVIF_MASK              0x00000001u
#define WDG_FEED_MASK                   0x00000001u

/* ========================== PWM 寄存器组 ================================== */
#define REG_PWM_CTRL                    (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x00u)))
#define REG_PWM_PSCR                    (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x04u)))
#define REG_PWM_CNT                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x08u)))
#define REG_PWM_CMP                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x0Cu)))
#define REG_PWM_CR0                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x10u)))
#define REG_PWM_CR1                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x14u)))
#define REG_PWM_CR2                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x18u)))
#define REG_PWM_CR3                     (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x1Cu)))
#define REG_PWM_STAT                    (*((volatile uint32_t *)(MPC_SOC_PWM_BASE + 0x20u)))

#define PWM_CTRL_OVIE_MASK              0x00000001u
#define PWM_CTRL_ENABLE_MASK            0x00000002u
#define PWM_CTRL_CLEAR_MASK             0x00000004u
#define PWM_STAT_OVIF_MASK              0x00000001u

/* ========================== QSPI 寄存器组 ================================= */
#define REG_QSPI_STATUS                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x00u)))
#define REG_QSPI_CLKDIV                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x04u)))
#define REG_QSPI_SPICMD                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x08u)))
#define REG_QSPI_SPIADR                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x0Cu)))
#define REG_QSPI_SPILEN                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x10u)))
#define REG_QSPI_SPIDUM                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x14u)))
#define REG_QSPI_TXFIFO                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x18u)))
#define REG_QSPI_RXFIFO                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x20u)))
#define REG_QSPI_INTCFG                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x24u)))
#define REG_QSPI_INTSTA                 (*((volatile uint32_t *)(MPC_SOC_QSPI_BASE + 0x28u)))

#define QSPI_STATUS_IDLE_MASK           0x00000001u
#define QSPI_INTCFG_INT_ENABLE_MASK     0x80000000u

/* ========================== RNG 寄存器组 ================================== */
#define REG_RNG_CTRL                    (*((volatile uint32_t *)(MPC_SOC_RNG_BASE + 0x00u)))
#define REG_RNG_SEED                    (*((volatile uint32_t *)(MPC_SOC_RNG_BASE + 0x04u)))
#define REG_RNG_VAL                     (*((volatile uint32_t *)(MPC_SOC_RNG_BASE + 0x08u)))

#define RNG_CTRL_ENABLE_MASK            0x00000001u

/* ========================== CRC 寄存器组 ================================== */
#define REG_CRC_CTRL                    (*((volatile uint32_t *)(MPC_SOC_CRC_BASE + 0x00u)))
#define REG_CRC_INIT                    (*((volatile uint32_t *)(MPC_SOC_CRC_BASE + 0x04u)))
#define REG_CRC_XORV                    (*((volatile uint32_t *)(MPC_SOC_CRC_BASE + 0x08u)))
#define REG_CRC_DATA                    (*((volatile uint32_t *)(MPC_SOC_CRC_BASE + 0x0Cu)))
#define REG_CRC_STAT                    (*((volatile uint32_t *)(MPC_SOC_CRC_BASE + 0x10u)))

#define CRC_CTRL_ENABLE_MASK            0x00000001u
#define CRC_CTRL_REVIN_MASK             0x00000002u
#define CRC_CTRL_REVOUT_MASK            0x00000004u
#define CRC_CTRL_MODE_SHIFT             3u
#define CRC_CTRL_SIZE_SHIFT             5u
#define CRC_STAT_DONE_MASK              0x00000001u

#define CRC_MODE_CRC8                   0u
#define CRC_MODE_CRC16_1021             1u
#define CRC_MODE_CRC16_8005             2u
#define CRC_MODE_CRC32                  3u

#define CRC_SIZE_8                      0u
#define CRC_SIZE_16                     1u
#define CRC_SIZE_24                     2u
#define CRC_SIZE_32                     3u

/* ========================== CLINT 寄存器组 ================================ */
#define REG_CLINT_MSIP                  (*((volatile uint32_t *)(MPC_SOC_CLINT_BASE + 0x0000u)))
#define REG_CLINT_MTIMECMP_LO           (*((volatile uint32_t *)(MPC_SOC_CLINT_BASE + 0x4000u)))
#define REG_CLINT_MTIMECMP_HI           (*((volatile uint32_t *)(MPC_SOC_CLINT_BASE + 0x4004u)))
#define REG_CLINT_MTIME_LO              (*((volatile uint32_t *)(MPC_SOC_CLINT_BASE + 0xBFF8u)))
#define REG_CLINT_MTIME_HI              (*((volatile uint32_t *)(MPC_SOC_CLINT_BASE + 0xBFFCu)))

#endif
