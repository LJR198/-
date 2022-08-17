<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
  <el-breadcrumb-item :to="{ path: '/index' }">首页</el-breadcrumb-item>
  <el-breadcrumb-item>角色管理</el-breadcrumb-item>
  <el-breadcrumb-item>角色列表</el-breadcrumb-item>
</el-breadcrumb>
<el-card>
    <el-button type="success" @click="adddialogFormVisible=true">添加角色</el-button>
     <el-table
    :data="rolelist"
    style="width: 100%">
    <el-table-column type="expand">
      <template slot-scope="props">    
        <p style="margin-left: 50px;" v-for="(item,index) in rolepowerlist" :key="index">
                <!-- {{item  }} -->
                <!-- {{props}} -->
            <el-row :gutter="20" v-for="(item2,index2) in item.menuids" :key="index2" v-show="item.roleid==props.row._id && item2.order===1">
                <el-col :span="24">
                    <el-tag class="onepow">   {{item2.name}}</el-tag>
                    <i class="el-icon-arrow-right"></i>
                    <el-tag type="success" style="margin-left:50px" @close="deletepower(item3,props.row._id)" closable v-for="(item3,index3) in item.menuids" :key="index3" v-show="item.roleid==props.row._id && item3.order===2 && item3.charend==item2._id">
                        {{item3.name}}
                    </el-tag>
                </el-col>
                 
            </el-row>
       </p>
      </template>
    </el-table-column>
    <el-table-column
      label="#"
      type="index">
    </el-table-column>
    <el-table-column
      label="角色名称"
      prop="rolename">
    </el-table-column>
    <el-table-column
      label="操作"
      v-if="user.state"
      >
      <template slot-scope="scope">
        <el-button type="primary" icon="el-icon-edit" @click="editrole(scope.row)"></el-button>
        <el-button type="danger" icon="el-icon-delete" @click="deleterole(scope.row._id)"></el-button>
        <el-button type="warning" icon="el-icon-s-tools" @click="fenpei(scope.row._id)"></el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="page"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pagesize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="count">
    </el-pagination>
    
</el-card>
<el-dialog
  title="提示"
  :visible.sync="quanxiaodialogVisible"
  width="30%"
  @close="handleClose">
  <span>
    <el-tree :data="treedata" :props="defaultProps" ref="treeref" show-checkbox
    node-key="_id" default-expand-all :default-checked-keys="defkeys"></el-tree>
  </span>
  <span slot="footer" class="dialog-footer">
    <el-button @click="quanxiaodialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="confrupoer">确 定</el-button>
  </span>
</el-dialog>
  <el-dialog title="修改角色" :visible.sync="roledialogFormVisible">
  <el-form :model="roleform">
    <el-form-item label="角色名称" :label-width="formLabelWidth">
      <el-input v-model="roleform.rolename" autocomplete="off"></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="roledialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="confirmeditrole">确 定</el-button>
  </div>
</el-dialog>
<el-dialog title="添加角色" :visible.sync="adddialogFormVisible" @close="clearform">
  <el-form :model="form">
    <el-form-item label="角色名称" :label-width="formLabelWidth">
      <el-input v-model="form.rolename" autocomplete="off"></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="adddialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="confirmaddrole" v-show="form.rolename">确 定</el-button>
  </div>
