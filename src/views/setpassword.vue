<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>修改密码</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 20px">
      <el-form
        ref="elForm"
        :model="formData"
        :rules="rules"
        size="medium"
        label-width="100px"
      >
        <el-form-item label="原密码" prop="password" >
          <el-input
            v-model="formData.password"
            placeholder="请输入原密码"
            clearable
            :style="{ width: '100%' }"
            show-password
            :disabled='errortimes>=3'
            
          ></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newpassword">
          <el-input
            v-model="formData.newpassword"
            placeholder="请输入新密码"
            clearable
            show-password
            :style="{ width: '100%' }"
          >
          </el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmpassword">
          <el-input
            v-model="formData.confirmpassword"
            placeholder="请输入确认密码"
            clearable
            show-password
            :style="{ width: '100%' }"
          >
          </el-input>
        </el-form-item>
        <el-form-item size="large">
          <el-button type="primary" @click="submitForm">提交</el-button>
          <el-button @click="resetForm">重置</el-button>
          <el-button type="primary" v-if="errortimes==3" @click="forgetthepassword">忘记密码</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <el-dialog title="忘记密码" :visible.sync="dialogFormVisible">
  <el-form :model="form" :rules="formrules" ref="formref">
    <el-form-item label="验证码" :label-width="formLabelWidth" prop="name" >
      <el-input v-model="form.name" autocomplete="off" placeholder="请输入验证码"></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="dialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="submitForm2">确 定</el-button>
  </div>
</el-dialog>
<el-dialog title="设置密码" :visible.sync="setdialogFormVisible">
  <el-form :model="form" :rules="formrules" ref="formrefs">
    <el-form-item label="新密码" :label-width="formLabelWidth" prop="password"  >
      <el-input v-model="form.password" autocomplete="off" placeholder="请输入验证码" show-password></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="setdialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="submitForm3">确 定</el-button>
  </div>
</el-dialog>
  </div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  data() {
    var validatepassword=(rules,value,callback)=>{
        if(value!=this.user.password){
          this.errortimes+=1
          return  callback(new Error('原密码不正确'))
        }else{
          return  callback()

        }
    };
    var validateconfirmpassword=(rules,value,callback)=>{
      if(value!=this.formData.newpassword){
        return callback(new Error('两次密码不一致请重新输入'))
      }else{
          return  callback()

      }
    };
    var validateyanzhengma =(rules,value,callback)=>{
      if(value!=this.countnum){
        return callback(new Error('验证码错误'))
      }else{
        return callback()
      }
    }
    return {
      countnum:"",
      form:{
        name:"",
        password:"",
      },
      setdialogFormVisible:false,
      dialogFormVisible:false,
      formLabelWidth:"80px",
      errortimes:0,
      formData: {
        password: "",
        newpassword: "",
        confirmpassword: "",
      },
      formrules:{
        name:[
          {
            required: true,
            message: "请输入验证码",
            trigger: "blur",
          },
          {validator: validateyanzhengma, trigger: 'blur'},

        ],
        password:[
          {
            required: true,
            message: "请输入原密码",
            trigger: "blur",
          },
          { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }

        ]
      },
      rules: {
        password: [
          {
            required: true,
            message: "请输入原密码",
            trigger: "blur",
          },
          {validator: validatepassword, trigger: 'blur'},

        ],
        newpassword: [
          {
            required: true,
            message: "请输入新密码",
            trigger: "blur",
          },
          { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }

        ],
        confirmpassword: [
          {
            required: true,
            message: "请输入确认密码",
            trigger: "blur",
          },
          { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' },

          {validator: validateconfirmpassword, trigger: 'blur'}

        ],
      },
    };
  },
  methods: {
    forgetthepassword(){
      let cnt=''
     for (let i = 0; i < 6; i++) {
      let num=Math.ceil(Math.random()*9)
      cnt+=num
      
     }
    //  console.log(cnt);
     this.countnum=cnt;
     alert(`验证码是${cnt}`)
     this.dialogFormVisible=true;
    },
    submitForm3(){
      this.$refs["formrefs"].validate(async(valid) => {
        if (!valid) return;
        console.log(this.form);
        let {data:res}=await this.$http.post('/setpassword/'+this.user._id,{newpassword:this.form.password})
        if(res.user.matchedCount==1){
          this.$message.success('修改密码成功！ 请重新登录')
          this.$router.push('/login')
        }else{
          this.$message.info('修改密码失败！')
        }

        // this.setdialogFormVisible=true
      })
    },
    submitForm2(){
      this.$refs["formref"].validate(async(valid) => {
        if (!valid) return;
        console.log(this.form);
        this.setdialogFormVisible=true
      })
    },
    submitForm() {
      this.$refs["elForm"].validate(async(valid) => {
        if (!valid) return;
        // console.log(this.formData)
        let {data:res}=await this.$http.post('/setpassword/'+this.user._id,this.formData)
        console.log(res)
        if(res.user.matchedCount==1){
          this.$message.success('修改密码成功！ 请重新登录')
          this.$router.push('/login')
        }else{
          this.$message.info('修改密码失败！')
        }
        // TODO 提交表单
      });
    },
    resetForm() {
      this.$refs["elForm"].resetFields();
    },
  },
  computed: {
    ...mapState(['user'])
  },
  filters: {},
  watch: {},
  created() {},
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
</style>