import { createApp, defineAsyncComponent } from 'vue'
import directionals from './directives/vDirectionals.js'
import scrolllock from './directives/vScrolllock.js'

// Necessary for Craft vite plugin
import '../styles/index.scss'

createApp({
  components: {
    PAccordion: defineAsyncComponent(() => import('./components/PAccordion.vue')),
    PDismissable: defineAsyncComponent(() => import('./components/PDismissable.vue')),
    PLazy: defineAsyncComponent(() => import('./components/PLazy.vue')),
    POpenable: defineAsyncComponent(() => import('./components/POpenable.vue')),
    PTabs: defineAsyncComponent(() => import('./components/PTabs.vue')),
    PDirectionalKeys: defineAsyncComponent(() => import('./components/PDirectionalKeys.vue')),

    PSelect: defineAsyncComponent(() => import('@vueform/multiselect/themes/default.css') && import('@vueform/multiselect')),
    PSlider: defineAsyncComponent(() => import('./components/PSlider.vue')),
    PYouTube: defineAsyncComponent(() => import('./components/PYouTube.vue')),

    ElementCollection: defineAsyncComponent(() => import('./components/ElementCollection.vue')),
  },
  directives: {
    directionals,
    scrolllock,
  },
}).mount('#app')
