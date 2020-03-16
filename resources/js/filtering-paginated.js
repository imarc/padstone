import Vue from 'vue';
import store from './store.js';
import {
    LiveSearch,
    CollectionComponent,
    PaginatedCollectionComponent,
    PaginationNav,
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
            type: null,
            topic: null,
            category: null,
        },
    },

    methods: {
        orderby(attr) {
            if (`${attr} asc` == this.params.orderby) {
                this.params.orderBy = `${attr} desc`;
            } else {
                this.params.orderBy = `${attr} asc`;
            }
        },
    },

    mixins: [
        new SyncsWithUrl('params'),
        new ResetsPage(),
    ],

    components: {
        resources: PaginatedCollectionComponent.for('resources'),
        resourceTypes: CollectionComponent.for('resourceTypes'),
        resourceTopics: CollectionComponent.for('resourceTopics'),
        blogs: PaginatedCollectionComponent.for('blogs'),
        blogCategories: CollectionComponent.for('blogCategories'),
        search: LiveSearch,
        pagination: PaginationNav,
    },
})
