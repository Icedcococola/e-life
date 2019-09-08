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
            
      <el-form-item label="编号" prop="pricelistid">
         <el-input v-model="form.pricelistid"></el-input>
      </el-form-item>

      <el-form-item label="价格" prop="price">
         <el-input v-model="form.price"></el-input>
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
      mounted:function(){
        this.getTableData();
      },

      methods:
      {
         submit(formName)
    {
        this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认提交申请？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked=true
              this.axios.get('/api/Servicea/changeprice',
              {
                params:{
                  pricelistid:this[formName].pricelistid,
                  price:this[formName].price
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
                  this.$router.push({name:"Service"});
                      
                  
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
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看活动安排"});
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
        /*
        topage(lalala){
          var fd  = new FormData()
          fd.append("activityid",lalala)
          this.axios.post('/api/Activity/findbyid',fd,{
            headers:{
              'Content-Type': 'application/x-www-form-urlencoded'
            }}
          ).then((response)=>{
            this.$confirm(response.data.detail,'活动详情')
            console.log(response)
          })
          
        },
*/
        
        current_change:function(currentPage){
           this.currentPage = currentPage;
        },
        /*
        deleteLine(id,index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            this.clicked = true
            var fd = new FormData()
            fd.append("activityid",id)
            this.axios.post('/api/Activity/delete',fd,{
              headers:{
                  'Content-Type': 'application/x-www-form-urlencoded'
              }
            }
            ).then((response)=>{
              if(response.status === 200){
                this.searchData.splice(index,1);
                this.$message({type:'success',message:'删除成功!'});
                this.clicked = false 
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
              if(error.response.status === 500){
                this.$router.push({
                  name:'fot'
                })
              }
            })

           
          }
          )
        },
*/
      },
      data() {
        return {
          form:{
            type:'',
            pricelistid:window.sessionStorage.getItem('pricelistid'),
            price:''
          },
          rules:{
            pricelistid:[
                {required:true,message:'请填写编号', trigger:'blur'}
            ],
            price:[
                {required:true,message:'请输入新价格',trigger:'blur'}
            ]
          },
          pagesize:5,
          currentPage:1,
          title:'修改电脑维修价格',
          input: '',
          search: '',
          options: [{
          value: '1',
          label: '超市送货'
        }, {
          value: '2',
          label: '电脑维修'
        }],
          options1: [{
          value: 'SJTU MINHANG',
          label: 'SJTU MINHANG'
        }, {
          value: 'SJTU XUHUI',
          label: 'SJTU XUHUI'
        }],
          tableData: [{
              storeid:5555,
              community:'SJTU MINHANG',
              address:'东川路800号'

          },
          {
              storeid:1744,
              community:'SJTU XUHUI',
              address:'华山路1954号'
          }]
        }
      }
    }
</script>
