import moment from 'moment'

<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="14">
        <div class="new" style="font-size:250%; height:50px; color:#858585;text-align:left;"><i class="el-icon-document"></i>{{title}}</div>
      </el-col>
      <el-col :span='8'>
        <el-input v-model="search" class="search" icon="search" placeholder="请输入搜索内容"></el-input>
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
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="latestnewsid"
        label="资讯编号"
        width="150"
        align="center">
      </el-table-column>  
      <el-table-column
        prop="title"
        label="标题"
        align="center">
      </el-table-column>    
      <el-table-column
        prop="time"
        
        label="日期"
        width="160"
        align="center">
      </el-table-column>
      <el-table-column
        prop="op"
        label="操作"
        width="210"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="primary" @click="topage(scope.row.latestnewsid)" round>查看</el-button>
            <el-button type="danger" @click="deleteLine(scope.row.latestnewsid,scope.$index)" round >删除</el-button>
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
          this.getNewsData();
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
        topage(lhlhlh){
          var fd  = new FormData()
          fd.append("latestnewsid",lhlhlh)
          this.axios.post('/api/Latestnews/findbyid',fd,{
            headers:{
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
          ).then((response)=>{
            console.log(response.data)
            this.$router.push({
            name:"资讯详情页",
            params:{
              data:response.data
            }
            });
          })

        },
        
        current_change:function(currentPage){
           this.currentPage = currentPage;
        },
        deleteLine(id,index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            //this.searchData.splice(index,1);
            var fd  = new FormData()
            fd.append("latestnewsid",id)
            this.axios.post('/api/Latestnews/delete',fd,
            {
              headers:{
                'Content-Type': 'application/x-www-form-urlencoded'
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

        getNewsData(){
          var fd  = new FormData()
          fd.append("community",window.sessionStorage.getItem('community'))
          this.axios.post('/api/Latestnews/findAll',fd,{
            headers:{
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
          )
          .then((response)=>{
            var newsDt = response.data;
            this.tableData = newsDt;
          })
        },


      },
      data() {
        return {
          pagesize:5,
          currentPage:1,
          title:'最新资讯',
          input: '',
          search:'',
          tableData: []
        }
      }
    }
</script>
