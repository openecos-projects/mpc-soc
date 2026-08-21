import { defineConfig } from 'vitepress'

const cnSidebar = [
  {
    text: 'SoC 平台',
    items: [
      { text: '架构说明', link: '/architecture' },
      { text: '地址空间', link: '/memory-map' },
      { text: 'IP 就绪度', link: '/ip-readiness' },
      { text: '启动流程', link: '/boot-flow' }
    ]
  },
  {
    text: '用户接入',
    items: [
      { text: '获取 User Kit', link: '/user-kit' },
      { text: '接入指南', link: '/user-guide' },
      { text: '仿真与波形', link: '/simulation' },
      { text: 'Hello 冒烟', link: '/examples/hello' }
    ]
  }
]

const enSidebar = [
  {
    text: 'SoC platform',
    items: [
      { text: 'Architecture', link: '/en/architecture' },
      { text: 'Memory map', link: '/en/memory-map' },
      { text: 'IP readiness', link: '/en/ip-readiness' },
      { text: 'Boot flow', link: '/en/boot-flow' }
    ]
  },
  {
    text: 'User workflow',
    items: [
      { text: 'Get the User Kit', link: '/en/user-kit' },
      { text: 'Integration guide', link: '/en/user-guide' },
      { text: 'Simulation and waveforms', link: '/en/simulation' },
      { text: 'Hello smoke', link: '/en/examples/hello' }
    ]
  }
]

export default defineConfig({
  title: 'mpc-soc',
  description: 'RISC-V SoC integration board for multi-project chips',
  base: '/mpc-soc/',
  cleanUrls: true,
  lastUpdated: true,
  locales: {
    root: { label: '中文', lang: 'zh-CN' },
    en: { label: 'English', lang: 'en-US', link: '/en/' }
  },
  head: [
    ['meta', { name: 'theme-color', content: '#0a8f7a' }],
    ['meta', { name: 'color-scheme', content: 'light dark' }],
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/mpc-soc/mark.svg' }]
  ],
  markdown: {
    lineNumbers: true,
    languages: ['system-verilog'],
    languageAlias: { systemverilog: 'system-verilog' }
  },
  themeConfig: {
    logo: { src: '/mark.svg', alt: 'mpc-soc' },
    siteTitle: 'mpc-soc',
    socialLinks: [
      { icon: 'github', link: 'https://github.com/openecos-projects/mpc-soc' }
    ],
    locales: {
      root: {
        nav: [
          { text: '首页', link: '/' },
          { text: '用户指南', link: '/user-guide' },
          { text: '仿真', link: '/simulation' },
          { text: 'English', link: '/en/' }
        ],
        sidebar: cnSidebar,
        outline: { level: [2, 3], label: '本页内容' },
        docFooter: { prev: '上一页', next: '下一页' },
        lastUpdated: { text: '最后更新' },
        returnToTopLabel: '返回顶部',
        sidebarMenuLabel: '目录',
        darkModeSwitchLabel: '外观'
      },
      en: {
        nav: [
          { text: 'Home', link: '/en/' },
          { text: 'User guide', link: '/en/user-guide' },
          { text: 'Simulation', link: '/en/simulation' },
          { text: '中文', link: '/' }
        ],
        sidebar: { '/en/': enSidebar },
        outline: { level: [2, 3], label: 'On this page' }
      }
    },
    search: { provider: 'local' },
    footer: {
      message: 'Documentation is maintained from one bilingual source tree.',
      copyright: 'mpc-soc'
    }
  }
})
