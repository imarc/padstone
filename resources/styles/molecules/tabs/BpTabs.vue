<template>
    <section
        ref="tabSection"
        :class="`${block}`"
    >
        <nav :class="`${block}__${navElement}`">
            <ul :class="`${block}__${navListElement}`">
                <li
                    v-for="(tabTitle, tab) in tabs"
                    :key="tab"
                    :class="[`${block}__${tabElement}`, isActive(tab)]"
                >
                    <button
                        :id="tab"
                        :tabindex="isActive(tab) ? '0' : '-1'"
                        :class="`${block}__${buttonElement}`"
                        role="button"
                        :aria-selected="`${isActive(tab)}`"
                        :aria-controls="`${tab}-panel`"
                        v-text="tabTitle"
                    />
                </li>
            </ul>
        </nav>
        <div
            v-for="(tabTitle, tab) in tabs"
            :id="`${tab}-panel`"
            :key="tab"
            tabindex="0"
            :class="`${block}__${panelElement}`"
            :hidden="!isActive(tab)"
            :aria-labelledby="tab"
        >
            <div v-if="isActiveItem(tab)">
                <slot :name="`tab-panel-${tab}`" />
            </div>
        </div>
    </section>
</template>

<script setup>

import { ref } from 'vue'

import useExpandable from '@resources/js/components/UseExpandable.js'

const tabSection = ref(null)

const props = defineProps({
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
        default (props) {
            const [firstTab] = Object.keys(props.tabs)
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
        default (props) {
            return !props.vertical
        },
    },
})

function isActive (tab) {
    return tab === activeItem.value ? props.activeClass : ''
}
function isActiveItem (tab) {
    return activeItem.value === tab
}

const { activeItem } = useExpandable(tabSection,
    props.tabs,
    {
        initialItem: props.initialTab,
        setHash: props.setHash,
        wrap: props.wrap,
        vertical: props.vertical,
    }
)

</script>
