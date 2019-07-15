<template>
 <div>
    <el-row  type="flex" justify="center" style="margin-top:9%" :gutter="90">

    <el-col :span="11">
      
     <el-card>
      <el-row class="qwer" style="height:50px;display:flex;align-items:center;color:#272727;font-size:25px;margin-bottom:9%;" type="flex" justify="center">{{title}}</el-row >
      
<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
  <el-form-item label="用户名" prop="username" style="margin-bottom:7%">
    <el-input v-model="ruleForm.username"></el-input>
  </el-form-item>
  <el-form-item label="密码" prop="password">
    <el-input v-model="ruleForm.password" type="password"></el-input>
  </el-form-item>
</el-form>
     
     
    <el-button type="primary" @click="toHome('ruleForm')" >确定</el-button>

     </el-card>

    </el-col>

    </el-row>
  </div>
</template>

<script>
export default {
  mounted:function(){
    this.showtoken();
  },
  methods:{
    toHome(formName){
       this.$refs[formName].validate((valid)=>{
         if(valid){
            this.axios.get('/api/Admin/login',{
              params:{
                adminname:this[formName].username,
                password:this[formName].password,
                type:"wuye"
              }
            }).then((response)=>{
            if(response.status === 200){
                console.log(response);
                var a = response.data.num;
                console.log(a);
                if(a===0){
                  this.$confirm('用户名不存在','提示')
                }else if(a===1){
                  this.$confirm('密码不正确','提示')
                }else if(a===2){
                  this.$store.commit('SET_TOKEN',1)
                  this.$store.commit('SET_COMMUNITY',response.data.community)
                  this.$router.push({
                    name:'已发布的信息',
                    params:{
                    data:response.data
                }
                });
                }
                
                
                
            }else{
              this.$confirm('用户名或密码不正确', '提示', {
                confirmButtonText: '确定',
                type: 'warning'
                })
            }
            })

         }else{
           this.$alert('请完整填写用户名和密码', '提示', {
           confirmButtonText: '确定',
           callback: action => {
           }
          });
           return false;
         }
       })
      
    },

    showtoken(){
      var a = window.sessionStorage.getItem('token')
      this.$confirm(a,'提示')
    }
  },
  
  data() {
    return {
      title:'物业管理员登录',

      ruleForm: {
        username:'',
        password:''
      },
      rules: {
        username:[
          {required: true, message:'请输入用户名',trigger:'blur'}
        ],
        password:[
          {required: true, message:'请输入密码', trigger:'blur'}
        ],

      }
    }
  }
  
}
</script>



<style>
.gf{
  background: #272727c7
}
</style>
