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
        width="180"
        align="center">
      </el-table-column>
      <el-table-column
        prop="title"
        label="标题"
        align="center">
      </el-table-column>      
      <el-table-column
        prop="date"
        label="日期"
        width="210"
        align="center">
      </el-table-column>     
      <el-table-column
        prop="op"
        label="操作"
        width="210"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="primary" @click="topage" round>查看</el-button>
            <el-button type="danger" @click="deleteLine(scope.$index)" round >删除</el-button>
          </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
 export default {

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
        topage(){
          this.$router.push({
            name:"活动详情页"
          });

        },

        deleteLine(index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            this.searchData.splice(index,1);
            this.$message({type:'success',message:'删除成功!'});
          }
          )
        },

      },
      data() {
        return {
          input: '',
          search: '',
          tableData: [{
            date: '2019-07-02',
            title: '广场舞大赛'
          }, {
            date: '2019-07-04',
            title: '划龙舟大赛'
          }, {
            date: '2019-07-01',
            title: '包粽子大赛'
          }, {
            date: '2019-07-03',
            title: '欢乐斗地主'
          }]
        }
      }
    }
</script>
