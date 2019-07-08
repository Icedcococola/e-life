<template>
  <div>

  <el-row >
      <el-col >
        <div style="font-size:160%; height:50px; color:#858585fa;text-align: right">
          <i class="el-icon-edit"></i>编辑物业通知
        </div>
      </el-col>
  </el-row>

  <el-row>
    <div style="width:100%;background:#c4c4c4fa;height:1px;margin:0px auto;padding:0px;overflow:hidden;"></div>
  </el-row>

  
  <el-row type="flex" justify="center">
    <el-col :span="18">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:6%">
    <el-form-item label="标题" prop="title" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.title" clearable="true"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="content">
      <el-input type="textarea" :autosize="{ minRows: 18, maxRows: 24}" placeholder="请输入内容" v-model="ruleForm.content"></el-input>
    </el-form-item>

  </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')">提交物业通知</el-button>

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
              this.$message({type:'success',message:'提交成功！'});
              this.$router.push({name:"查看物业通知"});
            });
          }else{
            this.$alert('请填写完整','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
        })
    }
  },
  data() {
    return {
      ruleForm:{
        title:'',
        content:'',
        date:''
      },
      rules:{
        title:[
          {required:true,message:'请输入通知标题',trigger:'blur'}
        ],
        content:[
          {required:true, message:'请输入通知内容',trigger:'blur'}
        ],
        date:[
          {required:true, message:'请选择日期',trigger:'blur'}
        ]
      }
    }
  }
}
</script>

