<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>预约管理</el-breadcrumb-item>
      <el-breadcrumb-item>检查项管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="serch" clearable @clear="getproplist">
            <el-button
              slot="append"
              icon="el-icon-search"
              @click="getproplist"
            ></el-button>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button type="primary" @click="dialogFormVisible = true"
            >添加检查项</el-button
          >
        </el-col>
      </el-row>
      <el-table
        :data="proplist"
        style="width: 100%"
        border
        stripe
        highlight-current-row
      >
        <el-table-column type="index" label="#"> </el-table-column>
        <el-table-column prop="name" label="套餐名称"> </el-table-column>
        <el-table-column prop="issex" label="适用性别"> </el-table-column>
        <el-table-column prop="isage" label="适用年龄"> </el-table-column>
        <el-table-column prop="code" label="助记码"> </el-table-column>
        <el-table-column prop="price" label="价格"> </el-table-column>
        <el-table-column prop="explain" label="说明"> </el-table-column>
        <el-table-column prop="attention" label="注意事项"> </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              type="primary"
              size="small"
              icon="el-icon-edit"
              @click="editproobmodel(scope.row._id)"
            ></el-button>
            <el-button
              type="danger"
              size="small"
              icon="el-icon-delete"
              @click="deleteproobmodel(scope.row._id)"
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

      <el-dialog title="添加检查项" :visible.sync="dialogFormVisible" @close="clearform">
        <div>
          <el-radio-group v-model="radio1">
            <el-radio-button label="基本信息"></el-radio-button>
            <!-- <el-radio-button label="北京"></el-radio-button> -->
          </el-radio-group>
        </div>
        <el-form :model="form">
          <el-form-item label="检查项名" :label-width="formLabelWidth">
            <el-input v-model="form.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用年龄" :label-width="formLabelWidth">
            <el-input v-model="form.isage" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用性别" :label-width="formLabelWidth">
            <el-radio-group v-model="form.issex">
              <el-radio :label="'男'">男</el-radio>
              <el-radio :label="'女'">女</el-radio>
              <el-radio :label="'不限'">不限</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="项目编码" :label-width="formLabelWidth">
            <el-input
              v-model="form.code"
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
          <el-form-item label="类型" :label-width="formLabelWidth">
            <el-input v-model="form.type" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="说明" :label-width="formLabelWidth">
            <el-input v-model="form.explain" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="注意事项" :label-width="formLabelWidth">
            <el-input v-model="form.attention" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="addproobmodel">确 定</el-button>
        </div>
      </el-dialog>
      <el-dialog title="修改检查项" :visible.sync="editdialogFormVisible" @close="clearedform">
        
        <el-form :model="edform">
          <el-form-item label="检查项名" :label-width="formLabelWidth">
            <el-input v-model="edform.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用年龄" :label-width="formLabelWidth">
            <el-input v-model="edform.isage" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="适用性别" :label-width="formLabelWidth">
            <el-radio-group v-model="edform.issex">
              <el-radio :label="'男'">男</el-radio>
              <el-radio :label="'女'">女</el-radio>
              <el-radio :label="'不限'">不限</el-radio>
            </el-radio-group>
          </el-form-item>
          
          <el-form-item label="价格" :label-width="formLabelWidth">
            <el-input
              v-model="edform.price"
              type="number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="类型" :label-width="formLabelWidth">
            <el-input v-model="edform.type" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="说明" :label-width="formLabelWidth">
            <el-input v-model="edform.explain" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="注意事项" :label-width="formLabelWidth">
            <el-input v-model="edform.attention" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="editdialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="editproob">确 定</el-button>
        </div>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      proplist: [],
      radio1: "基本信息",
      page: 1,
      pagesize: 3,
      serch:"",
      count: 0,
      editdialogFormVisible:false,
      dialogFormVisible: false,
      form: {
        name: "",
        isage: "",
        issex: "",
        code: 0,
        price: 0,
        type: "",
        explain: "",
        attention: "",
      },
       edform: {
        name: "",
        isage: "",
        issex: "",
        code: 0,
        price: 0,
        type: "",
        explain: "",
        attention: "",
      },
      formLabelWidth: "80px",
    };
  },
  methods: {
    handleSizeChange(val){
        console.log(val);
        this.pagesize=val
        this.getproplist()
    },
    handleCurrentChange(val){
        this.page=val
        this.getproplist()

    },
    async getproplist(){
        let {data:res}=await this.$http.get(`/getproplist?page=${this.page}&pagesize=${this.pagesize}&serch=${this.serch}`)
        this.proplist=res.data
        this.count=res.count
    },
    async addproobmodel() {
      let { data: res } = await this.$http.post("/addproobmodel", this.form);
      console.log(res);
      this.clearform()
      this.getproplist()
    },
    async deleteproobmodel(id){
        let {data:res}=await this.$http.delete('/deleteproobmodel/'+id)
        this.page=1
        this.getproplist()

    },
    async editproobmodel(id){
        let {data:res}=await this.$http.get('/getproone/'+id)
        console.log(res);
        this.edform=res.data
        this.editdialogFormVisible=true
    },
    async editproob(){
        let {data:res}=await this.$http.put('/editproobmodel',this.edform)
        console.log(res);
        this.clearedform()
        this.getproplist()
    },
    clearform(){
        this.form={
            name: "",
        isage: "",
        issex: "",
        code: 0,
        price: 0,
        type: "",
        explain: "",
        attention: "",
        }
        this.dialogFormVisible=false
    },
    clearedform(){
        this.edform={
             name: "",
        isage: "",
        issex: "",
        code: 0,
        price: 0,
        type: "",
        explain: "",
        attention: "",
        }
        this.editdialogFormVisible=false
    }
  },
  computed: {},
  filters: {},
  watch: {},
  created() {
    this.getproplist()
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
</style>