<template>
  <div>
    <el-card>
      <div class="left">
        <img :src="user.imgpath" alt="" />
      </div>
      <div class="right">
        <h2>个人信息卡</h2>
        <el-row :gutter="20">
          <el-col :span="9">
            <div class="grid-content bg-purple">
               <span> 用户名：{{user.username}}    </span>   
            </div>
        </el-col>
          <el-col :span="8">
            <div class="grid-content bg-purple">
               <span> 手机号：{{user.phone}}</span>
            </div>
        </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="9">
            <div class="grid-content bg-purple">
               <span> 邮箱: {{user.email}}</span>
            </div>
            </el-col>
          <el-col :span="8">
            <div class="grid-content bg-purple">
                    <span> 住址：{{user.addr}}</span>
                </div>
                </el-col>
        </el-row>
        <el-row :gutter="25">
          <el-col :span="9"><div class="grid-content bg-purple">
            <span> 性别：{{user.sex}}</span>
            </div></el-col>
          <el-col :span="15">
            <div class="grid-content bg-purple">
                <span>最近登录事件: {{user.logintime |formattime }}</span>
            </div>
        </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="9"><div class="grid-content bg-purple">
            <el-button type="primary" @click="edituser"> 编辑个人信息</el-button>
            </div></el-col>
          <el-col :span="8"><div class="grid-content bg-purple">
            
                <el-button type="primary" @click="goindex">返回</el-button>
            </div>
        </el-col>
        </el-row>
      </div>
    </el-card>
    
<el-dialog
  title="修改"
  :visible.sync="dialogVisible"
  width="30%"
  :before-close="handleClose">
      <el-form ref="elForm" :model="formData" :rules="rules" size="medium" label-width="100px">
  <el-form-item label="账号" prop="username">
    <el-input v-model="formData.username" placeholder="请输入账号"  clearable
      :style="{width: '50%'}"></el-input>
  </el-form-item>
  <el-form-item label="头像" prop="password">
    <!-- <el-upload
  class="upload-demo"

  :on-success="seucess"
  
>
  <el-button size="small" type="primary">点击上传</el-button>
 
</el-upload> -->
<el-upload
  :show-file-list="false"
  class="avatar-uploader"
    action="http://localhost:3000/imgs"
  :headers="heared"
  :on-success="seucess"
  >
  <img v-if="formData.imgpath" :src="formData.imgpath" class="avatar">
  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
</el-upload>
  </el-form-item>
  <el-form-item label="手机号" prop="phone">
    <el-input v-model="formData.phone" placeholder="请输入手机号" :maxlength="11" show-word-limit clearable
      :style="{width: '50%'}"></el-input>
  </el-form-item>
  <el-form-item label="邮箱" prop="email">
    <el-input v-model="formData.email" placeholder="请输入邮箱"  clearable :style="{width: '50%'}">
    </el-input>
  </el-form-item>
  <el-form-item label="性别" prop="sex">
    <el-radio-group v-model="formData.sex">
    <el-radio :label="'男'">男</el-radio>
    <el-radio :label="'女'">女</el-radio>
  </el-radio-group>
    <!-- <el-input v-model="formData.sex" placeholder="请输入性别"  clearable :style="{width: '50%'}">
    </el-input> -->
    
  </el-form-item>
  <el-form-item label="家庭住址" prop="addr">
    <el-input v-model="formData.addr" placeholder="请输入家庭住址"  clearable
      :style="{width: '50%'}"></el-input>
  </el-form-item>
  <el-form-item label="角色" prop="roleid">
     <el-select v-model="formData.roleid" placeholder="请选择">
    <el-option
      v-for="item in roleslst"
      :key="item._id"
      :label="item.rolename"
      :value="item._id">
    </el-option>
  </el-select>
  </el-form-item>
  <el-form-item size="large">
    <el-button type="primary" @click="submitForm">提交</el-button>
    <!-- <el-button @click="resetForm">重置</el-button> -->
  </el-form-item>
