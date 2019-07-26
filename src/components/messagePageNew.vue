<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="center">
      <el-col>
        <div style="font-size:270%; height:50px; color:#858585fa;text-align:center;">
            <div >
               {{title}}
            </div>
        </div>
      </el-col>
    </el-row>

    <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin-top:10px;margin-bottom:20px;padding:0px;overflow:hidden;"></div>
    </el-row>

    <el-row type="flex" justify="center">
      <el-col style="font-size:150%;color:#858585fa;text-align:center;margin-bottom:10px;">
        {{time}}
      </el-col>
    </el-row>


    <el-row type="flex" justify="center">

      <el-col :span="18">
        <div style="font-size:150%; height:50px; color:#858585ff;text-align:left;">
            <div class="text-wrapper">
               {{detail}}
            </div>
        </div>
      </el-col>
    </el-row>    

  </div>
</template>

<script>
export default {
  mounted:function(){
    this.show()
     //this.tableData = this.$route.params.data
  },
  methods:{
    show(){
       this.$confirm(this.$route.params.title+','+this.$route.params.time+','+this.$route.params.detail)
       this.title = this.$route.params.title
       this.time = this.$route.params.time
       this.detail = this.$route.params.detail
    }
  },
  data () {
    return {
      title:'',
      time:'',
      detail:'',
      tableData: []
    }
  }
}
</script>

<style>
  .text-wrapper{
    white-space: pre-line;
  }
</style>
