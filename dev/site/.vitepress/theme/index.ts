import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'
import DocsDashboard from './components/DocsDashboard.vue'
import SocArchitecture from './components/SocArchitecture.vue'
import './style.css'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('DocsDashboard', DocsDashboard)
    app.component('SocArchitecture', SocArchitecture)
  }
} satisfies Theme
