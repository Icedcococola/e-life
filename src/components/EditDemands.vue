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
        
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:5%">
       <el-form-item label="商家名称" prop="title" style="margin-bottom:4%;">
        <el-col style="width:50%">
           <el-input v-model="ruleForm.title" placeholder="请输入商家名称" ></el-input>
        </el-col>
       </el-form-item>
      </el-form>
    
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:4%">
      <el-form-item label="价格" prop="price" style="margin-bottom:4%">
        <el-col style="width:35%">
            <el-input v-model="ruleForm.price" placeholder="请输入单价" ></el-input>
        </el-col>
      </el-form-item>

      <el-form-item label="数量" prop="num" style="margin-bottom:4%">
        <el-col style="width:35%">
            <el-row type="flex" justify="start">
            <el-input-number v-model="num1" :min="1" :max="10000" label="请选择数量"></el-input-number>
            </el-row>
        </el-col>
      </el-form-item>

    </el-form>

    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="margin-top:4%">

    <el-form-item label="商品详情" prop="detail" style="margin-bottom:4%;">
      <el-input type="textarea" :autosize="{ minRows: 12, maxRows: 18}" placeholder="请输入活动内容" v-model="ruleForm.detail" ></el-input>
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
       action="https://jsonplaceholder.typicode.com/posts/"
        multiple
       :limit="1"
       :on-exceed="handleExceed"
       :show-file-list="true"
       :on-remove="handleRemove"
       :before-remove="beforeRemove"
       :on-success="handleAvatarSuccess"
       :before-upload="beforeAvatarUpload">
       <img v-if="imageUrl" :src="imageUrl" class="avatar">
       <i v-else class="el-icon-picture avatar-uploader-icon"></i>
       </el-upload>
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
       this.showDemandId();
       
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
              
              this.axios.get('/api/Activity/add',
              {
                params:{
                  title:this[formName].title,
                  detail:this[formName].detail,
                  activitytime:this[formName].date,
                  place:this[formName].place,
                  community:window.sessionStorage.getItem('community'),
                  picture:this.imageUrl,
                  id:this.emm
                }
              }).then((response)=>{
                if(response.status === 200){
                  console.log(response);
                  //console.log(response.data.result);
                  //if(response.data.result === null){
                    //this.$message({type:'success',message:'提交成功！'});
                    //this.$router.push({name:"查看活动安排"});
                  //}

                  this.axios.get('/api/Activity/delete',{
                      params:{
                          activityid:this.emm
                      }
                  }).then((response)=>{
                      if(response.status === 200){
                          this.$message({type:'success',message:'提交成功！'});4
                          this.$router.push({name:"LaunchedDemands"});
                      }

                  })
                }
              })
              //this.$message({type:'success',message:'提交成功！'});
              //this.$router.push({name:"查看活动安排"});
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

        
    },

    handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
    },

    showDemandId(){
       //var id = this.DemandId;
       var deid = window.sessionStorage.getItem('demandId')
       this.$confirm(deid,'提示')
    },

    handleExceed(files, fileList) {
        this.$message.warning(`最多选择 1 张图片`);
    },
    handleRemove(file, fileList) {
        console.log(file, fileList);
        this.imageUrl = ''
    },
    beforeRemove(file, fileList) {
        return this.$confirm(`确定移除 ${ file.name }?`);
    }

  },

  data() {
    return {
      emm:window.sessionStorage.getItem('demandId'),
      num1:'1',
      imageUrl: '',
      title:'编辑待发布需求',
      fileList: [],
      ruleForm:{
        title:'',
        detail:'',
        date:'',
        place:'',
        time:'',
        picture:'',
        price:'',
        num:''
        
      },
      rules:{
        title:[
          {required:true, message:'请输入商家名称', trigger:'blur'}
        ],
        detail:[
          {required:true, message:'请输入商品详情',trigger:'blur'}
        ],
        date:[
          {type: 'date', required:true, message:'请选择截止时间', trigger:'change'}
        ],
        price:[
          {required:true,message:'请输入单价',trigger:'blur'}
        ],
        num:[
          {required:true,message:'请输入数量',trigger:'blur'}
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
    border-color: #409EFF;
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