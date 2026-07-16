#include SIM_TOP_HEADER
#include "verilated.h"

#if VM_TRACE
#include "verilated_fst_c.h"
#endif

#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#ifndef DEFAULT_MAX_CYCLES
#define DEFAULT_MAX_CYCLES 1000
#endif

namespace {
std::vector<std::uint8_t> flash_image;
constexpr std::uint64_t kUartBitCycles = 13 * 16;
std::string uart_stop_text;
std::string uart_fail_text;
std::string uart1_arm_text;
std::string uart_seen_text;
bool uart_stop_matched = false;
bool uart_fail_matched = false;
bool uart1_armed = false;
std::vector<std::uint32_t> gpio_expect_values;
std::uint32_t gpio_expect_mask = 0xf;
std::size_t gpio_expect_index = 0;
bool gpio_expect_matched = false;

std::string plusarg_value(const char* prefix, int argc, char** argv) {
  const std::string key(prefix);
  for (int index = 1; index < argc; ++index) {
    const std::string arg(argv[index]);
    if (arg.rfind(key, 0) == 0) {
      return arg.substr(key.size());
    }
  }
  return {};
}

std::uint64_t plusarg_u64(const char* prefix, std::uint64_t default_value, int argc, char** argv) {
  const std::string value = plusarg_value(prefix, argc, argv);
  if (value.empty()) {
    return default_value;
  }

  char* end = nullptr;
  const auto parsed = std::strtoull(value.c_str(), &end, 0);
  if (end == value.c_str() || *end != '\0') {
    std::cerr << "Invalid integer plusarg " << prefix << value << '\n';
    std::exit(2);
  }
  return parsed;
}

std::vector<std::uint32_t> plusarg_u32_list(const char* prefix, int argc, char** argv) {
  const std::string value = plusarg_value(prefix, argc, argv);
  std::vector<std::uint32_t> result;
  if (value.empty()) {
    return result;
  }

  std::size_t start = 0;
  while (start <= value.size()) {
    const auto end = value.find(',', start);
    const auto token = value.substr(start, end == std::string::npos ? std::string::npos : end - start);
    if (!token.empty()) {
      char* parse_end = nullptr;
      const auto parsed = std::strtoul(token.c_str(), &parse_end, 0);
      if (parse_end == token.c_str() || *parse_end != '\0') {
        std::cerr << "Invalid integer list plusarg " << prefix << value << '\n';
        std::exit(2);
      }
      result.push_back(static_cast<std::uint32_t>(parsed));
    }
    if (end == std::string::npos) {
      break;
    }
    start = end + 1;
  }
  return result;
}

bool load_flash_image(const std::string& path) {
  std::ifstream file(path, std::ios::binary);
  if (!file) {
    return false;
  }

  flash_image.assign(std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>());
  return true;
}

class UartRxDriver {
 public:
  UartRxDriver(std::string input, std::uint64_t start_cycle)
      : input_(std::move(input)), start_cycle_(start_cycle) {}

  int level(std::uint64_t cycle) const {
    if (input_.empty() || cycle < start_cycle_) {
      return 1;
    }

    const std::uint64_t elapsed = cycle - start_cycle_;
    const std::uint64_t bit_index = elapsed / kUartBitCycles;
    const std::uint64_t frame_index = bit_index / kFrameBits;
    const std::uint64_t frame_bit = bit_index % kFrameBits;

    if (frame_index >= input_.size()) {
      return 1;
    }

    if (frame_bit == 0) {
      return 0;
    }
    if (frame_bit == 9) {
      return 1;
    }

    const auto ch = static_cast<std::uint8_t>(input_[frame_index]);
    return (ch >> (frame_bit - 1)) & 1U;
  }

 private:
  static constexpr std::uint64_t kFrameBits = 10;

  std::string input_;
  std::uint64_t start_cycle_;
};

class Uart1TxWaveChecker {
 public:
  Uart1TxWaveChecker(std::string expected, std::uint64_t bit_cycles)
      : expected_(std::move(expected)), bit_cycles_(bit_cycles) {
    if (enabled() && bit_cycles_ == 0) {
      std::cerr << "Invalid UART1 bit cycle count: 0\n";
      std::exit(2);
    }
  }

