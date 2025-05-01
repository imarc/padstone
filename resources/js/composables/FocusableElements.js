import { toValue } from 'vue'

const FOCUSABLE_SELECTOR = `:not([tabindex^="-"]):not([disabled]):is(a[href],audio[controls],button,details summary,input,map area[href],select,svg a[xlink\:href],[tabindex],textarea,video[controls])`

export default function focusableElements(element, includeSelf = true) {
  element = toValue(element)
  const elements = [...element.querySelectorAll(FOCUSABLE_SELECTOR)]
  if (includeSelf && element.matches(FOCUSABLE_SELECTOR)) {
    elements.unshift(element)
  }

  return elements
}
