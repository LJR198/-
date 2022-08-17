<template>
  <div>
     <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>工作台</el-breadcrumb-item>
      <el-breadcrumb-item>工作台展示</el-breadcrumb-item>
    </el-breadcrumb>
      <el-row :gutter="20" >
        <el-col :span="10" :offset="1">
          <div>
            <span class="spanna">今日汇总信息</span>
            <span class="bordersap"></span>
            <ul class="dayishui">
                <li>
                    <span>50</span>
                    <span>今日预约人数</span>
                </li>
                <li>
                    <span>48</span>
                    <span>今日评估人数</span>
                </li>
                <li>
                    <span>2</span>
                    <span>今日未执行</span>
                </li>
                <li>
                    <span>48</span>
                    <span>今日以执行</span>
                </li>
            </ul>
          </div>
        </el-col>
        <el-col :span="10" :offset="1">
          <div>
            <span class="spanna">汇总信息</span>
            <span class="bordersap"></span>
            <ul class="dayishuid">
                <li>
                    <span>219</span>
                    <span>近一周预约人数</span>
                </li>
                <li>
                    <span>190</span>
                    <span>近一周评估人数</span>
                </li>
                <li>
                    <span>150</span>
                    <span>近一周未执行</span>
                </li>
                <li>
                    <span>100</span>
                    <span>近一周已执行</span>
                </li>
            </ul>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" >
        <el-col :span="10" :offset="1">
         <div>
            <span class="spanna">会员统计</span>
            <span class="bordersap"></span>
             <Echarts class="chart" :option="option"></Echarts>
          </div>
        </el-col>
        <el-col :span="10" :offset="1">
          <div>
            <span class="spanna">工作量</span>
            <span class="bordersap"></span>
             <Echarts class="chart" :option="option2"></Echarts>
          </div>
        </el-col>
      </el-row>
  </div>
</template>

<script>
import dayjs from 'dayjs'

export default {
    name:'Workbench',
    data(){
        return{
             option: {
        tooltip: {
          //触发方式 - 坐标轴
          trigger: "axis",
        },
        xAxis: {
          type: "category",
          boundaryGap: false,
        },
        yAxis: {
          type: "value",
          boundaryGap: [0, "30%"],
        },
        visualMap: {
          type: "piecewise",
          show: true,
          dimension: 0,
          seriesIndex: 0,
          pieces: [
            {
              gt: 1,
              lt: 3,
              color: "rgba(0, 0, 180, 0.4)",
            },
            {
              gt: 5,
              lt: 7,
              color: "rgba(0, 0, 180, 0.4)",
            },
          ],
        },
        series: [
          {
            type: "line",
            smooth: 0.6,
            symbol: "none",
            lineStyle: {
              color: "#5470C6",
              width: 5,
            },
            markLine: {
              symbol: ["none", "none"],
              label: { show: false },
            //   data: [{ xAxis: 1 }, { xAxis: 3 }, { xAxis: 5 }, { xAxis: 7 }],
            },
            areaStyle: {},
            data: [],
          },
        ],
      },
             option2: {
        title: {
          text: "套餐工作量",
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
        }
    },
    methods:{
         async getuser() {
      let { data: res } = await this.$http.get("/users");
      res.data.forEach((item) => {
        item.logintime = dayjs(item.logintime).format("MM-DD");
      });
      console.log(res);
      let arr = [];
      let obj = {};

      res.data.forEach((item) => {
        if (!obj[item.logintime]) {
          obj[item.logintime] = 1;
        } else {
          obj[item.logintime] = obj[item.logintime] + 1;
        }
      });
      for (let i of Object.entries(obj)) {
        // console.log(i);
        arr.push(i);
      }
      this.option.series[0].data = arr;
      //    console.log(this.option.series)
    },
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
        this.option2.series[0].data=arr
        // this.datalist=res.data
        // this.count=res.count
       
    },
    },
    computed: {
     
    },
    mounted(){
        this.getuser()
        this.gettaocan()
    }
}
</script>

<style scoped>
.el-row{
  margin-top: 50px;
}
.el-col{
  height: 350px;
  background: #fff;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.15) !important;
  border-radius: 10px;
}
.el-col-offset-1{
  margin-left: 5.16667%;
}
.spanna{
    font-size: 20px;
    font-weight: bolder;
    display: inline-block;
    margin-top: 20px;
    margin-left: 20px;
}
.bordersap{
    display: block;
    width: 100%;
    height: 2px;
    background-color: aqua;
    margin-top: 10px;
}
li{
    list-style: none;
}
.dayishui,.dayishuid{
    width: 100%;
}
.dayishui li{
    width: 150px;
    height: 150px;
    float: left;
    margin-left: 10px;
    text-align: center;
    font-weight: bolder;
}
.dayishui li:first-child{
    margin-left: 0px;
}
.dayishui li>span:first-child{
    display: block;
    line-height:150px;
    font-size: 26px;
    border: 1px dotted aqua;
    border-radius: 50%;
    width: 150px;
    height: 150px;
    border: 1px dotted aqua;
    float: left;
    font-weight: bolder;
    color: rgba(7, 113, 233, 0.555);


}
.dayishui li>span:nth-child(2){
    display: block;
    margin-top:169px;
}
.dayishuid li{
    width: 150px;
    height: 150px;
    float: left;
    margin-left: 10px;
    text-align: center;
    font-weight: bolder;
}
.dayishuid li:first-child{
    margin-left: 0px;
}
.dayishuid li>span:first-child{
    display: block;
    line-height:150px;
    font-size: 26px;
    border: 1px dotted rgb(33, 86, 155);
    border-radius: 50%;
    width: 150px;
    height: 150px;
    float: left;
    font-weight: bolder;
    color: rgba(10, 53, 245, 0.938);


}
.dayishuid li>span:nth-child(2){
    display: block;
    margin-top:169px;
}
.chart{
    height: 300px;
}
</style>