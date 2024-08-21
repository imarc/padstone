<template>
    <nav ref="nav">
        <slot />
    </nav>
</template>
<script setup>
import { ref } from 'vue'
import useDirectional from '@resources/js/components/UseDirectional.js'

const nav = ref(null)
useDirectional(nav)
</script>
