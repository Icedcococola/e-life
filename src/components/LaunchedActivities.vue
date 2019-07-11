<template>
  <div id="l-ac">

    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="14">
        <div style="font-size:190%; height:50px; color:#858585fa;text-align:left;"><i class="el-icon-document"></i>活动安排
        </div>
      </el-col>
      <el-col :span='8'>
          <el-input v-model="search" class="search" icon="search" placeholder="请输入要搜索的标题关键字"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button icon="el-icon-search" circle></el-button>
      </el-col>
   


    </el-row>
    <el-row>
    <div style="width:100%;background:#c4c4c4fa;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>
    
    <el-table
      :data="searchData"
      style="width: 100%"
      :default-sort="{prop:'no',order:'ascending'}">
      
      <el-table-column
        type="index"
        label="序号"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="activityid"
        label="活动编号"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="title"
        label="标题"
        width="250"
        align="center">
      </el-table-column>
      <el-table-column
        prop="time"
        label="日期"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="activitytime"
        label="时间"
        width="100"
        align="center">
      </el-table-column>        
      <el-table-column
        prop="place"
        label="地点"
        width="200"
        align="center">
      </el-table-column>   
      <el-table-column
        prop="op"
        label="操作"
        width="150"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="primary" @click="topage(scope.row.activityid)" icon="el-icon-search" circle></el-button>
            <el-button type="danger" @click="deleteLine(scope.row.activityid,scope.$index)" icon="el-icon-delete" circle></el-button>
          </template>
      </el-table-column>
    </el-table>
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
          if(search)   {
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
        topage(lalala){
          //this.$router.push({
          //  name:"活动详情页",
          //  params:{title:lalala}
          //});
          //alert(lalala);
          //var params = new URLSearchParams();
          //params.append('activityid',lalala)
          this.axios.get('/api/Activity/findbyid',{
            params:{
              activityid:lalala
            }
          }).then((response)=>{
            this.$confirm(response.data.detail,'活动详情')
            console.log(response)
          })
          

        },

        deleteLine(id,index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            //this.searchData.splice(index,1);
            //var params = new URLSearchParams();
            this.axios.get('/api/Activity/delete',{
              params:{
                activityid:id
              }
            }).then((response)=>{
              if(response.status === 200){
                this.searchData.splice(index,1);
                this.$message({type:'success',message:'删除成功!'});
              }
            })

            //this.$message({type:'success',message:'删除成功!'});
          }
          )
        },

        getTableData(){
          this.axios.get('/api/Activity/findAll',
          {
            params:{
              community:window.sessionStorage.getItem('community')
            }
          })
          .then((response)=>{
            var dt = response.data;
            this.tableData = dt;
           // var lalala = this.tableData;
           // console.log(lalala[1].content);
          })
        },


      },
      data() {
        return {
          input: '',
          search: '',
          tableData: []
        }
      }
    }
</script>
