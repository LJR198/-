const mongoose=require('./db')
let Schema=mongoose.Schema
let users=new Schema({
    username:{
        type:String,
    },
    password:{
        type:String,
    },
    phone:{
        type:String,
    },
    email:{
        type:String,
    },
    addr:{
        type:String,
    },
    sex:{
        type:String,
    },
    logintime:{
        type:Date,
        default:new Date()
    },
    imgpath:{
        type:String,
        default:""
    },
    state:{
        type:Boolean,
        default:true
    },
    roleid:{
        type:mongoose.Types.ObjectId,
        ref:"roles",
       
    }
})
let roles=new Schema({
    rolename:{
        type:String,
    },
    
})
let menus=new Schema({
    name:{
        type:String,
    },
    path:{
        type:String,
        default:null,
    },
    order:{
        type:Number,
    },
    charend:{
        type:mongoose.Types.ObjectId,
        ref:"menus",
        default:null,
    }
})
let rolesmenus=new Schema({
    roleid:{
        type:mongoose.Types.ObjectId,
        ref:"roles"
    },
    menuids:{
        type:[mongoose.Types.ObjectId],
        ref:"menus"
    }
})
let yuyues=new Schema({
    rennum:{
        type:Number,
    },
    maxnum:{
        type:Number
    },
    data:{
        type:Date,
        default:new Date()
    },
    comboid:{
        type:mongoose.Types.ObjectId,
        ref:"combo",
        default:null
    }
})
let combo=new Schema({
    name:{
        type:String,
    },
    issex:{
        type:String,
    },
    isage:{
        type:String,
    },
    encoder:{
        type:Number,
    },
    price:{
        type:Number,
    },
    explain:{
        type:String,
        default:"暂无说明"
    },
    jianzuid:{
        type:mongoose.Types.ObjectId,
        ref:"jianchazu"
    }
})
let jianchazu=new Schema({
    name:{
        type:String,
    },
    issex:{
        type:String,
    },
    encoder:{
        type:Number,
    },
    mnemonic:{
        type:Number,
    },
    explain:{
        type:String,
        default:"暂无说明"
    },
    attention:{
        type:String,
        default:"暂无注意事项"
    },
    proobid:{
        type:mongoose.Types.ObjectId,
        ref:"proob"
    }
})
let proob=new Schema({
    name:{
        type:String,
    },
    isage:{
        type:String,
    },
    issex:{
        type:String,
    },
    code:{
        type:Number,
    },
    price:{
        type:Number,
    },
    type:{
        type:String,
    },
    explain:{
        type:String,
        default:"暂无说明"
    },
    attention:{
        type:String,
        default:"暂无注意事项"
    },
})
let jianchazumodel=mongoose.model('jianchazu',jianchazu,'jianchazus')
let usermodel=mongoose.model('users',users,'users')
let rolemodel=mongoose.model('roles',roles,'roles')
let menumodel=mongoose.model('menus',menus,'menus')
let yuyuesmodel=mongoose.model('yuyues',yuyues,'yuyuess')
let combomodel=mongoose.model('combo',combo,'combos')
let rolesmenumodel=mongoose.model('rolesmenus',rolesmenus,'rolesmenus')
let proobmodel=mongoose.model('proob',proob,'proobs')
module.exports={
    usermodel,
    rolemodel,
    menumodel,
    rolesmenumodel,
    yuyuesmodel,
    combomodel,
    jianchazumodel,
    proobmodel,

}