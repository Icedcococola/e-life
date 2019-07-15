<template>
  <el-container >
      
    <el-header style="background:#ffffff; font-size: 200%; height: 65px;">
      <el-row style="margin-top:10px;" type="flex" justify="end">

        <el-col :span="24">
          <div style="font-size:100%; font-weight:bold;height:50px; color:#2A8FF7;text-align:left;" @click="toHome">
              elife邮包通知系统
          </div>
        </el-col>

        <el-col :span="4">
           <div style="font-size:50%; height:50px; color:#2A8FF7;display:flex;align-items:center;justify-content:flex-end;">
            <el-dropdown @command="tologin">
              <span class="el-dropdown-link" style="color:#2a8ff7;">
              <el-button type="text" class="button">邮包管理员<i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
              
              </span>
             <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="c">登出</el-dropdown-item>
             </el-dropdown-menu>
            </el-dropdown>
           </div>
        </el-col>


      </el-row>
    </el-header> 


    <el-container>

    <el-aside>
        <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      router
      style="background:#ffffff;">
      <el-menu-item index="/LaunchedParcel">
        <i class="el-icon-menu"></i>
        <span slot="title">查看已通知的邮包</span>
      </el-menu-item> 
      <el-menu-item index="/EditParcel">
        <i class="el-icon-edit"></i>
        <span slot="title">编辑新的邮包通知</span>
      </el-menu-item>

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

<script>
export default {
  methods:
  {
    tologin(command)
    {
      this.$router.push({
         name:"login"
      }),
      this.$store.commit('LOGOUT')
    },
    toHome()
    {
      this.$router.push({
        name:"parcelHome"
      })
    }
  },
  data() {
    return {
    }
  }
}
</script>
