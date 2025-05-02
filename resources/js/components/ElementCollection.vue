<script setup>
import { computed, toValue, reactive } from 'vue'
import { useFetch, useUrlSearchParams } from '@vueuse/core'

const props = defineProps({
    url: {
        type: String,
        required: true,
    },
    querySync: {
        default: true,
    },
    initialValue: {
        type: Object,
        default: () => ({}),
    },
    only: {
        type: [Array, Boolean],
        default: false,
    },
    except: {
        type: Array,
        default: [],
    },
})

const params = props.querySync ? useUrlSearchParams('history') : reactive(props.initialValue)

const url = computed(() => {
    const nonNull = Object.fromEntries(Object.entries(toValue(params))
        .filter(([key, value]) => {
            return value != null
                && !props.except.includes(key)
                && (!props.only || props.only.includes(key))
        }))
    return `${props.url}?${new URLSearchParams(nonNull)}`
})

const response = useFetch(url, { refetch: true })
const result = computed(() => JSON.parse(response.data?.value ?? null))
</script>

<template>
    <slot
        v-bind="{
            ...result,
            params,
            isFetching: response?.isFetching,
            isFinished: response?.isFinished,
        }"
    />
</template>
