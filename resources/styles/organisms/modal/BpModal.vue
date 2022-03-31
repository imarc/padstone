<template>
    <div :class="`${block}`">
        <slot
            name="open-button"
            :open-modal="openModal"
        >
            <button
                :class="`${block}__${openButtonElement}`"
                @click="openModal"
            >
                Open Modal
            </button>
        </slot>
        <MountingPortal
            v-if="open"
            mount-to="#modal"
            append
        >
            <div
                :class="`${block}__${overlayElement}`"
                @click="clickOut"
            >
                <div
                    ref="modalWrapper"
                    :class="`${block}__${wrapperElement}`"
                >
                    <div
                        ref="modalContainer"
                        :class="`${block}__${containerElement}`"
                    >
                        <div
                            ref="modalContent"
                            :class="`${block}__${contentElement}`"
                            tabindex="0"
                        >
                            <slot />
                        </div>
                        <slot
                            v-if="loading"
                            name="loading-spinner"
                            :loading="loading"
                        >
                            <img
                                :class="`${block}__${loadingSpinnerElement}`"
                                src="/media/spinner.gif"
                                alt=""
                            >
                        </slot>
                    </div>
                    <slot
                        name="close-button"
                        :close-modal="closeModal"
                    >
                        <button
                            :class="`${block}__${closeButtonElement}`"
                            @click="closeModal"
                        >
                            Close Modal
                            <svg
                                :class="`${block}__${closeButtonIconElement}`"
                                viewBox="0 0 320 512"
                            >
                                <path
                                    fill="currentColor"
                                    d="M193.94 256L296.5 153.44l21.15-21.15c3.12-3.12 3.12-8.19 0-11.31l-22.63-22.63c-3.12-3.12-8.19-3.12-11.31 0L160 222.06 36.29 98.34c-3.12-3.12-8.19-3.12-11.31 0L2.34 120.97c-3.12 3.12-3.12 8.19 0 11.31L126.06 256 2.34 379.71c-3.12 3.12-3.12 8.19 0 11.31l22.63 22.63c3.12 3.12 8.19 3.12 11.31 0L160 289.94 262.56 392.5l21.15 21.15c3.12 3.12 8.19 3.12 11.31 0l22.63-22.63c3.12-3.12 3.12-8.19 0-11.31L193.94 256z"
                                />
                            </svg>
                        </button>
                    </slot>
                </div>
            </div>
        </MountingPortal>
    </div>
</template>

<script>
export default {

    props: {
        block: {
            type: String,
            default: 'modal',
        },

        openButtonElement: {
            type: String,
            default: 'openButton',
        },

        overlayElement: {
            type: String,
            default: 'overlay',
        },

        containerElement: {
            type: String,
            default: 'container',
        },

        loadingSpinnerElement: {
            type: String,
            default: 'loadingSpinner',
        },

        contentElement: {
            type: String,
            default: 'content',
        },

        closeButtonElement: {
            type: String,
            default: 'closeButton',
        },

        wrapperElement: {
            type: String,
            default: 'wrapper',
        },

        closeButtonIconElement: {
            type: String,
            default: 'closeButtonIcon',
        },
    },

    data: () => ({
        open: false,
        loading: true,
    }),

    methods: {
        async openModal () {
            this.open = true
            this.lockScroll()
            window.addEventListener('keyup', this.keyboardEvent)
            await this.handleContent()
            this.loading = false
        },

        closeModal () {
            this.unlockScroll()
            this.open = false
        },

        handleContent () {
            return new Promise((resolve, reject) => {
                this.$nextTick(async () => {
                    const { modalContent } = this.$refs
                    const { innerHTML } = modalContent

                    const parsedDocument = this.htmlDecode(innerHTML)
                    const body = parsedDocument.querySelector('body')
                    const scripts = [...parsedDocument.querySelectorAll('script')]

                    scripts.forEach(script => script.remove())
                    modalContent.innerHTML = body.innerHTML

                    modalContent.focus()

                    if (scripts.length) {
                        await this.loadScripts(scripts)
                        resolve()
                    } else {
                        resolve()
                    }
                })
            })
        },

        htmlDecode (string) {
            const doc = new DOMParser().parseFromString(string, 'text/html')
            const body = doc.querySelector('body')
            body.innerHTML = doc.documentElement.textContent
            return doc
        },

        async loadScripts (scripts) {
            const scriptsWithSrc = scripts.filter(script => script.src)
            const inlineScripts = scripts.filter(script => !script.src)

            // inline scripts most likely rely on an external api, run first
            if (scriptsWithSrc.length) {
                await this.fetchExternalScripts(scriptsWithSrc)
            }

            if (inlineScripts.length) {
                this.runInlineScripts(inlineScripts)
            }
        },

        runInlineScripts (scripts) {
            scripts.forEach(inlineScript => {
                // eslint-disable-next-line no-eval
                eval(inlineScript.innerHTML)
            })
        },

        fetchExternalScripts (scripts) {
            return new Promise((resolve, reject) => {
                const scriptPromises = scripts.map(scriptTag => new Promise((resolve, reject) => {
                    const scriptEl = document.createElement('script')
                    scriptEl.onload = () => { resolve() }
                    scriptEl.src = scriptTag.src
                    document.body.appendChild(scriptEl)
                }))

                Promise.all(scriptPromises).then(resolve)
            })
        },

        lockScroll () {
            const { documentElement, body } = document
            documentElement.classList.add('-lock')
            body.classList.add('-lock')
        },

        unlockScroll () {
            const { documentElement, body } = document
            documentElement.classList.remove('-lock')
            body.classList.remove('-lock')
        },

        keyboardEvent ({ key }) {
            if (key === 'Escape') {
                window.removeEventListener('keyup', this.keyboardEvent)
                this.closeModal()
            }
        },

        clickOut ({ path }) {
            const { modalWrapper } = this.$refs

            if (!path.includes(modalWrapper)) {
                this.closeModal()
            }
        },
    },

}
</script>
