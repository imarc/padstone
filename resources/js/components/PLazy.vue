<script setup>
  import { computed, ref, nextTick, useTemplateRef } from 'vue'

  /**
   * PLazy is a vue component that lazy loads its content after it's been clicked.
   *
   * @slot default - the content to lazyload. It will remove inert attributes, change data-src
   *                 attributes to src attributes, and call .load() on videos.
   * @slot placeholder - the content to display before it's lazyloaded. The following properties
   *                     are exposed to this slot:
   *       load {function} - function to call to load the content.
   *       loaded {boolean} - whether the content is loaded or not.
   *       modifier {string} - either '-loaded' or '' based on loaded.
   */

  const loaded = ref(false)
  const content = useTemplateRef('content')
  const modifier = computed(() => loaded.value ? '-loaded' : '')

  const load = async () => {
    if (loaded.value) return

    await nextTick()

    const promises = []

    /* Change data-src attributes to src attributes */
    content.value.querySelectorAll('[data-src]')
      .forEach(element => element.setAttribute('src', element.dataset.src))

    /* remove inert attribute */
    content.value.querySelectorAll('[inert]')
      .forEach(element => element.inert = false)

    /* load videos */
    content.value.querySelectorAll('video')
      .forEach(element => {
        element.load()
        promises.push(new Promise(resolve => {
          element.addEventListener('loadeddata', resolve, { once: true })
        }))
      })

    /* load iframes */
    content.value.querySelectorAll('iframe')
      .forEach(element => {
        promises.push(new Promise(resolve => {
          element.addEventListener('load', resolve, { once: true })
        }))
      })

    /* wait for all videos and iframes to load, then update loaded.value */
    Promise.all(promises).then(() => loaded.value = true)
  }
</script>

<template>
  <div ref="content">
    <slot name="default"></slot>
  </div>
  <slot name="placeholder" v-bind="{ load, loaded, modifier }"></slot>
</template>

<style scoped>
div {
  container-type: size;
}
</style>
