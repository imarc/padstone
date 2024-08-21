<template>
    <div class="mobileNav">
        <slot name="button">
            <button
                class="mobileNav__button"
                :class="buttonClass"
                @click="open"
            >
                <svg
                    class="mobileNav__icon"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                    stroke="currentColor"
                    fill="none"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                >
                    <line
                        x1="4"
                        y1="6"
                        x2="20"
                        y2="6"
                    />
                    <line
                        x1="4"
                        y1="12"
                        x2="20"
                        y2="12"
                    />
                    <line
                        x1="4"
                        y1="18"
                        x2="20"
                        y2="18"
                    />
                </svg>
            </button>
        </slot>
        <nav
            ref="menuEl"
            class="mobileNav__menu"
        >
            <slot />
        </nav>
    </div>
</template>
<script setup>
import { onMounted, ref } from 'vue'
import MmenuLight from 'mmenu-light'

let drawer = null
const menuEl = ref(null)

const props = defineProps({
    title: {
        type: String,
        required: true,
    },
    mediaQuery: {
        type: String,
        default: '(max-width: 624px)',
    },
    buttonClass: {
        type: String,
        default: 'button -primary -ghost',
    },
    navigationOptions: {
        type: Object,
        default: (props) => ({
            title: props.title,
        }),
    },
    offcanvasOptions: {
        type: Object,
        default: null,
    },
})

const isOpen = () => {
    return drawer.wrapper.matches('.mm-ocd--open')
}

const onKeyDown = event => {
    if (event.key === 'Escape' && isOpen()) {
        close()
    }
}

const open = () => drawer.open()
const close = () => drawer.close()

onMounted(() => {
    const menu = new MmenuLight(menuEl.value, props.mediaQuery)
    menu.navigation(props.navigationOptions)
    drawer = menu.offcanvas(props.offcanvasOptions)

    document.addEventListener('keydown', onKeyDown)
})
</script>
