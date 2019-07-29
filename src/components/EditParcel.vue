<template>
  <div>

  <el-row >
      <el-col >
        <div class="t" style="font-size:230%; height:50px; color:#858585;text-align: right"><i class="el-icon-edit"></i>{{title}}</div>
      </el-col>
  </el-row>

  <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin:0px auto;padding:0px;overflow:hidden;"></div>
  </el-row>
  <el-row type="flex" justify="center" >
    <el-col :span="18">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:6%">
    <el-form-item label="快递单号" prop="packageid" style="margin-bottom:5%;">
      <el-input v-model.number="ruleForm.packageid" placeholder="请输入快递单号"></el-input>
    </el-form-item>
    <el-form-item label="手机号" prop="phonenum" style="margin-bottom:5%;">
      <el-input v-model.number="ruleForm.phonenum" placeholder="请输入手机号"></el-input>
    </el-form-item>
    <el-form-item label="快递公司" prop="company" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.company" placeholder="请输入快递公司"></el-input>
    </el-form-item>
    </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')" :loading="clicked">提交邮件通知</el-button>


  </div>
</template>

<script>
export default {
  methods:
  {
    commit(formName)
    {
      /*if(this[formName].packageid.split(" ").join("").length === 0){
         this.$confirm('快递单号不可为空')
      }else if(this[formName].phonenum.split(" ").join("").length === 0){
         this.$confirm('手机号不可为空')
      }else {*/
          this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认内容并提交？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked=true
              this.axios.get('/api/Express/addExpress',{
                  params:{
                    packageid:this[formName].packageid,
                    phonenum:this[formName].phonenum,
                    company:this[formName].company
                  }
              }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  //var a = response.data.result;
                  //console.log(a);
                  //if(a ===null){
                   // this.$message({type:'success',message:'提交成功！'});
                    this.$confirm('提交成功，是否继续添加邮件通知？')
                    .then(()=>{
                      let NewPage = '_empty' + '?time=' + new Date().getTime()/500;
                      this.$router.push(NewPage);
                      this.$router.go(-1);
                    })
                  //}
                }else{
                  this.$confirm('提交失败，请稍后重试','提示')
                }
              })
              .catch(error => {
                this.clicked = false
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
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看最新资讯"});
            });
          }else{
            this.$alert('请填写完整','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
        })
        //}
    },
  },
  data() {
    return {
      clicked:false,
      title:'编辑邮件通知',
      ruleForm:{
        packageid:'',
        phonenum:'',
        company:''
      },
      rules:{
        packageid:[
          {required:true, message:'请输入快递单号',trigger:'blur'},
          {type: 'number', message: '快递单号必须为数字值'}
        ],
        phonenum:[
          {required:true, message:'请输入手机号',trigger:'blur'},
          {type: 'number', message: '手机号必须为数字值'}
        ],
        company:[
          {required:true, message:'请输入快递公司',trigger:'blur'}
        ]
        
      }
    }
  }
}
</script>

