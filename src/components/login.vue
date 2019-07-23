<template>
  <div>
    <el-row  type="flex" justify="center" style="margin-top:10%" :gutter="90">

    <el-col :span="6">
      
     <el-card :body-style="{ padding: '0px' }" >
      <img src="@/assets/wy.jpg" class="image" @click="wuye">
      <div class="x" style="padding: 25px;font-size:120%">
        我是物业管理员
        <div class="bottom clearfix">
        </div>
      </div>
     </el-card>

    </el-col>

    <el-col :span="6">
     <el-card :body-style="{ padding: '0px' }" >
      <img src="@/assets/yb.jpg" class="image" @click="parcel">
      <div class="y" style="padding: 25px;font-size:18px">
        我是邮包管理员
        <div class="bottom clearfix">
        </div>
      </div>
     </el-card>

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