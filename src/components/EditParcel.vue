<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="start">
      <el-col :span="18">
        <div style="font-size:190%; height:50px; color:#858585fa;text-align:left;"><i class="el-icon-document"></i>编辑新邮包通知
        </div>
      </el-col>

      <el-col :span="3">
          <div>
              <el-button @click="addLine" round>新增一行</el-button>
          </div>
      </el-col>

      <el-col :span="3">
          <div>
              <el-button type="success" @click="commitAll" round>批量提交</el-button>
          </div>
      </el-col>

    </el-row>
    <el-row>
    <div style="width:100%;background:#c4c4c4;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>
    
    <el-table
      :data="tableData"
      style="width: 100%"
      height="500"
      :default-sort="{prop:'no',order:'ascending'}">
      
      <el-table-column
        type="index"
        label="序号"
        width="180"
        align="center">
      </el-table-column>

      <el-table-column
        prop="orderid"
        label="快递单号"
        align="center">
        <template slot-scope="scope">
            <el-input v-model="scope.row.orderid" placeholder="快递单号"></el-input>
        </template>
      </el-table-column> 
      
      <el-table-column
        prop="company"
        label="快递公司"
        align="center">
        <template slot-scope="scope">
            <el-input v-model="scope.row.company" placeholder="快递公司名"></el-input>
        </template>
      </el-table-column> 

      <el-table-column
        prop="phonenum"
        label="手机号"
        align="center">
        <template slot-scope="scope">
            <el-input v-model="scope.row.phonenum" placeholder="手机号"></el-input>
        </template>
      </el-table-column>     

      <el-table-column
        prop="op"
        label="操作"
        width="130"
        align="center"
        fixed="right">
        <template slot-scope="scope">
            <el-button type="danger" @click="deleteLine(scope.$index)" round >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
 export default {
      methods:
      {
        addLine(){
          var newValue={
            company:'',
            phonenum:'',
            orderid:''
          };
          this.tableData.push(newValue);
        },

        deleteLine(index){
          this.$confirm('确认删除？',
                        '提示',
                        {confirmButtonText:'确定',cancelButtonText:'取消'}
          ).then(()=>{
            this.tableData.splice(index,1);
            this.$message({type:'success',message:'删除成功!'});
          }
          )
        },

        commitAll(){
          //这里写把数据传到后端的函数
          //
          //
          
          //这里把表格清空
          
        this.$confirm('确认全部提交？',
                        '提示',
                        {confirmButtonText:'确定提交',cancelButtonText:'取消'}
          ).then(()=>{
            var newTable = [];
            this.tableData=newTable; 
            this.$message({type:'success',message:'提交成功!'});
          }
          );
        }
          
        

      },
      data() {
        return {
          tableData: []
        }
      }
    }
</script>