</el-dialog>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
    data () {
        return {
          adddialogFormVisible:false,
          roledialogFormVisible:false,
          form:{
            rolename:""
          },
            defkeys:[],
            formLabelWidth:"180px",
            rolelist:[],
            count:0,
            page:1,
            pagesize:5,
            role_id:"",
            roleform:{
              _id:"",
              rolename:""
            },
            rolepowerlist:[],
            treedata:[],
            quanxiaodialogVisible:false,
               defaultProps: {
          label: 'name',
          children: 'menus'
        },
        }
    },
    methods:{
      clearform(){  
        this.form={
          rolename:""
        }
        this.adddialogFormVisible=false

      },
      async deletepower(data,roleid){  
        console.log(data,roleid,111)
 
       let obj={}
         this.rolepowerlist.forEach(item=>{
            // console.log(item);
            if(item.roleid==roleid){
              obj=item
            }
        })
        console.log(obj);
        let arr=obj.menuids.filter(item=>{
          return item._id!=data._id && item._id!==data.charend
        })
        // console.log(arr);

        let brr=[]
        arr.forEach(item=>{
          brr.push(item._id)
        })
        console.log(brr)
        const {data:res}=await this.$http.post('/setrolemenu',{roleid:roleid,keys:brr})
        this.getrolelist()
        this.getrolepowerlist()
        this.$router.go(0)
      },
      async confirmaddrole(){
          const {data:res}=await this.$http.post('/addrole',this.form)
          this.adddialogFormVisible=false
          this.getrolelist()
      },
      async confirmeditrole(){
          console.log(this.roleform)
          const {data:res}=await this.$http.put('/editrole/'+this.roleform._id,{rolename:this.roleform.rolename})
          this.roledialogFormVisible=false
          this.getrolelist()
      },
      editrole(data){
        console.log(data)
          this.roleform=data
          this.roledialogFormVisible=true
      },
      async deleterole(id){
        let a=await  this.$confirm('此操作将永久删除该角色, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).catch(err=>{
          this.$message.info('您取消了删除')
        })
        if(a=='confirm'){
            const {data:res}=await this.$http.delete('/role/'+id)
            console.log(res);
            if(res.data.acknowledged){
              this.$message.success(res.msg)
            }else{
              this.$message.error(res.msg)
            }
              this.getrolelist()

        }
      },
        setdefkeys(arr){
            arr.forEach(item=>{
                item.menuids.forEach(item2=>{
                        this.defkeys.push(item2._id)
                })
            })
        },
        fenpei(id){
          this.role_id=id
            let arr=this.rolepowerlist.filter(item=>{
                
                if(item.roleid==id){
                    return item
                }
            })

            this.setdefkeys(arr)
            this.gettreedata()
            this.quanxiaodialogVisible=true
        },
        
        async gettreedata(){
            const {data:res}=await this.$http.get('/fmenus')
            console.log(res.data)
            this.treedata=res.data
        },
        handleClose(done) {
          this.defkeys=[]
      },
        async getrolepowerlist(){
                const {data:res}=await this.$http.get('/rolepowerlist')
                console.log(res);
                this.rolepowerlist=res.data
        },
        async getrolelist(){
            const {data:res}=await this.$http.get(`/roeslist?page=${this.page}&pagesize=${this.pagesize}`)
            // this.
            console.log(res);
            this.rolelist=res.data
            this.count=res.count
        },
            handleSizeChange(val) {
        console.log(`每页 ${val} 条`);
        this.pagesize=val;
        this.getrolelist()
      },
      handleCurrentChange(val) {
        console.log(`当前页: ${val}`);
        this.page=val
        this.getrolelist()
      },
      async confrupoer(){
        const keys=[...this.$refs.treeref.getCheckedKeys(),...this.$refs.treeref.getHalfCheckedKeys()]
        // console.log(keys);
        const {data:res}=await this.$http.post('/setrolemenu',{roleid:this.role_id,keys:keys})
        console.log(res);
        this.getrolepowerlist()
            this.quanxiaodialogVisible=false
         this.$router.go(0)
      }
       
    },
    computed:{
      ...mapState(['user'])
    },
    filters:{

    },
    watch:{

    },
    created(){
        this.getrolelist()
        this.getrolepowerlist()
    },
    mounted(){

    },
    destroyed(){

    }
}
</script>

<style scoped>
.el-card{
    margin-top: 20px;
}
.demo-table-expand {
    font-size: 0;
  }
  .demo-table-expand label {
    width: 90px;
    color: #99a9bf;
  }
  .demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 50%;
  }
  .onepow{
    margin: 20px 0px;
  }
</style>