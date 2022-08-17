<template>
  <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>预约管理</el-breadcrumb-item>
      <el-breadcrumb-item>运营数据统计</el-breadcrumb-item>
    </el-breadcrumb>
      <el-row :gutter="20" style="margin-top:20px">
        <el-col :span="6">
          <el-button type="primary" @click="exportexcelselect">导出excel</el-button>
        </el-col>
      </el-row>
      <el-card style="margin-top:20px">
          <el-table
    :data="tableData"
     @selection-change="handleSelectionChange"
    style="width: 100%">
    <el-table-column
      prop="date"
      type="selection"
      width="50">
    </el-table-column>
    <el-table-column label="会员数据统计">
        <el-table-column
          prop="xinzenghuiyuan"
          label="新增会员数量"
          width="250">
        </el-table-column>
        <el-table-column
          prop="huiyuannum"
          label="会员总数"
          width="250">
        </el-table-column>
        <el-table-column
          prop="benyuehuiyuan"
          label="本月新增会员数"
          width="250">
        </el-table-column>
    </el-table-column>
    <el-table-column label="预约到诊数据统计">
        <el-table-column
          prop="benriyue"
          label="本日预约数"
          width="250">
        </el-table-column>       
         <el-table-column
          prop="benyueyuyue"
          label="本月预约数"
          width="300">
        </el-table-column>
        
    </el-table-column>
    <el-table-column label="套餐名称">
        <el-table-column
          prop="name"
          label="套餐"
          width="280">
        </el-table-column>
    </el-table-column>
  </el-table>
        <el-dialog title="预览保存的数据" :visible.sync="selectwind" width="90%">
 <el-table
    :data="selectdata"
    id="selecttable"
    style="width: 100%">
    
    <el-table-column label="会员数据统计">
        <el-table-column
          prop="xinzenghuiyuan"
          label="新增会员数量"
          width="250">
        </el-table-column>
        <el-table-column
          prop="huiyuannum"
          label="会员总数"
          width="250">
        </el-table-column>
        <el-table-column
          prop="benyuehuiyuan"
          label="本月新增会员数"
          width="250">
        </el-table-column>
    </el-table-column>
    <el-table-column label="预约到诊数据统计">
        <el-table-column
          prop="benriyue"
          label="本日预约数"
          width="250">
        </el-table-column>       
         <el-table-column
          prop="benyueyuyue"
          label="本月预约数"
          width="300">
        </el-table-column>
        
    </el-table-column>
    <el-table-column label="套餐名称">
        <el-table-column
          prop="name"
          label="套餐"
          width="280">
        </el-table-column>
    </el-table-column>
  </el-table>
   <div slot="footer" class="dialog-footer">
    <el-button @click="exportExcel">确定保存</el-button>
    
  </div>
</el-dialog>
      </el-card>
    </div>
</template>

<script>
import htmlToExcel from '../utlis/htmltoExcel'

export default {
    data () {
        return {
               tableData: [{
          xinzenghuiyuan: 50,
          huiyuannum: 900,
          benyuehuiyuan: 100,
          benriyue: 50,
          benyueyuyue: 56,
          name: '全面检查'
        }, {
          xinzenghuiyuan: 60,
          huiyuannum: 1000,
          benyuehuiyuan: 200,
          benriyue: 20,
          benyueyuyue: 76,
          name: '女士体检'
        }, {
          xinzenghuiyuan: 70,
          huiyuannum: 1100,
          benyuehuiyuan: 300,
          benriyue: 30,
          benyueyuyue: 66,
          name: '男士体检'
        }, ],
        selectdata:[],
        selectwind:false,
        }
    },
    methods:{
      exportExcel(){
        htmlToExcel.getExcel('#selecttable','运营数据统计')
      },
      exportexcelselect(){
        if(this.selectdata.length<1){
          this.$message.error('请选择导出的内容')
          return false
        }
        this.selectwind=true
      },
      handleSelectionChange(val){
        this.selectdata=val
      }
    },
    computed:{

    },
    filters:{

    },
    watch:{

    },
    created(){

    },
    mounted(){

    },
    destroyed(){

    }
}
</script>

<style scoped>

</style>