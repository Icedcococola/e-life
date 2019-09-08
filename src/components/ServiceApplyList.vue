<template>
  <div id="l-ac">

    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="14">
        <div class="tit" style="font-size:250%; height:50px; color:#858585;text-align:left;"><i class="el-icon-document"></i>{{title}}</div>
      </el-col>
      <el-col :span='8'>
          <el-input v-model="search" class="search" icon="search" placeholder="请输入要搜索的标题关键字"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button icon="el-icon-search" circle></el-button>
      </el-col>
   
    </el-row>
    <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>
    
    <el-table
      :data="searchData.slice((currentPage-1)*pagesize,currentPage*pagesize)"
      style="width: 100%"
      :default-sort="{prop:'no',order:'ascending'}">
      
      <el-table-column
        type="index"
        label="序号"
        width="60"
        align="center">
      </el-table-column>
      <el-table-column
        prop="storecomserviceid"
        label="编号"
        width="90"
        align="center">
      </el-table-column>
      <el-table-column
        prop="storename"
        label="商店名称"
        width="200"
        align="center">
      </el-table-column>
      <el-table-column
        prop="community"
        label="社区"
        width="200"
        align="center">
      </el-table-column>
      <el-table-column
        prop="type"
        label="服务类型"
        width="200"
        align="center">
      </el-table-column>
      <el-table-column
        prop="op"
        label="操作"
        width="250"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="primary" @click="agree(scope.row.storecomserviceid)" round>同意</el-button>
            <el-button type="danger" @click="refuse(scope.row.storecomserviceid)" round>拒绝</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="block">
    
    <el-pagination
      layout="prev, pager, next, total"
      :page-size="pagesize"
      @current-change="current_change"
      :total=this.searchData.length>
    </el-pagination>
    </div>
  </div>
</template>

<script>
 export default {
      mounted:function(){
        this.getTableData();
      },
      
      computed:{

        searchData:function(){
          var search = this.search;
          if(search){
            return this.tableData.filter(function(dt){
              return Object.keys(dt).some(function(key){
                return String(dt[key]).toLowerCase().indexOf(search) > -1
              })
            })
          }  
          return this.tableData                 
        }

      },

      methods:
      {
          agree(storecomserviceid){
              this.storecomserviceid = storecomserviceid
             this.$confirm('确定同意该服务商的申请？',
                           '提示',
                           {confirmButtonText:'确定',cancelButtonText:'取消'})
             .then(()=>{
                 this.axios.get('/api/Servicea/agree',
                 {
                     params:{
                         storecomserviceid:this.storecomserviceid
                     }
                 }
                 ).then((response)=>{
                     if(response.status === 200){
                         console.log(response);
                         this.$message({type:'success',message:'成功同意该申请'})
                     }
                 })

             })
          },

          refuse(storecomserviceid){
              this.storecomserviceid = storecomserviceid
              this.$confirm('确定拒绝该服务商的申请？',
                             '提示',
                           {confirmButtonText:'确定',cancelButtonText:'取消'})
              .then(()=>{
                  this.axios.get('/api/Servicea/refuse',
                  {
                      params:{
                          storecomserviceid:this.storecomserviceid
                      }
                  }).then((response)=>{
                      if(response.status === 200){
                          console.log(response);
                          this.$message({type:'success',message:'成功拒绝该申请'})
                      }
                  })
              })
          },
        topage(storeid){
          this.$store.commit('SET_STOREID',storeid)
           //var fd  = new FormData()
           //fd.append("latestnewsid",storeid)
           this.axios.get('/api/Store/getdiscount',{
            params:{
              storeid:storeid
            }
          }
          ).then((response)=>{
            console.log(response.data)
            this.$router.push({
            name:"Discount",
            params:{
              data:response.data,
              
            }
            });
          })

          },/*
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


        getTableData(){
          //var fd = new FormData()
          //fd.append("community",window.sessionStorage.getItem('community'))
          this.axios.get('/api/Servicea/listallapply',{
          params:{
            community:window.sessionStorage.getItem('community')
          }
          })
          .then((response)=>{
            var dt = response.data;
            this.tableData = dt;
          })
        },
      },
      data() {
        return {
          storename:'',
          goodsid:'',
          pagesize:5,
          currentPage:1,
          title:'服务提供商申请',
          storecomserviceid:'',
          input: '',
          search: '',
          tableData: [
              

          ]
        }
      }
    }
</script>
