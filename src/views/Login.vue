<template>
  <div class="denlu">
    <div class="loginbox">
      <div class="imgbox">
        <img src="../assets/logo.png" alt="" />
      </div>
      <div class="formbox">
        <el-form ref="userform" :model="form" label-width="0px" class="foem" :rules="rulesform">
          <el-form-item  prop="username" >
            <el-input v-model="form.username" >
                <i slot="prefix" class="iconfont icon-yonghu"></i>
            </el-input>
          </el-form-item>
          <el-form-item  prop="password" >
            <el-input v-model="form.password"  show-password>
                <i slot="prefix" class="iconfont icon-mima"></i>

            </el-input>
          </el-form-item>
          <div class="btns">
            <el-button type="primary" class="bbtn" @click="login">登录</el-button>
            <el-button type="success" class="bbtn" @click="$router.push('/resetuser')">注册</el-button>
            <el-button type="info" class="bbtn" @click="restform">重置</el-button>

          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import jwtdecode from 'jwt-decode'
import { mapMutations, mapState } from 'vuex';
export default {
  data() {
    return {
        form:{
            username:"admin",
            password:"123456789",
        },
        rulesform:{
            username:[
                { required: true, message: '请输入用户名称', trigger: 'blur' },
                { min: 5, max: 10, message: '长度在 5 到 10 个字符', trigger: 'blur' }
            ],
            password:[
                { required: true, message: '请输入密码', trigger: 'blur' },
                { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }


            ]
        }
    };
  },
  methods: {
    ...mapMutations(['getuser']),
    login(){
        this.$refs.userform.validate(async (valid)=>{
            if(valid){
                let {data:res}=await this.$http.post('/login',this.form)
                // console.log(res);
                if(res.msg){
                   return this.$message.error(res.msg)
                }
                this.$message.success("成功");
                sessionStorage.setItem('token',res.token)
                let user=jwtdecode(res.token)._doc
                // sessionStorage.setItem('user',JSON.stringify(user))
                this.getuser(user)
                this.$router.push('/home')
                
            }
        })
    },
    restform(){
            this.$refs.userform.resetFields()
    }
  
  },
  computed: {
    ...mapState(['user']),
  },
  filters: {},
  watch: {},
  created() {},
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>

.loginbox {
  width: 600px;
  height: 400px;
  background-color: white;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  border-radius: 10px;
}
.imgbox {
  width: 210px;
  height: 210px;
  background-color: white;
  border-radius: 50%;
  position: absolute;
  border:1px solid #eee;
  text-align: center;
  left: 50%;
  top: 1%;
  padding: 10px;
  transform: translate(-50%, -50%);
  /* line-height: 210px; */
  box-shadow: 0 0 10px #888888;
}
.imgbox img {
    border-radius: 50%;
    border: 1px solid #eee;
}
.denlu {
  width: 100%;
  height: 100%;
  background-image: url(../assets/onhon.png);
  background-repeat: no-repeat;
  background-size: 100% 100%;
  background-position: center center;
}
.formbox{
        display: flex;
    margin-top: 141px;
    align-items: center;
    flex-direction: column;

}
.foem{
    width: 600px;
}

.el-input{
    width: 600px;
}
.el-form-item{
    margin-bottom: 40px;

}
.btns{
        display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
    flex-wrap: wrap;
}
.bbtn{
    width: 150px;
}
</style>