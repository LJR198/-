<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>角色管理</el-breadcrumb-item>
      <el-breadcrumb-item>权限展示</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top:15px">
        <el-table
    :data="menusdata"
    border
    style="width: 100%">
    <el-table-column
    label="#"
      type="index"
     >
    </el-table-column>
    <el-table-column
      prop="name"
      label="权限名称"
      >
    </el-table-column>
    <el-table-column
      prop="path"
      label="地址">
    </el-table-column>
    <el-table-column
      prop="order"
      label="等级">
      <template slot-scope="scope">
        <el-tag v-if="scope.row.order==1">标签一</el-tag>
        <el-tag type="success" v-else>标签二</el-tag>
      </template>
    </el-table-column>
  </el-table>
    </el-card>
    </div>
</template>

<script>
export default {
    data () {
        return {
            menusdata:[]
        }
    },
    methods:{
        async getmenusdata(){
            let {data:res}=await this.$http.get('/fmenus?fen=all')
            console.log(res);
            this.menusdata=res.data
        }
    },
    computed:{

    },
    filters:{

    },
    watch:{

    },
    created(){
        this.getmenusdata()
    },
    mounted(){

    },
    destroyed(){

    }
}
</script>

<style scoped>
.el-table{
    min-width:  1600px;
}
</style>