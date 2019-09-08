<template>
  <div>

  <el-row >
      <el-col >
        <div class="t" style="font-size:230%; height:50px; color:#858585;text-align: right"><i class="el-icon-edit"></i>{{title}}</div>
      </el-col>
  </el-row>

  <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin:0px auto;padding:0px;overflow:hidden;"></div>
  </el-row>

  <el-row type="flex" justify="center" >
    <el-col :span="18">

    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:4%">
      

      <el-form-item label="商家名称" prop="storename" style="margin-bottom:4%;">
        <el-row type="flex" justify="start">
        <el-col :span="12">
           <el-input v-model="ruleForm.storename" disabled></el-input>
        </el-col>
        </el-row>
      </el-form-item>
      
      
      <el-form-item label="社区" prop="community" style="margin-bottom:4%">
         <el-row type="flex" justify="start">
           
          <el-select v-model="ruleForm.community" placeholder="请选择社区">
          <el-option label="交大闵行" value="SJTU MINHANG"></el-option>
          <el-option label="交大徐汇" value="SJTU XUHUI"></el-option>
          </el-select>  
        </el-row>
      </el-form-item>

      <el-form-item label="商户类型" prop="type" style="margin-bottom:4%">
         <el-row type="flex" justify="start">
           
          <el-select v-model="ruleForm.type" placeholder="请选择商户类型">
          <el-option label="周边餐饮" value="1"></el-option>
          <el-option label="超市购物" value="2"></el-option>
          <el-option label="休闲娱乐" value="3"></el-option>
          <el-option label="生活服务" value="4"></el-option>
          </el-select>  
        </el-row>
      </el-form-item>


       <el-form-item label="商户位置" prop="location" style="margin-bottom:4%">
       <el-row>
         <el-col :span="10">
           
          <el-popover
             ref="popover4"
             placement="right"
             width="500"
             trigger="click">
             <!--<el-table :data="gridData">
             <el-table-column width="150" property="date" label="日期"></el-table-column>
             <el-table-column width="100" property="name" label="姓名"></el-table-column>
             <el-table-column width="300" property="address" label="地址"></el-table-column>
             </el-table>
             -->
             <el-amap
              vid="amapDemo"  
              :center="center"
              :zoom="zoom"  
              class="amap-demo"
              style="height:350px;width:500px"
              :plugin="plugin"
              :events="events">
             </el-amap>

             <div>
                经纬：{{longitude}}，{{latitude}}<br>地址：{{address}}
             </div>
            </el-popover> 

        <el-input readonly v-model="location" id="lnglat" placeholder="点击右侧按钮选择位置">
          <el-button v-popover:popover4 slot="append" icon="el-icon-location-outline"></el-button>
        </el-input>
         </el-col>
       </el-row>
      </el-form-item>


      <el-form-item label="优惠" prop="discount" style="margin-bottom:4%;">
        <el-row type="flex" justify="start">
        <el-col :span="12">
           <el-input v-model="ruleForm.discount" placeholder="请输入优惠"></el-input>
        </el-col>
        </el-row>
      </el-form-item>

    </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')" :loading="isclicked">提交申请</el-button>

  </div>
</template>

