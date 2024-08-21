/**
 * BpClickable is a functional component for making the clickable target for a
 * link or button tied to more elements.
 */
const BpClickable = function (props, { slots }) {
    const click = () => querySelector(props.selector)?.click()
    const vnodes = slots.default({ click })

    const querySelector = selector => {
        for (const vnode of vnodes) {
            const el = vnode.el?.querySelector?.(selector)
            if (el) {
                return el
            }
        }
    }

    vnodes.forEach(vnode => {
        vnode.props.onClick = click
    })

    return vnodes
}

BpClickable.props = {
    selector: {
        type: String,
        default: () => '[data-clickable]',
    },
}

export default BpClickable
