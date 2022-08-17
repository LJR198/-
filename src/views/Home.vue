<template>
  <el-container>
    <el-header>
      <div class="logo">
        <img src=".././assets/健康管理 (1).png" alt="" srcset="" />
        <span>健康管理系统</span>
      </div>
      <div class="userbox">
        <el-popover placement="right" width="100" trigger="hover" @hide="reseti()" >
          <ul class="hovera">
            <li v-for="(item,index) in userset" :key="index" :class="{green:usersetindex===index}" @mousemove="classset(index)" @click="gotorou(index)">
              {{item}}
            </li>
          </ul>
          <img :src=user.imgpath alt="" srcset=""  slot="reference"/>
        </el-popover>
        <span>{{ user.username }}</span>
      </div>
    </el-header>
    <el-container>
      <el-aside :width="menuwidth">
        <el-menu
          :collapse="isshoumenu"
          router
          class="el-menu-vertical-demo"
          background-color="#545c64"
          text-color="#fff"
          unique-opened
          :collapse-transition="false"
          active-text-color="#67C23A"
        >
          <div class="menuclike" @click="menuscollapse">|||</div>
          <el-submenu
            :index="item._id + ''"
            v-for="item in menus"
            :key="item._id"
            
          >
            <template slot="title">
              <i :class="fonts[item._id]"></i>
              <span>{{ item.name }}</span>
            </template>
            <el-menu-item-group>
              <el-menu-item
                :index="ceim.path"
                v-for="ceim in item.menus"
                :key="ceim._id"
              >
                <i class="el-icon-menu"></i>

                {{ ceim.name }}</el-menu-item
              >
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      menus: [],
      userset:['个人资料','修改密码','退出登录'],
      isshoumenu: true,
      usersetindex:0,
      menuwidth: "64px",
      fonts: {
       "62f307ce9107dca6a1762215": "iconfont icon-a-gongzuotaigongzuozhuo-09",
        "62f307ce9107dca6a1762216": "iconfont icon-yonghu",
        "62f307ce9107dca6a1762217": "iconfont icon-yuyueguanli",
        "62f307ce9107dca6a1762218": "iconfont icon-jiaoseguanli1",
        "62f307ce9107dca6a1762219": "iconfont icon-tongji",
      },
    };
  },
  methods: {
    reseti(){
      this.usersetindex=0
    },
    gotorou(index){
        console.log(index)
        if(index==0){
          this.$router.push('/userinfo')
        }else if(index==1){
          this.$router.push('/setpassword')
        }else{
          sessionStorage.clear()
          this.$router.push('/login')
        }
    },
    classset(index){
      this.usersetindex=index
    },
    menuscollapse() {
      this.isshoumenu = !this.isshoumenu;
      this.isshoumenu ? (this.menuwidth = "64px") : (this.menuwidth = "200px");
    },
    async getmenus() {
      let { data: res } = await this.$http.get("/menus");
      console.log(res);
      this.menus = res.menus;
    },
  },
  computed: {
    ...mapState(["user"]),
  },
  filters: {},
  watch: {},
  created() {
    this.getmenus();
  },
  mounted() {},
  destroyed() {},
};
</script>

<style scoped>
.hovera{
  /* background-color: red; */

}
.hovera li{
  font-size: 14px;
  text-align: center;
  letter-spacing: 5px;
  margin: 20px auto;


}
li{
  list-style: none;
}
.menuclike {
  text-align: center;
  color: white;
  font-weight: bold;
  letter-spacing: 5px;
}
.el-container {
  width: 100%;
  height: 100%;
}
.el-header {
  display: flex;
  background-color: #52bfdd !important;
  justify-content: space-between;
  flex-direction: row;
}
.el-header,
.el-footer {
  background-color: #b3c0d1;
  color: #333;
}

.el-aside {
  background-color: #12c5ddb0;
  color: #333;
}

.el-main {
  background-color: #e9eef3;
  color: #333;
}
.logo {
  display: flex;
  line-height: 60px;
}
.logo img {
  width: 60px;
  height: 60px;
  border-radius: 50%;
}
.logo span {
  display: inline-block;
  margin-left: 10px;
  font-size: 20px;
  font-family: "华文彩云";
}
.userbox img {
  width: 60px;
  height: 60px;
  border-radius: 50%;
}
.userbox span {
  display: inline-block;
  margin-left: 10px;
  font-size: 20px;
  font-family: "华文彩云";
}
.userbox {
  line-height: 60px;
  display: flex;
}
.el-menu {
  border: none;
  height: 100%;
}
.green{
  background: green;
  color:white
}
</style>