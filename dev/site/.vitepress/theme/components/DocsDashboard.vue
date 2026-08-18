<script setup lang="ts">
import { useData } from 'vitepress'
import { computed, ref } from 'vue'
import {
  ArrowRight,
  BookOpen,
  Box,
  CheckCircle2,
  Cpu,
  FlaskConical,
  TerminalSquare
} from '@lucide/vue'
import { SOC_DATA } from '../soc-data'
import SocArchitecture from './SocArchitecture.vue'

const { lang } = useData()
const query = ref('')
const fmtRegion = (value: string) =>
  value.replace(/^0x([0-9a-f]+)$/i, (_, hex: string) =>
    `0x${hex.toUpperCase().replace(/([0-9A-F])(?=(?:[0-9A-F]{4})+$)/g, '$1_')}`
  )
const isEn = lang.value.startsWith('en')
const filteredIps = computed(() => {
  const q = query.value.trim().toLowerCase()
  const rows = isEn ? SOC_DATA.ipsEn : SOC_DATA.ips
  return rows.filter((ip) =>
    !q || Object.values(ip).some((value) => String(value).toLowerCase().includes(q))
  )
})
const base = isEn ? '/mpc-soc/en' : '/mpc-soc'
const fmtHz = (hz: number) => (hz >= 1_000_000 ? `${hz / 1_000_000} MHz` : `${hz / 1000} kHz`)
const fmtHex = (value: string) =>
  value.replace(/^0x([0-9a-f]+)$/i, (_, hex: string) =>
    `0x${hex.toUpperCase().replace(/([0-9A-F])(?=(?:[0-9A-F]{4})+$)/g, '$1_')}`
  )

const copy = isEn
  ? {
      kicker: 'RISC-V SoC workspace',
      title: 'mpc-soc',
      lead: 'A simulatable RISC-V SoC board. Attach a core to an existing slot, run software, and inspect the memory map from one documentation workbench.',
      action: 'Open the user guide',
      docsLabel: 'Documentation',
      startLabel: 'Quick start',
      startNote: 'Users attach a core through CORE_SEL. Full bootrom regression stays on the maintainer Makefile.',
      ipTitle: 'IP readiness',
      memoryTitle: 'Memory map',
      filter: 'Filter',
      filterPlaceholder: 'Search IP or function',
      regionCount: `${SOC_DATA.regions.length} mapped regions`
    }
  : {
      kicker: 'RISC-V SoC workspace',
      title: 'mpc-soc',
      lead: '给多项目芯片提供可仿真、可跑软件的 RISC-V SoC 底板。把 core 接到现有槽位，在同一套文档工作台里查看地址空间和 IP 状态。',
      action: '打开用户指南',
      docsLabel: '文档目录',
      startLabel: '快速开始',
      startNote: '用户阶段通过 CORE_SEL 选择待测 core。完整 bootrom 回归走维护者入口。',
      ipTitle: 'IP 就绪度',
      memoryTitle: '地址空间',
      filter: '筛选',
      filterPlaceholder: '搜索 IP 或功能',
      regionCount: `${SOC_DATA.regions.length} 个映射区域`
    }

const docs = isEn
  ? [
      { icon: BookOpen, label: 'User guide', detail: 'Attach a core and run SoC simulation', to: `${base}/user-guide` },
      { icon: Cpu, label: 'Architecture', detail: 'asicTop, SimTop, and the AXI fabric', to: `${base}/architecture` },
      { icon: Box, label: 'Memory map', detail: 'Flash, PSRAM, and peripheral windows', to: `${base}/memory-map` },
      { icon: FlaskConical, label: 'IP readiness', detail: 'Smoke status and verification limits', to: `${base}/ip-readiness` }
    ]
  : [
      { icon: BookOpen, label: '用户接入', detail: '把 core 接到现有槽位并跑仿真', to: `${base}/user-guide` },
      { icon: Cpu, label: '架构说明', detail: 'asicTop、SimTop 与 AXI 互连', to: `${base}/architecture` },
      { icon: Box, label: '地址空间', detail: 'Flash、PSRAM 和外设窗口', to: `${base}/memory-map` },
      { icon: FlaskConical, label: 'IP 就绪度', detail: '冒烟状态和验证边界', to: `${base}/ip-readiness` }
    ]
</script>

