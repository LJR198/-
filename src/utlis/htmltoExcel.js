import FileSaver from "file-saver";
import XLSX from "xlsx";
const htmlToExcel={
    getExcel(dom,title='默认标题'){
        let exceltitle=title
        let wb=XLSX.utils.table_to_book(document.querySelector(dom))
        //获取二进制字符串作为输出
        let wbout=XLSX.write(wb,{bookType:"xlsx",bookSST:true,type:'array'})
        try{
            FileSaver.saveAs(
                new Blob([wbout],{type:"application/octet-stream"}),
                exceltitle+'.xlsx'
            );
        }catch(e){
            if(typeof console !== "undefined" ) return console.log(e,wbout);
        }
        return wbout
    }
}
export default htmlToExcel