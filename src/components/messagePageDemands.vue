<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="center">
      <el-col>
        <div style="font-size:190%; height:50px; color:#858585fa;text-align:center;">
            <div>
               biaoti
            </div>
        </div>
      </el-col>
    </el-row>

    <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin-top:10px;margin-bottom:20px;padding:0px;overflow:hidden;"></div>
    </el-row>

    <el-row type="flex" justify="center">
      <el-col style="font-size:90%;color:#858585fa;text-align:center;margin-bottom:50px;">
        time
      </el-col>
    </el-row>


    <el-row type="flex" justify="center">

      <el-col :span="14">
        <div style="font-size:100%; height:50px; color:#858585ff;text-align:center;">
            <div>
               detail
            </div>
        </div>
      </el-col>
    </el-row>    

  </div>
</template>

<script>
export default {
  //mounted:function(){
  //   this.show(this.$route.params.data)
  //   this.tableData = this.$route.params.data
  // },
  methods:{
    show(a){
       this.$confirm(a,'提示')
    }
  },
  data () {
    return {
      tableData: []
    }
  }
}
</script>