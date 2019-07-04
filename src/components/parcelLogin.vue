<template>
  <div>
    <el-row  type="flex" justify="center" style="margin-top:9%" :gutter="90">

    <el-col :span="11">
      
     <el-card>
      <el-row style="height:50px;display:flex;align-items:center;color:#272727c7;font-size:25px;" type="flex" justify="center">邮包管理员登录 
      </el-row>
      
      <el-row style="margin-top:30px;display:flex;align-items:center;">
        <el-col :span="6">
          用户名
        </el-col>
        <el-col :span="16">
          <el-input v-model="username" placeholder="请输入用户名"></el-input>
        </el-col>
      </el-row>

      <el-row style="margin-top:40px;display:flex;align-items:center;">
        <el-col :span="6">
          密码
        </el-col>
        <el-col :span="16">
          <el-input v-model="password" placeholder="请输入密码"></el-input>
        </el-col>
      </el-row>

      <el-row style="margin-top:40px;display:flex;align-items:center;">
        <el-col >
          <el-button type="primary" @click="toHome">确认</el-button>
        </el-col>
      </el-row>
      
     </el-card>

    </el-col>

    </el-row>
  </div>
</template>

<script>
export default {
  methods:{
    toHome(){
      this.$router.push({
          name:'parcelHome'
        });
    },
  },
  
  data() {
    return {
      username: '',
      password: ''
    }
  }
  
}
</script>



<style>
.gf{
  background: #272727c7
}
</style>

