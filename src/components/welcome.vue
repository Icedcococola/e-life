<template>
  <div class="middle" style="backgroundImage: 'url(' + require('@/assets/welcome.jpg') + ')'">


    <el-row  type="flex" justify="center">

    <el-col :span="13" style="font-size:60px;color:#000000;margin-top:10%;">
        欢迎使用elife智能生活社区后台管理系统

    </el-col>

    </el-row>
  </div>
</template>

<style>
  .time {
    font-size: 13px;
    color: #999;
  }
  
  .bottom {
    margin-top: 13px;
    line-height: 12px;
  }

  .button {
    padding: 0;
    float: right;
  }

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
      display: table;
      content: "";
  }
  
  .clearfix:after {
      clear: both
  }
</style>

<script>
export default {
  methods:{
    wuye(){
      this.$router.push({
          name:'wuyeLogin'
        });
    },
    parcel(){
      this.$router.push({
          name:'parcelLogin'
        });
    },
  },

  data: () => ({
      show2: true
    })
  
}
</script>