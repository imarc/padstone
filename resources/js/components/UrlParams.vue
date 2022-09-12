<template>
    <slot
        :params="params"
        :set-param="setParam"
    />
</template>
<script setup>
import { useUrlSearchParams } from '@vueuse/core'

const params = useUrlSearchParams('history', { removeNullishValues: true })

const setParam = (key, value) => {
    params.value[key] = value
    return value
}
</script>
