<template>
    <slot
        name="open-button"
        :open="open"
    />
    <teleport to="body">
        <div
            v-if="isOpen"
            :class="block"
        >
            <div
                :class="`${block}__${overlayElement}`"
            >
                <div
                    ref="modalWrapper"
                    :class="`${block}__${wrapperElement}`"
                >
                    <div
                        :class="`${block}__${containerElement}`"
                    >
                        <div
                            ref="modalContent"
                            :class="`${block}__${contentElement}`"
                            tabindex="0"
                        >
                            <slot />
                        </div>
                        <slot
                            v-if="loading"
                            name="loading-spinner"
                            :loading="loading"
                        >
                            <img
                                :class="`${block}__${loadingSpinnerElement}`"
                                src="/resources/media/spinner.gif"
                                alt=""
                            >
                        </slot>
                    </div>
                    <slot
                        name="close-button"
                        :close="close"
                    >
                        <button
                            :class="`${block}__${closeButtonElement}`"
                            @click="close"
                        >
                            Close Modal
                            <svg
                                :class="`${block}__${closeButtonIconElement}`"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                                fill="none"
                            >
                                <line
                                    x1="18"
                                    y1="6"
                                    x2="6"
                                    y2="18"
                                />
                                <line
                                    x1="6"
                                    y1="6"
                                    x2="18"
                                    y2="18"
                                />
                            </svg>
                        </button>
                    </slot>
                </div>
            </div>
        </div>
    </teleport>
</template>

<script setup>
import { nextTick, ref, watch } from 'vue'
import useOpenable from '@resources/js/components/UseOpenable.vue'
import useLazyEmbed from '@resources/js/components/UseLazyEmbed.js'

defineProps({
    block: {
        type: String,
        default: 'modal',
    },

    overlayElement: {
        type: String,
        default: 'overlay',
    },

    containerElement: {
        type: String,
        default: 'container',
    },

    loadingSpinnerElement: {
        type: String,
        default: 'loadingSpinner',
    },

    contentElement: {
        type: String,
        default: 'content',
    },

    closeButtonElement: {
        type: String,
        default: 'closeButton',
    },

    wrapperElement: {
        type: String,
        default: 'wrapper',
    },

    closeButtonIconElement: {
        type: String,
        default: 'closeButtonIcon',
    },
})

const loading = ref(false)
const modalContent = ref(null)
const modalWrapper = ref(null)

const { isOpen, open, close } = useOpenable(modalWrapper)
const { loadEmbed } = useLazyEmbed(modalContent)

watch(isOpen, async isOpen => {
    if (isOpen) {
        loading.value = true
        lockScroll()
        await nextTick(loadEmbed)
    } else {
        unlockScroll()
    }

    loading.value = false
})

const lockScroll = () => {
    document.documentElement.classList.add('-lock')
}

const unlockScroll = () => {
    document.documentElement.classList.remove('-lock')
}
</script>
