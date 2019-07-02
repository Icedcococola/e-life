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
        }
      ]
    }
  ]
})
