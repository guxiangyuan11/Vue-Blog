import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

let state = {
  username: ''
};
let mutations = {
  reciveName: (state, username) => {
    state.username = username;
  }
};
export default new Vuex.Store({
  state,
  mutations
});
