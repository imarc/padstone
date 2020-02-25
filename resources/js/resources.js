import Vue from 'vue';
import store from './store.js';
import {
    LiveSearch,
    ContinuousCollectionComponent,
    SyncsWithUrl,
    ResetsPage,
} from 'clockvine-vue';

const app = new Vue({
    el: 'main',
    store,

    data: {
        params: {
            orderBy: 'title asc',
            page: 1,
            search: '',
        },
    },

    computed: {
        nextPage() {
            const urlParams = new URLSearchParams(location.search);
            urlParams.set('page', this.params.page + 1);
            return '?' + urlParams.toString();
        },
    },

    mixins: [
        new SyncsWithUrl('params', {
            page: () => false,
            orderBy: 'title asc'
        }),
        new ResetsPage(),
    ],

    components: {
        resources: ContinuousCollectionComponent.for('resources'),
        search: LiveSearch,
    },
})