  bool enabled() const { return !expected_.empty(); }
  bool done() const { return !enabled() || done_; }
  bool failed() const { return failed_; }
  std::size_t decoded_count() const { return decoded_index_; }
  const std::string& error() const { return error_; }

  void sample(int level, std::uint64_t cycle, bool armed) {
    level = level ? 1 : 0;
    if (!enabled() || done_ || failed_) {
      last_level_ = level;
      return;
    }
    if (!armed) {
      armed_seen_ = false;
      last_level_ = 1;
      return;
    }
    if (!armed_seen_) {
      armed_seen_ = true;
      last_level_ = 1;
    }
    if (level != last_level_ && edge_log_count_ < 16) {
      std::cout << "UART1 TX edge: cycle " << cycle << " level " << level << '\n';
      ++edge_log_count_;
    }

    if (!in_frame_) {
      if (last_level_ == 1 && level == 0) {
        in_frame_ = true;
        frame_start_cycle_ = cycle;
        frame_sample_bit_ = 0;
      } else {
        last_level_ = level;
        return;
      }
    }

    const auto elapsed = cycle - frame_start_cycle_;
    while (!failed_ && in_frame_ && frame_sample_bit_ < kFrameBits &&
           elapsed >= frame_sample_bit_ * bit_cycles_ + (bit_cycles_ / 2)) {
      const int expected_level = expected_level_for(frame_sample_bit_);
      if (level != expected_level) {
        char buffer[192];
        std::snprintf(buffer, sizeof(buffer),
                      "byte %zu bit %llu center cycle %llu expected %d observed %d",
                      decoded_index_, static_cast<unsigned long long>(frame_sample_bit_),
                      static_cast<unsigned long long>(cycle), expected_level, level);
        error_ = buffer;
        failed_ = true;
      }

      ++frame_sample_bit_;
      if (frame_sample_bit_ >= kFrameBits) {
        ++decoded_index_;
        in_frame_ = false;
        done_ = decoded_index_ >= expected_.size();
      }
    }

    last_level_ = level;
  }

 private:
  static constexpr std::uint64_t kFrameBits = 10;

  int expected_level_for(std::uint64_t frame_bit) const {
    if (frame_bit == 0) {
      return 0;
    }
    if (frame_bit == 9) {
      return 1;
    }

    const auto byte = static_cast<std::uint8_t>(expected_[decoded_index_]);
    return (byte >> (frame_bit - 1)) & 1U;
  }

