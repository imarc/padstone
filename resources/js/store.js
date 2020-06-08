import Vue from 'vue';
import Vuex from 'vuex';
import { ElementApiModule } from 'clockvine-vue';

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        resources: new ElementApiModule('/resources.json', { debounce: 1000 }),
        resourceTypes: new ElementApiModule('/resourceTypes.json', { debounce: 1000 }),
        resourceTopics: new ElementApiModule('/resourceTopics.json', { debounce: 1000 }),
        blogs: new ElementApiModule('/blogs.json', { debounce: 1000 }),
        blogCategories: new ElementApiModule('/blogCategories.json', { debounce: 1000 }),
    },
});
