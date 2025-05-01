<script>
  import { ref, useTemplateRef } from 'vue'

  const YT_API_LOADED = ref(false)

  window.onYouTubeIframeAPIReady = () => YT_API_LOADED.value = true
</script>

<script setup>
  import { computed, onMounted, ref, useTemplateRef, watchEffect } from 'vue'

  let player = null
  const mediaEl = useTemplateRef('video')
  const mounted = ref(false)
  const loaded = ref(false)
  const modifier = computed(() => loaded.value ? '-loaded' : '')

  if (typeof window?.YT?.Player === 'undefined') {
    const yt = document.createElement('script')
    yt.src = 'https:///www.youtube.com/iframe_api'
    document.body.append(yt)
  }

  onMounted(() => mounted.value = true)
  watchEffect(() => {
    if (mounted.value && YT_API_LOADED.value) {
      player = new YT.Player(mediaEl.value.querySelector('iframe'))
    }
  })

  const playPause = () => {
    loaded.value = true

    const iframe = mediaEl.value.querySelector('iframe')
    if (iframe.getAttribute('tabindex') == -1) {
      iframe.removeAttribute('tabindex')
    }

    if (player.getPlayerState() === 1) {
      player.pauseVideo()
    } else {
      player.playVideo()
    }
  }
</script>

<template>
  <div ref="video"><slot name="default" /></div>
  <slot name="placeholder" v-bind="{ playPause, loaded, modifier }">
    <button @click="playPause">play</button>
  </slot>
</template>

<style scoped>
div {
  container-type: size;
}
</style>
