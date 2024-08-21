import { unref, onMounted } from 'vue'

/**
 * Default selector used for all focusable elements.
 */
const FOCUSABLE_SELECTOR = [
    'a[href]',
    'audio[controls]',
    'button',
    'details summary',
    'input',
    'map area[href]',
    'select',
    'svg a[xlink\\:href]',
    '[tabindex]',
    'textarea',
    'video[controls]',
].map(t => t + ':not([tabindex^="-"]):not([disabled])').join()

/**
 * Default key filters. These should be functions that 'filter out' what
 * elements should be considered when a key is hit.
 */
const KEY_FILTERS = {
    ArrowRight: elements => elements.filter(({ x, top, bottom }) => x > 0 && top < 0 && bottom > 0),
    ArrowLeft: elements => elements.filter(({ x, top, bottom }) => x < 0 && top < 0 && bottom > 0),
    ArrowDown: elements => elements.filter(({ y, left, right }) => y > 0 && left < 0 && right > 0),
    ArrowUp: elements => elements.filter(({ y, left, right }) => y < 0 && left < 0 && right > 0),
    Home: elements => elements.length && elements.slice(0, 1),
    End: elements => elements.length && elements.slice(-1),
}

/**
 * Retrieves where the element is drawn on screen (client rects).
 * Adds in x and y for the center of the element.
 */
const getElementRects = el => {
    const rects = el.getClientRects()[0]

    if (!rects || !rects.left) {
        return null
    }

    return {
        bottom: rects.bottom,
        height: rects.height,
        left: rects.left,
        right: rects.right,
        top: rects.top,
        width: rects.width,
        x: rects.left + rects.width / 2,
        y: rects.top + rects.height / 2,
    }
}

/**
 * Calls getElementRects for every element in nodeList, and adjust the
 * values to be relative to origin for simpler follow up math. Also
 * calculates the distance between the two elements' centers.
 */
const augmentElementRects = (nodeList, origin) => {
    const elements = []
    origin = getElementRects(origin)

    if (!origin) {
        return elements
    }

    nodeList.forEach(el => {
        const rects = getElementRects(el)
        if (rects === null) {
            return
        }

        rects.bottom -= origin.y
        rects.left -= origin.x
        rects.right -= origin.x
        rects.top -= origin.y
        rects.x -= origin.x
        rects.y -= origin.y

        const distance = Math.sqrt(rects.x * rects.x + rects.y * rects.y)

        elements.push({ el, ...rects, distance })
    })

    return elements
}

/**
 * Finds all focusable elements within and including el.
 */
const queryFocusableElements = el => {
    el = unref(el)
    const elements = [...el.querySelectorAll(FOCUSABLE_SELECTOR)]
    if (el.matches(FOCUSABLE_SELECTOR)) {
        elements.unshift(el)
    }

    return elements
}

/**
 * useDirectional() takes any number of rootElements that it searches for
 * focusable elements and handles directional arrow moves between. Also
 * supports Home and End.
 */
export default function useDirectional (...rootElements) {
    const findTarget = (el, key) => {
        const elements = augmentElementRects(rootElements.map(queryFocusableElements).flat(), el)
        if (key in KEY_FILTERS) {
            return KEY_FILTERS[key](elements).reduce(
                (closest, el) => {
                    return el.distance < closest.distance ? el : closest
                },
                { distance: Infinity }
            )
        }
        return null
    }

    const handler = evt => {
        const newTarget = findTarget(evt.target, evt.key)

        if (newTarget?.el) {
            evt.preventDefault()
            evt.stopPropagation()
            newTarget.el.focus()
        }
    }

    onMounted(() => {
        rootElements.forEach(el => {
            unref(el).addEventListener('keydown', handler)
        })
    })
}
