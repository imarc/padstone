/**
 * UseLazyEmbed is a composable component that provides a single method,
 * loadEmbed, that takes the encoded contents of an element, decodes and readds
 * them to the DOM. Useful for lazyloading things like HTML widgets or embeds.
 */
export default function useLazyEmbed (el) {
    /**
     * Asynchronous method that loads the contents of the element.
     */
    const loadEmbed = async () => {
        const embed = parseEmbed(el.value.innerHTML)
        const scripts = [...embed.querySelectorAll('script')]
        scripts.forEach(script => script.remove())

        const markup = embed.querySelector('body')
        el.value.innerHTML = markup.innerHTML

        if (scripts.length) {
            await loadScripts(scripts)
        }

        el.value.focus()
    }

    /**
     * Internal - parses and decodes and encoded contents of the element.
     */
    const parseEmbed = string => {
        const doc = new DOMParser().parseFromString(string, 'text/html')
        doc.body.innerHTML = doc.body.textContent
        return doc
    }

    /**
     * Internal - asynchronous method to handle script tags within the element.
     * First all script tags with src attributes are loaded, then other script
     * tags are run inline.
     */
    const loadScripts = async scripts => {
        const scriptsWithSrc = scripts.filter(script => script.src)
        const inlineScripts = scripts.filter(script => !script.src)

        // inline scripts most likely rely on an external api, run first
        if (scriptsWithSrc.length) {
            await fetchExternalScripts(scriptsWithSrc)
        }

        if (inlineScripts.length) {
            runInlineScripts(inlineScripts)
        }
    }

    /**
     * Internal - fetches and adds external scripts to the DOM.
     */
    const fetchExternalScripts = scripts => {
        return Promise.all(
            scripts.map(tag => new Promise(resolve => {
                const el = document.createElement('script')
                el.onload = resolve
                el.src = tag.src
                document.body.appendChild(el)
            }))
        )
    }

    /**
     * Internal - runs inline scripts via eval().
     */
    const runInlineScripts = scripts => {
        scripts.forEach(inlineScript => {
            // eslint-disable-next-line no-eval
            eval(inlineScript.innerHTML)
        })
    }

    return { loadEmbed }
}
