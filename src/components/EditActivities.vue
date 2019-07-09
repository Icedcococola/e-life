<template>
  <div>

  <el-row >
      <el-col >
        <div style="font-size:160%; height:50px; color:#858585fa;text-align: right">
          <i class="el-icon-edit"></i>编辑活动安排
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
      <el-input v-model="ruleForm.title" placeholder="请输入活动标题"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="content" style="margin-bottom:5%;">
      <el-input type="textarea" :autosize="{ minRows: 12, maxRows: 18}" placeholder="请输入活动内容" v-model="ruleForm.content"></el-input>
    </el-form-item>
    
    <el-form-item label="时间" prop="date" style="margin-bottom:5%;">
  
        <el-col :span="6" style="width:30%">
          <el-date-picker
            v-model="ruleForm.date"
            type="date"
            placeholder="选择日期">
          </el-date-picker>
        </el-col>

        <el-col class="line" :span="2">-</el-col>

        <el-col :span="6" style="width:30%">
          <el-form-item prop="time">
            <el-time-select
            v-model="ruleForm.time"
            :picker-options="{
            start: '08:00',
            step: '00:30',
            end: '20:00'
            }"
            placeholder="选择时间">
          </el-time-select>
          </el-form-item>
        </el-col>

    </el-form-item >
    
    <el-form-item label="地点" prop="place" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.place" placeholder="请输入活动地点"></el-input>
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
              this.axios.post('https://www.easy-mock.com/mock/5d22ed7d1994010b14459e3b/example/api/commitact',
              {
                title:this[formName].title,
                content:this[formName].content,
                date:this[formName].date,
                time:this[formName].time,
                place:this[formName].place
              }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  console.log(response.data.result);
                  if(response.data.result === 3){
                    this.$message({type:'success',message:'提交成功！'});
                    this.$router.push({name:"查看活动安排"});
                  }
                }
              })
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看活动安排"});
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
      fileList: [],
      ruleForm:{
        title:'',
        content:'',
        date:'',
        place:'',
        time:''
      },
      rules:{
        title:[
          {required:true, message:'请输入标题', trigger:'blur'}
        ],
        content:[
          {required:true, message:'请输入活动内容',trigger:'blur'}
        ],
        date:[
          {type: 'date', required:true, message:'请选择日期', trigger:'change'}
        ],
        place:[
          {required:true, message:'请输入活动地点', trigger:'blur'}
        ],
        time:[
          {required:true, message:'请选择具体时间',trigger:'blur'}
        ]
      }
    }
  }
}
</script>

