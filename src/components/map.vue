<template>
    <div class="amap-page-container">
      <el-row style="font-size:17px;margin-bottom:8px" type="flex" justify="start">
        <el-col :span="22">
          <el-row type="flex" justify="start">
          Position:[{{lng}},{{lat}}]Address:{{address}}
          </el-row>
        </el-col>
        <el-col :span="2">
          <el-button @click="commit">确定</el-button>
        </el-col>
      </el-row >

      <el-amap
        vid="amapDemo"  
        :center="center"
        :zoom="zoom"  
        class="amap-demo"
        :plugin="plugin"
        :events="events">
      </el-amap>
      
    </div>
  </template>

  <style>
    .amap-page-container{
      height:490px;
      width:920px
    }
   /* .amap-demo{
      height:450px;
      width:920px
    }*/
  </style>

  <script>
  
    export default {
      mounted:function(){
         
      },
      methods:{
       
         commit(){
           this.$confirm(this.lng+','+this.lat+','+this.address)
           .then(() => {
             this.$router.push({
               name:'AddStore',
               params:{
                  longitude:this.lng,
                  latitude:this.lat,
                  address:this.address,
                  }
             })
           })
         },

         setcenter(){

         }
      },
      data: function() {
        let self = this;
        return {
          zoom: 12,
          center: [121.59996, 31.197646],
          plugin:['Geocoder'],
          address: 'address',
          events: {
            click(e) {
              let { lng, lat } = e.lnglat;
              self.lng = lng;
              self.lat = lat;
              // 这里通过高德 SDK 完成。
              var geocoder = new AMap.Geocoder({
                radius: 1000,
                extensions: "all"
              });        
              geocoder.getAddress([lng ,lat], function(status, result) {
                if (status === 'complete' && result.info === 'OK') {
                  if (result && result.regeocode) {
                    self.address = result.regeocode.formattedAddress;
                  }
                }
              });  
            }
          },
          lng: 0,
          lat: 0
        };
      }
    };
</script>