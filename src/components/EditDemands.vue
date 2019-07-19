<template>
  <div>

  <el-row >
      <el-col >
        <div class="t" style="font-size:160%; height:50px; color:#858585;text-align: right"><i class="el-icon-edit"></i>{{title}}</div>
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

      <el-form-item label="价格" prop="price" style="margin-bottom:4%">
        <el-col style="width:28%">
            <el-input type="price" v-model.number="ruleForm.price" placeholder="请输入单价"></el-input>
        </el-col>
      </el-form-item>

     <el-form-item label="数量" prop="num" style="margin-bottom:4%">
        <el-col style="width:35%">
            <el-row type="flex" justify="start">
            <el-input-number type="num" v-model="ruleForm.num" :min="1" :max="10000" label="请选择数量" ></el-input-number>
            </el-row>
        </el-col>
      </el-form-item>

    <el-form-item label="商品详情" prop="detail" style="margin-bottom:4%;">
      <el-input type="textarea" :autosize="{ minRows: 12, maxRows: 18}" placeholder="请输入商品详情" v-model="ruleForm.detail" ></el-input>
    </el-form-item>
    
    <el-form-item label="截止时间" prop="date" style="margin-bottom:4%;">
  
        <el-col :span="6" style="width:30%">
          <el-date-picker
            v-model="ruleForm.date"
            type="datetime"
            placeholder="选择时间">
          </el-date-picker>
        </el-col>

    </el-form-item >
    
    <el-row type="flex" style="start">
    <el-form-item label="商品图片" prop="picture">
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
  
  <el-button type="primary" @click="commit('ruleForm')">发布商品</el-button>

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
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看活动安排"});
            }
            );
          }else{
            this.$alert('请正确填写并填写完整','提示',{
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
        const isLt2M = file.size / 1024 / 1024 <2;

        if(!isJPG && !isPNG){
         this.$message.error('上传图片只能是jpg/jpeg或png格式！')
         this.imageUrl = 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg'
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
          }else{
            value=(value*10/10).toFixed(2)
            this.ruleForm.price=value
            callback()
          }
          
        };
    return {
      emm:window.sessionStorage.getItem('desiredid'),
      num1:'1',
      imageUrl: 'https://i.loli.net/2019/07/19/5d312e20c0c6d52233.jpg',
      title:'编辑待发布需求',
      fileList: [],
      ruleForm:{
        price:'',
        num:'',
        detail:'',
        date:'',
        picture:''
        
      },
      
      rules:{
        title:[
          {required:true, message:'商家名称不可为空', trigger:'blur'}
        ],
        detail:[
          {required:true, message:'商品详情不可为空',trigger:'blur'}
        ],
        date:[
          {type: 'date', required:true, message:'截止时间不可为空', trigger:'change'}
        ],
        price:[
          {required:true,message:'单价不可为空',trigger:'change'},
          //{validator: checkAge, trigger: 'blur'}
          {type:'number',message:'请填写正整数',trigger:'blur'}
        ],
        num:[
          {required:true,message:'数量不可为空',trigger:'blur'},
          {validator: checkInt, trigger: 'blur'}
          //{type:'number',message:'请填写正整数',trigger:'blur'}
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