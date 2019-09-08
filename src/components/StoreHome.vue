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
              <el-button type="text" class="button" >商家管理员<i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
              
              </span>
             <el-dropdown-menu slot="dropdown">
               
              <el-dropdown-item disabled>{{this.storename}}管理员</el-dropdown-item>
              <el-dropdown-item command="c" divided>登出</el-dropdown-item>
             </el-dropdown-menu>
            </el-dropdown>
           </div>
        </el-col>


      </el-row>
    </el-header> 


    <el-container>

    <el-aside style="width:20%;">
        <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      router
      style="background:#ffffff;width:99%;font-size:20px">
      <el-menu-item index="StoreCommunity">
        <template slot="title">
          <i class="el-icon-news"></i>
          <span>查看已入驻社区</span>
        </template>
      </el-menu-item>

      <el-menu-item index="CommunityList">
        <template slot="title">
          <i class="el-icon-edit"></i>
          <span>申请入驻新社区</span>
        </template>
      </el-menu-item>

      <el-menu-item index="StoreDesired">
        <template slot="title">
          <i class="el-icon-edit"></i>
          <span>团购需求管理</span>
        </template>
      </el-menu-item>

      <el-submenu index="5">
        <template slot="title">
          <i class="el-icon-edit-outline"></i>
          <span>成为服务提供商</span>
        </template>
      <el-menu-item-group style="background:#ffffff;">
        <template slot="title"></template>
        <el-menu-item index="/ApplyForService">申请成为服务提供商</el-menu-item>
        
        
      </el-menu-item-group>
      </el-submenu>
     
     
      <el-submenu index="6">
        <template slot="title">
          <i class="el-icon-edit-outline"></i>
          <span>周边优惠</span>
        </template>
      <el-menu-item-group style="background:#ffffff;">
        <template slot="title"></template>
        <el-menu-item index="/StoreDiscount">查看本店优惠</el-menu-item>
        <el-menu-item index="/ApplyForDiscount">申请加入周边优惠</el-menu-item>
        
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
      var b = window.sessionStorage.getItem('storename')
      this.$confirm('欢迎您，'+b+'管理员！','提示')
    }
  },
  data() {
    return {
      communityname:window.sessionStorage.getItem('community'),
      storename:window.sessionStorage.getItem('storename')
    }
  }
}
</script>
