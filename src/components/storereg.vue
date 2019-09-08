<template>
 <div>
    <el-row  type="flex" justify="center" style="margin-top:9%" :gutter="90">

    <el-col :span="11">
      
     <el-card>
      <el-row class="qwer" style="height:50px;display:flex;align-items:center;color:#272727;font-size:25px;margin-bottom:9%;" type="flex" justify="center">{{title}}</el-row >
      
<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
  <el-form-item label="用户名" prop="username" style="margin-bottom:7%">
    <el-input v-model="ruleForm.username" @keyup.enter.native="toHome('ruleForm')"></el-input>
  </el-form-item>
  <el-form-item label="密码" prop="password" style="margin-bottom:7%">
    <el-input v-model="ruleForm.password" type="password" @keyup.enter.native="toHome('ruleForm')"></el-input>
  </el-form-item>
  <el-form-item label="地址" prop="address" style="margin-bottom:7%">
        <el-input v-model="ruleForm.address" @keyup.enter.native="toHome('ruleForm')"></el-input>
    </el-form-item>
  <el-form-item label="商家图片" prop="picture">
       <el-upload
       class="avatar-uploader"
        action="/img"
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :before-remove="beforeRemove"
        multiple
        :limit="1"
        :show-file-list="true"
        :on-exceed="handleExceed"
        :on-success="handleAvatarSuccess"
        :before-upload="beforeAvatarUpload"
        :file-list="fileList">
       <img v-if="imageUrl" :src="imageUrl" class="avatar">
       <i v-else class="el-icon-picture avatar-uploader-icon"></i>
       </el-upload>
       <div style="font-size:10px;color:#909092">上传图片格式：jpg/jpeg、png且大小不超过2M</div>
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
   // this.showtoken();
    
  },
  methods:{
    toHome(formName){
       this.$refs[formName].validate((valid)=>{
         if(valid){
            this.storenm = this[formName].username;
           this.axios.get('/api/Store/register',{
              params:{
                storename:this[formName].username,
                password:this[formName].password,
                img:this.imageUrl,
                address:this[formName].address

              }
            }).then((response)=>{
                this.storenm = this[formName].username;
            if(response.status === 200){
                console.log(response);
                var a = response.data.num;
                console.log(a);
                if(a===0){
                  this.$confirm('用户名已存在','提示')
                }else if(a===1){
                  this.$message({
                    message: '注册成功！',
                    type: 'success'
                  });
                  this.$router.push({
                    name:'storelogin',
                    /*params:{
                    data:response.data
                }*/
                });
               }
                
            }
            

            })
            .catch(error => {
              console.log(error.response.status)
              if(error.response.status === 404){
                this.$router.push({
                  name:'fof'
              })
              }else if(error.response.status === 500){
                this.$router.push({
                  name:'fot'
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
    },
    beforeAvatarUpload(file) {
        console.log(file)
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if(!isJPG && !isPNG){
         this.$message.error('上传图片只能是jpg/jpeg或png格式！')
         this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
         this.fileList =[]
         //handleRemove(file,fileList) 
        }
        if(!isLt2M){
         this.$message.error('上传图片大小不能超过2M！')
         this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
         //handleRemove(file,fileList)
        }
        if((isJPG || isPNG) && isLt2M){
         let fd = new FormData()
         fd.append('smfile',file)
         this.axios.post('/img',fd)
         .then((response)=>{
          if(response.status === 200){
            console.log(response.data.code)
            if(response.data.code === "success"){
              console.log(response.data.data.url)
              this.imageUrl = response.data.data.url
            }
          }
        }) 
        }else{
          /*
          let fd = new FormData()
          fd.append('smfile',file)
          this.axios.post('/img',fd)
          .then((response)=>{
          if(response.status === 200){
            console.log(response.data.code)
            if(response.data.code === "success"){
              console.log(response.data.data.url)
              this.imageUrl = response.data.data.url
            }
          }
        }) */

        //this.imageUrl = 'https://i.loli.net/2019/07/19/5d3129a0dbc7876672.jpg'
        }
        
    },

    checkValidUpload(file){
       const isJPG = file.type === 'image/jpeg';
       const isPNG = file.type === 'image/png';
       const isLt2M = file.size / 1024 / 1024 <2;
       
       if(!isJPG && !isPNG){
         this.$message.error('上传图片只能是jpg/jpeg或png格式！')
       }
       if(!isLt2M){
         this.$message.error('上传图片大小不能超过2M！')
       }
       return (isJPG || isPNG) && isLt2M
    },


    handlePreview(file) {
        console.log(file);
    },
    handleExceed(files, fileList) {
        this.$message.warning(`最多选择 1 张图片`);
    },
    handleRemove(file, fileList) {
        console.log(file, fileList);
        this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
    },
    beforeRemove(file, fileList) {
        return this.$confirm(`确定移除 ${ file.name }?`);
    },
  },
  
  data() {
    return {
      title:'商家注册',
      imageUrl:'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg',

      ruleForm: {
        username:'',
        password:'',
        address:''
      },
      rules: {
        username:[
          {required: true, message:'请输入用户名',trigger:'blur'}
        ],
        password:[
          {required: true, message:'请输入密码', trigger:'blur'}
        ],
        address:[
          {required: true, message:'请输入地址', trigger:'blur'}
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
