<template>
  <el-container >
      
    <el-header style="background:#ffffff; font-size: 200%; height: 65px;" class="b">
      <el-row style="margin-top:10px;" type="flex" justify="end" >

        <el-col :span="24">
          <div style="font-size:100%; font-weight:bold;height:50px; color:#2A8FF7;text-align:left;" @click="toHome">elife后台管理系统</div>
        </el-col>

        <el-col :span="4">
           <div style="font-size:50%; height:50px; color:#2A8FF7;display:flex;align-items:center;justify-content:flex-end;">
            <el-dropdown @command="tologin">
              <span class="el-dropdown-link" style="color:#2a8ff7;">
              <el-button type="text" class="button" >物业管理员<i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
              
              </span>
             <el-dropdown-menu slot="dropdown">
               
              <el-dropdown-item disabled>{{communityname}}管理员</el-dropdown-item>
              <el-dropdown-item command="c" divided>登出</el-dropdown-item>
             </el-dropdown-menu>
            </el-dropdown>
           </div>
        </el-col>


      </el-row>
    </el-header> 


    <el-container>

    <el-aside style="width:25%">
        <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      router
      style="background:#ffffff;width:99%">
      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-news"></i>
          <span>查看已发布信息</span>
        </template>
      <el-menu-item-group style="background:#ffffff;">
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
      <el-menu-item-group style="background:#ffffff;">
        <template slot="title"></template>
        <el-menu-item index="/EditActivities">活动安排</el-menu-item>
        <el-menu-item index="/EditNews" >最新资讯</el-menu-item>
        <el-menu-item index="/EditNotice" >物业通知</el-menu-item>
        <el-menu-item index="/EditUrgent" >紧急通知</el-menu-item>
      </el-menu-item-group>
      </el-submenu>
      
      <el-submenu index="3">
        <template slot="title">
          <i class="el-icon-edit-outline"></i>
          <span>团购需求管理</span>
        </template>
      <el-menu-item-group style="background:#ffffff;">
        <template slot="title"></template>
        <el-menu-item index="/LaunchedDemands">查看已上架商品</el-menu-item>
        <el-menu-item index="/DemandstoLaunch" >未发布需求管理</el-menu-item>
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

<script>
export default {
  mounted:function(){
    this.show();
  },
  methods:
  {
    tologin(command)
    {
      this.$store.commit('LOGOUT')
      this.$router.push({
         name:"login"
      });
    },
    toHome()
    {
      this.$router.push({
        name:"已发布的信息"
      })
    },

    show(){
      var a= window.sessionStorage.getItem('community')
      this.$confirm('欢迎您，'+a+'管理员！','提示')
    }
  },
  data() {
    return {
      communityname:window.sessionStorage.getItem('community')
    }
  }
}
</script>
