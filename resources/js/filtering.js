import store from './store.js';
import {
    LiveSearch,
    CollectionComponent,
    ContinuousCollectionComponent,
    SyncsWithUrl,
    ResetsPage,
} from 'clockvine-vue';

export default {
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
        resourceTypes: CollectionComponent.for('resourceTypes'),
        resourceTopics: CollectionComponent.for('resourceTopics'),
        blogs: ContinuousCollectionComponent.for('blogs'),
        blogCategories: CollectionComponent.for('blogCategories'),
        search: LiveSearch,
    },
}
