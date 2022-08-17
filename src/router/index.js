import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Home from '../views/Home.vue'
import Hindex from '../views/Hindex.vue'
import Resetuser from '../views/Resetuser.vue'
import Userinfo from '../views/Useronfo.vue'
import Users from '../views/Users.vue'
import Lookwork from '../views/Lookwork.vue'
import yuyues from '../views/Yuyues.vue'
import taocang from '../views/Taocang.vue'
import jianchag from '../views/Jianchag.vue'
import jianchazg from '../views/Jianchazg.vue'
import roles from '../views/roles.vue'
import menus from '../views/menus.vue'
import huiyuannum from '../views/huiyuannum.vue'
import taocanyuyue from '../views/taocanyuyue.vue'
import yunyingshuju from '../views/yunyingshuju.vue'
import setpassword from '../views/setpassword.vue'
Vue.use(VueRouter)

const routes = [
  {
    path:"/",
    redirect: '/login',  // 重定向:重新指向其它path,会改变网址
  },
  {
    path:"/login",
    component: Login
  },
  {
    path:'/home',
    component: Home,
    children:[
      {
        path:"/home",
        redirect:"/homeindex"
      },
      {
        path:"/setpassword",
        component:setpassword
      },
      {
        path:"/homeindex",
        component: Hindex
      },
      {
        path:"/userinfo",
        component: Userinfo,
      },
      {
        path:"/users",
        component: Users
      },
      {
        path:"/lookwork",
        component: Lookwork
      },
      {
        path:"/yuyues",
        component:yuyues
      },
      {
        path:"/taocang",
        component:taocang
      },
      {
        path:"/jianchag",
        component:jianchag
      },
      {
        path:"/jianchazg",
        component:jianchazg
      },
      {
        path:"/roles",
        component:roles
      },
      {
        path:"/menus",
        component:menus
      },
      {
        path:'/huiyuannum',
        component :huiyuannum
      },
      {
        path:"/taocanyuyue",
        component :taocanyuyue
      },
      {
        path:"/yunyingshuju",
        component :yunyingshuju
      }
    ]
  },
  {
    path:"/resetuser",
    component: Resetuser
  }
]

const router = new VueRouter({
  routes
})

// 访问的白名单, 可以直接通行
const whiteList = ['/login','/resetuser']
router.beforeEach((to, from, next) => {
  // 访问的路径在白名单
  if (whiteList.includes(to.path.toLowerCase())) {
    next()
  } else {
    let token=sessionStorage.getItem('token')
    if (token) {
      next()
    } else {
      next('/login')
    }
  }
})
export default router
