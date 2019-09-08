<template>
  <div id="l-ac">

    <el-row type="flex" class="row-bg" justify="start">
      <el-col :span="14">
        <div class="tit" style="font-size:250%; height:50px; color:#858585;text-align:left;"><i class="el-icon-document"></i>{{title}}</div>
      </el-col>
   
   
    </el-row>
    <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>
    
    <el-row type="flex" justify="center">
        
        <el-form ref="form" :rules="rules" :model="form" label-width="90px" style="margin-top:2%">
            
      <el-form-item label="店名" prop="storename">
         <el-input v-model="form.storename" disabled></el-input>
      </el-form-item>

      <el-form-item label="社区" prop="community">
         <el-input v-model="form.community" disabled></el-input>
      </el-form-item>

      <el-form-item label="优惠" prop="discount">
         <el-input v-model="form.discount"></el-input>
      </el-form-item>


    <el-form-item>
      <el-button type="primary" @click="submit('form')">提交修改</el-button>
    </el-form-item>
    </el-form>
    </el-row>

  </div>
</template>

<script>
import { format } from 'path';
 export default {
   /*   mounted:function(){
        this.getTableData();
      },
*/
      methods:
      {
         submit(formName)
    {
        this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认提交修改？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked=true
              this.axios.get('/api/Discount/change',
              {
                params:{
                  community:window.sessionStorage.getItem('community'),
                  storename:window.sessionStorage.getItem('storename'),
                  discount:this[formName].discount
                }
              }
              ).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  //console.log(response.data.result);
                  //if(response.data.result === null){
                    //this.$message({type:'success',message:'提交成功！'});
                    //this.$router.push({name:"查看活动安排"});
                  //}
                  this.$message({type:'success',message:'提交成功！'});
                  this.$router.push({name:"StoreHome"});
                      
                  
                }
              })
              .catch(error => {
                this.clicked = false
                console.log(error.response.status)
                if(error.response.status === 404){
                  this.$router.push({
                    name:'fof'
                  })
                }
                else if(error.response.status === 500){
                  this.$router.push({
                    name:'fot'
                  })
                }
              })
            }
            );
          }else{
            this.$alert('请正确填写','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
        })

      
    },
        
        current_change:function(currentPage){
           this.currentPage = currentPage;
        },
      },
      data() {
        return {
          form:{
            storename:window.sessionStorage.getItem('storename'),
            community:window.sessionStorage.getItem('community'),
            discount:''
          },
          rules:{
            discount:[
              {required:true,message:'请填写优惠', trigger:'blur'}
            ]
          },
          pagesize:5,
          currentPage:1,
          title:'修改本店优惠',
          input: '',
          search: '',
          
        }
      }
    }
</script>
