import { ref, toValue, watchEffect } from 'vue'

export default function focusWithArrows(
  elements,
  {
    includeHomeEnd = true,
  } = {}
) {

  const KEY_BEHAVIORS = {
    ArrowLeft: i => Math.max(0, i - 1),
    ArrowRight: i => Math.min(handledElements.length - 1, i + 1),
  }

  if (includeHomeEnd) {
    KEY_BEHAVIORS.Home = () => 0
    KEY_BEHAVIORS.End = () => handledElements.length - 1
  }

  const focus = ref(null)

  const handleKeydown = event => {
    if (event.key in KEY_BEHAVIORS) {
      event.preventDefault()
      const i = handledElements.indexOf(event.target)

      focus.value = handledElements[KEY_BEHAVIORS[event.key](i)]
      focus.value.focus()
    }
  }

  const handledElements = []

  watchEffect(() => {
    (toValue(elements) || [])
      .filter(elem => !handledElements.includes(elem))
      .forEach(elem => {
        elem.addEventListener('keydown', handleKeydown)
        elem.addEventListener('focus', event => {
          focus.value = event.target
          event.target.addEventListener('blur', () => focus.value = null, { once: true })
        })
        handledElements.push(elem)

        if (document.activeElement === elem) {
          focus.value = elem
        }
      })
  })

  return focus
}
