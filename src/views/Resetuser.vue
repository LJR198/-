<template>
  <div>
    <el-form ref="elForm" :model="formData" :rules="rules" size="medium" label-width="100px">
  <el-form-item label="用户名：" prop="username">
    <el-input v-model="formData.username" placeholder="请输入用户名：" clearable :style="{width: '100%'}"></el-input>
  </el-form-item>
  <el-form-item label="密码：" prop="password">
    <el-input v-model="formData.password" placeholder="请输入密码：" clearable show-password
      :style="{width: '100%'}"></el-input>
  </el-form-item>
  <el-form-item label="手机号：" prop="phone">
    <el-input v-model="formData.phone" placeholder="请输入手机号：" clearable show-password
      :style="{width: '100%'}"></el-input>
  </el-form-item>
  <el-form-item label="邮箱：" prop="email">
    <el-input v-model="formData.email" placeholder="请输入邮箱：" clearable :style="{width: '100%'}"></el-input>
  </el-form-item>
  <el-form-item label="地址：" prop="addr">
    <el-input v-model="formData.addr" placeholder="请输入地址：" clearable :style="{width: '100%'}"></el-input>
  </el-form-item>
  <el-form-item label="性别：" prop="sex">
    <el-radio-group v-model="formData.sex" size="medium">
      <el-radio v-for="(item, index) in sexOptions" :key="index" :label="item.value"
        :disabled="item.disabled">{{item.label}}</el-radio>
    </el-radio-group>
  </el-form-item>
  <el-form-item label="头像：" prop="imgpath" required>
    <el-upload ref="imgpath" action="http://localhost:3000/imgs" :on-success="sucessimg">
      <el-button size="small" type="primary" icon="el-icon-upload">点击上传</el-button>
    </el-upload>
  </el-form-item>
  <el-form-item label="角色：" prop="roleid">
    <el-select v-model="formData.roleid" placeholder="请选择角色" clearable :style="{width: '100%'}">
      <el-option v-for="item in roleidOptions" :key="item._id" :label="item.rolename" :value="item._id"
        :disabled="item.disabled"></el-option>
    </el-select>
  </el-form-item>
  <el-form-item size="large">
    <el-button type="primary" @click="submitForm">提交</el-button>
    <el-button @click="resetForm">重置</el-button>
  </el-form-item>
</el-form>
  </div>
</template>

<script>
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
      formData: {
        username: "",
        phone:"",
        password: "",
        email: "",
        addr: "",
        sex: "",
        imgpath: "",
        roleid: "",
      },
      rules: {
        username: [{
          required: true,
          message: '请输入用户名：',
          trigger: 'blur'
        },
        {
             min: 5, max: 10, message: '长度在 5 到 10 个字符', trigger: 'blur' 
        }],
        password: [{
          required: true,
          message: '请输入密码：',
          trigger: 'blur'
        },
        {
             min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' 
        }],
        email: [{
          required: true,
          message: '请输入邮箱：',
          trigger: 'blur'
        },
        {
            validator: chkemail, trigger: 'blur'
        }],
        phone:[{
             required: true,
          message: '请输入手机号',
          trigger: 'blur'
        },{
            validator: chkphone, trigger: 'blur'
        }],
        addr: [{
          required: true,
          message: '请输入地址：',
          trigger: 'blur'
        }],
        sex: [{
          required: true,
          message: '性别：不能为空',
          trigger: 'change'
        }],
        roleid: [{
          required: true,
          message: '请选择角色',
          trigger: 'change'
        }],
      },
      sexOptions: [{
        "label": "男",
        "value": "男"
      }, {
        "label": "女",
        "value": "女"
      }],
      roleidOptions: [],
    }
  },
    methods:{
        async getroleidOptions(){
            let {data:res}=await this.$http.get('/roles')
            this.roleidOptions=res.data
        },
        submitForm() {
      this.$refs['elForm'].validate(async (valid) => {
        if(valid){
            console.log(this.formData);
            let {data:res}=await this.$http.post('/adduser',this.formData)
            console.log(res);
            if(res.code==200){
                this.$message.success('注册成功')
                console.log();
                if(this.$route.query.adduser=='adduser'){
                  this.$router.push('/users')
                }else{
                  this.$router.push('/login')

                }
                return;
            } else if (res.code==205){
                this.$message.info('用户已存在')

              if(this.$route.query.adduser=='adduser'){
                  this.$router.push('/users')
                }else{
                  this.$router.push('/login')

                }
              // this.$router.push('/login')
                return

            }else{
              // this.$router.push('/login')

              this.$message.error('注册失败')
              if(this.$route.query.adduser=='adduser'){
                  this.$router.push('/users')
                }else{
                  this.$router.push('/login')

                }
              return
            }
        }
        // TODO 提交表单
      })
    },
    resetForm() {
      this.$refs['elForm'].resetFields()
    },
    sucessimg(req,file,filelist){
        console.log(req);
        this.formData.imgpath='http://localhost:3000/'+req.path
    }
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
        this.getroleidOptions()
        
    },
    destroyed(){

    }
}
</script>

<style scoped>

</style>