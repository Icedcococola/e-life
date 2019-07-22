<template>
    <div>
       <el-row type="flex" justify="center">
        <img :src="imgUrl" alt="">
       </el-row>
       <el-row>
         <el-button @click="back">返回上一页</el-button>
       </el-row>
    </div>
</template>

<script>
export default{
    data(){
        return {
            imgUrl:'https://i.loli.net/2019/07/22/5d353ebdb418b37230.jpg'
        }
    },
    methods:{
        back(){
            this.$router.go(-1);
        }
    }
}
</script>
