import Vue from 'vue'
import Vuex from 'vuex'
import createVuexalong from 'vuex-along'

Vue.use(Vuex)
let obj=JSON.parse(sessionStorage.getItem('vue-state'))
// console.log(obj.root.user);
export default new Vuex.Store({
  state: {
    user:obj ? obj.root.user :{}
  },
  getters: {
  },
  mutations: {
    getuser(state,data){
      state.user=data
      console.log(state,data,1111);
    }
  },
  actions: {
  },
  modules: {
  },
  plugins:[createVuexalong({
    name:"vue-state",
    local:false,
    session:{
      list:['user'],
      isFilter: true
    }
  })]
 
})
