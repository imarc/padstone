<template>
    <div :class="[block, isOpen ? '-open' : '-closed' ]">
        <header>
            <div
                :id="`${id}-control`"
                :class="`${block}__${headerElement}`"
                :aria-expanded="`${isOpen}`"
                :aria-controls="id"
                tabindex="0"
                role="button"
                @click="open"
                @keyup.enter="open"
            >
                <slot name="heading" />
                <slot name="icon">
                    <svg :class="`${block}__icon`" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none">
                        <polyline points="6 9 12 15 18 9" />
                    </svg>
                </slot>
            </div>
        </header>
        <transition
            name="accordion__transition"
            @enter="startTransition"
            @after-enter="endTransition"
            @before-leave="startTransition"
            @after-leave="endTransition"
        >
            <div
                v-if="isOpen"
                :id="id"
                ref="content"
                :class="`${block}__${contentElement}`"
                :aria-labelledby="`${id}-control`"
            >
                <slot />
            </div>
        </transition>
    </div>
</template>
<script>
export default {
    props: {
        block: {
            type: String,
            default: 'accordion',
        },
        headerElement: {
            type: String,
            default: 'header',
        },
        contentElement: {
            type: String,
            default: 'content',
        },
        id: {
            type: String,
            default: () => Math.random().toString(36).substr(2),
        },
    },
    data: () => ({ isOpen: false }),
    methods: {
        open () {
            this.isOpen = !this.isOpen
        },

        /**
         * The following methods and transition hooks are necessary to work
         * around the fact that CSS transitions can't navigate to auto values.
         */
        startTransition (el) {
            el.style.height = el.scrollHeight + 'px'
        },
        endTransition (el) {
            el.style.height = ''
        },
    },
}
</script>
