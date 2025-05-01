<script>
  const openableGroups = {}
</script>

<script setup>
import { ref, nextTick, useSlots, useTemplateRef } from 'vue'

import focusableElements from '../composables/FocusableElements.js'

const {
  closeOnBlur,
  refocus,
  label,
  name,
  openOnHover,
  hoverOrClick
} = defineProps({
  closeOnBlur: { type: Boolean, default: true },
  refocus: { type: Boolean, default: true },
  label: { type: String, default: "" },
  name: { type: String, default: "global" },
  openOnHover: { type: Boolean, default: false },
  hoverOrClick: { type: Boolean, default: false },
})
const emit = defineEmits(['open', 'close'])
const slots = useSlots()
const button = useTemplateRef('button')
const openable = useTemplateRef('openable')
const open = ref(false)

const targetOutside = evt => {
  if (openable.value && !openable.value.contains(evt.target)) {
    toggle()
  }
}

const pressEscape = evt => {
  if (evt.key === 'Escape') {
    evt.stopPropagation()
    toggle()
  }
}

let escapeHandler = null

const updateGroup = (open) => {
  if (!name) {
    return
  }

  if (!(name in openableGroups)) {
    openableGroups[name] = new Set()
  }

  if (open) {
    openableGroups[name].forEach(t => t())
    openableGroups[name].add(toggle)
  } else {
    openableGroups[name].delete(toggle)
  }
}

const toggle = (evt, { noFocus = false } = {}) => {
  evt?.stopPropagation()
  emit(open.value ? 'close' : 'open')
  open.value = !open.value
  updateGroup(open.value)
  nextTick(() => {
    if (open.value) {
      if (refocus && !noFocus) {
        focusableElements(openable)?.[0].focus()
      }

      document.documentElement.addEventListener('click', targetOutside)
      openable.value.addEventListener('keydown', pressEscape)

      if (closeOnBlur) {
        document.documentElement.addEventListener('focusin', targetOutside)
      }
    } else {
      document.documentElement.removeEventListener('click', targetOutside)
      openable.value.removeEventListener('keydown', pressEscape)

      if (closeOnBlur) {
        document.documentElement.removeEventListener('focusin', targetOutside)
      }

      if (refocus && !noFocus) {
        focusableElements(button)?.[0].focus()
      }
    }
  })
}


let timeout = null

const mouseover = () => {
  if (timeout) {
    clearTimeout(timeout)
  }

  timeout = setTimeout(() => {
    if (!open.value) {
      toggle(undefined, { noFocus: true })
    }
  }, 450)
}

const mouseout = () => {
  if (timeout) {
    clearTimeout(timeout)
  }

  timeout = setTimeout(() => {
    if (open.value) {
      toggle(undefined, { noFocus: true })
    }
  }, 450)
}

const keypress = evt => {
  if (evt.key == ' ' || evt.key == 'Enter') {
    toggle()
  }
}

let bindings = { click: toggle }
if (openOnHover) {
  bindings = { mouseover, mouseout, keypress }
} if (hoverOrClick) {
  bindings = { click: toggle, mouseover, mouseout }
}

</script>

<template>
  <button v-bind="$attrs" ref="button" v-on="bindings">
    <slot name="toggle" v-bind="bindings">{{ label }}</slot>
  </button>
  <div ref="openable" v-on="(openOnHover || hoverOrClick) ? { mouseover, mouseout } : {}">
    <slot v-if="open" v-bind="bindings" />
  </div>
</template>
