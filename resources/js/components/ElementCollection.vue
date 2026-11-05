<script setup>
import { computed, toValue, reactive, isRef, isReactive, watch } from 'vue'
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

// Changing a filter invalidates the current page.
watch(() => JSON.stringify({ ...params, page: undefined }), () => {
    delete params.page
})

const url = computed(() => {
    const nonNull = Object.fromEntries(Object.entries(toValue(params))
        .filter(([key, value]) => {
            return value != null
                && !props.except.includes(key)
                && (!props.only || props.only.includes(key))
        }))
    return `${props.url}?${new URLSearchParams(nonNull)}`
})

const response = useFetch(url, { refetch: true }).get().json()

const slotProps = computed(() => ({
  response,
  noResults: response.isFinished.value && (!response.data.value?.data || response.data.value.data.length == 0),
  data: response.data.value?.data || [],
  meta: response.data.value?.meta,
  params,
}))
</script>

<template><slot v-bind="slotProps" /></template>
