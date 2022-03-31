<template>
    <section :class="`${block}`">
        <nav :class="`${block}__${navElement}`">
            <ul :class="`${block}__${navListElement}`">
                <li
                    v-for="(tabTitle, tab) in tabs"
                    :key="tab"
                    :class="[`${block}__${tabElement}`, isActive(tab)]"
                >
                    <button
                        :id="tab"
                        :tabindex="isFocusedTab(tab) ? '0' : '-1'"
                        :class="`${block}__${buttonElement}`"
                        role="button"
                        :aria-selected="`${isActive(tab)}`"
                        :aria-controls="`${tab}-panel`"
                        @click="selectTab(tab)"
                        @keyup.enter="selectTab(tab)"
                        @keyup.space="selectTab(tab)"
                        @keyup.right="vertical ? null : navigateNextTab($event)"
                        @keyup.left="vertical ? null : navigatePrevTab($event)"
                        @keydown.down="vertical ? navigateNextTab($event) : null"
                        @keydown.up="vertical ? navigatePrevTab($event) : null"
                        @focus="setFocusTab(tab)"
                        v-text="tabTitle"
                    />
                </li>
            </ul>
        </nav>
        <div
            v-for="(tabTitle, tab) in tabs"
            v-show="isActiveTab(tab)"
            :id="`${tab}-panel`"
            :key="tab"
            tabindex="0"
            :class="`${block}__${panelElement}`"
            :hidden="!isActiveTab(tab)"
            :aria-labelledby="tab"
        >
            <slot :name="`tab-panel-${tab}`" />
        </div>
    </section>
</template>

<script>
export default {

    props: {
        block: {
            type: String,
            default: 'tabs',
        },
        navElement: {
            type: String,
            default: 'header',
        },
        navListElement: {
            type: String,
            default: 'list',
        },
        tabElement: {
            type: String,
            default: 'tab',
        },
        buttonElement: {
            type: String,
            default: 'button',
        },
        panelElement: {
            type: String,
            default: 'panel',
        },
        activeClass: {
            type: String,
            default: '-active',
        },
        tabs: {
            type: Object,
            required: true,
        },
        initialTab: {
            type: String,
            default () {
                const [firstTab] = Object.keys(this.tabs)

                return firstTab
            },
        },
        setHash: {
            type: Boolean,
            default: true,
        },
        vertical: {
            type: Boolean,
            default: false,
        },
        wrap: {
            type: Boolean,
            default() {
                return !this.vertical;
            },
        }
    },

    data () {
        return {
            activeTab: '',
            currentFocusTab: '',
        }
    },

    computed: {
        tabKeys () {
            return Object.keys(this.tabs)
        },
        firstTabKey () {
            return this.tabKeys[0]
        },
        lastTabKey () {
            return this.tabKeys[this.tabKeys.length - 1]
        },
        currentFocusTabIndex () {
            return this.tabKeys.indexOf(this.currentFocusTab)
        },
        nextTabKey () {
            return this.currentFocusTab === this.lastTabKey
                ? (this.wrap ? this.firstTabKey : null)
                : this.tabKeys[this.currentFocusTabIndex + 1]
        },
        prevTabKey () {
            return this.currentFocusTabIndex === 0
                ? (this.wrap ? this.lastTabKey : null)
                : this.tabKeys[this.currentFocusTabIndex - 1]
        },
    },

    mounted () {
        this.setInitFocusTab()
        this.setInitActiveTab()
        this.attachKeyboardListeners()
    },

    methods: {
        setInitActiveTab () {
            if (location.hash && this.tabKeys.indexOf(location.hash.substr(1)) !== -1) {
                this.activeTab = location.hash.substr(1)
            } else if (this.initialTab) {
                this.activeTab = this.initialTab
            } else {
                [this.activeTab] = this.tabs
            }
        },
        setFocusTab (tab) {
            this.currentFocusTab = tab
            this.selectTab(tab)
        },
        setInitFocusTab () {
            this.currentFocusTab = this.initialTab
        },
        selectTab (tab) {
            this.activeTab = tab
            if (this.setHash) {
                history.replaceState(undefined, undefined, `#${this.activeTab}`)
            }
        },
        isActive (tab) {
            return tab === this.activeTab ? this.activeClass : ''
        },
        isActiveTab (tab) {
            return this.activeTab === tab
        },
        isFocusedTab (tab) {
            return this.currentFocusTab === tab
        },
        navigateNextTab (evt) {
            if (this.nextTabKey) {
                evt.preventDefault();
                const nextTabButton = this.$el.querySelector(`[id="${this.nextTabKey}"]`)
                nextTabButton.focus()
            }
        },
        navigatePrevTab (evt) {
            if (this.prevTabKey) {
                evt.preventDefault();
                const prevTabButton = this.$el.querySelector(`[id="${this.prevTabKey}"]`)
                prevTabButton.focus()
            }
        },
        attachKeyboardListeners () {
            const firstTabEl = this.$el.querySelector(`[id="${this.firstTabKey}"]`)
            const lastTabEl = this.$el.querySelector(`[id="${this.lastTabKey}"]`)

            this.$el.addEventListener('keydown', event => {
                if (event.keyCode === 36) {
                    event.preventDefault()

                    firstTabEl.focus()
                    this.activeTab = this.firstTabKey
                }

                if (event.keyCode === 35) {
                    event.preventDefault()

                    lastTabEl.focus()
                    this.activeTab = this.lastTabKey
                }
            })
        },
    },

}
</script>
