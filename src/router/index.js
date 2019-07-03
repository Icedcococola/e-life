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

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: '已发布的信息',
      component: Home,
      iconCls: 'el-icon-message',
      children:[
        {
          path:'/LaunchedActivities',
          component:LaunchedActivities,
          name:'活动安排',
          hidden:true
        },
        {
          path:'/LaunchedNews',
          component:LaunchedNews,
          name:'最新资讯'
        },
        {
          path:'/LaunchedNotice',
          component:LaunchedNotice,
          name:'物业通知'
        },
        {
          path:'/LaunchedUrgent',
          component:LaunchedUrgent,
          name:'紧急通知'
        },
        {
          path:'/messagePageAct',
          component:messagePageAct,
          name:'活动详情页'
        },
        {
          path:'/messagePageUrg',
          component:messagePageUrg,
          name:'紧急详情页'
        },
        {
          path:'/messagePageNew',
          component:messagePageNew,
          name:'资讯详情页'
        },
        {
          path:'/messagePageNot',
          component:messagePageNot,
          name:'物业详情页'
        }
      ]
      
    },
    {
      path:'/',
      name:'编辑新发布的信息',
      component:Home,
      iconCls: 'el-icon-message',
      children:[
        {
          path:'/EditActivities',
          component:EditActivities,
          name:'活动安排',
          hidden:true
        },
        { 
          path:'/EditNews',
          component:EditNews,
          name:'最新资讯'
        },
        {
          path:'/EditNotice',
          component:EditNotice,
          name:'物业通知'
        },
        {
          path:'/EditUrgent',
          component:EditUrgent,
          name:'紧急通知'
        },
      ]
    },
    {
      path:'/login',
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
    }

  ]
})
