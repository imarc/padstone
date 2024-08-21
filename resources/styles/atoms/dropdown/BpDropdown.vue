<template>
    <div
        class="dropdown"
        :class="{'-open': isOpen}"
    >
        <button
            ref="button"
            :aria-controls="id"
            :aria-expanded="String(isOpen)"
            class="dropdown__button"
            :class="labelClass"
            @click.prevent="toggle"
        >
            <slot name="button">
                {{ label }}
                <svg
                    class="dropdown__icon"
                    viewBox="0 0 24 24"
                    stroke-width="1"
                    stroke="currentColor"
                    fill="none"
                ><polyline points="6 9 12 15 18 9" /></svg>
            </slot>
        </button>
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
const button = ref(null)

defineProps({
    id: { type: String, required: true },
    label: { type: String, required: true },
    labelClass: { type: String, default: '' },
    transition: { type: String, default: 'dropdown__transition' },
})

const { isOpen, toggle } = useOpenable(dropdown, button)

</script>
