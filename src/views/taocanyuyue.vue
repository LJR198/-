<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>统计</el-breadcrumb-item>
      <el-breadcrumb-item> 套餐预约占比统计</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <Echarts class="chart" :option="option"></Echarts>
    </el-card>
  </div>
</template>

<script>
import dayjs from 'dayjs'
export default {
  data() {
    return {
      option: {
        title: {
          text: "套餐预约占比",
          subtext: dayjs(new Date()).format('MM-DD'),
          left: "center",
        },
        tooltip: {
          trigger: "item",
        },
        legend: {
          orient: "vertical",
          left: "left",
        },
        series: [
          {
            name: "Access From",
            type: "pie",
            radius: "50%",
            data: [
              { value: 1048, name: "Search Engine" },
              { value: 735, name: "Direct" },
              { value: 580, name: "Email" },
              { value: 484, name: "Union Ads" },
              { value: 300, name: "Video Ads" },
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
            },
          },
        ],
      },
    };
  },
  methods: {
    async gettaocan(){
        let {data:res}=await this.$http.get(`/comoraid`)
        console.log(res);
        let arr=[]
        let obj={}
        res.name.forEach(item=>{
          if(!obj[item.name]){
            obj[item.name]=0
          }
        })
        res.data.forEach(item=>{
          // console.log(item);
          if(item.comboid){
            // console.log(Object.keys(obj).includes(item.comboid.name));
          // console.log(item);
          if(Object.keys(obj).includes(item.comboid.name)){
            obj[item.comboid.name]=item.rennum
            
          }

          }
        })
        console.log(obj);
        for(let i of Object.entries(obj)){
          // console.log(i);
          arr.push({
            "value":i[1],
            "name":i[0]
          })
        }
        console.log(arr)
        this.option.series[0].data=arr
        // this.datalist=res.data
        // this.count=res.count
       
    },
  },
  computed: {},
  filters: {},
  watch: {},
  created() {
    this.gettaocan()
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
.chart {
  height: 800px;
}
</style>