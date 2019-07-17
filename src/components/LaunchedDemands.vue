<template>
  <div id="l-ac">

    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="14">
        <div class="tit" style="font-size:190%; height:50px; color:#858585;text-align:left;"><i class="el-icon-document"></i>{{title}}</div>
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
      :data="searchData"
      style="width: 200%,"
      row-style="height:80px"
      :default-sort="{prop:'no',order:'ascending'}">
      
      <el-table-column
        type="index"
        label="序号"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="community"
        label="社区"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="deatil"
        label="详情"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="goodsid"
        label="商品ID"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="goodsname"
        label="商品名称"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="img"
        label="图片"
        width="100"
        align="center">
        <template slot-scope="scope">
              <img :src=scope.row.img alt="" style="width:80px;height:80px">
         </template>
      </el-table-column>
      <el-table-column
        prop="price"
        label="价格"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="price"
        label="价格"
        width="80"
        align="center">
      </el-table-column>
      <el-table-column
        prop="remainingnum"
        label="剩余数量"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="store"
        label="店名"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="totalnum"
        label="总数"
        width="100"
        align="center">
      </el-table-column>
      <el-table-column
        prop="deadline"
        label="活动时间"
        width="100"
        align="center">
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
          //this.axios.get('/api/Activity/findbyid',{
          //  params:{
          //    activityid:lalala
          //  }
          //}).then((response)=>{
          //  this.$confirm(response.data.detail,'活动详情')
          //  console.log(response)
          //})
          this.$router.push(
              {
                  name:'messagePageDemands',
                  params:{
                      
                  }
              }
          )
          
        },

        deleteLine(id,index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
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

          }
          )
        },

        getTableData(){
          var fd  = new FormData()
          fd.append("community",window.sessionStorage.getItem('community'))
          this.axios.post('/api/Goods/find',fd,
          {
            headers:{
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
          //this.axios.get('/api/Activity/findAll',
          //{
          //  params:{
          //    community:window.sessionStorage.getItem('community')
          //  }
          //}
          )
          .then((response)=>{
            console.log(response.data)
            var dt = response.data;
            this.tableData = dt;
          })
        },
      },
      data() {
        return {
          title:'已上架商品',
          input: '',
          search: '',
          tableData: []
        }
      }
    }
</script>