  std::string expected_;
  std::uint64_t bit_cycles_ = 0;
  int last_level_ = 1;
  bool in_frame_ = false;
  bool armed_seen_ = false;
  bool done_ = false;
  bool failed_ = false;
  std::size_t decoded_index_ = 0;
  std::uint64_t frame_sample_bit_ = 0;
  std::uint64_t frame_start_cycle_ = 0;
  std::uint64_t edge_log_count_ = 0;
  std::string error_;
};

void drive_static_inputs(SIM_TOP_CLASS* top, int uart0_rx, std::uint32_t core_sel) {
#ifdef SIM_TOP_ASICTOP
  top->coreSel = core_sel & 0xfU;
  top->pll_en_i = 0;
  top->clk_cfg_i = 0;

  top->uart0_rx = uart0_rx;
  top->uart1_uart_rx_i = 1;
  top->spi_miso = 1;

  top->psram_dio_0 = 0;
  top->psram_dio_1 = 0;
  top->psram_dio_2 = 0;
  top->psram_dio_3 = 0;
  top->gpio0_0 = 0;
  top->gpio0_1 = 0;
  top->gpio0_2 = 0;
  top->gpio0_3 = 0;
  top->i2c_scl_0 = 1;
  top->i2c_sda_0 = 1;
  top->qspi_dio_0 = 0;
  top->qspi_dio_1 = 0;
  top->qspi_dio_2 = 0;
  top->qspi_dio_3 = 0;
#elif defined(SIM_TOP_SIMTOP)
  top->coreSel = core_sel & 0xfU;
  top->externalPins_uart0_rx = uart0_rx;
  top->externalPins_uart1_rx = 1;
#else
  (void)top;
  (void)uart0_rx;
  (void)core_sel;
#endif
}

void drive_gpio_inputs(SIM_TOP_CLASS* top, std::uint32_t gpio_in, std::uint32_t gpio_drive) {
#ifdef SIM_TOP_SIMTOP
  top->externalPins_gpio0_in = gpio_in & 0xfU;
  top->externalPins_gpio0_drive = gpio_drive & 0xfU;
#else
  (void)top;
  (void)gpio_in;
  (void)gpio_drive;
#endif
}

std::uint32_t sample_gpio0(SIM_TOP_CLASS* top) {
#ifdef SIM_TOP_SIMTOP
  return top->externalPins_gpio0_out & 0xfU;
#else
  (void)top;
  return 0;
#endif
}

int sample_uart1_tx(SIM_TOP_CLASS* top) {
#ifdef SIM_TOP_ASICTOP
  return top->uart1_uart_tx_o ? 1 : 0;
#elif defined(SIM_TOP_SIMTOP)
  return top->externalPins_uart1_tx ? 1 : 0;
#else
  (void)top;
  return 1;
#endif
}

void record_gpio_sample(std::uint32_t value) {
  if (gpio_expect_values.empty() || gpio_expect_matched) {
    return;
  }

  const auto masked_value = value & gpio_expect_mask;
  const auto expected = gpio_expect_values[gpio_expect_index] & gpio_expect_mask;
  if (masked_value != expected) {
    return;
  }

  ++gpio_expect_index;
  gpio_expect_matched = gpio_expect_index >= gpio_expect_values.size();
}

void record_uart_tx_byte(std::uint8_t byte) {
  const bool need_stop = !uart_stop_text.empty() && !uart_stop_matched;
  const bool need_fail = !uart_fail_text.empty() && !uart_fail_matched;
  const bool need_uart1_arm = !uart1_arm_text.empty() && !uart1_armed;
  if (!need_stop && !need_fail && !need_uart1_arm) {
    return;
  }

  uart_seen_text.push_back(static_cast<char>(byte));
  auto max_seen = std::max(uart_stop_text.size(), uart_fail_text.size());
  max_seen = std::max(max_seen, uart1_arm_text.size());
  if (uart_seen_text.size() > max_seen) {
    uart_seen_text.erase(0, uart_seen_text.size() - max_seen);
  }
  if (!uart_stop_matched && !uart_stop_text.empty() && uart_seen_text.size() >= uart_stop_text.size()) {
    uart_stop_matched = uart_seen_text.substr(uart_seen_text.size() - uart_stop_text.size()) == uart_stop_text;
  }
  if (!uart_fail_matched && !uart_fail_text.empty() && uart_seen_text.size() >= uart_fail_text.size()) {
    uart_fail_matched = uart_seen_text.substr(uart_seen_text.size() - uart_fail_text.size()) == uart_fail_text;
  }
  if (!uart1_armed && !uart1_arm_text.empty() && uart_seen_text.size() >= uart1_arm_text.size()) {
    uart1_armed = uart_seen_text.substr(uart_seen_text.size() - uart1_arm_text.size()) == uart1_arm_text;
  }
}

bool all_stop_conditions_matched(const Uart1TxWaveChecker& uart1_wave) {
  const bool has_uart_stop = !uart_stop_text.empty();
  const bool has_gpio_stop = !gpio_expect_values.empty();
  const bool has_uart1_stop = uart1_wave.enabled();
  if (!has_uart_stop && !has_gpio_stop && !has_uart1_stop) {
    return false;
  }

  const bool uart_done = uart_stop_text.empty() || uart_stop_matched;
  const bool gpio_done = gpio_expect_values.empty() || gpio_expect_matched;
  const bool uart1_done = !uart1_wave.enabled() || uart1_wave.done();
  return uart_done && gpio_done && uart1_done;
}
}  // namespace

