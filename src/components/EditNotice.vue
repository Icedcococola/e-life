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

  <el-row style="margin-top:50px;margin-bottom:40px;" type="flex" justify="center">
    <el-col :span="3">
       标题
     </el-col>
     <el-col :span="17">
      <el-input
      type="textarea"
      :rows="2"
      placeholder="请输入标题"
      v-model="title">
      </el-input>        
     </el-col>
  </el-row>

  <el-row style="margin-top:25px;" type="flex" justify="center">
    <el-col :span="3">
      正文
    </el-col>
    <el-col :span="17">
      <el-input
      type="textarea"
      :rows="16"
      placeholder="请输入内容"
      v-model="content">
      </el-input>
    </el-col>
  </el-row>

  <el-row style="height:100px; margin-top:30px;">
    <el-button type="primary" @click="confirm1">提交物业通知</el-button>
  </el-row>



  </div>
</template>

<script>
export default {
  methods:
  {
    confirm1()
    {
      this.$confirm('确认内容并提交？',
                    '提示',
                    {confirmButtonText:'确定',cancelButtonText:'取消'}
      ).then(()=>{
        this.$message({type:'success',message:'提交成功!'});
        this.$router.push({name:"物业详情页"});
      });
    }
  },
  data() {
    return {
      title:'',
      content:''
    }
  }
}
</script>

