<template>
    <slot
        v-if="!isDismissed"
        :dismiss="dismiss"
    />
</template>
<script setup>
import { ref } from 'vue'
import useStorage from '@resources/js/components/UseStorage.js'

const props = defineProps({
    storageKey: {
        type: String,
        required: true,
    },
    expiration: {
        type: Number,
        default: 604800000,
    },
})

const isDismissed = ref(false)
const expiresAt = ref(undefined)

useStorage(isDismissed, props.storageKey)
useStorage(expiresAt, `${props.storageKey}__expiresAt`)

if (isDismissed.value && (!expiresAt.value || expiresAt.value < (new Date()).getTime())) {
    isDismissed.value = false
    expiresAt.value = undefined
}

const dismiss = () => {
    expiresAt.value = (new Date()).getTime() + props.expiration
    isDismissed.value = true
}
</script>