extern "C" void flash_read(int addr, int* data) {
  std::uint32_t word = 0;
  if (addr >= 0) {
    const auto base = static_cast<std::size_t>(addr);
    for (std::size_t byte = 0; byte < 4; ++byte) {
      if (base + byte < flash_image.size()) {
        word |= static_cast<std::uint32_t>(flash_image[base + byte]) << (8 * byte);
      }
    }
  }
  *data = static_cast<int>(word);
}

extern "C" void uart_tx_byte(int data) {
  record_uart_tx_byte(static_cast<std::uint8_t>(data & 0xff));
  std::fflush(stdout);
}

extern "C" void debug(int addr, int data) {
  (void)addr;
  (void)data;
}

extern "C" void ebreak(int test) {
  (void)test;
  Verilated::gotFinish(true);
}

int main(int argc, char** argv) {
  std::cout << std::unitbuf;
  auto context = std::make_unique<VerilatedContext>();
  context->commandArgs(argc, argv);

  const std::string bootrom_path = plusarg_value("+bootrom=", argc, argv);
  const std::string wave_path = plusarg_value("+wave=", argc, argv);
  const std::string uart_input = plusarg_value("+uart-in=", argc, argv);
  const std::string uart1_expect = plusarg_value("+uart1-expect=", argc, argv);
  uart1_arm_text = plusarg_value("+uart1-arm-text=", argc, argv);
  uart_stop_text = plusarg_value("+uart-stop-text=", argc, argv);
  uart_fail_text = plusarg_value("+uart-fail-text=", argc, argv);
  const std::uint64_t max_cycles = plusarg_u64("+max-cycles=", DEFAULT_MAX_CYCLES, argc, argv);
  const auto core_sel = static_cast<std::uint32_t>(plusarg_u64("+core-sel=", 0, argc, argv));
  const std::uint64_t uart_start_cycle = plusarg_u64("+uart-start-cycle=", 10000, argc, argv);
  const std::uint64_t uart1_bit_cycles = plusarg_u64("+uart1-bit-cycles=", 1, argc, argv);
  const auto gpio_in = static_cast<std::uint32_t>(plusarg_u64("+gpio-in=", 0, argc, argv));
  const auto gpio_drive = static_cast<std::uint32_t>(plusarg_u64("+gpio-drive=", 0, argc, argv));
  gpio_expect_mask = static_cast<std::uint32_t>(plusarg_u64("+gpio-expect-mask=", 0xf, argc, argv));
  gpio_expect_values = plusarg_u32_list("+gpio-expect=", argc, argv);

  if (!bootrom_path.empty()) {
    if (!load_flash_image(bootrom_path)) {
      std::cerr << "Boot ROM image not found: " << bootrom_path << '\n';
      return 2;
    }
    std::cout << "Boot ROM image: " << bootrom_path << " (" << flash_image.size() << " bytes)\n";
  } else {
    std::cout << "Boot ROM image: <none>\n";
  }
  std::cout << "Max cycles: " << max_cycles << '\n';
  std::cout << "Core select: " << (core_sel & 0xfU) << '\n';
  if (!uart_input.empty()) {
    std::cout << "UART input: " << uart_input << " (start cycle " << uart_start_cycle << ")\n";
  }
  if (!uart_stop_text.empty()) {
    std::cout << "UART stop text: " << uart_stop_text << '\n';
  }
  if (!uart_fail_text.empty()) {
    std::cout << "UART fail text: " << uart_fail_text << '\n';
  }
  if (!uart1_expect.empty()) {
    std::cout << "UART1 TX expect: " << uart1_expect << " (8N1, "
              << uart1_bit_cycles << " cycles/bit)\n";
    if (!uart1_arm_text.empty()) {
      std::cout << "UART1 TX arm text: " << uart1_arm_text << '\n';
    }
  }
  if (!gpio_expect_values.empty() || gpio_drive != 0) {
    std::cout << "GPIO input: 0x" << std::hex << gpio_in << " drive: 0x" << gpio_drive
              << " expect-mask: 0x" << gpio_expect_mask << std::dec << '\n';
  }

  auto top = std::make_unique<SIM_TOP_CLASS>(context.get());
  UartRxDriver uart_rx(uart_input, uart_start_cycle);
  Uart1TxWaveChecker uart1_wave(uart1_expect, uart1_bit_cycles);
  drive_static_inputs(top.get(), uart_rx.level(0), core_sel);
  drive_gpio_inputs(top.get(), gpio_in, gpio_drive);

#if VM_TRACE
  std::unique_ptr<VerilatedFstC> trace;
  if (!wave_path.empty()) {
    context->traceEverOn(true);
    trace = std::make_unique<VerilatedFstC>();
    top->trace(trace.get(), 99);
    trace->open(wave_path.c_str());
    std::cout << "Waveform: " << wave_path << '\n';
  }
#endif

  top->reset = 1;
  for (std::uint64_t cycle = 0; cycle < max_cycles && !context->gotFinish() &&
                                !all_stop_conditions_matched(uart1_wave) && !uart_fail_matched &&
                                !uart1_wave.failed();
       ++cycle) {
    drive_static_inputs(top.get(), uart_rx.level(cycle), core_sel);
    drive_gpio_inputs(top.get(), gpio_in, gpio_drive);
    top->clock = 0;
    top->eval();
    record_gpio_sample(sample_gpio0(top.get()));
#if VM_TRACE
    if (trace) {
      trace->dump(context->time());
    }
#endif
    context->timeInc(1);

    top->reset = cycle < 10;
    drive_static_inputs(top.get(), uart_rx.level(cycle), core_sel);
    drive_gpio_inputs(top.get(), gpio_in, gpio_drive);
    top->clock = 1;
    top->eval();
    record_gpio_sample(sample_gpio0(top.get()));
    uart1_wave.sample(sample_uart1_tx(top.get()), cycle, uart1_arm_text.empty() || uart1_armed);
#if VM_TRACE
    if (trace) {
      trace->dump(context->time());
    }
#endif
    context->timeInc(1);
  }

  top->final();
#if VM_TRACE
  if (trace) {
    trace->close();
  }
#endif

  if (!gpio_expect_values.empty() && !gpio_expect_matched) {
    std::cerr << "SIM FAIL: GPIO output sequence stopped at index " << gpio_expect_index
              << " before " << context->time() << " ticks" << '\n';
    return 1;
  }
  if (uart_fail_matched) {
    std::cerr << "SIM FAIL: UART fail text observed at " << context->time() << " ticks" << '\n';
    return 1;
  }
  if (uart1_wave.failed()) {
    std::cerr << "SIM FAIL: UART1 TX waveform mismatch: " << uart1_wave.error() << '\n';
    return 1;
  }
  if (uart1_wave.enabled() && !uart1_arm_text.empty() && !uart1_armed) {
    std::cerr << "SIM FAIL: UART1 TX arm text not observed before " << context->time() << " ticks" << '\n';
    return 1;
  }
  if (uart1_wave.enabled() && !uart1_wave.done()) {
    std::cerr << "SIM FAIL: UART1 TX waveform stopped after " << uart1_wave.decoded_count()
              << " of " << uart1_expect.size() << " byte(s) before " << context->time() << " ticks" << '\n';
    return 1;
  }
  if (!uart_stop_text.empty() && !uart_stop_matched) {
    std::cerr << "SIM FAIL: UART stop text not observed before " << context->time() << " ticks" << '\n';
    return 1;
  }

  if (uart1_wave.enabled()) {
    std::cout << "SIM PASS: UART1 TX 8N1 waveform and stop conditions observed at "
              << context->time() << " ticks" << '\n';
  } else if (!gpio_expect_values.empty()) {
    std::cout << "SIM PASS: GPIO output sequence observed at " << context->time() << " ticks" << '\n';
  } else if (!uart_stop_text.empty()) {
    std::cout << "SIM PASS: UART stop text observed at " << context->time() << " ticks" << '\n';
  } else {
    std::cout << "SIM PASS: reached " << context->time() << " ticks" << '\n';
  }
  return 0;
}
