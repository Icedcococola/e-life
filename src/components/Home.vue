<template>
  <el-container >
      
    <el-header style="background:#2282db; font-size: 200%; height: 65px;">
      <el-row style="margin-top:10px;" >
        <el-col :span="6">
          e-life后台管理系统
        </el-col>
      </el-row>
    </el-header> 
    <el-footer style="height:10px;"></el-footer>


    <el-container>

    <el-aside>
        <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      router
      style="background:#82b1dd;">
      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-news"></i>
          <span>查看已发布信息</span>
        </template>
      <el-menu-item-group style="background:#e9ecf5ee;">
        <template slot="title"></template>
        <el-menu-item index="/LaunchedActivities" >活动安排</el-menu-item>
        <el-menu-item index="/LaunchedNews" >最新资讯</el-menu-item>
        <el-menu-item index="/LaunchedNotice" >物业通知</el-menu-item>
        <el-menu-item index="/LaunchedUrgent" >紧急通知</el-menu-item>
      </el-menu-item-group>
      </el-submenu>
      <el-submenu index="2">
        <template slot="title">
          <i class="el-icon-edit"></i>
          <span>编辑新通知</span>
        </template>
      <el-menu-item-group style="background:#e9ecf5ee;">
        <template slot="title"></template>
        <el-menu-item index="/EditActivities">活动安排</el-menu-item>
        <el-menu-item index="/EditNews" >最新资讯</el-menu-item>
        <el-menu-item index="/EditNotice" >物业通知</el-menu-item>
        <el-menu-item index="/EditUrgent" >紧急通知</el-menu-item>
      </el-menu-item-group>
      </el-submenu>
    </el-menu>
    </el-aside>
    <el-aside style="width:10px;">
    </el-aside>
    <el-main style="color:#110202ee;">
      <transition name="fade" mode="out-in">
        <router-view></router-view>
      </transition>
    </el-main>
    </el-container>
  </el-container>
</template>


<style>
  id{background: #a8a8a8fa;}
</style>
