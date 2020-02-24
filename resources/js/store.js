import Vue from 'vue';
import Vuex from 'vuex';
import { ElementApiModule } from 'clockvine-vue';

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        resources: new ElementApiModule('/resources.json', { debounce: 1000 }),
    },
});
