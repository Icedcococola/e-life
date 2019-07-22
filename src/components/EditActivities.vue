<template>
  <div>

  <el-row >
      <el-col >
        <div class="t" style="font-size:160%; height:50px; color:#858585;text-align: right"><i class="el-icon-edit"></i>{{title}}</div>
      </el-col>
  </el-row>

  <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin:0px auto;padding:0px;overflow:hidden;"></div>
  </el-row>

  <el-row type="flex" justify="center" >
    <el-col :span="18">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:6%">
    <el-form-item label="标题" prop="title" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.title" placeholder="请输入活动标题"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="detail" style="margin-bottom:5%;">
      <el-input type="textarea" :autosize="{ minRows: 12, maxRows: 18}" placeholder="请输入活动内容" v-model="ruleForm.detail"></el-input>
    </el-form-item>
    
    <el-form-item label="时间" prop="date" style="margin-bottom:5%;">
  
        <el-col :span="6" style="width:30%">
          <el-date-picker
            v-model="ruleForm.date"
            type="datetime"
            placeholder="选择时间"
            >
          </el-date-picker>
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
              
              this.axios.get('/api/Activity/add',
              {
                params:{
                  title:this[formName].title,
                  detail:this[formName].detail,
                  activitytime:this[formName].date,
                  place:this[formName].place,
                  community:window.sessionStorage.getItem('community')
                }
              }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  //console.log(response.data.result);
                  //if(response.data.result === null){
                    this.$message({type:'success',message:'提交成功！'});
                    this.$router.push({name:"查看活动安排"});
                  //}
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
             //this.$message({type:'success',message:'提交成功！'});
             // this.$router.push({name:"查看活动安排"});
            }
            );
          }else{
            this.$alert('请填写完整','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
        })

        
    },
    
    //timeFormat(date){
    //  var strDate = new Date(date);
    //  let Y=strDate.getFullYear()+'-';
    //  let M=(strDate.getMonth()+1 < 10 ? '0'+(strDate.getMonth()+1) : strDate.getMonth()+1) + '-';
    //  let D=
    //}




  },
  data() {
    return {

      title:'编辑活动安排',
      fileList: [],
      ruleForm:{
        title:'',
        detail:'',
        date:'',
        place:'',
        time:''
      },
      rules:{
        title:[
          {required:true, message:'请输入标题', trigger:'blur'}
        ],
        detail:[
          {required:true, message:'请输入活动内容',trigger:'blur'}
        ],
        date:[
          {type: 'date', required:true, message:'请选择日期', trigger:'change'}
        ],
        place:[
          {required:true, message:'请输入活动地点', trigger:'blur'}
        ]
      }
    }
  }
}
</script>

