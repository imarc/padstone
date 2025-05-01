<script setup>
import { useSlots } from 'vue'
import useDirectionalKeys from '../composables/UseDirectionalKeys.js'

const slots = useSlots()

const test = evt => {
  console.log('test', evt)
}

//useDirectionalKeys(...slots.default())
</script>
<template>
  <slot @keydown="test" @click="test" />
</template>
