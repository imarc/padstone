<template>
    <div
        ref="dropdown"
        class="dropdown"
        :class="{'-open': isOpen}"
    >
        <a
            ref="link"
            :aria-controls="id"
            :aria-expanded="String(isOpen)"
            class="dropdown__link"
            :class="labelClass"
            :href="href"
            @click.prevent="toggle"
        >
            <slot name="link">
                {{ label }}
                <svg
                    class="dropdown__icon"
                    viewBox="0 0 24 24"
                    stroke-width="1"
                    stroke="currentColor"
                    fill="none"
                ><polyline points="6 9 12 15 18 9" /></svg>
            </slot>
        </a>
        <div
            v-show="isOpen"
            :id="id"
            ref="dropdown"
            class="dropdown__content"
        >
            <slot />
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import useOpenable from '@resources/js/components/UseOpenable.vue'

const dropdown = ref(null)
const link = ref(null)

defineProps({
    delay: { type: Number, default: 0 },
    hoverable: { type: Boolean, default: false },
    href: { type: String, required: true },
    id: { type: String, required: true },
    label: { type: String, required: true },
    labelClass: { type: String, default: '' },
    transition: { type: String, default: 'dropdown__transition' },
})

const { toggle, isOpen } = useOpenable(dropdown, link)

</script>
