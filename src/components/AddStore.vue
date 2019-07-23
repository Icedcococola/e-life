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
      <el-form-item label="商家名称" prop="title" style="margin-bottom:4%;">
        <el-col style="width:50%">
           <el-input v-model="ruleForm.title" placeholder="请输入商家名称" ></el-input>
        </el-col>
       </el-form-item>

      <el-form-item label="商户类型" prop="price" style="margin-bottom:4%">
        <el-row type="flex" justify="start">
        <el-select v-model="ruleForm.region" placeholder="请选择商户类型">
        <el-option label="周边餐饮" value="shanghai"></el-option>
        <el-option label="超市购物" value="beijing"></el-option>
        <el-option label="休闲娱乐" value="beijing"></el-option>
        <el-option label="生活服务" value="beijing"></el-option>
        </el-select>
        </el-row>
      </el-form-item>

     <el-form-item label="商户位置" prop="location" style="margin-bottom:4%">
         <el-col :span="12">
        <el-input readonly placeholder="点击右侧图标选择商户地图位置"></el-input>
         </el-col>
      </el-form-item>

    <el-form-item label="详细地址" prop="detail" style="margin-bottom:4%;">
      <el-input v-model="ruleForm.detail"></el-input>
    </el-form-item>
    
    
    <el-row type="flex" style="start">
    <el-form-item label="商户图片" prop="picture">
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
       <div style="font-size:10px;color:#909092">上传图片格式：jpg/jpeg、png且大小不超过2M</div>
    </el-form-item>
    </el-row>
    </el-form>
    </el-col>
  </el-row>
  
  <el-button type="primary" @click="commit('ruleForm')" :loading="clicked">发布商品</el-button>

  </div>
</template>

<script>
export default {
    mounted:function(){
       //this.showDemandId(); 
    },
  methods:
  {
    commit(formName)
    {
        
        this.$refs[formName].validate((valid)=>{
          if(valid){
            this.$confirm('确认内容并提交？',
                          '提示',
                          {confirmButtonText:'确定',cancelButtonText:'取消'}
            ).then(()=>{
              this.clicked=true
              this.axios.get('/api/Goods/up',
              {
                params:{
                  desiredid:this.emm,
                  detail:this[formName].detail,
                  deadline:this[formName].date,
                 // community:window.sessionStorage.getItem('community'),
                  img:this.imageUrl,
                  price:this[formName].price,
                  store:this[formName].title,
                  totalnum:this[formName].num
                }
              }
              ).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  //console.log(response.data.result);
                  //if(response.data.result === null){
                    //this.$message({type:'success',message:'提交成功！'});
                    //this.$router.push({name:"查看活动安排"});
                  //}
                  this.$message({type:'success',message:'提交成功！'});
                  this.$router.push({name:"LaunchedDemands"});
                      
                  
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
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看活动安排"});
            }
            );
          }else{
            this.$alert('请正确填写','提示',{
              confirmButtonText:'确定',
              callback: action=>{}
            });
            return false;
          }
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

    showDemandId(){
       //var id = this.DemandId;
       var deid = window.sessionStorage.getItem('desiredid')
       this.$confirm(deid,'提示')
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
    var checkInt = (rule,value,callback) => {
        if (!value) {
            return callback(new Error('价格不能为空'));
        }
        var emmm = /^\d+$/;
        if (!emmm.test(value)) {
            callback(new Error('请输入整数值'));
          }else if(value < 1){
             callback(new Error("请输入正整数"))
          }else{
            callback()
          }
    };

    var checkAge = (rule, value, callback) => {
          if (!value) {
            return callback(new Error('价格不能为空'));
          }
          var re = /^\d+(?=\.{0,2}\d+$|$)/ ;
          if (!re.test(value)) {
            callback(new Error('请输入数字值'));
          }else if(value < 1){
            callback(new Error('请输入正整数'))
          }
            else{
            value=(value*10/10).toFixed(2)
            this.ruleForm.price=value
            callback()
          }
          
        };
    return {
      clicked:false,
      emm:window.sessionStorage.getItem('desiredid'),
      detailmaxlength:10,
      num1:'1',
      imageUrl: 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg',
      title:'添加新商户',
      fileList: [],
      ruleForm:{
        price:'',
        location:'',
        region:'',
        detail:'',
        date:'',
        picture:'',
        longitude:'',
        latitude:''
        
      },
      
      rules:{
        title:[
          {required:true, message:'商家名称不可为空', trigger:'blur'}
        ],
        detail:[
          {required:true, message:'商户地址不可为空',trigger:'blur'}
          
        ],
        
        price:[
          {required:true,message:'商户类型不可为空',trigger:'change'}
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