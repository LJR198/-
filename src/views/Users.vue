<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="serch" clearable @clear="getusersdata">
            <el-button slot="append" icon="el-icon-search"   @click="getusersdata"></el-button>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button type="primary" @click="gotosrree">添加用户</el-button>
        </el-col>
      </el-row>
      <el-table :data="usersdata" style="width: 100%" border stripe highlight-current-row>
        <el-table-column type="index" label="#"> </el-table-column>
        <el-table-column prop="username" label="用户名"> </el-table-column>
        <el-table-column prop="email" label="邮箱"> </el-table-column>
        <el-table-column prop="phone" label="电话"> </el-table-column>
        <el-table-column prop="roleid" label="角色">
          <template slot-scope="scope">
            {{ scope.row.roleid.rolename }}
          </template>
        </el-table-column>
        <el-table-column prop="state" label="状态">
          <template slot-scope="scope">
            <el-switch
              @change="eduserstate(scope.row)"
              v-model="scope.row.state"
              active-color="#13ce66"
              inactive-color="#ff4949"
            >
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" v-if="user.state"> 
            <template slot-scope="scope" >
                <el-button type="primary" size="small" icon="el-icon-edit" @click="edituser(scope.row._id)" v-if="user.state"></el-button>
                <el-button type="danger" size="small" icon="el-icon-delete" @click="deleteuser(scope.row._id)"></el-button>
                <el-button type="warning" size="small" icon="el-icon-setting" @click="getuserrole(scope.row._id)"></el-button>
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
      :total="count">
    </el-pagination>
    </el-card>
    <el-dialog @close="onClose" title="修改用户"  :visible.sync="dialogVisible">
  <el-form ref="elForm" :model="userform" :rules="rules" size="medium" label-width="100px">
    <el-form-item label="用户名" prop="username">
      <el-input v-model="userform.username" placeholder="请输入用户名" clearable :style="{width: '100%'}">
      </el-input>
    </el-form-item>
    <el-form-item label="性别" prop="sex">
      <el-radio-group v-model="userform.sex" size="medium">
        <el-radio v-for="(item, index) in sexOptions" :key="index" :label="item.value"
          :disabled="item.disabled">{{item.label}}</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="邮箱" prop="email">
      <el-input v-model="userform.email" placeholder="请输入邮箱" clearable :style="{width: '100%'}"></el-input>
    </el-form-item>
    <el-form-item label="电话" prop="phone">
      <el-input v-model="userform.phone" placeholder="请输入电话" clearable :style="{width: '100%'}"></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer">
    <el-button  @click="dialogVisible=false">取消</el-button>
    <el-button type="primary" @click="handelConfirm">确定</el-button>
  </div>
</el-dialog>
    <el-dialog title="分配角色" :visible.sync="setdialogFormVisible" @close="closeEvent">
  <el-form :model="form">
    <el-form-item label="当前角色" :label-width="formLabelWidth">
      <el-input v-model="form.rolename" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="分配角色" :label-width="formLabelWidth">
     <el-select v-model="form.rolename2" placeholder="请选择">
    <el-option
      v-for="item in roleidOptions"
      :key="item._id"
      :label="item.rolename"
      :value="item._id">
    </el-option>
  </el-select>
        
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="setdialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="setoutuserrole">确 定</el-button>
  </div>
