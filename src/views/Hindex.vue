<template>
    <div>
        <div class="block">
   
    <el-carousel height="450px">
      <el-carousel-item v-for="item in imglist" :key="item">
       
            <img :src=item alt="" srcset="" class="small">
        
      </el-carousel-item>
    </el-carousel>
  </div>
  <el-card class="carda">
    <h2>健康管理流程图</h2>
     <img src="../assets/流程图.png" alt="" srcset="">
  </el-card>
    </div>
</template>

<script>
export default {
    data () {
        return {
            imglist:['http://localhost:3000/upload\\Gz28_IkRkj23D0pKKgay3eCJ.png','http://localhost:3000/upload\\Gz28_IkRkj23D0pKKgay3eCJ.png','http://localhost:3000/upload\\Gz28_IkRkj23D0pKKgay3eCJ.png']
        }
    },
    methods:{

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
.el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 150px;
    margin: 0;
  }

  .el-carousel__item:nth-child(2n) {
     background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
     background-color: #d3dce6;
  }
  .block{
    text-align: center;
  }
  .small {
    width: 1646px;
    height: 350px;
  }
  .carda{
    margin-top: 20px;
    height: 450px;
    position: relative;
  }
  .carda img{
    /* margin-bottom: 20px; */
    /* width: 100%; */
    width: 1400px;
    height: 300px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
   
  
  }
  </style>