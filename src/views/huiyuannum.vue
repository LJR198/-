<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>统计</el-breadcrumb-item>
      <el-breadcrumb-item>会员数量统计</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <Echarts class="chart" :option="option"></Echarts>
    </el-card>
  </div>
</template>

<script>
import dayjs from "dayjs";
import { forIn } from "lodash";
export default {
  data() {
    return {
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
    };
  },
  methods: {
    async getuser() {
      let { data: res } = await this.$http.get("/users");
      res.data.forEach((item) => {
        item.logintime = dayjs(item.logintime).format("YYYY-MM-DD");
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
  },
  computed: {},
  filters: {},
  watch: {},
  created() {
    this.getuser();
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