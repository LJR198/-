const mongoose=require('mongoose')
mongoose.connect('mongodb://127.0.0.1:27017/db2201demo',(err)=>{
    if(err){
        console.log("链接失败");
    }else{
        console.log("链接成功");
    }

})
module.exports=mongoose