#!/usr/bin/env bash
set -euo pipefail

sdk_dir="${1:?usage: prepare_minimal_ecos_sdk.sh <output-directory>}"
mkdir -p \
  "$sdk_dir/include" \
  "$sdk_dir/components/libc/include" \
  "$sdk_dir/components/libgcc/include" \
  "$sdk_dir/lib"

cat > "$sdk_dir/include/hal_sys_uart.h" <<'EOF'
#ifndef HAL_SYS_UART_H
#define HAL_SYS_UART_H
#include <stdint.h>
void hal_sys_uart_init(void);
void hal_sys_putchar(char c);
void hal_sys_putstr(char *str);
uint8_t hal_sys_getchar(void);
#endif
EOF

cat > "$sdk_dir/include/hal_gpio.h" <<'EOF'
#ifndef HAL_GPIO_H
#define HAL_GPIO_H
#include <stdint.h>
#define GPIO_LEVEL_LOW 0u
#define GPIO_LEVEL_HIGH 1u
void hal_gpio_set_dir(uint32_t value);
uint32_t hal_gpio_get_dir(void);
uint32_t hal_gpio_get_input(void);
uint32_t hal_gpio_get_output(void);
void hal_gpio_set_output(uint32_t value);
void hal_gpio_set_level(uint32_t pin, uint32_t level);
uint32_t hal_gpio_get_level(uint32_t pin);
#endif
EOF

cat > "$sdk_dir/include/hal_timer.h" <<'EOF'
#ifndef HAL_TIMER_H
#define HAL_TIMER_H
#include <stdint.h>
void hal_timer_stop(void);
void hal_timer_set_prescale(uint32_t value);
void hal_timer_set_cmp(uint32_t value);
void hal_timer_set_ctrl(uint32_t value);
uint32_t hal_timer_get_stat(void);
void hal_timer_clear(void);
void delay_ms(uint32_t value);
#endif
EOF

cat > "$sdk_dir/include/hal_uart.h" <<'EOF'
#ifndef HAL_UART_H
#define HAL_UART_H
#include <stdint.h>
void hal_uart_init(uint32_t baud);
void hal_uart_putchar(char c);
void hal_uart_putstr(const char *str);
int hal_uart_getchar(void);
#endif
EOF

cat > "$sdk_dir/components/libc/include/string.h" <<'EOF'
#ifndef STRING_H
#define STRING_H
#include <stddef.h>
void *memcpy(void *dest, const void *src, size_t n);
void *memset(void *s, int c, size_t n);
size_t strlen(const char *s);
int strcmp(const char *s1, const char *s2);
#endif
EOF

cat > "$sdk_dir/components/libc/include/stdio.h" <<'EOF'
#ifndef STDIO_H
#define STDIO_H
int printf(const char *format, ...);
int puts(const char *s);
#endif
EOF

cat > "$sdk_dir/components/libgcc/include/libgcc.h" <<'EOF'
#ifndef LIBGCC_H
#define LIBGCC_H
#endif
EOF
