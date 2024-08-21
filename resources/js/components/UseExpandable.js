import { ref, unref, computed, onMounted } from 'vue'

export default function useExpandable (itemSection, items,
    {
        initialItem = null,
        setHash = true,
        wrap = true,
        vertical = false,
    } = {}) {
    const activeItem = ref('')
    const currentFocusItem = ref('')

    const itemKeys = computed(() => Object.keys(items))
    const firstItemKey = computed(() => itemKeys.value[0])
    const lastItemKey = computed(() => itemKeys.value[itemKeys.value.length - 1])
    const currentFocusItemIndex = computed(() => itemKeys.value.indexOf(currentFocusItem.value))

    const nextItemKey = computed(() => {
        return currentFocusItem.value === lastItemKey.value
            ? (wrap ? firstItemKey.value : null)
            : itemKeys.value[currentFocusItemIndex.value + 1]
    })

    const prevItemKey = computed(() => {
        return currentFocusItemIndex.value === 0
            ? (wrap ? lastItemKey.value : null)
            : itemKeys.value[currentFocusItemIndex.value - 1]
    })

    const navigateNextItem = (evt) => {
        if (nextItemKey.value) {
            evt.preventDefault()
            const nextItemButton = unref(itemSection).querySelector(`[id="${nextItemKey.value}"]`)
            nextItemButton.click()
        }
    }

    const navigatePrevItem = (evt) => {
        if (prevItemKey.value) {
            evt.preventDefault()
            const prevItemButton = unref(itemSection).querySelector(`[id="${prevItemKey.value}"]`)
            prevItemButton.click()
        }
    }

    const setInitActiveItem = () => {
        if (location.hash && itemKeys.value.indexOf(location.hash.substr(1)) !== -1) {
            activeItem.value = location.hash.substr(1)
        } else if (initialItem) {
            activeItem.value = initialItem
        } else {
            [activeItem.value] = items
        }
    }

    const attachEventListeners = () => {
        const firstItemEl = unref(itemSection).querySelector(`[id="${firstItemKey.value}"]`)
        const lastItemEl = unref(itemSection).querySelector(`[id="${lastItemKey.value}"]`)

        unref(itemSection).addEventListener('click', event => {
            if (event.target.id) {
                event.preventDefault()
                event.target.focus()
                selectItem(event.target.id)
            }
        })

        unref(itemSection).addEventListener('keydown', event => {
            // Home
            if (event.keyCode === 36) {
                event.preventDefault()
                firstItemEl.focus()
                activeItem.value = firstItemKey.value
            }
            // End
            if (event.keyCode === 35) {
                event.preventDefault()
                lastItemEl.focus()
                activeItem.value = lastItemKey.value
            }
            // Left - 37
            if (event.keyCode === 37) {
                if (!vertical) {
                    event.preventDefault()
                    navigatePrevItem(event)
                }
            }
            // Right - 39
            if (event.keyCode === 39) {
                event.preventDefault()
                if (!vertical) {
                    navigateNextItem(event)
                }
            }
            // Up - 38
            if (event.keyCode === 38) {
                if (vertical) {
                    event.preventDefault()
                    navigatePrevItem(event)
                }
            }
            // Down - 40
            if (event.keyCode === 40) {
                if (vertical) {
                    event.preventDefault()
                    navigateNextItem(event)
                }
            }
        })
    }

    const setFocusItem = (item) => {
        currentFocusItem.value = item
    }

    const setInitFocusItem = () => {
        currentFocusItem.value = initialItem
    }

    const selectItem = (item) => {
        activeItem.value = item
        setFocusItem(item)
        if (setHash) {
            history.replaceState(undefined, undefined, `#${activeItem.value}`)
        }
    }

    onMounted(() => {
        setInitFocusItem()
        setInitActiveItem()
        attachEventListeners()
    })
    return {
        activeItem,
    }
}
