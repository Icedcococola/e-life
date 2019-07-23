<template>
    <div class="amap-page-container">
      <el-amap
        vid="amapDemo"  
        :center="center"
        :zoom="zoom"  
        :plugin="plugin"
        class="amap-demo"
        :events="events">
      </el-amap>
      <div class="toolbar">
        position: [{{ lng }}, {{ lat }}]
      </div>
    </div>
  </template>

  <style>
    .amap-page-container {
      width: 1240px;
      height: 588px;
      margin:0px
    }
  </style>

  <script>
    export default{
      data: function() {
        let self = this;

        return {
          zoom: 12,
          center: [121.59996, 31.197646],
          events: {
            click(e) {
              let { lng, lat } = e.lnglat;
              self.lng = lng;
              self.lat = lat;
              self.$confirm(self.lng+','+self.lat)
            }
          },
          lng: 0,
          lat: 0
        };
      }
    };
</script>