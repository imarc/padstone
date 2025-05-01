export default {
  mounted() {
    document.documentElement.style.overflow = 'hidden'
  },
  unmounted() {
    document.documentElement.style.overflow = ''
  },
}