</el-dialog>
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex';
export default {
  data() {
    var chkemail=(rules,value,callback)=>{
           let emailre= /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
           if(!emailre.test(value)){
            return callback(new Error('邮箱格式不正确'))
           }else{
            return callback()
           }
        };
        var chkphone=(rules,value,callback)=>{
            let phonere=/^(?:(?:\+|00)86)?1[3-9]\d{9}$/
            if(!phonere.test(value)){
            return callback(new Error('手机号格式不正确'))
           }else{
            return callback()
           }
        }
    return {
        form:{rolename:"",rolename2:"",id:""},
        formLabelWidth:"180px",
        setdialogFormVisible:false,
        dialogVisible:false,
         rules: {
        username: [{
          required: true,
          message: '请输入用户名',
          trigger: 'blur'
        },
        {
             min: 5, max: 10, message: '长度在 5 到 10 个字符', trigger: 'blur' 
        }
        ],
        sex: [{
          required: true,
          message: '性别不能为空',
          trigger: 'change'
        }],
        email: [{
          required: true,
          message: '请输入邮箱',
          trigger: 'blur'
        },
        {
            validator: chkemail, trigger: 'blur'
        }
        ],
        phone: [{
          required: true,
          message: '请输入电话',
          trigger: 'blur'
        },
        {
            validator: chkphone, trigger: 'blur'
        }
        ],
      },
      sexOptions: [{
        "label": "男",
        "value": "男"
      }, {
        "label": "女",
        "value": "女"
      }],
      usersdata: [],
      page: 1,
      pagesize: 3,
      count: 0,
      serch: "",
      userform:{
        _id:"",
        username:"",
        sex:"",
        phone:"",
        email:"",
      },
      roleidOptions:[]
    };
  },
  methods: {
    ...mapMutations(['getuser']),
    gotosrree(){
      this.$router.push({path:"/resetuser",query:{adduser:"adduser"}})
    },
    handleSizeChange(val){
        this.pagesize=val
        this.getusersdata()
    },
    handleCurrentChange(val){
        this.page=val
        this.getusersdata()


    },
    async setoutuserrole(){
        console.log(this.form)
        let {data:res}=await this.$http.post('/setuserrole/'+this.form.id,{roleid:this.form.rolename2})
        this.closeEvent()
        this.getusersdata()
    },
    closeEvent(){
        this.setdialogFormVisible=false
        this.form={
            rolename:"",rolename2:"",id:""
        }
    },
    async getroleidOptions(){
            let {data:res}=await this.$http.get('/roles')
            this.roleidOptions=res.data
        },
    async getuserrole(id){
        let {data:res}=await this.$http.get('/userole/'+id)
        console.log(res)
        this.getroleidOptions()
        this.form.id=res.user._id
        this.form.rolename=res.user.roleid.rolename
        this.setdialogFormVisible=true
    },
    async eduserstate(user){
        // console.log(user);
        let {data:res}=await this.$http.put('/eduserstate/'+user._id,{state:user.state})
        if(user._id==this.user._id){
          // this.user.state=user.state
          this.getuser(user)
          // this.$router.push('/login')
        }
        if(res.code==200){
                 this.$message.success('修改用户信息成功')
            }else{
                this.$message.error('修改用户信息失败')

            }
            this.getusersdata()
    },
    onClose() {
        this.dialogVisible=false
      this.userform={
         _id:"",
        username:"",
        sex:"",
        phone:"",
        email:"",
      }
    },
    handelConfirm() {
      this.$refs['elForm'].validate(async(valid) => {
        console.log(valid);
        if(valid){
            let {data:res}=await this.$http.put('/edituser/'+this.userform._id,this.userform)
            if(res.code==200){
                 this.$message.success('修改用户信息成功')
            }else{
                this.$message.error('修改用户信息失败')

            }
            this.getusersdata()
             this.onClose()

        }else{
                this.$message.error('数据格式不正确')
        this.onClose()

        }
      })
    },
    async getusersdata() {
      if(this.serch){
        this.page=1
      }
      let { data: res } = await this.$http.get(
        `/users?page=${this.page}&pagesize=${this.pagesize}&serch=${this.serch}`
      );
    //   console.log(res);
      this.usersdata = res.data;
      this.count = res.count;
    },
    async deleteuser(id){
        // console.log(id);
        //删除用户
        if(id==this.user._id){
            return this.$message.error('当前用户不可删除')
        }
        let aed=await   this.$confirm('此操作将永久删除用户, 是否继续?', '!警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).catch(()=>{
             this.$message({
            type: 'info',
            message: '已取消删除'
          });   
        })
        if (aed=='confirm'){
            let {data:res}=await this.$http.delete('/user/'+id)
            // console.log(res);
            if(res.data.deletedCount==1){
                this.$message.success('删除成功')
            }else{
                this.$message.error('删除失败')


            }
            this.page=1
            this.getusersdata()
            
        }
        // console.log(aed)
    },
    async edituser(id){
        let {data:res}=await this.$http.put('/user/'+id)
        console.log(res);
        this.userform=res.user
        this.dialogVisible=true
    }
  },
  computed: {
    ...mapState(["user"])
  },
  filters: {},
  watch: {},
  created() {
    this.getusersdata();
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
.el-table{
    max-width: 1600px;
    min-width: 1600px;
}
</style>