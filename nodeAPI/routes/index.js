var express = require('express');
var router = express.Router();
let {
  usermodel,
  rolemodel,
  menumodel,
  rolesmenumodel,
  combomodel,
  yuyuesmodel,
  jianchazumodel,
  proobmodel,

} = require('../models/modes')
let jsonwebtoken = require('jsonwebtoken');
/* GET home page. */
let multiparty = require('multiparty');
const { routes } = require('../app');
const { Router } = require('express');
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});
//登录
router.post('/login', async (req, res) => {
  let body = req.body
  let user = await usermodel.findOne({ username: body.username }).exec()
  let token = ''
  let msg = ''
  if (user) {
    if (user.password == body.password) {
      token = 'Bearer' + ' ' + jsonwebtoken.sign({ ...user }, 'panpan', { expiresIn: '1d' })
    } else {
      msg = '密码不正确'
    }
  } else {
    msg = '用户不存在'
  }
  res.send({
    msg,
    token,
  })
})
function menuf(arr, brr) {
  arr.forEach(item => {
    if (item.order == 1) {
      item.menus = []
      brr.push(item)
    } else {
      brr.forEach(ceim => {
        if (item.charend.toString()) {

          if (item.charend.toString() == ceim._id.toString()) {
            ceim.menus.push(item)
          }
        }
      })
    }
  })

}
//根据登录的用户所对应的角色获取相应的菜单数据
router.get('/menus', async (req, res) => {
  let user = req.user._doc
  let role = await rolemodel.findOne({ _id: user.roleid })
  let menus = await rolesmenumodel.aggregate([
    { $match: { "roleid": role._id } },
    {
      $lookup: {
        from: "menus",
        foreignField: "_id",
        localField: "menuids",
        as: "menulis"
      }
    },

  ]).exec()
  // console.log(menus);
  let brr = []

  menuf(menus[0].menulis, brr)
  // console.log(brr);
  res.send({
    menus: brr
  })
})
//头像
router.post('/imgs', (req, res) => {
  let form = new multiparty.Form()
  form.uploadDir = 'upload'
  form.parse(req, (err, filedata, imgdata) => {
    res.send({
      path: imgdata.file[0].path
    })
  })
})
//获取角色
router.get('/roles', async (req, res) => {
  let data = await rolemodel.find()

  res.send({
    data
  })
})
//注册用户
router.post('/adduser', async (req, res) => {
  let body = req.body
  let user = await usermodel.findOne({ username: body.username })
  if (user) {
    res.send({
      code: 205
    })
  } else {
    let data = await usermodel.create(body)
    res.send({ data, code: 200 })
  }

})
//获取用户信息
router.get('/user/:id', async (req, res) => {
  let id = req.params.id
  let user = await usermodel.findOne({ _id: id })
  res.send({
    user
  })
})
//修改用户
router.post('/eduser', async (req, res) => {
  let body = req.body
  let data = await usermodel.updateOne({ _id: body._id }, { $set: body })
  let user = await usermodel.findOne({ _id: body._id })
  res.send({
    data,
    user,
  })
})
//获取所有用户信息：
router.get('/users', async (req, res) => {
  let page = req.query.page * 1
  let pagesize = req.query.pagesize * 1
  let serch = req.query.serch
  let data;
  let count;
  if (serch) {
    console.log(serch, 111);
    let userre = new RegExp(serch)
    let phone = new RegExp(serch)
    let email = new RegExp(serch)
    let addr = new RegExp(serch)
    data = await usermodel.find({ $or: [{ username: userre }, { phone: phone }, { email: email }, { addr: addr }] }).populate('roleid').limit(pagesize).skip((page - 1) * pagesize).exec()
    count = await usermodel.find({ $or: [{ username: userre }, { phone: phone }, { email: email }, { addr: addr }] }).count()

  } else {
    data = await usermodel.find().populate('roleid').limit(pagesize).skip((page - 1) * pagesize).exec()
    count = await usermodel.find().count()


  }
  res.send({
    data,
    count,
  })
})
//删除用户
router.delete('/user/:id', async (req, res) => {
  let id = req.params.id
  let data = await usermodel.deleteOne({ _id: id })
  res.send({
    data,
    code: 200
  })
})
//获取单个用户对象 返回 username email phone sex
router.put('/user/:id', async (req, res) => {
  let id = req.params.id
  let user = await usermodel.findOne({ _id: id }, { _id: 1, username: 1, email: 1, sex: 1, phone: 1 })
  // console.log(user);
  res.send({
    user
  })
})
//修改用户信息
router.put('/edituser/:id', async (req, res) => {
  let id = req.params.id
  let body = req.body
  delete body._id
  let data = await usermodel.updateOne({ _id: id }, { $set: body })
  res.send({
    data,
    code: 200
  })
})
//修改用户状态
router.put('/eduserstate/:id', async (req, res) => {
  let id = req.params.id
  let state = req.body
  let data = await usermodel.updateOne({ _id: id }, { $set: state })
  res.send({
    data,
    code: 200
  })

})
//获取用户的角色信息
router.get('/userole/:id', async (req, res) => {
  let id = req.params.id
  let user = await usermodel.findOne({ _id: id }, { roleid: 1, _id: 1 }).populate('roleid')
  res.send({
    user
  })

})
//修改用户角色信息
router.post('/setuserrole/:id', async (req, res) => {
  let id = req.params.id
  let body = req.body
  let data = await usermodel.updateOne({ _id: id }, { $set: req.body })
  res.send({
    data,
    body,
    code: 200,
  })
})
//获取所有的角色信息
router.get('/roeslist', async (req, res) => {
  let page = req.query.page * 1
  let pagesize = req.query.pagesize * 1
  // console.log(page,pagesize);
  let data = await rolemodel.find().limit(pagesize).skip((page - 1) * pagesize).exec()
  let count = await rolemodel.find().count()
  res.send({
    data: data,
    count: count,
  })

})
router.get('/rolepowerlist', async (req, res) => {

  let menus = await rolesmenumodel.find().populate('menuids')


  res.send({
    data: menus
  })
})
//获取所有的权限数据
router.get('/fmenus', async (req, res) => {
  let fen = req.query.fen
  console.log(fen);

  let menus = await menumodel.aggregate([
    { $lookup: { from: "menus", localField: '_id', foreignField: "charend", as: "menus" } }, { $sort: { _id: 1 } }
  ]).exec()
  let data

  if (fen == 'all') {
    data = await menumodel.find()
  } else {
    data = menus.filter(item => item.menus.length > 0)
  }
  res.send({
    data
  })
})
router.post('/setrolemenu', async (req, res) => {
  let body = req.body
  let dataf = await rolesmenumodel.findOne({ roleid: body.roleid })
  let data
  if (dataf) {
    data = await rolesmenumodel.updateMany({ roleid: body.roleid }, { $set: { menuids: body.keys } })
  } else {
    data = await rolesmenumodel.create({ roleid: body.roleid, menuids: body.keys })
  }

  res.send({
    body,
    data
  })
})
router.delete('/role/:id', async (req, res) => {
  let id = req.params.id
  let users = await usermodel.find({ roleid: id })
  // console.log(users)
  if (users.length > 0) {
    let data = { acknowledged: false, deletedCount: 0 }
    res.send({
      data,
      msg: "该角色已被用户使用不可删除"
    })
  } else {
    let data = await rolemodel.deleteOne({ _id: id })
    if (data.acknowledged) {
      res.send({
        data,
        msg: "删除成功"
      })
    } else {
      res.send({
        data,
        msg: "删除失败"
      })
    }
  }
  // let user=req.user._doc
  // console.log(user);



  // res.send({
  //   msg:"sss"
  // })
})
//修改角色
router.put('/editrole/:id', async (req, res) => {
  let id = req.params.id
  let body = req.body
  console.log(body);
  let data = await rolemodel.updateOne({ _id: id }, { $set: body })
  res.send({
    data,
    msg: ""
  })
})
//添加角色
router.post('/addrole', async (req, res) => {
  let body = req.body
  console.log(body);
  let data = await rolemodel.create(body)
  res.send({
    data
  })
})
//获取当前预约信息
router.post('/getone', async (req, res) => {
  let body = req.body
  console.log(body);
  let yuo = await yuyuesmodel.findOne({ data: body.data })
  res.send({
    yuo
  })
})
//设置预约
router.post('/addyuyue', async (req, res) => {
  let body = req.body
  // console.log(body);
  let yu = await yuyuesmodel.findOne({ data: body.data })
  console.log(yu);
  let data;
  if (yu) {
    data = await yuyuesmodel.updateOne({ data: body.data }, { $set: { rennum: 0, maxnum: body.maxnum } });
  } else {
    data = await yuyuesmodel.create({ rennum: 0, maxnum: body.maxnum, data: body.data })

  }
  res.send({
    data,
    body
  })
})
//获取预约信息
router.get('/getyuyue', async (req, res) => {
  let data = await yuyuesmodel.find()
  res.send({
    data
  })
})

