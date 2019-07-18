import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import EditActivities from "@/components/EditActivities"
import EditNews from "@/components/EditNews"
import EditNotice from "@/components/EditNotice"
import EditUrgent from "@/components/EditUrgent"
import LaunchedActivities from "@/components/LaunchedActivities"
import LaunchedNews from "@/components/LaunchedNews"
import LaunchedNotice from "@/components/LaunchedNotice"
import LaunchedUrgent from "@/components/LaunchedUrgent"
import messagePageAct from "@/components/messagePageAct"
import messagePageUrg from "@/components/messagePageUrg"
import messagePageNew from "@/components/messagePageNew"
import messagePageNot from "@/components/messagePageNot"
import login from "@/components/login"
import wuyeLogin from "@/components/wuyeLogin"
import parcelLogin from "@/components/parcelLogin"
import parcelHome from "@/components/parcelHome"
import LaunchedParcel from "@/components/LaunchedParcel"
import EditParcel from "@/components/EditParcel"
import DemandstoLaunch from "@/components/DemandstoLaunch"
import LaunchedDemands from "@/components/LaunchedDemands"
import EditDemands from "@/components/EditDemands"
import messagePageDemands from "@/components/messagePageDemands"
import UnlaunchedParcel from "@/components/UnlaunchedParcel"
import store from '@/store/index'

Vue.use(Router)


const router = new Router({
  routes: [
    {
      path: '/Home',
      name: '已发布的信息',
      component: Home,
      iconCls: 'el-icon-message',
      children:[
        {
          path:'/LaunchedActivities',
          component:LaunchedActivities,
          name:'查看活动安排',
          hidden:true,
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/LaunchedNews',
          component:LaunchedNews,
          name:'查看最新资讯',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/LaunchedNotice',
          component:LaunchedNotice,
          name:'查看物业通知',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/LaunchedUrgent',
          component:LaunchedUrgent,
          name:'查看紧急通知',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/messagePageAct',
          component:messagePageAct,
          name:'活动详情页',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/messagePageUrg',
          component:messagePageUrg,
          name:'紧急详情页',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/messagePageNew',
          component:messagePageNew,
          name:'资讯详情页',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/messagePageNot',
          component:messagePageNot,
          name:'物业详情页',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/DemandstoLaunch',
          component:DemandstoLaunch,
          name:'DemandstoLaunch',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/LaunchedDemands',
          component:LaunchedDemands,
          name:'LaunchedDemands',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/messagePageDemands',
          component:messagePageDemands,
          name:'messagePageDemands',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        }
      ]
      
    },
    {
      path:'/Home',
      name:'编辑新发布的信息',
      component:Home,
      iconCls: 'el-icon-message',
      children:[
        {
          path:'/EditActivities',
          component:EditActivities,
          name:'编辑活动安排',
          hidden:true,
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        { 
          path:'/EditNews',
          component:EditNews,
          name:'编辑最新资讯',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/EditNotice',
          component:EditNotice,
          name:'编辑物业通知',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/EditUrgent',
          component:EditUrgent,
          name:'编辑紧急通知',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/EditDemands',
          component:EditDemands,
          name:'EditDemands',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        }
      ]
    },
    {
      path:'/',
      component:login,
      name:'login',
      
    },
    {
      path:'/wuyeLogin',
      component:wuyeLogin,
      name:'wuyeLogin'
    },
    {
      path:'/parcelLogin',
      component:parcelLogin,
      name:'parcelLogin'
    },
    {
      path:'/parcelHome',
      component:parcelHome,
      name:'parcelHome',
      children:[
        {
          path:'/LaunchedParcel',
          component:LaunchedParcel,
          name:'LaunchedParcel',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/EditParcel',
          component:EditParcel,
          name:'EditParcel',
          meta: {
            requireAuth: true // 添加该字段，表示进入这个路由是需要登录的
          }
        },
        {
          path:'/UnlaunchedParcel',
          component:UnlaunchedParcel,
          name:'UnlaunchedParcel',
          meta:{
            requireAuth:true
          }
        }
      ]
    }
    
  ]
})



router.beforeEach((to, from, next) => {
  const token = store.state.token
  if (to.meta.requireAuth) { // 判断该路由是否需要登录权限
    if (token) { // 通过vuex state获取当前的token是否存在
      next()
    } else {
      console.log('该页面需要登陆')
      next({
        path: '/wuyeLogin'
        //query: {redirect: to.fullPath} // 将跳转的路由path作为参数，登录成功后跳转到该路由
      })
    }
  } else {
    next()
  }
})


export default router