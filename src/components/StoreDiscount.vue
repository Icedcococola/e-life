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
    <el-col :span="12">
    <el-form ref="form" :model="form" label-width="80px">
  <el-form-item label="商店名称">
    <el-input v-model="form.storename" disabled></el-input>
  </el-form-item>
    <el-form-item label="社区名称">
        <el-row type="flex" justify="start">
    <el-select v-model="form.community" placeholder="请选择社区">
        
    <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
  </el-row>
  </el-form-item>
  </el-form>
  <el-row type="flex" justify="center">
  <el-form :inline="true">
<el-form-item >
    <el-button type="primary" @click="finddiscount('form')" >查看</el-button>
    <el-button type="primary" @click="modifydiscount('form')" >修改</el-button>
  </el-form-item>
  </el-form>
  </el-row>
    </el-col>
    </el-row>

    <el-row type="flex" justify="center">
    <div style="width:80%;background:#EEEEEE;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>

    <el-row type="flex" justify="center">
        {{this.discount}}
    </el-row>
  </div>
</template>

<script>
 export default {
    /*  mounted:function(){
        this.getTableData();
      },
    */ 
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
          modifydiscount(form){
             this.$store.commit('SET_COMMUNITY',this[form].community)
             this.$router.push({
                 name:'StoreModifyDiscount'
             })
          },
          finddiscount(form){
             this.$store.commit('SET_COMMUNITY',this[form].community)
             this.axios.get('/api/Discount/findmine',{
                 params:{
                    community:this[form].community,
                    storename:window.sessionStorage.getItem('storename')
                 }
                 }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  this.discount = response.data.discount
                }
              })
             }
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
          this.axios.get('/api/Discount/findmine',{
          params:{
            storename:window.sessionStorage.getItem('storename'),
            community:this[form].community
          }
          })
          .then((response)=>{
            var dt = response.data;
            this.tableData = dt;
          })
        },
      
      data() {
        return {
          form:{
            storename:window.sessionStorage.getItem('storename'),
            community:''
          },
          options: [{
          value: 'SJTU MINHANG',
          label: '交大闵行'
        }, {
          value: 'SJTU XUHUI',
          label: '交大徐汇'
        }],
          pagesize:5,
          currentPage:1,
          title:'本店优惠',
          input: '',
          search: '',
          discount:'',
          tableData: {
            discount:'lalalalalalalalalalalalllllllaaaaaaaa'
          }
        }
      }
    }
</script>