<template>
  <main class="docs-dashboard">
    <section class="dashboard-heading">
      <div>
        <div class="dashboard-kicker"><Cpu :size="15" /> {{ copy.kicker }}</div>
        <h1>{{ copy.title }}</h1>
        <p>{{ copy.lead }}</p>
      </div>
      <a class="primary-action" :href="`${base}/user-guide`">
        {{ copy.action }} <ArrowRight :size="17" />
      </a>
    </section>

    <section class="metric-strip" aria-label="SoC 关键参数">
      <div><span>TOP</span><strong>{{ SOC_DATA.soc.top }}</strong></div>
      <div><span>CLOCK</span><strong>{{ fmtHz(SOC_DATA.soc.clockHz) }}</strong></div>
      <div><span>DATA</span><strong>{{ SOC_DATA.soc.dataWidth }} bit</strong></div>
      <div><span>RESET PC</span><strong>{{ fmtHex(SOC_DATA.soc.resetPc) }}</strong></div>
      <div class="metric-state"><CheckCircle2 :size="16" /><strong>Verilator 5.050</strong></div>
    </section>

    <SocArchitecture compact />

    <section class="dashboard-grid">
      <div class="doc-directory">
        <div class="section-label"><BookOpen :size="16" /> {{ copy.docsLabel }}</div>
        <div class="doc-links">
          <a v-for="item in docs" :key="item.label" :href="item.to" class="doc-link">
            <component :is="item.icon" :size="20" />
            <span><strong>{{ item.label }}</strong><small>{{ item.detail }}</small></span>
            <ArrowRight :size="16" />
          </a>
        </div>
      </div>

      <div class="quick-terminal">
        <div class="section-label"><TerminalSquare :size="16" /> {{ copy.startLabel }}</div>
        <div class="terminal-window" aria-label="检查并运行 SoC 冒烟的命令">
          <div class="terminal-title"><span></span><span></span><span></span><code>mpc-soc</code></div>
          <pre><span class="prompt">$</span> make doctor
<span class="prompt">$</span> make check
<span class="result">SOC SMOKE CHECK PASS</span></pre>
        </div>
        <p>{{ copy.startNote }}</p>
      </div>
    </section>

    <section class="soc-overview" id="ip-status">
      <div>
        <div class="overview-heading">
          <div class="section-label"><FlaskConical :size="16" /> {{ copy.ipTitle }}</div>
          <div class="filter-wrap">
            <label for="ip-filter">{{ copy.filter }}</label>
            <input id="ip-filter" v-model="query" type="search" :placeholder="copy.filterPlaceholder">
          </div>
        </div>
        <div class="ip-table-shell">
          <table class="ip-table">
            <colgroup>
              <col class="col-name">
              <col class="col-function">
              <col class="col-address">
              <col class="col-status">
              <col class="col-tests">
              <col class="col-risk">
            </colgroup>
            <thead>
              <tr>
                <th>IP</th>
                <th>{{ isEn ? 'Function' : '功能' }}</th>
                <th>{{ isEn ? 'Address' : '地址 / 实例' }}</th>
                <th>{{ isEn ? 'Status' : '状态' }}</th>
                <th>{{ isEn ? 'Tests' : '测试' }}</th>
                <th>{{ isEn ? 'Gaps' : '验证边界' }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="ip in filteredIps" :key="ip.name">
                <td class="ip-name">{{ ip.name }}</td>
                <td>{{ ip.function }}</td>
                <td class="ip-address">{{ ip.address }}</td>
                <td><span class="ip-status">{{ ip.status }}</span></td>
                <td>{{ ip.tests }}</td>
                <td>{{ ip.risk }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div id="memory-map">
        <div class="overview-heading">
          <div class="section-label"><Box :size="16" /> {{ copy.memoryTitle }}</div>
          <span class="eyebrow">{{ copy.regionCount }}</span>
        </div>
        <div class="memory-grid">
          <article v-for="region in SOC_DATA.regions" :key="region.name" class="memory-card">
            <span class="kind">{{ region.kind }}</span>
            <small>{{ region.name }}</small>
            <strong>{{ fmtRegion(region.base) }}</strong>
            <p>{{ region.description }} · {{ fmtRegion(region.size) }}</p>
          </article>
        </div>
      </div>
    </section>
  </main>
</template>
