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

Vue.use(Router)

export default new Router({
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
          hidden:true
        },
        {
          path:'/LaunchedNews',
          component:LaunchedNews,
          name:'查看最新资讯'
        },
        {
          path:'/LaunchedNotice',
          component:LaunchedNotice,
          name:'查看物业通知'
        },
        {
          path:'/LaunchedUrgent',
          component:LaunchedUrgent,
          name:'查看紧急通知'
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
      path:'/Home',
      name:'编辑新发布的信息',
      component:Home,
      iconCls: 'el-icon-message',
      children:[
        {
          path:'/EditActivities',
          component:EditActivities,
          name:'编辑活动安排',
          hidden:true
        },
        { 
          path:'/EditNews',
          component:EditNews,
          name:'编辑最新资讯'
        },
        {
          path:'/EditNotice',
          component:EditNotice,
          name:'编辑物业通知'
        },
        {
          path:'/EditUrgent',
          component:EditUrgent,
          name:'编辑紧急通知'
        },
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
          name:'LaunchedParcel'
        },
        {
          path:'/EditParcel',
          component:EditParcel,
          name:'EditParcel'
        }
      ]
    },
    

  ]
})