<script>
export default {
    mounted:function(){
       //this.showDemandId(ruleForm); 
       //this.setlnglat()

    },
  methods:
  {
    setlnglat(){
       if(this.longitude === undefined){
         var string1 = '点击右侧按钮选择位置'
         var string2 = '点击右侧按钮选择地址'
         this.location = string1
         this.address = string2
       }else{
         this.location = this.longitude+'，'+this.latitude
       }
      // this.$confirm(this.location+','+this.address)
    },
    commit(formName)
    
    {
      if(this.longitude === undefined || this.longitude === 0){
        this.$confirm('请选择商家位置')
      }else{
        this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认内容并提交？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.isclicked=true
              this.axios.get('/api/Discount/applyfordiscount',
              {
                params:{
                  storename:this[formName].storename,
                  
                  type:this[formName].type,
                 // community:window.sessionStorage.getItem('community'),
                  community:this[formName].community,
                  discount:this[formName].discount,
                  longitude:this.longitude,
                  latitude:this.latitude
                }
              }
              ).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  this.$message({type:'success',message:'提交成功！'});
                  this.$router.push({name:"StoreDiscount"});
                      
                }
              })
              .catch(error => {
                this.isclicked = false
                console.log(error.response.status)
                if(error.response.status === 404){
                  this.$router.push({
                    name:'fof'
                  })
                }
                else if(error.response.status === 500){
                  this.$router.push({
                    name:'fot'
                  })
                }
              })
            }
            );
          }else{
            this.$alert('请填写完整','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
        })
        }
    },
 
    handleAvatarSuccess(res, file) {
       
    },
    beforeAvatarUpload(file) {
        console.log(file)
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if(!isJPG && !isPNG){
         this.$message.error('上传图片只能是jpg/jpeg或png格式！')
         this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
         this.fileList =[]
         //handleRemove(file,fileList) 
        }
        if(!isLt2M){
         this.$message.error('上传图片大小不能超过2M！')
         this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
         //handleRemove(file,fileList)
        }
        if((isJPG || isPNG) && isLt2M){
         let fd = new FormData()
         fd.append('smfile',file)
         this.axios.post('/img',fd)
         .then((response)=>{
          if(response.status === 200){
            console.log(response.data.code)
            if(response.data.code === "success"){
              console.log(response.data.data.url)
              this.imageUrl = response.data.data.url
            }
          }
        }) 
        }else{
          /*
          let fd = new FormData()
          fd.append('smfile',file)
          this.axios.post('/img',fd)
          .then((response)=>{
          if(response.status === 200){
            console.log(response.data.code)
            if(response.data.code === "success"){
              console.log(response.data.data.url)
              this.imageUrl = response.data.data.url
            }
          }
        }) */

        //this.imageUrl = 'https://i.loli.net/2019/07/19/5d3129a0dbc7876672.jpg'
        }
        
    },

    checkValidUpload(file){
       const isJPG = file.type === 'image/jpeg';
       const isPNG = file.type === 'image/png';
       const isLt2M = file.size / 1024 / 1024 <2;
       
       if(!isJPG && !isPNG){
         this.$message.error('上传图片只能是jpg/jpeg或png格式！')
       }
       if(!isLt2M){
         this.$message.error('上传图片大小不能超过2M！')
       }
       return (isJPG || isPNG) && isLt2M
    },


    handlePreview(file) {
        console.log(file);
    },
    handleExceed(files, fileList) {
        this.$message.warning(`最多选择 1 张图片`);
    },
    handleRemove(file, fileList) {
        console.log(file, fileList);
        this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
    },
    beforeRemove(file, fileList) {
        return this.$confirm(`确定移除 ${ file.name }?`);
    },
    
  },

  data() {
    let self = this;
    return {
      isclicked:false,
      zoom: 12,
      gridData:[{
         date:'2019-07-09',
         name:'哈哈',
         address:'啦啦啦啦啦啦啦啦啦'

      }],
      center: [121.59996, 31.197646],
      plugin:['Geocoder',
             {
            pName: 'Geolocation',
            events: {
              init(o) {
                // o 是高德地图定位插件实例
                o.getCurrentPosition((status, result) => {
                  if (result && result.position) {
                    self.lng = result.position.lng;
                    self.lat = result.position.lat;
                    self.center = [self.lng, self.lat];
                    self.loaded = true;
                    self.$nextTick();
                  }
                });
              }
            }
          }],
      imageUrl: 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg',
      title:'申请加入周边优惠',
      events: {
            click(e) {
              let { lng, lat } = e.lnglat;
              self.longitude = lng;
              self.latitude = lat;
              self.location = self.longitude + '，' + self.latitude
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
      lat: 0,
      fileList: [],
      ruleForm:{
        storename:window.sessionStorage.getItem('storename'),
        type:'',
        picture:'',
        discount:''
        
      },
      address:'',
      location:'',
      longitude:0,
      latitude:0,
      
      rules:{
        storename:[
          {required:true, message:'请输入商家名称', trigger:'blur'},
        ],
        type:[
          {required:true,message:'请选择商户类型',trigger:'blur'}
        ],
        discount:[
          {required:true,message:'请输入优惠',trigger:'blur'}
        ],
        community:[
          {required:true,message:'请输入社区',trigger:'blur'}
        ]
      }
    }
  }
}
</script>

<style>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #909092;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>