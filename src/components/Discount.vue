<template>
  <div id="l-ac">

    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="12">
        <div class="tit" style="font-size:250%; height:50px; color:#858585;text-align:left;"><i class="el-icon-document"></i>{{title}}</div>
      </el-col>
      <el-col :span='8'>
          <el-input v-model="search" class="search" icon="search" placeholder="请输入要搜索的标题关键字"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button icon="el-icon-search" circle></el-button>
      </el-col>
      <el-col :span="2">
        <el-button icon="el-icon-plus" circle type="success" @click="adddiscount"></el-button>
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
        prop="storeid"
        label="商户id"
        width="90"
        align="center">
      </el-table-column>
      <el-table-column
        prop="storecomid"
        label="优惠id"
        width="230"
        align="center">
      </el-table-column>       
      <el-table-column
        prop="discount"
        label="优惠详情"
        width="370"
        align="center">
      </el-table-column>  
      <el-table-column
        prop="op"
        label="操作"
        width="150"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="primary" icon="el-icon-edit" circle @click="topage(scope.row.storecomid,scope.row.discount)"></el-button>
            <el-button type="danger" icon="el-icon-delete" circle @click="deleteLine(scope.$index,scope.row.storecomid)"></el-button>

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
       //this.show()
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
          show(){
              this.$confirm(window.sessionStorage.getItem('storeid'))
          },
          adddiscount(){
           /* this.$router.push({
                name:'AddDiscount'
            })*/
            if(this.tableData.length === 1)
            {
              this.$confirm('不可添加')
            }else{
              this.$router.push({
                name:'AddDiscount'
              })
            }
          },
          addLine(){
          var newValue={
            company:'',
            phonenum:'',
            orderid:''
          };
          this.tableData.push(newValue);
        },
          topage(discountid,discount){
          /* var fd  = new FormData()
           fd.append("storeid",lhlhlh)
           this.axios.post('/api/Latestnews/findbyid',fd,{
            headers:{
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
          ).then((response)=>{
            console.log(response.data)
            this.$router.push({
            name:"Discount",
            params:{
              data:response.data
            }
            });
          })
*/         this.$store.commit('SET_DISCOUNTID',discountid)
           this.$router.push({
               name:"modifyDiscount",
               params:{
                   
                   discount:discount,
                   
               }
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
        
        deleteLine(index,id){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            this.clicked = true
            //var fd = new FormData()
            //fd.append("discountid",id)
            this.axios.get('/api/Store/deletediscount',{
              params:{
                  storecomid : id
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



        getTableData(){
          
          //var fd = new FormData()
          //fd.append("community",window.sessionStorage.getItem('community'))
          this.axios.get('/api/Store/getdiscount',{
           params:{
             storeid:window.sessionStorage.getItem('storeid')
           }}
           )
          .then((response)=>{
            var dt = response.data;
            this.tableData = dt;
          })
          //var dt = this.$route.params.data;
          //this.tableData = dt;
        },
      },
      data() {
        return {
          storeid:'',
          pagesize:5,
          currentPage:1,
          title:'商户优惠列表',
          input: '',
          search: '',
          tableData: []
        }
      }
    }
</script>
