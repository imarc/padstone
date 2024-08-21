<template>
    <div :class="block">
        <button
            :id="`${id}-control`"
            :class="`${block}__${headerElement}`"
            :aria-expanded="`${isOpen}`"
            :aria-controls="id"
            @click="open"
        >
            <slot name="heading" />
            <slot name="icon">
                <svg
                    :class="[`${block}__${iconElement}`, { '-open': isOpen }]"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                    stroke="currentColor"
                    fill="none"
                >
                    <polyline points="6 9 12 15 18 9" />
                </svg>
            </slot>
        </button>
        <Transition
            name="accordion__transition"
            @enter="startTransition"
            @leave="endTransition"
        >
            <div
                v-if="isOpen"
                :id="id"
                ref="contentWrapper"
                :class="`${block}__${contentWrapperElement}`"
            >
                <div
                    ref="content"
                    :class="`${block}__${contentElement}`"
                    :aria-labelledby="`${id}-control`"
                >
                    <slot />
                </div>
            </div>
        </Transition>
    </div>
</template>

<script setup>
import { ref, nextTick } from 'vue'

defineProps({
    block: { type: String, default: 'accordion' },
    headerElement: { type: String, default: 'header' },
    iconElement: { type: String, default: 'icon' },
    contentElement: { type: String, default: 'content' },
    contentWrapperElement: { type: String, default: 'contentWrapper' },
    id: { type: String, default: () => Math.random().toString(36).substr(2) },
})

const isOpen = ref(false)
const content = ref(null)
const contentWrapper = ref(null)

const open = () => {
    isOpen.value = !isOpen.value
}

const startTransition = async (el) => {
    await nextTick()
    el.style.height = `${content.value.scrollHeight}px`
}

const endTransition = (el) => {
    el.removeAttribute('style')
}

addEventListener('resize', () => {
    if (!content.value) {
        return
    }

    const newHeight = `${content.value.scrollHeight}px`

    requestAnimationFrame(() => {
        contentWrapper.value.style.height = newHeight
    })
})
</script>
