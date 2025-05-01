<script setup>
import { ref } from 'vue'

const { name } = defineProps({ name: { type: String } })

const open = ref(name ? sessionStorage[name] !== 'dismissed' : true)

const close = () => {
  open.value = false
  if (name) {
    sessionStorage[name] = 'dismissed'
  }
}
</script>

<template>
  <div v-if="open" @close="close">
    <slot :close="close" />
  </div>
</template>
