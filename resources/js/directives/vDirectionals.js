import focusableElements from '../composables/FocusableElements.js'

/**
 * Default key filters. These should be functions that 'filter out' what
 * elements should be considered when a key is hit.
 */
const KEY_BINDINGS = {
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
  if (!el) {
    console.error("Unable to determine location of element", el);
    return null
  }

  const rects = el.getClientRects()[0]

  if (!rects) {
    return getElementRects(el.parentElement)
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

const findTarget = (el, key, root) => {
  const elements = augmentElementRects(focusableElements(root), el)
  if (key in KEY_BINDINGS) {
    const { el } = KEY_BINDINGS[key](elements).reduce(
      (closest, el) => {
        return el.distance < closest.distance ? el : closest
      },
      { distance: Infinity }
    )

    return el
  }
  return null
}

export default {
  mounted(element) {
    const handler = evt => {
      const target = findTarget(evt.target, evt.key, element)

      if (target) {
        evt.preventDefault()
        evt.stopPropagation()
        target.focus()
      }
    }
    element.addEventListener('keydown', handler)
  },
}
