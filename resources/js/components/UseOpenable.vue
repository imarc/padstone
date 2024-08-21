<script>
import { nextTick, ref } from 'vue'

/**
 * constant list of tags that we don't want to block default behavior for mouse
 * clicks we don't want to suppress.
 */
const TAGS_WITH_DEFAULT_BEHAVIOR = ['A', 'BUTTON', 'IFRAME', 'INPUT', 'TEXTAREA', 'VIDEO', 'MAP', 'OBJECT']

/**
 * UseOpenable is a composable component for 'openable' components such as
 * modals and dropdowns. It provides methods for handling focus, keyboard
 * events, hover and delayed close.
 */
export default function useOpenable (el, focusOnClose = null) {
    let timeout = null
    const isOpen = ref(false)

    /**
     * Runs open() if it's closed, and close() if it's open.
     */
    const toggle = () => {
        if (isOpen.value) {
            close()
        } else {
            open()
        }
    }

    /**
     * Opens the component, changing `isOpen` to true and setting up event listeners.
     */
    const open = () => {
        if (isOpen.value) {
            return
        }

        isOpen.value = true
        addEventListener('focusout', checkFocus)
        addEventListener('keydown', checkKeydown)
        nextTick(() => {
            el.value.addEventListener('mousedown', checkMousedown)
        })
    }

    /**
     * Closes the component, changing `isOpen` to false and remove listeners.
     */
    const close = () => {
        if (!isOpen.value) {
            return
        }

        clearTimeout(timeout)

        isOpen.value = false
        removeEventListener('focusout', checkFocus)
        removeEventListener('keydown', checkKeydown)
        el.value.removeEventListener('mousedown', checkMousedown)
    }

    /**
     * delayClose runs close after `delay` milliseconds. Used for components
     * that close on mouseleave to make them more forgiving.
     */
    const delayClose = delay => {
        clearTimeout(timeout)
        timeout = setTimeout(close, delay)
    }

    /**
     * keepOpen cancels a delayClose()
     */
    const keepOpen = () => clearTimeout(timeout)

    /**
     * Internal - checks if the currently focused element is outside of this
     * component, and if so, closes the component.
     */
    const checkFocus = (event) => {
        if (isOpen.value && !el.value.contains(event.relatedTarget)) {
            close()
        }
    }

    /**
     * Internal - if a mousedown event has fired on an unfocusable element
     * within this component, prevents the default behavior of changing the
     * browser's focus to body.
     */
    const checkMousedown = (event) => {
        if (!TAGS_WITH_DEFAULT_BEHAVIOR.includes(event.target.tagName)) {
            event.preventDefault()
            event.target.focus()
        }
    }

    /**
     * Internal - closes this component if escape is pressed.
     */
    const checkKeydown = (event) => {
        if (event.key === 'Escape') {
            close()
            if (focusOnClose) {
                focusOnClose.value.focus()
            }
        }
    }

    return {
        close,
        delayClose,
        isOpen,
        keepOpen,
        open,
        toggle,
    }
}
</script>
