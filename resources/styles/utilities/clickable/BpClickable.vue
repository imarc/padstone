<script>

/**
 * Renderless component for making a larger element clickable.
 *
 * Example:
 *
 *     <bp-clickable v-slot="{ click }">
 *         <div @click="click($event, $refs.link)">
 *             <!-- ... -->
 *             <a ref="link" href="...">...</a>
 *         </div>
 *     </bp-clickable>
 *
 */
export default {
    methods: {
        click (evt, link) {
            if (evt.target.tagName === 'A') {
                return
            }

            let url = null
            if (typeof (link) === 'string') {
                url = link
            } else if (link instanceof Node) {
                url = link.getAttribute('href')
            }

            evt.preventDefault()
            window.location = url
        },
    },
    render () {
        return this.$scopedSlots.default({
            click: this.click,
        })
    },
}
</script>
