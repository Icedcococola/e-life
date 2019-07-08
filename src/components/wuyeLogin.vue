<template>
  <div>
    <el-row  type="flex" justify="center" style="margin-top:9%" :gutter="90">

    <el-col :span="11">
      
     <el-card>
      <el-row style="height:50px;display:flex;align-items:center;color:#272727c7;font-size:25px;margin-bottom:9%;" type="flex" justify="center">物业管理员登录 
      </el-row >
      
<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
  <el-form-item label="用户名" prop="username" style="margin-bottom:7%">
    <el-input v-model="ruleForm.username"></el-input>
  </el-form-item>
  <el-form-item label="密码" prop="password">
    <el-input v-model="ruleForm.password"></el-input>
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
  methods:{
    toHome(formName){
       this.$refs[formName].validate((valid)=>{
         if(valid){
            this.axios.post('https://www.easy-mock.com/mock/5d22ed7d1994010b14459e3b/example/api/wuyelogin',
            {
              user:this[formName].username,
              pass:this[formName].password
            }
            ).then((response)=>{
            if(response.status === 200 ){
                console.log(response);
                var a = response.data.match;
                console.log(a);
                if(a===0){
                  this.$store.commit('SET_TOKEN',1)
                }
                //easy mock返的数据莫要包在data:{}里。。。你可长点心吧

            }
            })
            this.$router.push({
                name:'已发布的信息'
                });

            
           //this.$router.push({
           //  name:'已发布的信息'
           //});
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
  },
  
  data() {
    return {
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
        ]
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
