import 'slick-carousel'
import 'lazysizes'
import PortalVue from 'portal-vue'
import { Swiper, SwiperSlide } from 'vue-awesome-swiper'

import './plugins/dropdown.plugin'
import './plugins/mobileNavigation.plugin'
import './plugins/stickyElement.plugin'
import './plugins/stickyHeader.plugin'
import './plugins/tabs.plugin'

import BpAccordion from '../styles/molecules/accordion/BpAccordion'
import BpCarousel from '../styles/organisms/carousel/BpCarousel'
import BpClickable from '../styles/utilities/clickable/BpClickable'
import BpDirectional from '../styles/utilities/directional/BpDirectional'
import BpDismissable from '../styles/utilities/dismissable/BpDismissable'
import BpDropdown from '../styles/atoms/dropdown/BpDropdown'
import BpMobileNavigation from '../styles/organisms/mobile-navigation/BpMobileNavigation'
import BpModal from '../styles/organisms/modal/BpModal'
import BpTabs from '../styles/molecules/tabs/BpTabs'

import Vue from 'vue'

Vue.use(PortalVue)

// eslint-disable-next-line
new Vue({
    el: '#root',
    components: {
        BpAccordion,
        BpCarousel,
        BpClickable,
        BpDirectional,
        BpDismissable,
        BpDropdown,
        BpMobileNavigation,
        BpModal,
        BpTabs,
        Swiper,
        SwiperSlide,
    },
})
