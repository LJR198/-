<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>预约管理</el-breadcrumb-item>
      <el-breadcrumb-item>预约设置</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 20px">
      <el-calendar  class="calendata">
        <template slot="dateCell" slot-scope="{ data }" >
           <!-- {{data.day.split("-").slice(2).join("-")}} -->
           <div class="ten">
            <div  >
                <!-- {{data.day.split('-').slice(1)[1]}} -->
            <span >{{data.day.split("-").slice(2).join("-")}}</span>
            <!-- {{}} -->
           </div>
           <div v-show="dataarr.includes(data.day.split('-').slice(1).join('-'))" v-for="item in yuyuelisi" :key="item._id">
                    <p v-if="item.data.split('-')[0]== data.day.split('-').slice(1)[0] && item.data.split('-')[1]== data.day.split('-').slice(1)[1] ">
                        <span class="span">可预约人数{{item.maxnum}}</span>
                        <span class="span">预约人数{{item.rennum}}</span>
                    </p>
           </div>
           <div class="btn" v-show="data.day.split('-').slice(1)[0] > dataflg.split('-')[0] ||data.day.split('-').slice(1)[0] == dataflg.split('-')[0] ">
            <el-button
              type="primary"
              slot="dateCell"
              size="mini"
              @click="steyuyuenum(data)"
              v-if="
                data.day.split('-').slice(1)[0] > dataflg.split('-')[0] ||
                data.day.split('-').slice(1)[1] >= dataflg.split('-')[1] 
              "
            >
              设置</el-button
            >
            <el-button type="primary" v-if="dataarr.includes(data.day.split('-').slice(1).join('-')) && data.day.split('-').slice(1)[1] >= dataflg.split('-')[1] "  size="mini" @click="setcom(data)">预约</el-button>
           </div>
           </div>
        </template>
      </el-calendar>
      <!-- {{dataflg}} -->
      <el-dialog title="设置预约人数" :visible.sync="dialogFormVisible" @close="clterfoem">
        <el-form :model="form">
          <el-form-item label="预约人数" :label-width="formLabelWidth">
            <el-input v-model="form.maxnum" type="number" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="confomaddyu"
          >确 定</el-button
        >
      </div>
      </el-dialog>
      <!-- 预约 -->
      <el-dialog title="设置预约人数" :visible.sync="setdialogFormVisible" @close="clterform" >
        <el-form :model="adform" :rules="rulesf" ref="adformref">
          <el-form-item label="最多预约人数" :label-width="formLabelWidth">
            <el-input v-model="adform.maxnum" type="number" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="预约人数" :label-width="formLabelWidth" prop="rennum">
            <el-input v-model="adform.rennum" type="number" autocomplete="off" :max=adform.maxnum></el-input>
          </el-form-item>
          <el-form-item label="预约人数" :label-width="formLabelWidth" prop="comboid">
            <el-select v-model="adform.comboid" placeholder="请选择">
    <el-option
      v-for="item in combos"
      :key="item._id"
      :label="item.name"
      :value="item._id">
    </el-option>
  </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
        <el-button @click="setdialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="confosetmaddyu"
          >确 定</el-button
        >
      </div>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import dayjs from "dayjs";
export default {
  
  data() {
    var maxvalue=(rules,value,callback)=>{
      if(value==0){
        return callback(new Error('值不可为空'))
      }else if(value>this.adform.maxnum){
        return callback(new Error('不可超过最大值'))
      }else{
        return callback()
      }
    }
    return {
      value: new Date(),
      setdialogFormVisible:false,
      formLabelWidth: "180px",
      dialogFormVisible:false,
      dataarr:[],
      combos:[],
      adform:{
        maxnum:0,
        data:"",
        rennum:0,
        comboid:"",
      },
      rulesf:{
        rennum:[
          { required: true, message: '请输入活动名称', trigger: 'blur' },
          { validator: maxvalue, trigger: 'blur' }
        ],
        comboid:[
          { required: true, message: '请输入活动名称', trigger: 'blur' },

        ]
      },
      form:{
        maxnum:0,
        data:""
      },
      yuyuelisi:[]
    };
  },
  methods: {
     confosetmaddyu(){
      this.$refs.adformref.validate(async(valid)=>{
        if(valid){
      let {data:res}=await this.$http.post('/comformsetyu',this.adform)
      console.log(res);
      this.setdialogFormVisible=false
      this.getyuyuelist()

        }
      })
      // console.log(this.adform);
    },
    clterform(){
      this.adform={
        maxnum:0,
        data:"",
        rennum:"",
        comboid:"",
      }
      this.setdialogFormVisible=false;
    },
    async setcom(da){
      let {data:res}=await this.$http.post('/getone',{data:da.day})
      let {data:add}=await this.$http.get('/combols')
      this.combos=add.data
      console.log(add);
      this.adform.data=da.day
      this.adform.maxnum=res.yuo.maxnum
      da.isSelected=true
      this.setdialogFormVisible=true
    },
    clterfoem(){
        this.form={
            maxnum:0,
        data:""
        }
        this.dialogFormVisible=false
    },
    async steyuyuenum(da) {
        console.log(da);
        da.isSelected=true
        let {data:res}=await this.$http.post('/getone',{data:da.day})
        console.log(res);
        this.form.data=da.day
        this.form.maxnum= res.yuo ? res.yuo.maxnum :""
        this.dialogFormVisible=true
    },
    async confomaddyu(){
        console.log(this.form);
        let {data:res}=await this.$http.post('/addyuyue',this.form)
        // console.log(res);
        this.getyuyuelist()
        this.dialogFormVisible=false
    },
    async getyuyuelist(){
        let {data:res}=await this.$http.get('/getyuyue')
        this.yuyuelisi=res.data
        this.yuyuelisi.forEach(item=>{
            item.data=dayjs(item.data).format('MM-DD')
            this.dataarr.push(item.data)
        })
    }
  },
  computed: {
    dataflg() {
    //   console.log(new Date().getTime());
      let data = dayjs(new Date().getTime()).format("MM-DD");
    //   console.log(data);
      return data;
    },
  },
  filters: {},
  watch: {},
  created() {
    this.getyuyuelist()
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
.calendata {
  text-align: right;
  height: 80%;
  /* line-height: 38px; */
}
.current{
    width: 600px;
    height: 600px;
}
.is-selected {
  color: #1989fa;
}
.span{
    display: block;
}
.btn {
  display: flex;
  flex-direction: row-reverse;
  justify-content: flex-start;
}
li{
    list-style: none;
}
.ten{
       width: 100%;
    height: 100%;
    display: flex;
    font-size: 8px;
    flex-direction: column;
    align-content: stretch;
    justify-content: center;
    
}
/* .el-button{
    width: 50px;
    text-align: center !important;
    margin-right: 10px;
    height: 30px;
} */
</style>