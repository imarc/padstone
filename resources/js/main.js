import 'mmenu-light/dist/mmenu-light.css'
import 'normalize.css/normalize.css'
import 'lazysizes'
import 'swiper/css'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { useUrlSearchParams } from '@vueuse/core'

import '../styles/main.scss'

import BpCarousel from '../styles/organisms/carousel/BpCarousel.vue'
import BpClickable from '../styles/utilities/clickable/BpClickable.js'
import BpDirectional from '../styles/utilities/directional/BpDirectional.vue'
import BpDismissable from '../styles/utilities/dismissable/BpDismissable.vue'
import BpDropdown from '../styles/atoms/dropdown/BpDropdown.vue'
import BpDropdownHoverable from '../styles/atoms/dropdown/BpDropdownHoverable.vue'
import BpDropdownLink from '../styles/atoms/dropdown/BpDropdownLink.vue'
import BpMobileNavigation from '../styles/organisms/mobile-navigation/BpMobileNavigation.vue'
import BpModal from '../styles/organisms/modal/BpModal.vue'

import ElementCollection from '../js/components/ElementCollection.vue'
import UrlParams from '../js/components/UrlParams.vue'

import { createApp } from 'vue'

const app = createApp({
    components: {
        Swiper,
        SwiperSlide,

        BpCarousel,
        BpClickable,
        BpDirectional,
        BpDismissable,
        BpDropdown,
        BpDropdownHoverable,
        BpDropdownLink,
        BpMobileNavigation,
        BpModal,

        ElementCollection,
        UrlParams,
    },
})

app.mount('#root')
