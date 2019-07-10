<template>
  <div>

  <el-row >
      <el-col >
        <div style="font-size:160%; height:50px; color:#858585fa;text-align: right">
          <i class="el-icon-edit"></i>编辑最新资讯
        </div>
      </el-col>
  </el-row>

  <el-row>
    <div style="width:100%;background:#c4c4c4fa;height:1px;margin:0px auto;padding:0px;overflow:hidden;"></div>
  </el-row>
  <el-row type="flex" justify="center" >
    <el-col :span="18">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:6%">
    <el-form-item label="标题" prop="title" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.title" placeholder="请输入资讯标题"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="detail" style="margin-bottom:5%;">
      <el-input type="textarea" :autosize="{ minRows: 12, maxRows: 18}" placeholder="请输入资讯内容" v-model="ruleForm.detail"></el-input>
    </el-form-item>
    </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')">提交活动安排</el-button>


  </div>
</template>

<script>
export default {
  methods:
  {
    commit(formName)
    {
          this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认内容并提交？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.axios.get('/api/Latestnews/add',{
                  params:{
                    title:this[formName].title,
                    detail:this[formName].detail
                  }
              }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  var a = response.data.result;
                  console.log(a);
                  //if(a ===null){
                    this.$message({type:'success',message:'提交成功！'});
                    this.$router.push({name:"查看最新资讯"});
                  //}
                }else{
                  this.$confirm('提交失败，请稍后重试','提示')
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
    },
  },
  data() {
    return {
      dialogImageUrl:'',
      dialogVisible:false,
      ruleForm:{
        title:'',
        detail:'',
      },
      rules:{
        title:[
          {required:true, message:'请输入资讯标题',trigger:'blur'}
        ],
        detail:[
          {required:true, message:'请输入资讯内容',trigger:'blur'}
        ],
        
      }
    }
  }
}
</script>