//设置预约信息
router.post('/comformsetyu', async (req, res) => {
  let body = req.body
  let data = await yuyuesmodel.updateOne({ data: body.data }, { $set: body })
  res.send({
    body,
    data
  })
})
//添加检查项
router.post('/addproobmodel', async (req, res) => {
  let body = req.body
  console.log(body);
  let data = await proobmodel.create(body)
  res.send({
    data
  })
})
//获取检查项信息
router.get('/getproplist', async (req, res) => {
  let page = req.query.page * 1
  let pagesize = req.query.pagesize * 1
  let serch = req.query.serch
  let fen=req.query.fen
  if(fen=='no'){
    let data = await proobmodel.find()
    res.send({
      data
    })
  }else{
    if (serch) {
      let nameare = new RegExp(serch)
      let data = await proobmodel.find({ name: nameare }).limit(pagesize).skip((page - 1) * pagesize).exec()
      let count = await proobmodel.find({ name: nameare }).count()
      res.send({
        data,
        count
      })
    } else {
      let data = await proobmodel.find().limit(pagesize).skip((page - 1) * pagesize).exec()
      let count = await proobmodel.find().count()
      res.send({
        data,
        count
      })
    }
  }
  
})
//删除检查项信息
router.delete('/deleteproobmodel/:id',async(req,res)=>{
  let id=req.params.id
  console.log(id);
  // let data=aw
  let data=await proobmodel.deleteOne({_id:id})
  res.send({
    data
  })
})
//获取单个姜茶项信息
router.get('/getproone/:id',async(req,res)=>{
  let id=req.params.id
  let data=await proobmodel.findOne({_id:id},{_id:1,name:1,isage:1,issex:1,price:1,type:1,explain:1,attention:1})
  res.send({
    data
  })
})
//修改检查项
router.put('/editproobmodel',async(req,res)=>{
  let id=req.body._id
  delete req.body._id
  let data=await proobmodel.updateOne({_id:id},{$set:req.body})
  res.send({
    data
  })
})
//添加检查组
router.post('/addjianchazumodel',async(req,res)=>{
  let body=req.body
  let data=await jianchazumodel.create(body)
  res.send({
    data
  })
})
//获取检查组信息
router.get('/getjianchazulist', async (req, res) => {
  let page = req.query.page * 1
  let pagesize = req.query.pagesize * 1
  let serch = req.query.serch
  let fen=req.query.fen
  if(fen=='no'){
    let data=await jianchazumodel.find()
    res.send({
      data
    })
  }else{
    if (serch) {
      let nameare = new RegExp(serch)
      let data = await jianchazumodel.find({ name: nameare }).limit(pagesize).skip((page - 1) * pagesize).exec()
      let count = await jianchazumodel.find({ name: nameare }).count()
      res.send({
        data,
        count
      })
    } else {
      let data = await jianchazumodel.find().limit(pagesize).skip((page - 1) * pagesize).exec()
      let count = await jianchazumodel.find().count()
      res.send({
        data,
        count
      })
    }
  }
  
})
//删除检查组信息
router.delete('/deletejianchazumodel/:id',async(req,res)=>{
  let id=req.params.id
  console.log(id);
  // let data=aw
  let data=await jianchazumodel.deleteOne({_id:id})
  res.send({
    data
  })
})
//获取单个检查组信息
// jianchazumodelone
router.get('/jianchazumodelone/:id',async(req,res)=>{
  let id=req.params.id
  let data=await jianchazumodel.findOne({_id:id},)
  res.send({
    data
  })
})
//修改检查组
router.put('/editjianchazumodel',async(req,res)=>{
  let id=req.body._id
  delete req.body._id
  let data=await jianchazumodel.updateOne({_id:id},{$set:req.body})
  res.send({
    data
  })
})
//获取套餐信息
router.get('/combols', async (req, res) => {
  let fen = req.query.fen
  console.log(fen);
  if (fen == 'all') {
    let page = req.query.page * 1
    let pagesize = req.query.pagesize * 1
    let serch = req.query.serch
    if (serch) {
      let nameare = new RegExp(serch)
      let data = await combomodel.find({ name: nameare }).limit(pagesize).skip((page - 1) * pagesize).exec()
      let count = await combomodel.find({ name: nameare }).count()
      res.send({
        data,
        count
      })
    }else{
      let data = await combomodel.find().limit(pagesize).skip((page - 1) * pagesize)
      let count = await combomodel.find().count()
      res.send({
        data,
        count
      })
    }
   

  } else {
    let data = await combomodel.find()
    res.send({
      data
    })
  }

})
//添加套餐
router.post('/addcombomodel',async(req,res)=>{
  let body=req.body
  let data=await combomodel.create(body)
  res.send({
    body
  })
})
// 删除套餐
router.delete('/deletecombomodel/:id',async(req,res)=>{
  let id=req.params.id
  console.log(id);
  // let data=aw
  let data=await combomodel.deleteOne({_id:id})
  res.send({
    data
  })
})
// 获取单个套餐
router.get('/combomodelone/:id',async(req,res)=>{
  let id=req.params.id
  let data=await combomodel.findOne({_id:id},)
  res.send({
    data
  })
})
//修改套餐
router.put('/editcombomodel',async(req,res)=>{
  let id=req.body._id
  delete req.body._id
  let data=await combomodel.updateOne({_id:id},{$set:req.body})
  res.send({
    data
  })
})
//获取套餐预约占比数据
router.get('/comoraid',async(req,res)=>{
  let data=await yuyuesmodel.find().populate('comboid')
  let name=await combomodel.find()
  res.send({
    data,
    name
  })
})
//修改密码
router.post('/setpassword/:id',async(req,res)=>{
  let id=req.params.id
  let body=req.body
  let user=await usermodel.updateOne({_id:id},{$set:{password:body.newpassword}})
  // console.log(user);
  res.send({
    user,
    msg:"修改成功"
  })

})
// combomodel.create({
//   name:"女士体检",issex:"女",isage:"18-21",encoder:895,price:652.00,explain:"暂无说明"
// })
// menumodel.create([
//   {name:"工作台",path:"",order:1,},
//   {name:"用户管理",path:"",order:1},
//   {name:"预约管理",path:"",order:1,},
//   {name:"角色管理",path:"",order:1,},
//   {name:"统计",path:"",order:1,},
// ])
// menumodel.create({
//   name:"工作台展示",path:"/lookwork",order:2,charend:"62f307ce9107dca6a1762215"
// })
// menumodel.create({
//   name:"用户列表",path:"/users",order:2,charend:"62f307ce9107dca6a1762216"
// })
// menumodel.create([
//   {name:"角色展示",path:"/roles",order:2,charend:"62f307ce9107dca6a1762218"},
//   {name:"权限展示",path:"/menus",order:2,charend:"62f307ce9107dca6a1762218"}
// ])
// menumodel.create([
//     {name:"预约设置",path:'/yuyues',order:2,charend:"62f307ce9107dca6a1762217"},
//     {name:"套餐管理",path:'/taocang',order:2,charend:"62f307ce9107dca6a1762217"},
//     {name:"检查项管理",path:'/jianchag',order:2,charend:"62f307ce9107dca6a1762217"},
//     {name:"检查组管理",path:'/jianchazg',order:2,charend:"62f307ce9107dca6a1762217"},

