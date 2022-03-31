<template>
    <div class="mobileNav">
        <slot name="button">
            <button class="mobileNav__button" :class="buttonClass" @click="open">
                <svg class="mobileNav__icon" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="4" y1="6" x2="20" y2="6" />
                    <line x1="4" y1="12" x2="20" y2="12" />
                    <line x1="4" y1="18" x2="20" y2="18" />
                </svg>
            </button>
        </slot>
        <nav ref="menu" class="mobileNav__menu">
            <slot />
        </nav>
    </div>
</template>
<script>
import Vue from 'vue'
import MmenuLight from 'mmenu-light'

export default {
    menu: null,
    navigator: null,
    drawer: null,
    props: {
        title: {
            type: String,
        },
        mediaQuery: {
            type: String,
        },
        buttonClass: {
            type: String,
            default: 'button -primary -ghost',
        },
        navigationOptions: {
            type: Object,
            default() {
                return {
                    title: this.title,
                }
            },
        },
        offcanvasOptions: {
            type: Object,
        }
    },

    methods: {
        /**
         * Unfortunately this is not reactive; but still here for convienence.
         */
        isOpen() {
            return this.$options.drawer.wrapper.matches('.mm-ocd--open')
        },

        onKeyDown(event) {
            if (event.key === 'Escape' && this.isOpen()) {
                this.close();
            }
        },

        open() {
            this.$options.drawer.open()
        },

        close() {
            this.$options.drawer.close()
        },
    },

    mounted() {
        this.$options.menu = new MmenuLight(this.$refs.menu, this.mediaQuery)
        this.$options.navigator = this.$options.menu.navigation(this.navigationOptions)
        this.$options.drawer = this.$options.menu.offcanvas(this.offcanvasOptions)

        document.addEventListener('keydown', this.onKeyDown)
    }
}
</script>
