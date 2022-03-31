<template>
    <swiper
        ref="mySwiper"
        :options="swiperOptions"
        class="foobar"
    >
        <slot
            v-for="(_, name) in $slots"
            :slot="name"
            :name="name"
        />
    </swiper>
</template>
<script>
import { Swiper, directive } from 'vue-awesome-swiper'
import 'swiper/css/swiper.css'

const variants = {
    default: {
        spaceBetween: 40,
        centeredSlides: true,
        pagination: {
            el: '.swiper-pagination',
        },
    },
    bleedRight: {
        slidesPerView: 1,
        spaceBetween: 40,

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

export default {
    components: {
        Swiper,
    },
    directives: {
        swiper: directive,
    },
    props: {
        variant: {
            type: String,
            default: 'default',
        },
        swiperOptions: {
            type: Object,
            default () {
                return {
                    keyboard: {
                        enabled: true,
                    },
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    ...variants[this.variant],
                }
            },
        },
    },
}
</script>
