package cn.csdb.portal.controller;

import cn.csdb.portal.model.*;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.DataSrcService;
import cn.csdb.portal.service.ShowTypeInfService;
import cn.csdb.portal.service.SynchronizationTablesService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class EditDataController {
    @Autowired
    private CheckUserDao checkUserDao;

    @Autowired
    private DataSrcService dataSrcService;

    @Autowired
    private ShowTypeInfService showTypeInfService;

    @Autowired
    private SynchronizationTablesService synchronizationTablesService;

//    根据登录人员的subjectCode，获得对应数据库连接信息
    public DataSrc getDataSrc(String subjectCode){
        Subject subject=checkUserDao.getSubjectByCode(subjectCode);
        DataSrc datasrc = new DataSrc();
        datasrc.setDatabaseName(subject.getDbName());//数据库名
        datasrc.setDatabaseType("mysql");          //数据库类型
        datasrc.setHost(subject.getDbHost());       //连接地址
        datasrc.setPort(subject.getDbPort());       //端口号
        datasrc.setUserName(subject.getDbUserName());  //用户名
        datasrc.setPassword(subject.getDbPassword());  //密码

        return datasrc;
    }

    @ResponseBody
    @RequestMapping("/showTable")
    public JSONObject showTable(String subjectCode){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        List<String> list = dataSrcService.relationalDatabaseTableList(datasrc);

        List<ShowTypeInf> showTypeInfList1 = new ArrayList<>();
        for (String s : list) {
            if (showTypeInfService.getTableComment(s, subjectCode) != null) {
                ShowTypeInf showTypeInf = showTypeInfService.getTableComment(s, subjectCode);
                ShowTypeInf showTypeInf1 = new ShowTypeInf();
                showTypeInf1.setTableName(s);
                showTypeInf1.setTableComment(showTypeInf.getTableComment());
                showTypeInfList1.add(showTypeInf1);
            } else {
                ShowTypeInf showTypeInf1 = new ShowTypeInf();
                showTypeInf1.setTableName(s);
                showTypeInf1.setTableComment("");
                showTypeInfList1.add(showTypeInf1);
            }
        }

        jsonObject.put("list", showTypeInfList1);
        jsonObject.put("dataSourceName", datasrc.getDataSourceName());
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping("/showTableData")
        public JSONObject test(String subjectCode, String tableName,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                               @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        DataSrc datasrc=getDataSrc(subjectCode);
         List<Map<String,Object>> list=new ArrayList<>();

        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list3=map.get("COLUMN_NAME");
        List<String> list4=map.get("DATA_TYPE");
        List<String> list5=map.get("COLUMN_COMMENT");
        List<String> list6=map.get("pkColumn");
        List<String> list7=map.get("autoAdd");
        List<String> list8=map.get("COLUMN_TYPE");
             list=dataSrcService.getTableData(datasrc,tableName,pageNo,pageSize);
        List<String> list1=new ArrayList<>();
        int countNum=dataSrcService.countData(datasrc,tableName);
        JSONObject jsonObject=new JSONObject();
        ShowTypeInf showTypeInf = showTypeInfService.getTableComment(tableName, subjectCode);
        if (showTypeInf != null) {
            jsonObject.put("tableComment", showTypeInf.getTableComment());
        } else {
            jsonObject.put("tableComment", "");
        }
        int check = synchronizationTablesService.isSynchronizationTable(tableName, subjectCode);
        jsonObject.put("totalCount", countNum);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", countNum % pageSize == 0 ? countNum / pageSize : countNum / pageSize + 1);

        jsonObject.put("isSync", check);
         jsonObject.put("dataDatil",list);
         jsonObject.put("columns",list3);
        jsonObject.put("dataType",list4);
        jsonObject.put("columnComment",list5);
        jsonObject.put("pkColumn",list6);
        jsonObject.put("autoAdd",list7);
        jsonObject.put("columnType",list8);
       return jsonObject;
    }


//    显示表数据，使用template，建立数据类，未完成
    @ResponseBody
    @RequestMapping("/showTableDataTestTmpl")
    public JSONObject showTableDataTestTmpl(String subjectCode, String tableName,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                           @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        DataSrc datasrc=getDataSrc(subjectCode);
        List<List<Object>> list=new ArrayList<>();

        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list3=map.get("COLUMN_NAME");
        List<String> list4=map.get("DATA_TYPE");
        List<String> list5=map.get("COLUMN_COMMENT");

        list=dataSrcService.getTableDataTestTmpl(datasrc,tableName,pageNo,pageSize);
        List<String> list1=new ArrayList<>();
        int countNum=dataSrcService.countData(datasrc,tableName);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("totalCount", countNum);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", countNum % pageSize == 0 ? countNum / pageSize : countNum / pageSize + 1);

        jsonObject.put("dataDatil",list);
        jsonObject.put("columns",list3);
        jsonObject.put("dataType",list4);
        jsonObject.put("columnComment",list5);

        return jsonObject;
    }

    /**
     * @Description: 新增数据，点击保存按钮
     * @Param: [subjectCode, tableName, addData, enumnCoumn]
     * @return: com.alibaba.fastjson.JSONObject
     * @Author: zcy
     * @Date: 2019/5/7
     */
    @RequestMapping("/addTableData")
    @ResponseBody
    public JSONObject addTableData(String subjectCode, String tableName, String addData, String enumnCoumn){

        JSONObject jsonObject=new JSONObject();
        JSONArray jsonArray=JSONArray.parseArray(addData);
        String column="";
        String values="";
        String enumnCoumns[] = enumnCoumn.split(",");
//
        ShowTypeInf showTypeInf = showTypeInfService.getShowTypeInf(tableName, subjectCode);

        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);

        List<String> list1=map.get("pkColumn");
        List<String> list2=map.get("autoAdd");
        List<String> list3=map.get("IS_NULLABLE");

        for(int i=0;i<jsonArray.size();i++){
            String col = jsonArray.getJSONObject(i).getString("columnName");
            String val = jsonArray.getJSONObject(i).getString("columnValue");

            if(list1.get(i).equals("PRI") && list2.get(i).equals("auto_increment")){ //有主键且自增
                System.out.println(jsonArray.getJSONObject(i).getString("columnName"));

            }else if(list1.get(i).equals("PRI") && !list2.get(i).equals("auto_increment") && !col.equals("PORTALID")){   //有主键但不自增，判断新增主键是否重复
                if(val!=null && !val.equals("")){
                    if( dataSrcService.checkPriKey(datasrc,tableName,val,col)==1){
                        jsonObject.put("data","0");
                        jsonObject.put("prikey",col);
                        return jsonObject;
                    }
                    val = getEnumKeyByVal(showTypeInf, enumnCoumns, col, val, datasrc);

                    column += "" + col + " ,";
                    values += "'" + val + "' ,";
                }else{
                    jsonObject.put("data","-1");
                    jsonObject.put("prikey",col);
                    return jsonObject;
                }
            }else if(col.equals("PORTALID")){
                String uuid = UUID.randomUUID().toString();
                column+="PORTALID ,";
                values+="'"+uuid+"' ,";
            } else{
                if(val!=null&& !val.equals("")) {
                    val = getEnumKeyByVal(showTypeInf, enumnCoumns, col, val, datasrc);
                    column += "" + col + " ,";
                    values += "'" + val + "' ,";
                }else if(!col.equals("PORTALID") && list3.get(i).equals("NO")) {
                    jsonObject.put("data", "-2+" + col);    //该列不能为空
                    return jsonObject;
                }
            }
        }

        column=column.substring(0,column.length()-1);
        values=values.substring(0,values.length()-1);

        int n=dataSrcService.addData(datasrc,tableName,column,values);
        if(n==1){
            jsonObject.put("data","1");
        }else{
            jsonObject.put("data","-3");
        }
          return jsonObject;
    }

    @RequestMapping("deleteData")
    @ResponseBody
    public JSONObject deleteData(String subjectCode,String tableName,String delPORTALID){
        JSONObject jsonObject=new JSONObject();
        System.out.println(subjectCode+",,,"+tableName+",,,"+delPORTALID);
        DataSrc datasrc=getDataSrc(subjectCode);
        int i=dataSrcService.deleteDate(tableName,delPORTALID,datasrc);
        if(i==1){
            jsonObject.put("data","1");
        }else{
            jsonObject.put("data","0");
        }
        return jsonObject;
    }

    public String getEnumKeyByVal(ShowTypeInf showTypeInf, String[] enumnCoumns, String col, String val, DataSrc datasrc) {
        if (showTypeInf != null) {
            for (int ii = 0; ii < enumnCoumns.length; ii++) {
                if (col.equals(enumnCoumns[ii])) {
                    ShowTypeDetail showTypeDetail = showTypeInfService.getShowTypeDetail(showTypeInf, enumnCoumns[ii]);
                    if (showTypeDetail != null) {
                        if (showTypeDetail.getOptionMode().equals("1")) {
                            List<EnumData> list = showTypeDetail.getEnumData();
                            for (EnumData e : list) {
                                if (val.equals(e.getValue())) {
                                    val = e.getKey();
                                }
                            }
                        }
                        if (showTypeDetail.getOptionMode().equals("2")) {
                            String reTable = showTypeDetail.getRelationTable();
                            String recolK = showTypeDetail.getRelationColumnK();
                            String recolV = showTypeDetail.getRelationColumnV();
                            val = dataSrcService.getSqlEnumData(datasrc, reTable, recolK, recolV, val);
                        }
                    }
                }

            }
        }
        return val;
    }

    @ResponseBody
    @RequestMapping("/toaddTableData")
    public JSONObject toaddTableData(String subjectCode,String tableName){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list1=map.get("COLUMN_NAME");//列明
        List<String> list2=map.get("DATA_TYPE");//字段类型
        List<String> list3=map.get("COLUMN_COMMENT"); //注释
        List<String> list4=map.get("autoAdd");  //自增
        List<String> list5=map.get("pkColumn");  //键
        jsonObject.put("COLUMN_NAME",list1);
        jsonObject.put("DATA_TYPE",list2);
        jsonObject.put("COLUMN_COMMENT",list3);
        jsonObject.put("autoAdd",list4);
        jsonObject.put("pkColumn",list5);


        List<EnumData> enumDataList = new ArrayList<>();
//        判断该表是否设置过显示类型
        ShowTypeInf showTypeInf = showTypeInfService.getTableComment(tableName, subjectCode);
        if (showTypeInf == null) {
            jsonObject.put("alert", 0);//该表没有设置过显示类型
        } else {
            enumDataList = getEnumData(list1, showTypeInf, datasrc, tableName);
            jsonObject.put("enumDataList", enumDataList);
            jsonObject.put("alert", 1);
        }
        return jsonObject;
    }

    public List<EnumData> getEnumData(List<String> list1, ShowTypeInf showTypeInf, DataSrc datasrc, String tableName) {
        List<EnumData> enumDataList = new ArrayList<>();
        for (int i = 0; i < list1.size(); i++) {
            ShowTypeDetail showTypeDetail = showTypeInfService.getShowTypeDetail(showTypeInf, list1.get(i));
            if (showTypeDetail != null) {
                EnumData enumData = new EnumData();
                String s = "";
                if (showTypeDetail.getType() == 2) {
                    if (showTypeDetail.getOptionMode().equals("1")) { //文本串

                        List<EnumData> enumText = showTypeDetail.getEnumData();

                        for (EnumData e : enumText) {
                            s += e.getValue() + ",";
                        }
                        enumData.setKey(list1.get(i));
                        enumData.setValue(s);
                        enumDataList.add(enumData);
                    }
                    if (showTypeDetail.getOptionMode().equals("2")) {  //sql
                        String reTable = showTypeDetail.getRelationTable();
                        String reColKey = showTypeDetail.getRelationColumnK();
                        String reColVal = showTypeDetail.getRelationColumnV();
                        List<String> list = dataSrcService.getDataByColumn(datasrc, tableName, list1.get(i));
                        List<EnumData> enumSqlList = dataSrcService.getEnumData(datasrc, reTable, reColKey, reColVal);
                        enumData = dataSrcService.enumCorresponding(list, enumSqlList);
                        enumData.setKey(list1.get(i));
                        enumDataList.add(enumData);
                    }
                }
            }
        }
        return enumDataList;
    }

    @RequestMapping("toupdateTableData")
    @ResponseBody
    public JSONObject toupdateTableData(String subjectCode,String tableName,String PORTALID){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list1=map.get("COLUMN_NAME");
        List<String> list2=map.get("DATA_TYPE");//字段类型
        List<String> list3=map.get("COLUMN_COMMENT"); //注释
        List<String> list4=map.get("autoAdd");  //自增
        List<String> list5=map.get("pkColumn");  //键
        List<String> list6=map.get("COLUMN_TYPE"); //列类型

        jsonObject.put("COLUMN_NAME",list1);
        jsonObject.put("DATA_TYPE",list2);
        jsonObject.put("COLUMN_COMMENT",list3);
        jsonObject.put("autoAdd",list4);
        jsonObject.put("pkColumn",list5);
        jsonObject.put("COLUMN_TYPE",list6);
        List<String> list7 = dataSrcService.getDataByPORTALID(datasrc, tableName, PORTALID);

        List<EnumData> enumDataList = new ArrayList<>();
//        判断该表是否设置过显示类型
        ShowTypeInf showTypeInf = showTypeInfService.getTableComment(tableName, subjectCode);
        if (showTypeInf == null) {
            jsonObject.put("alert", 0);//该表没有设置过显示类型
        } else {
            for (int i = 0; i < list1.size(); i++) {
                ShowTypeDetail showTypeDetail = showTypeInfService.getShowTypeDetail(showTypeInf, list1.get(i));
                if (showTypeDetail != null) {
                    EnumData enumData = new EnumData();
                    if (showTypeDetail.getType() == 2) {
                        String s = "";
                        if (showTypeDetail.getOptionMode().equals("1")) { //文本串

                            List<EnumData> enumText = showTypeDetail.getEnumData();

                            for (EnumData e : enumText) {
                                if (list7.get(i).equals(e.getKey())) {
                                    list7.set(i, e.getValue());
                                }
                                s += e.getValue() + ",";
                            }
                            enumData.setKey(list1.get(i));
                            enumData.setValue(s);
                            enumDataList.add(enumData);

                        }
                        String s_val = "";
                        if (showTypeDetail.getOptionMode().equals("2")) {  //sql
                            String reTable = showTypeDetail.getRelationTable();
                            String reColKey = showTypeDetail.getRelationColumnK();
                            String reColVal = showTypeDetail.getRelationColumnV();
                            List<String> list = dataSrcService.getDataByColumn(datasrc, tableName, list1.get(i));
                            List<EnumData> enumSqlList = dataSrcService.getEnumData(datasrc, reTable, reColKey, reColVal);
                            for (String ss : list) {
                                for (EnumData e : enumSqlList) {
                                    if (ss.equals(e.getKey())) {
                                        s_val += e.getValue() + ",";
                                    }
                                    if (list7.get(i).equals(e.getKey())) {
                                        list7.set(i, e.getValue());
                                    }
                                }
                            }
                            enumData.setValue(s_val);
                            enumData.setKey(list1.get(i));
                            enumDataList.add(enumData);
                        }
                    }
                }
            }
        }
        jsonObject.put("enumDataList", enumDataList);
        jsonObject.put("data", list7);
        return jsonObject;
    }


    @RequestMapping("/saveTableData")
    @ResponseBody
    public JSONObject saveTableData(@Param("newdata") String newdata, String subjectCode, String tableName, String delPORTALID, String enumColumn){
        JSONObject jsonObject=new JSONObject();
        String enumnCoumns[] = enumColumn.split(",");
//
        ShowTypeInf showTypeInf = showTypeInfService.getShowTypeInf(tableName, subjectCode);
        JSONArray jsonArray2=JSONArray.parseArray(newdata);
        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
//        旧数据
        List<String> list=dataSrcService.getDataByPORTALID(datasrc,tableName,delPORTALID);
        List<String> list1=map.get("pkColumn");    //主键
        List<String> list2=map.get("autoAdd");
        List<String> list3=map.get("IS_NULLABLE");  //不为空

        //更新的数据
        String updatestr=" set ";
//        条件设置,拼串
        String conditionstr=" where ";
                conditionstr += " PORTALID  = '" + delPORTALID + "' ";

        for(int i=0;i<jsonArray2.size();i++){
            String column=jsonArray2.getJSONObject(i).getString("name");
            String value=jsonArray2.getJSONObject(i).getString("value");

            if(list3.get(i).equals("NO") && (value ==null ||value.equals(""))){
                jsonObject.put("data","-2+");           //该列不能为空
                jsonObject.put("col",column);
                return jsonObject;
            }
            if(list1.get(i).equals("PRI")){
              int n=dataSrcService.checkPriKey(datasrc,tableName,value,column);
              if(n>1) {
                  jsonObject.put("data", "-1");           //主键重复
                  return jsonObject;
              }
            }
            if(list.get(i).equals(value)){

            }else if((list.get(i).equals("")||list.get(i)==null)&&(value.equals("")||value==null)){

            }else {
                value = getEnumKeyByVal(showTypeInf, enumnCoumns, column, value, datasrc);
                updatestr += "" + column + "= '" + value + "' , ";
            }
        }
        if(updatestr.equals(" set ")){
            jsonObject.put("data","1");
            return jsonObject;
        }

        int ll=updatestr.length();
        String s2=updatestr.substring(0,ll-2);
        String s1=conditionstr;
        System.out.println(s2+";;;;;"+s1);

        int n=dataSrcService.updateDate(s1,s2,tableName,datasrc);
        if(n==1){
            jsonObject.put("data","1");
        }else{
            jsonObject.put("data","0");
        }
        return jsonObject;
    }

    @RequestMapping("toCheckTableData")
    @ResponseBody
    public JSONObject toCheckTableData(String subjectCode, String tableName, String PORTALID){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list1=map.get("COLUMN_NAME");
        List<String> list2=map.get("DATA_TYPE");//字段类型
        List<String> list3=map.get("COLUMN_COMMENT"); //注释
        List<String> list4=map.get("autoAdd");  //自增
        List<String> list5=map.get("pkColumn");  //键
        List<String> list6=map.get("COLUMN_TYPE"); //列类型
        List<String> list7=map.get("COLUMN_NAME");

        jsonObject.put("COLUMN_NAME",list1);
        jsonObject.put("DATA_TYPE",list2);
        jsonObject.put("COLUMN_COMMENT",list3);
        jsonObject.put("autoAdd",list4);
        jsonObject.put("pkColumn",list5);
        jsonObject.put("COLUMN_TYPE",list6);
        List<String> list=dataSrcService.getDataByPORTALID(datasrc,tableName,PORTALID);
        List<DataComposeDemo> d=new ArrayList<>();
        for(int i=0;i<list7.size();i++){
            DataComposeDemo composeDemo=new DataComposeDemo();
            composeDemo.setColName(list7.get(i));
            composeDemo.setAutoAdd(list4.get(i));
            composeDemo.setPkColumn(list5.get(i));
            composeDemo.setColumnComment(list3.get(i));
            composeDemo.setDataType(list2.get(i));
            composeDemo.setColumnType(list6.get(i));
            composeDemo.setData(list.get(i));
            d.add(composeDemo);
        }
//        jsonObject.put("data",list);
        jsonObject.put("data",d);
        return jsonObject;
    }


}
