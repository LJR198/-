import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './plugins/element.js'
import axios from 'axios'
import 'normalize.css'
import './assets/css/download/font1/iconfont.css'
import dayjs from 'dayjs'
import ECharts from 'vue-echarts'
import "echarts";
Vue.component('Echarts', ECharts)
axios.defaults.baseURL = 'http://localhost:3000'
axios.interceptors.request.use(function (config) {
  // 在发送请求之前做些什么
  // 把token加入请求头中, 不需要可以删除下面4句代码
  const token = sessionStorage.getItem('token')
  if (token) {
    config.headers.Authorization = token
  }
  return config
}, function (error) {
  // 对请求错误做些什么
  return Promise.reject(error)
})
Vue.prototype.$http=axios
Vue.config.productionTip = false
Vue.filter('formattime',(value) => {
  // console.log(value);
  let data=dayjs(value).format('YYYY-MM-DD HH:mm:ss')
  return data
})
new Vue({
  
  router,
  store,
  render: h => h(App)
}).$mount('#app')
