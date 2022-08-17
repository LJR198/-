/*
 Navicat Premium Data Transfer

 Source Server         : Mongodb
 Source Server Type    : MongoDB
 Source Server Version : 50009
 Source Host           : localhost:27017
 Source Schema         : db2201demo

 Target Server Type    : MongoDB
 Target Server Version : 50009
 File Encoding         : 65001

 Date: 17/08/2022 14:22:24
*/


// ----------------------------
// Collection structure for combos
// ----------------------------
db.getCollection("combos").drop();
db.createCollection("combos");

// ----------------------------
// Documents of combos
// ----------------------------
db.getCollection("combos").insert([ {
    _id: ObjectId("62f647af3bee3f1b658e7fec"),
    name: "全身检查",
    issex: "不限",
    isage: "阿萨德",
    encoder: NumberInt("0"),
    price: NumberInt("0"),
    explain: "阿萨德",
    jianzuid: ObjectId("62f63765e374e5182840cff3"),
    __v: NumberInt("0")
} ]);
db.getCollection("combos").insert([ {
    _id: ObjectId("62f649535e5e0000b2001d02"),
    name: "女士体检",
    issex: "不限",
    isage: "阿萨德",
    encoder: 0,
    price: 0,
    explain: "阿萨德",
    __v: 0,
    jianzuid: "62f63765e374e5182840cff3"
} ]);
db.getCollection("combos").insert([ {
    _id: ObjectId("62f6495a5e5e0000b2001d04"),
    name: "男士体检",
    issex: "不限",
    isage: "阿萨德",
    encoder: NumberInt("253"),
    price: NumberInt("500"),
    explain: "阿萨德",
    __v: NumberInt("0"),
    jianzuid: ObjectId("62f63765e374e5182840cff3")
} ]);
db.getCollection("combos").insert([ {
    _id: ObjectId("62f6f6d06f517b864f6ae400"),
    name: "儿童体检",
    issex: "不限",
    isage: "0-18",
    encoder: NumberInt("50"),
    price: NumberInt("99"),
    explain: "暂未有",
    jianzuid: ObjectId("62f63765e374e5182840cff3"),
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for jianchazus
// ----------------------------
db.getCollection("jianchazus").drop();
db.createCollection("jianchazus");

// ----------------------------
// Documents of jianchazus
// ----------------------------
db.getCollection("jianchazus").insert([ {
    _id: ObjectId("62f63765e374e5182840cff3"),
    name: "tetete",
    issex: "不限",
    encoder: NumberInt("520"),
    mnemonic: NumberInt("256"),
    explain: "暂无说明",
    attention: "暂无注意",
    proobid: ObjectId("62f5fe888e9e32c466448903"),
    __v: NumberInt("0")
} ]);
db.getCollection("jianchazus").insert([ {
    _id: ObjectId("62f639d8ed7d00000e007837"),
    __v: "0",
    attention: "暂无注意",
    encoder: 520,
    explain: "暂无说明",
    issex: "不限",
    mnemonic: 256,
    name: "tetete",
    proobid: "62f5fe888e9e32c466448903"
} ]);
db.getCollection("jianchazus").insert([ {
    _id: ObjectId("62f639e4ed7d00000e007838"),
    name: "tetete",
    issex: "女",
    encoder: NumberInt("520"),
    mnemonic: NumberInt("256"),
    explain: "暂无说明",
    attention: "暂无注意",
    proobid: ObjectId("62f5fe888e9e32c466448903"),
    __v: NumberInt("0")
} ]);
db.getCollection("jianchazus").insert([ {
    _id: ObjectId("62f63a9eed7d00000e00783a"),
    name: "tetete",
    issex: "不限",
    encoder: 520,
    mnemonic: 256,
    explain: "暂无说明",
    attention: "暂无注意",
    proobid: "62f5fe888e9e32c466448903",
    __v: 0
} ]);
db.getCollection("jianchazus").insert([ {
    _id: ObjectId("62f6f70d6f517b864f6ae413"),
    name: "阿萨德",
    issex: "男",
    encoder: NumberInt("13"),
    mnemonic: NumberInt("2123"),
    explain: "123",
    attention: "12312",
    proobid: ObjectId("62f6f6fc6f517b864f6ae40a"),
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for menus
// ----------------------------
db.getCollection("menus").drop();
db.createCollection("menus");

// ----------------------------
// Documents of menus
// ----------------------------
db.getCollection("menus").insert([ {
    _id: ObjectId("62f307ce9107dca6a1762215"),
    name: "工作台",
    path: "",
    order: NumberInt("1"),
    charend: null,
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f307ce9107dca6a1762216"),
    name: "用户管理",
    path: "",
    order: NumberInt("1"),
    charend: null,
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f307ce9107dca6a1762218"),
    name: "角色管理",
    path: "",
    order: NumberInt("1"),
    charend: null,
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f307ce9107dca6a1762217"),
    name: "预约管理",
    path: "",
    order: NumberInt("1"),
    charend: null,
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f307ce9107dca6a1762219"),
    name: "统计",
    path: "",
    order: NumberInt("1"),
    charend: null,
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30915104635837b583a66"),
    name: "工作台展示",
    path: "/lookwork",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762215"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f309893abc99d3d04775e7"),
    name: "用户列表",
    path: "/users",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762216"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f309f34bab34cc262ac1d1"),
    name: "角色展示",
    path: "/roles",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762218"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f309f34bab34cc262ac1d2"),
    name: "权限展示",
    path: "/menus",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762218"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a315a710c7c20023874"),
    name: "预约设置",
    path: "/yuyues",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762217"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a315a710c7c20023875"),
    name: "套餐管理",
    path: "/taocang",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762217"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a315a710c7c20023877"),
    name: "检查组管理",
    path: "/jianchazg",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762217"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a315a710c7c20023876"),
    name: "检查项管理",
    path: "/jianchag",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762217"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a4eda652e0dd48dbb8a"),
    name: "会员数量统计",
    path: "/huiyuannum",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762219"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a4eda652e0dd48dbb8b"),
    name: "套餐预约占比统计",
    path: "/taocanyuyue",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762219"),
    __v: NumberInt("0")
} ]);
db.getCollection("menus").insert([ {
    _id: ObjectId("62f30a4eda652e0dd48dbb8c"),
    name: "运营数据统计",
    path: "/yunyingshuju",
    order: NumberInt("2"),
    charend: ObjectId("62f307ce9107dca6a1762219"),
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for proobs
// ----------------------------
db.getCollection("proobs").drop();
db.createCollection("proobs");

// ----------------------------
// Documents of proobs
// ----------------------------
db.getCollection("proobs").insert([ {
    _id: ObjectId("62f5fe888e9e32c466448903"),
    name: "器官",
    isage: "15-25",
    issex: "不限",
    code: NumberInt("50"),
    price: NumberInt("120"),
    type: "体检",
    explain: "阿瓦达无",
    attention: "阿瓦达无",
    __v: NumberInt("0")
} ]);
db.getCollection("proobs").insert([ {
    _id: ObjectId("62f600dfed7d00000e007832"),
    name: "器官",
    isage: "15-25",
    issex: "不限",
    code: 50,
    price: 120,
    type: "体检",
    explain: "阿瓦达无",
    attention: "阿瓦达无",
    __v: 0
} ]);
db.getCollection("proobs").insert([ {
    _id: ObjectId("62f600e8ed7d00000e007834"),
    name: "器官",
    isage: "15-25",
    issex: "不限",
    code: 50,
    price: 120,
    type: "体检",
    explain: "阿瓦达无",
    attention: "阿瓦达无",
    __v: 0
} ]);
db.getCollection("proobs").insert([ {
    _id: ObjectId("62f64b1c5e5e0000b2001d07"),
    name: "器官",
    isage: "15-25",
    issex: "不限",
    code: 50,
    price: 120,
    type: "体检",
    explain: "阿瓦达无",
    attention: "阿瓦达无",
    __v: 0
} ]);
db.getCollection("proobs").insert([ {
    _id: ObjectId("62f6f6fc6f517b864f6ae40a"),
    name: "阿达",
    isage: "55",
    issex: "男",
    code: NumberInt("2131"),
    price: NumberInt("1231"),
    type: "阿萨德",
    explain: "ad",
    attention: "阿萨德",
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for roles
// ----------------------------
db.getCollection("roles").drop();
db.createCollection("roles");

// ----------------------------
// Documents of roles
// ----------------------------
db.getCollection("roles").insert([ {
    _id: ObjectId("62f49cac2a31000004005442"),
    rolename: "超级管理员"
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a28f9193cdbea55188f9"),
    rolename: "tes",
    __v: NumberInt("0")
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a3be9193cdbea5518948"),
    rolename: "a",
    __v: NumberInt("0")
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a3c19193cdbea551894b"),
    rolename: "a",
    __v: NumberInt("0")
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a3c49193cdbea551894e"),
    rolename: "a",
    __v: NumberInt("0")
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a4219193cdbea5518954"),
    rolename: "asda",
    __v: NumberInt("0")
} ]);
db.getCollection("roles").insert([ {
    _id: ObjectId("62f4a44dc18fbbe8a7fce22f"),
    rolename: "asd",
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for rolesmenus
// ----------------------------
db.getCollection("rolesmenus").drop();
db.createCollection("rolesmenus");

// ----------------------------
// Documents of rolesmenus
// ----------------------------
db.getCollection("rolesmenus").insert([ {
    _id: ObjectId("62f30b0984b69d2826257113"),
    roleid: ObjectId("62f49cac2a31000004005442"),
    menuids: [
        ObjectId("62f307ce9107dca6a1762215"),
        ObjectId("62f30915104635837b583a66"),
        ObjectId("62f307ce9107dca6a1762216"),
        ObjectId("62f309893abc99d3d04775e7"),
        ObjectId("62f307ce9107dca6a1762217"),
        ObjectId("62f30a315a710c7c20023874"),
        ObjectId("62f30a315a710c7c20023875"),
        ObjectId("62f30a315a710c7c20023877"),
        ObjectId("62f30a315a710c7c20023876"),
        ObjectId("62f307ce9107dca6a1762218"),
        ObjectId("62f309f34bab34cc262ac1d1"),
        ObjectId("62f309f34bab34cc262ac1d2"),
        ObjectId("62f307ce9107dca6a1762219"),
        ObjectId("62f30a4eda652e0dd48dbb8a"),
        ObjectId("62f30a4eda652e0dd48dbb8b"),
        ObjectId("62f30a4eda652e0dd48dbb8c")
    ],
    __v: NumberInt("0")
} ]);
db.getCollection("rolesmenus").insert([ {
    _id: ObjectId("62f463830cc7184f0a67ab95"),
    roleid: ObjectId("62f307eb99f4d68d1fedff1e"),
    menuids: [
        ObjectId("62f307ce9107dca6a1762215"),
        ObjectId("62f30915104635837b583a66"),
        ObjectId("62f307ce9107dca6a1762216"),
        ObjectId("62f309893abc99d3d04775e7")
    ],
    __v: NumberInt("0")
} ]);
db.getCollection("rolesmenus").insert([ {
    _id: ObjectId("62f607709e0ec7922cfa5f08"),
    roleid: ObjectId("62f4a28f9193cdbea55188f9"),
    menuids: [
        ObjectId("62f307ce9107dca6a1762215"),
        ObjectId("62f30915104635837b583a66"),
        ObjectId("62f307ce9107dca6a1762216"),
        ObjectId("62f309893abc99d3d04775e7"),
        ObjectId("62f307ce9107dca6a1762217"),
        ObjectId("62f30a315a710c7c20023874"),
        ObjectId("62f30a315a710c7c20023875"),
        ObjectId("62f30a315a710c7c20023877"),
        ObjectId("62f30a315a710c7c20023876"),
        ObjectId("62f307ce9107dca6a1762218"),
        ObjectId("62f309f34bab34cc262ac1d1"),
        ObjectId("62f309f34bab34cc262ac1d2"),
        ObjectId("62f307ce9107dca6a1762219"),
        ObjectId("62f30a4eda652e0dd48dbb8a"),
        ObjectId("62f30a4eda652e0dd48dbb8b"),
        ObjectId("62f30a4eda652e0dd48dbb8c")
    ],
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for users
// ----------------------------
db.getCollection("users").drop();
db.createCollection("users");

// ----------------------------
// Documents of users
// ----------------------------
db.getCollection("users").insert([ {
    _id: ObjectId("62f3081148cca8b67f342320"),
    username: "admin123",
    password: "123456789",
    phone: "19831031157",
    email: "2817166@qq.com",
    addr: "河北邯郸",
    sex: "男",
    logintime: ISODate("2022-08-10T01:21:21.095Z"),
    imgpath: "http://localhost:3000/upload\\\\sm-srt_tD-DhK9A0N0T8sDfT.gif",
    roleid: ObjectId("62f49cac2a31000004005442"),
    __v: NumberInt("0"),
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f31358bc8e547f7a3818a7"),
    username: "admin",
    password: "123456789",
    phone: "15271865264",
    email: "123@qq.com",
    addr: "河北邯郸",
    sex: "男",
    logintime: ISODate("2022-08-09T01:37:15.864Z"),
    imgpath: "http://localhost:3000/upload\\S01ykmemwINMd5Lo3bXTFJJk.jpg",
    roleid: ObjectId("62f49cac2a31000004005442"),
    __v: NumberInt("0"),
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f3964679e88bd3d9985c1b"),
    username: "123456",
    password: "123456789",
    phone: "15846235869",
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: ISODate("2022-08-09T11:26:46.589Z"),
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    state: true,
    roleid: ObjectId("62f49cac2a31000004005442"),
    __v: NumberInt("0")
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f64f110e47eec6ff89f362"),
    username: "aaaaa",
    password: "123456789",
    phone: "19831031157",
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: ISODate("2022-08-12T12:50:04.957Z"),
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    state: true,
    roleid: ObjectId("62f49cac2a31000004005442"),
    __v: NumberInt("0")
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755538b1d000075001443"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755588b1d000075001444"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7555d8b1d000075001445"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755628b1d000075001446"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755688b1d000075001447"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7556f8b1d000075001448"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755738b1d000075001449"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-12 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755788b1d00007500144a"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7557e8b1d00007500144b"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7559d8b1d00007500144c"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755a18b1d00007500144d"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755a58b1d00007500144e"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755aa8b1d00007500144f"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f755ad8b1d000075001450"),
    username: "aaaaa",
    password: 123456789,
    phone: 19831031157,
    email: "2817166575@qq.com",
    addr: "邯郸",
    sex: "男",
    logintime: "2022-08-13 12:50:04.957",
    imgpath: "http://localhost:3000/upload\\IwRZUv3TOaBRLMrTcGtkNZ2w.gif",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7598d8b1d000075001451"),
    username: 123456,
    password: 123456789,
    phone: 15846235869,
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: "2022-08-14 11:26:46.589",
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f759928b1d000075001452"),
    username: 123456,
    password: 123456789,
    phone: 15846235869,
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: "2022-08-14 11:26:46.589",
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f759978b1d000075001453"),
    username: 123456,
    password: 123456789,
    phone: 15846235869,
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: "2022-08-14 11:26:46.589",
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7599a8b1d000075001454"),
    username: 123456,
    password: 123456789,
    phone: 15846235869,
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: "2022-08-14 11:26:46.589",
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("62f7599f8b1d000075001455"),
    username: 123456,
    password: 123456789,
    phone: 15846235869,
    email: "2917456@qq.com",
    addr: "asd",
    sex: "男",
    logintime: "2022-08-14 11:26:46.589",
    imgpath: "http://localhost:3000/upload\\WGNkAkCs-iZleNJezR6QefvH.jpg",
    roleid: "62f49cac2a31000004005442",
    __v: 0,
    state: true
} ]);

// ----------------------------
// Collection structure for yuyuess
// ----------------------------
db.getCollection("yuyuess").drop();
db.createCollection("yuyuess");

// ----------------------------
// Documents of yuyuess
// ----------------------------
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f4e8dab1d41d8abed2a01b"),
    rennum: NumberInt("500"),
    maxnum: NumberInt("500"),
    data: ISODate("2022-08-23T00:00:00.000Z"),
    __v: NumberInt("0"),
    comboid: ObjectId("62f649535e5e0000b2001d02")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f4ec99e14bf50d23852d61"),
    rennum: NumberInt("0"),
    maxnum: NumberInt("9999"),
    data: ISODate("2022-08-11T00:00:00.000Z"),
    comboid: null,
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f4ff94d77140be9b5bfec3"),
    rennum: NumberInt("0"),
    maxnum: NumberInt("5000"),
    data: ISODate("2022-08-16T00:00:00.000Z"),
    comboid: null,
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f4ff9fd77140be9b5bfec6"),
    rennum: NumberInt("50"),
    maxnum: NumberInt("5000"),
    data: ISODate("2022-08-17T00:00:00.000Z"),
    comboid: ObjectId("62f647af3bee3f1b658e7fec"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f5012dd77140be9b5bfef0"),
    rennum: NumberInt("5555"),
    maxnum: NumberInt("5555"),
    data: ISODate("2022-08-12T00:00:00.000Z"),
    comboid: ObjectId("62f4e353d50c031de4c5c3d6"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f5a0f8dc892afb5c579f70"),
    rennum: NumberInt("15"),
    maxnum: NumberInt("9000"),
    data: ISODate("2022-08-18T00:00:00.000Z"),
    comboid: ObjectId("62f4e353d50c031de4c5c3d6"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f5f4cf9e8ea6a58fec141c"),
    rennum: NumberInt("500"),
    maxnum: NumberInt("5000"),
    data: ISODate("2022-08-19T00:00:00.000Z"),
    comboid: ObjectId("62f6495a5e5e0000b2001d04"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62f6f8116f517b864f6ae441"),
    rennum: NumberInt("500"),
    maxnum: NumberInt("3000"),
    data: ISODate("2022-08-13T00:00:00.000Z"),
    comboid: ObjectId("62f647af3bee3f1b658e7fec"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62faf253c6c3b7e4cf08912e"),
    rennum: NumberInt("100"),
    maxnum: NumberInt("200"),
    data: ISODate("2022-08-20T00:00:00.000Z"),
    comboid: ObjectId("62f6f6d06f517b864f6ae400"),
    __v: NumberInt("0")
} ]);
db.getCollection("yuyuess").insert([ {
    _id: ObjectId("62fc3992af5229532e00fee9"),
    rennum: NumberInt("0"),
    maxnum: null,
    data: ISODate("2022-08-21T00:00:00.000Z"),
    comboid: null,
    __v: NumberInt("0")
} ]);
