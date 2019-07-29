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
        <el-form label-width="100px" class="demo-ruleForm" style="margin-top:6%">
          <el-form-item label="商户编号" prop="storeid" style="margin-bottom:5%;">
            <!--
      <el-input v-model="discountid" readonly></el-input>
      -->
       <el-row type="flex" justify="start">
             <el-col :span="10" >
          <el-input v-model="storeid" readonly></el-input>
             </el-col>
       </el-row>
    </el-form-item>
          <el-form-item label="优惠编号" prop="discountid" style="margin-bottom:5%;">
            <!--
      <el-input v-model="discountid" readonly></el-input>
      -->
       <el-row type="flex" justify="start">
               <el-col :span="10" >
          <el-input v-model="discountid" readonly></el-input>
             </el-col>
       </el-row>
    </el-form-item>
    <el-form-item label="优惠名称" prop="discountname" style="margin-bottom:5%;">
      <el-input v-model="modifiedname" placeholder="请输入优惠名称"></el-input>
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
        var b = this.$route.params.discount
        
        this.$confirm(window.sessionStorage.getItem('discountid')+','+window.sessionStorage.getItem('storeid')+','+b)
        this.storeid = window.sessionStorage.getItem('storeid')
        this.discountid = window.sessionStorage.getItem('discountid')
        this.discountname = b
        this.modifiedname = b
      /*  this.discountname = b
        this.detail = c
        this.modifiedname = b
        this.modifieddetail = c*/
      },
    commit(formName)
    {
            this.$confirm('确认内容并提交更改？',
                          '提示',
                          {confirmButtonText:'确定更改',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked = true
              if(this.modifiedname.split(" ").join("").length === 0){
                this.resultname = this.discountname

              }else{
                this.resultname = this.modifiedname
              }
              
              this.axios.get('/api/Store/modifydiscount',{              //接口在这里接口在这里接口在这里接口在这里！！！！！！！！！！
                params:{
                  discount:this.resultname,
                  storecomid:this.discountid,

                }
                
              }).then((response)=>{
                if(response.status === 200){
                  //console.log(response);
                  //console.log(response.data.result);
                 // if(response.data.result === null){
                    this.$message({type:'success',message:'提交成功！'});
                    this.$router.push({name:"Discount"});
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
          
        
      
    }
  },
  data() {
    return {
      clicked:false,
      title:'修改商家优惠',
      storeid:'',
      discountid:'',
      discountname:'',
      detail:'',
      modifiedname:'',
      modifieddetail:'',
      resultname:'',
      resultdetail:''
    }
  }
}
</script>

