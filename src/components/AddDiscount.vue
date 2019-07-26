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
    <el-col :span="16">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:6%">
        
    <el-form-item label="优惠名称" prop="discountname" style="margin-bottom:5%;">
      <el-input v-model="ruleForm.discountname" placeholder="请输入优惠名称"></el-input>
    </el-form-item>
    <el-form-item label="优惠详情" prop="detail" style="margin-bottom:5%;">
      <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 5}" placeholder="请输入优惠详情" v-model="ruleForm.detail"></el-input>
    </el-form-item>
    </el-form>
    </el-col>
  </el-row>
  <el-button type="primary" @click="commit('ruleForm')" :loading="clicked">提交更改</el-button>
  </div>
</template>

<script>
export default {
    mounted:function(){
       this.show()
    },
  methods:
  {
      show(){
           
           this.$confirm(window.sessionStorage.getItem('storeid'))
      },
    commit(formName)
    {
        this.$refs[formName].validate((valid) =>{
            if(valid){
                this.$confirm('确认内容并提交更改？',
                          '提示',
                          {confirmButtonText:'确定更改',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked = true
              
              this.axios.get('/api/Emerge/add',{              //接口在这里接口在这里接口在这里接口在这里！！！！！！！！！！
                params:{
                  discountname:this[formName].discountname,
                  detail:this[formName].detail,
                  storeid:window.sessionStorage.getItem('storeid')
                }
                
              }).then((response)=>{
                if(response.status === 200){
                  //console.log(response);
                  //console.log(response.data.result);
                 // if(response.data.result === null){
                    this.$message({type:'success',message:'提交成功！'});
                    this.$router.push({name:"查看紧急通知"});
                  //}
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
              //this.$router.push({name:"查看紧急通知"});
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
      clicked:false,
      title:'增加新优惠',
      storeid:'',
      ruleForm:{
          discountname:'',
          detail:'',
      },
      rules:{
          discountname:[
              {required:true, message:'请输入优惠名称',trigger:'blur'}
          ],
          detail:[
              {required:true, message:'请输入优惠详情',trigger:'blur'}
          ]
      }
      
      
    }
  }
}
</script>

