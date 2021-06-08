import 'lazysizes/plugins/respimg/ls.respimg'
import 'lazysizes/plugins/object-fit/ls.object-fit'
import 'lazysizes'
import 'slick-carousel'
import PortalVue from 'portal-vue'

import './plugins/dropdown.plugin'
import './plugins/mobileNavigation.plugin'
import './plugins/stickyElement.plugin'
import './plugins/stickyHeader.plugin'
import './plugins/tabs.plugin'

import BpAccordion from '../styles/molecules/accordion/BpAccordion'
import BpTabs from '../styles/molecules/tabs/BpTabs'
import BpDirectional from '../styles/utilities/directional/BpDirectional'
import BpDropdown from '../styles/atoms/dropdown/BpDropdown'
import BpMobileNavigation from '../styles/organisms/mobile-navigation/BpMobileNavigation'
import BpModal from '../styles/organisms/modal/BpModal'

import Vue from 'vue'

import Filtering from './filtering.js'

Vue.use(PortalVue)

// eslint-disable-next-line
new Vue({
    el: '#root',
    mixins: [ Filtering ],
    components: {
        BpAccordion,
        BpDirectional,
        BpTabs,
        BpDropdown,
        BpMobileNavigation,
        BpModal,
    },
})
