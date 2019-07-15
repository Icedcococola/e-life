<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="center">
      <el-col :span="14">
        <div style="font-size:190%; height:50px; color:#858585fa;text-align:center;">
            <div>
               {{this.tableData.title}}
            </div>
        </div>
      </el-col>
    </el-row>

    <el-row>
    <div style="width:100%;background:#c4c4c4fa;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>

    <el-row type="flex" justify="start">

      <el-col :span="14">
        <div style="font-size:100%; height:50px; color:#858585fa;text-align:center;">
            <el-row type="flex" justify="center" :gutter="20">
               <el-col :span="6">
                 时间：
               </el-col>
               <el-col :span="6">
                 {{this.tableData.date}}
               </el-col>
               <el-col :span="3">
                 {{this.tableData.time}}
               </el-col>
            </el-row>
 
            <el-row>
              <el-col>

              </el-col>
            </el-row>

        </div>
      </el-col>
    </el-row>    

  </div>
</template>

<script>
export default {
  mounted:function(){
    this.showParam(this.$route.params.title)
  },

  methods:{
    showParam(wawa){
      this.axios.post('https://www.easy-mock.com/mock/5d22ed7d1994010b14459e3b/example/api/detail',
      {
        title:this.$route.params.title
      })
      .then((response)=>{
        if(response.status === 200){
          this.tableData = response.data;
        }

      })
    }
  },

  data () {
    return {
      tableData: [
        
      ]
    }
  }
}
</script>