<script setup lang="ts">
import { ArrowDown, ArrowRight, Box, Cable, Cpu, GitMerge } from '@lucide/vue'

defineProps<{ compact?: boolean }>()
</script>

<template>
  <section class="frame-architecture" :class="{ compact }" aria-label="SoC 数据通路">
    <div class="architecture-header">
      <div>
        <span class="eyebrow">SOC DATA PATH</span>
        <h2>一个 AXI master，一组可仿真外设</h2>
      </div>
      <code>asicTop / SimTop</code>
    </div>

    <div class="architecture-flow">
      <div class="arch-node external">
        <Cpu :size="22" />
        <span><strong>RISC-V core slot</strong><small>CORE_SEL 选择待测 CPU</small></span>
      </div>
      <ArrowRight class="flow-arrow desktop-arrow" :size="22" />
      <ArrowDown class="flow-arrow mobile-arrow" :size="22" />
      <div class="arch-split">
        <div class="arch-node payload">
          <GitMerge :size="20" />
          <span><strong>AXI4 XBar</strong><small>AXI4 → APB4 外设互连</small></span>
        </div>
        <div class="arch-node select">
          <Box :size="20" />
          <span><strong>Flash / PSRAM</strong><small>XIP + 24 MiB 软件窗口</small></span>
        </div>
      </div>
      <ArrowRight class="flow-arrow desktop-arrow" :size="22" />
      <ArrowDown class="flow-arrow mobile-arrow" :size="22" />
      <div class="arch-node frame-top">
        <Cable :size="22" />
        <span><strong>SimTop board models</strong><small>UART · GPIO · SPI · I2C</small></span>
      </div>
      <ArrowRight class="flow-arrow desktop-arrow" :size="22" />
      <ArrowDown class="flow-arrow mobile-arrow" :size="22" />
      <div class="design-stack">
        <div class="arch-node active"><Cpu :size="18" /><span><strong>selected core</strong><small>clock on · reset off</small></span></div>
        <div class="arch-node inactive"><Cpu :size="18" /><span><strong>other CORE_SEL slots</strong><small>held in reset</small></span></div>
      </div>
    </div>

    <div class="signal-legend">
      <span><i class="select-dot"></i> memory</span>
      <span><i class="payload-dot"></i> interconnect</span>
      <span><i class="inactive-dot"></i> unused slots</span>
    </div>
  </section>
</template>
