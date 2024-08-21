<template>
    <swiper
        navigation
        v-bind="currentVariant"
    >
        <slot />
    </swiper>
</template>
<script setup>
import { computed } from 'vue'
import { Swiper } from 'swiper/vue'
import { Keyboard, Navigation, Pagination } from 'swiper'
import 'swiper/css'
import 'swiper/css/navigation'
import 'swiper/css/pagination'

const variants = {
    default: {
        spaceBetween: 40,
        centeredSlides: true,
        pagination: {
            clickable: true,
        },
    },
    bleedRight: {
        slidesPerView: 1,
        spaceBetween: 0,

        breakpoints: {
            616: {
                slidesPerView: 1.5,
                spaceBetween: 40,
            },
            1000: {
                slidesPerView: 1.75,
                spaceBetween: 40,
            },
            1200: {
                slidesPerView: 2.25,
                spaceBetween: 40,
            },
        },
    },
}

const currentVariant = computed(() => ({
    modules: [Keyboard, Navigation, Pagination],
    keyboard: {
        enabled: true,
    },
    ...variants[props.variant],
}))

const props = defineProps({
    variant: {
        type: String,
        default: 'default',
    },
})
</script>