// ])
// menumodel.create([
//   {name:"会员数量统计",path:"/huiyuannum",order:2,charend:"62f307ce9107dca6a1762219"},
//   {name:"套餐预约占比统计",path:"/taocanyuyue",order:2,charend:"62f307ce9107dca6a1762219"},
//   {name:"运营数据统计",path:"/yunyingshuju",order:2,charend:"62f307ce9107dca6a1762219"},
// ])
// rolemodel.create([
//   {rolename:"超级管理员"},
//   {rolename:"管理员"},
//   {rolename:"测试人员"}
// ])
// rolesmenumodel.create([
//   {roleid:"62f307eb99f4d68d1fedff1d",menuids:[
//   '62f307ce9107dca6a1762215',
//   '62f307ce9107dca6a1762216',
//   '62f307ce9107dca6a1762218',
//   '62f307ce9107dca6a1762217',
//   '62f307ce9107dca6a1762219',
//   '62f30915104635837b583a66',
//   '62f309893abc99d3d04775e7',
//   '62f309f34bab34cc262ac1d1',
//   '62f309f34bab34cc262ac1d2',
//   '62f30a315a710c7c20023874',
//   '62f30a315a710c7c20023875',
//   '62f30a315a710c7c20023877',
//   '62f30a315a710c7c20023876',
//   '62f30a4eda652e0dd48dbb8a',
//   '62f30a4eda652e0dd48dbb8b',
//   '62f30a4eda652e0dd48dbb8c',
// ]}
// ])
// usermodel.create({
//   username:"admin123",
//   password:"123456",
//   phone:"19831031157",
//   email:"2817166@qq.com",
//   addr:"河北邯郸",
//   sex:"男",
//   roleid:"62f307eb99f4d68d1fedff1d"
// })
module.exports = router;
