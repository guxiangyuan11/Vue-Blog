// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import index from './index.vue';
import router from './router';
import axios from 'axios';
import VueAxios from 'vue-axios';
import store from './store/index';

Vue.use(VueAxios, axios);
Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  render: (h) => h(index)
});
