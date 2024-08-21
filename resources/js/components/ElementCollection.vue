<template>
    <slot
        v-bind="{
            elements: result?.data,
            meta: result?.meta,
            isFetching: response?.isFetching,
            isFinished: response?.isFinished,
        }"
    />
</template>
<script setup>
import { computed, useSlots, useAttrs } from 'vue'
import { useFetch } from '@vueuse/core'

const props = defineProps({
    url: {
        type: String,
        required: true,
    },
    params: {
        type: Object,
        default: () => ({}),
    },
})

const url = computed(() => {
    const nonNull = Object.fromEntries(Object.entries(props.params).filter(([_, v]) => v != null))
    return `${props.url}?${(new URLSearchParams(nonNull)).toString()}`
})
const response = useFetch(url, { refetch: true })
const result = computed(() => response.data?.value ? JSON.parse(response.data.value) : null)
</script>
