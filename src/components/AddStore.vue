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
      <el-form-item label="商户位置" prop="location" style="margin-bottom:4%">
       <el-row>
         <el-col :span="11">
        <el-input readonly v-model="location" id="lnglat">
          <el-button slot="append" icon="el-icon-location-outline" @click="tomap"></el-button>
        </el-input>
         </el-col>
       </el-row>
      </el-form-item>

      <el-form-item label="详细地址" prop="address" style="margin-bottom:4%;">
      <el-col :span="24">

      <el-input readonly v-model="address" id="lnglat">
          <el-button :rows="2" slot="append" icon="el-icon-location-outline" @click="tomap" type="textarea" ></el-button>
        </el-input>
      </el-col>
    </el-form-item>

      <el-form-item label="商家名称" prop="storename" style="margin-bottom:4%;">
        <el-row type="flex" justify="start">
        <el-col :span="11">
           <el-input v-model="ruleForm.storename" placeholder="请输入商家名称"></el-input>
        </el-col>
        </el-row>
      </el-form-item>

      <el-form-item label="商户类型" prop="type" style="margin-bottom:4%">
        
            <el-row type="flex" justify="start">
              <el-col :span="6">
        <el-select v-model="ruleForm.type" placeholder="请选择商户类型">
        <el-option label="周边餐饮" value="Restaurant"></el-option>
        <el-option label="超市购物" value="Shopping"></el-option>
        <el-option label="休闲娱乐" value="Entertainment"></el-option>
        <el-option label="生活服务" value="Service"></el-option>
        </el-select>
              </el-col>
            </el-row>
        
      </el-form-item>
    

    
    <el-form-item label="商户图片" prop="picture">
       <el-row type="flex" style="start">
      
       <el-upload
       class="avatar-uploader"
        action="/img"
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :before-remove="beforeRemove"
        multiple
        :limit="1"
        :show-file-list="true"
        :on-exceed="handleExceed"
        :on-success="handleAvatarSuccess"
        :before-upload="beforeAvatarUpload"
        :file-list="fileList">
       <img v-if="imageUrl" :src="imageUrl" class="avatar">
       <i v-else class="el-icon-picture avatar-uploader-icon"></i>
       </el-upload>
       
    </el-row>
    <el-row type="flex" justify="start">
       <div style="font-size:10px;color:#909092">上传图片格式：jpg/jpeg、png且大小不超过2M</div>
    </el-row>
    </el-form-item>
      
    </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')" :loading="clicked">发布商品</el-button>

  </div>
</template>

<script>
export default {
    mounted:function(){
       //this.showDemandId(ruleForm); 
       this.setlnglat()

    },
  methods:
  {
    setlnglat(){
       this.longitude = this.$route.params.longitude
       this.latitude = this.$route.params.latitude
       this.address = this.$route.params.address
      
       if(this.longitude === undefined){
         var string1 = '点击右侧按钮选择位置'
         var string2 = '点击右侧按钮选择地址'
         this.location = string1
         this.address = string2
       }else{
         this.location = this.longitude+','+this.latitude
       }
       this.$confirm(this.location+','+this.address)
    },
    commit(formName)
    {
      if(this.longitude === undefined || this.longitude === 0){
        this.$confirm('请选择商家位置')
      }
      
      else if(this.imageUrl === 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'){
         this.$confirm('请选择一张图片')
      }else{
        this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认内容并提交？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked=true
              this.axios.get('/api/Gs/up',
              {
                params:{
                  storename:this[formName].storename,
                  address:this.address,
                  type:this[formName].type,
                 // community:window.sessionStorage.getItem('community'),
                  img:this.imageUrl,
                  longitude:this.longitude,
                  latitude:this.latitude
                }
              }
              ).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  this.$message({type:'success',message:'提交成功！'});
                  this.$router.push({name:"StoreList"});
                      
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
 
    tomap(){
       this.$router.push({
         name:'map'
       })
    },
    handleAvatarSuccess(res, file) {
       // this.imageUrl = URL.createObjectURL(file.raw);
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

    showDemandId(formName){
       this.longitude = this.$route.params.longitude
       this.latitude = this.$route.params.latitude
       if((this.longitude === undefined)&&(this.latitude === undefined)){
         this.longitude = ''
         this.latitude = ''
       }
         this[formName].location = this.longitude+','+this.latitude
         this.$confirm(this[formName].location)
       
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
    return {
      imageUrl: 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg',
      title:'添加新商户',
      fileList: [],
      ruleForm:{
        storename:'',
        type:'',
        picture:'',
        
      },
      address:'',
      location:'',
      longitude:'',
      latitude:'',
      
      rules:{
        storename:[
          {required:true, message:'商家名称不可为空', trigger:'blur'}
        ],
        type:[
          {required:true,message:'请选择商户类型',trigger:'blur'}
        ],
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