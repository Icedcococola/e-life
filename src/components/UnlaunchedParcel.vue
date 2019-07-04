<template>
  <div id="l-ac">
    <el-row type="flex" class="row-bg" justify="end">
      <el-col :span="14">
        <div style="font-size:190%; height:50px; color:#858585fa;text-align:left;"><i class="el-icon-document"></i>未通知邮包
        </div>
      </el-col>
      <el-col :span='8'>
        <el-input v-model="input" placeholder="请输入要查询的关键字"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button icon="el-icon-search" circle></el-button>
      </el-col>
  
    </el-row>
    <el-row>
    <div style="width:100%;background:#c4c4c4fa;height:1px;margin-top:10px;margin-bottom:30px;padding:0px;overflow:hidden;"></div>
    </el-row>
    
    <el-table
      :data="tableData"
      style="width: 100%"
      :default-sort="{prop:'no',order:'ascending'}">
      
      <el-table-column
        prop="no"
        label="邮包编号"
        width="180"
        align="center">
      </el-table-column>
      <el-table-column
        prop="company"
        label="快递公司"
        align="center">
      </el-table-column> 
      <el-table-column
        prop="phonenum"
        label="手机号"
        align="center">
      </el-table-column>     
      <el-table-column
        prop="date"
        label="日期"
        width="210"
        align="center">
      </el-table-column>     
      <el-table-column
        prop="op"
        label="操作"
        width="210"
        align="center"
        fixed="right">
        <template>
            <el-button type="primary" round>已通知</el-button>
            <el-button type="danger" round >删除</el-button>
          </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
 export default {
      methods:
      {
      },
      data() {
        return {
          input: '',
          tableData: [{
            date: '2019-07-02',
            no: '1',
            company: 'balabala',
            phonenum:'12345678901'
          }, {
            date: '2019-07-04',
            no: '3',
            company: 'balabala',
            phonenum:'23456789012'
          }, {
            date: '2019-07-01',
            no: '4',
            company: 'baalballab',
            phonenum:'34567890123'
          }, {
            date: '2019-07-03',
            no: '2',
            company: 'balbalbalba',
            phonenum:'45678901234'
          }]
        }
      }
    }
</script>
