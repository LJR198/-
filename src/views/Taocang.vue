<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>预约管理</el-breadcrumb-item>
      <el-breadcrumb-item>套餐管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="serch" clearable @clear="getdatalist">
            <el-button
              slot="append"
              icon="el-icon-search"
              @click="getdatalist"
            ></el-button>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button type="primary" @click="dialogFormVisible = true"
            >添加套餐</el-button
          >
        </el-col>
      </el-row>
      <el-table
        :data="datalist"
        style="width: 100%"
        border
        stripe
        highlight-current-row
      >
        <el-table-column type="index" label="#"> </el-table-column>
        <el-table-column prop="name" label="套餐名称"> </el-table-column>
        <el-table-column prop="issex" label="适用性别"> </el-table-column>
        <el-table-column prop="isage" label="适用年龄"> </el-table-column>
        <el-table-column prop="encoder" label="助记码"> </el-table-column>
        <el-table-column prop="price" label="价格"> </el-table-column>
        <el-table-column prop="explain" label="说明"> </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              type="primary"
              size="small"
              icon="el-icon-edit"
              @click="editcombomodel(scope.row._id)"
            ></el-button>
            <el-button
              type="danger"
              size="small"
              icon="el-icon-delete"
              @click="deletecombomodel(scope.row._id)"
            ></el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="page"
        :page-sizes="[3, 6, 9, 12]"
        :page-size="pagesize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="count"
      >
      </el-pagination>

      <el-dialog title="添加检查组" :visible.sync="dialogFormVisible" @close="clearform">
        <div>
          <el-radio-group v-model="radio1">
            <el-radio-button label="基本信息"></el-radio-button>
            <el-radio-button label="检查组信息"></el-radio-button>
          </el-radio-group>
        </div>
        <el-form :model="form" v-if="radio1=='基本信息'">
          <el-form-item label="套餐名称" :label-width="formLabelWidth">
            <el-input v-model="form.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用性别" :label-width="formLabelWidth">
            <el-radio-group v-model="form.issex">
              <el-radio :label="'男'">男</el-radio>
              <el-radio :label="'女'">女</el-radio>
              <el-radio :label="'不限'">不限</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="适用年龄" :label-width="formLabelWidth">
            <el-input v-model="form.isage" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="助记码" :label-width="formLabelWidth">
            <el-input
              v-model="form.encoder"
              type="number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
           <el-form-item label="价格" :label-width="formLabelWidth">
            <el-input
              v-model="form.price"
              type="number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="说明" :label-width="formLabelWidth">
            <el-input v-model="form.explain" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="检查组" :label-width="formLabelWidth" >
            <el-radio-group v-model="form.jianzuid" v-for="item in jianchazulist" :key="item._id">
                <el-radio :label="item._id">{{item.name}}</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-form>
        <el-table
        :data="jianchazulist"
        style="width: 100%"
        border
        stripe
        highlight-current-row
       v-else>
        <el-table-column type="index" label="#"> </el-table-column>
        <el-table-column prop="name" label="套餐名称"> </el-table-column>
        <el-table-column prop="issex" label="适用性别"> </el-table-column>
        <el-table-column prop="encoder" label="编码"> </el-table-column>
        <el-table-column prop="mnemonic" label="助记码"> </el-table-column>
        <el-table-column prop="explain" label="说明"> </el-table-column>
        <el-table-column prop="attention" label="注意事项"> </el-table-column>
      </el-table>
        <div slot="footer" class="dialog-footer" v-if="radio1=='基本信息'">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="addcombomodel">确 定</el-button>
        </div>
      </el-dialog>
      <el-dialog title="修改检查组" :visible.sync="editdialogFormVisible" @close="clearedform">
        
        <el-form :model="edform" v-if="radio1=='基本信息'">
          <el-form-item label="套餐名称" :label-width="formLabelWidth">
            <el-input v-model="edform.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用性别" :label-width="formLabelWidth">
            <el-radio-group v-model="edform.issex">
              <el-radio :label="'男'">男</el-radio>
              <el-radio :label="'女'">女</el-radio>
              <el-radio :label="'不限'">不限</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="适用年龄" :label-width="formLabelWidth">
            <el-input v-model="edform.isage" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="助记码" :label-width="formLabelWidth">
            <el-input
              v-model="edform.encoder"
              type="number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
           <el-form-item label="价格" :label-width="formLabelWidth">
            <el-input
              v-model="edform.price"
              type="number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="说明" :label-width="formLabelWidth">
            <el-input v-model="edform.explain" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="检查组" :label-width="formLabelWidth">
            <el-radio-group v-model="edform.jianzuid" v-for="item in jianchazulist" :key="item._id">
                <el-radio :label="item._id">{{item.name}}</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="editdialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="edittaocan">确 定</el-button>
        </div>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
        jianchazulist:[],
      datalist: [],
      radio1: "基本信息",
      page: 1,
      pagesize: 3,
      serch:"",
      count: 0,
      editdialogFormVisible:false,
      dialogFormVisible: false,
      form: {
        name: "",
        issex: "",
        isage: "",
        encoder: 0,
        price: 0,
        explain: "",
        jianzuid:""
      },
       edform: {
         name: "",
        issex: "",
        isage: "",
        encoder: 0,
        price: 0,
        explain: "",
        jianzuid:""
      },
      formLabelWidth: "80px",
    };
  },
  methods: {
    handleSizeChange(val){
        console.log(val);
        this.pagesize=val
        this.getdatalist()
    },
    handleCurrentChange(val){
      // console.log(val);
        this.page=val
        this.getdatalist()

    },
    async getdatalist(){
        let {data:res}=await this.$http.get(`/combols?fen=all&page=${this.page}&pagesize=${this.pagesize}&serch=${this.serch}`)
        console.log(res);
        this.datalist=res.data
        this.count=res.count
       
    },
    async getjianchazulist(){
        let {data:res}=await this.$http.get(`/getjianchazulist?fen=no`)
        this.jianchazulist=res.data
    },
    async addcombomodel() {
      let { data: res } = await this.$http.post("/addcombomodel", this.form);
      console.log(res);
      this.clearform()
      this.getdatalist()
    },
    async deletecombomodel(id){
        let {data:res}=await this.$http.delete('/deletecombomodel/'+id)
        this.page=1
        this.getdatalist()

    },
    async editcombomodel(id){
        let {data:res}=await this.$http.get('/combomodelone/'+id)
        console.log(res);
        this.edform=res.data
        this.editdialogFormVisible=true
    },
    async edittaocan(){
        let {data:res}=await this.$http.put('/editcombomodel',this.edform)
        console.log(res);
        this.clearedform()
        this.getdatalist()
    },
    clearform(){
        this.form={
         name: "",
        issex: "",
        isage: "",
        encoder: 0,
        price: 0,
        explain: "",
        jianzuid:""
        }
        this.dialogFormVisible=false
    },
    clearedform(){
        this.edform={
          name: "",
        issex: "",
        isage: "",
        encoder: 0,
        price: 0,
        explain: "",
        jianzuid:""
        }
        this.editdialogFormVisible=false
    }
  },
  computed: {},
  filters: {},
  watch: {},
  created() {
    this.getdatalist()
    this.getjianchazulist()
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
</style>