</el-form>
  
</el-dialog>
  </div>
</template>

<script>
import { mapState,mapMutations } from "vuex";
export default {
  data() {
    const chkpnone=(rule, value, callback) =>{
           let phze= /^(?:(?:\+|00)86)?1[3-9]\d{9}$/
        //    console.log(phze.test(value),'sss');
           if(!phze.test(value)){
            callback(new Error("请输入正确的手机号"))
           }else{
            callback()
           }
           
        }
        const chkemail=(rule, value, callback) =>{
            let emaze=/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            if(!emaze.test(value)){
                callback(new Error("请输入正确的邮箱"))
            }else{
                callback()
            }
           }
    return {
        logintime:"",
        dialogVisible:false,
         heared:{
            'Authorization':sessionStorage.getItem('token') || "",
          },
            roleslst:[],
            formData:{
                password:"",
                username:"",
                phone:"",
                email:"",
                sex:"",
                addr:"",
                roleid:"",
                imgpath:""
            },
            rules:{
                username:[
                       { required: true, message: '请输入账号名称', trigger: 'blur' },
                        { min: 5, max: 10, message: '长度在 5 到 10 个字符', trigger: 'blur' }
                ],
                password:[
                    { required: true, message: '请输入密码', trigger: 'blur'},
                    { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }
                ],
                
                phone:[
                     { required: true, message: '请输入手机号', trigger: 'blur' },
                      { validator: chkpnone, trigger: 'blur' }
                ],
                email:[
                     { required: true, message: '请输入邮箱', trigger: 'blur' },
                      { validator: chkemail, trigger: 'blur' }

                ],
                sex:[
                     { required: true, message: '请输入性别', trigger: 'blur' },

                ],
                addr:[
                     { required: true, message: '请输入住址', trigger: 'blur' },
                    

                ],
                roleid:[
                     { required: true, message: '请输入角色', trigger: 'blur' },

                ]



            }
    };
  },
  methods: {
    ...mapMutations(['getuser']),
    goindex(){
        this.$router.push('/home')
    },
    async edituser(){
        let {data:res}=await this.$http.get('/user/'+this.user._id)
        // console.log(res);
        this.formData=res.user
        this.dialogVisible=true
    },
    seucess(res){
        this.formData.imgpath='http://localhost:3000/'+res.path
    },
    handleClose(){
        this.dialogVisible=false    
        this.formData={
             password:"",
                username:"",
                phone:"",
                email:"",
                sex:"",
                addr:"",
                roleid:"",
                imgpath:""
        }
    },
    async getrolelist(){
        let {data:res}=await this.$http.get('/roles')
        this.roleslst=res.data
    },
    submitForm(){
         this.$refs.elForm.validate(async (valid)=>{
            if(valid){
               
                let {data:res}=await this.$http.post('/eduser',this.formData)
                console.log(res);
                this.getuser(res.user)
                this.dialogVisible=false    
            }
         })
    }
  },
  computed: {
    ...mapState(["user"]),
  },
  filters: {},
  watch: {},
  created() {
    this.getrolelist()
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
.el-card {
  width: 85%;
  margin-left: 40px;
  height: 800px;
  margin-top: 25px;
}
.el-card .left {
  width: 500px;
  /* background-color: red; */
  float: left;
  height: 800px;
  background-image: url(../assets/96b672f8f9be15f2823d3ac466e34c23.png);
  background-position: center center;
  background-repeat: no-repeat;
  background-size: 100% 100%;
}
.el-card .right {
  width: 635px;
  height: 800px;
  float: right;
  padding-left: 40px;
}
.left img {
  border-radius: 50%;
  margin-left: 45px;
  margin-top: 143px;
  width: 400px;
  height: 400px;
}
.right h2 {
  width: 500px;
  border-bottom: 5px solid black;
}
.right .el-row{
    margin: 120px 0px;
}
.avatar{
    width: 100px;
    height: 100px;
}
</style>