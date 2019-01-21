package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.DataSrcService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EditDataController {
    @Autowired
    private CheckUserDao checkUserDao;

    @Autowired
    private DataSrcService dataSrcService;


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

        System.out.println();
        jsonObject.put("list", list);
        jsonObject.put("dataSourceName", datasrc.getDataSourceName());
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping("/showTableData")
//    public List<Map<String,Object>> test(String subjectCode, String tableName){
        public JSONObject test(String subjectCode, String tableName){
        DataSrc datasrc=getDataSrc(subjectCode);
         List<Map<String,Object>> list=new ArrayList<>();

        Map<String,List<String>> map=dataSrcService.getColumnName(datasrc,tableName);
        List<String> list3=map.get("COLUMN_NAME");
        List<String> list4=map.get("DATA_TYPE");
        List<String> list5=map.get("COLUMN_COMMENT");
             list=dataSrcService.getTableData(datasrc,tableName);
        List<String> list1=new ArrayList<>();
//         for(int i=0;i<=0;i++){
//             Map<String,Object> map1=list.get(i);
//             for(String key:map1.keySet()){
//                 list1.add(key);
//                 System.out.println("key:"+key+"...."+"value:"+map1.get(key));
//             }
//         }

        JSONObject jsonObject=new JSONObject();
//         ???  表列明顺序和读出的值顺序不一致
         jsonObject.put("dataDatil",list);
         jsonObject.put("columns",list3);
        jsonObject.put("dataType",list4);
       return jsonObject;
    }

    @RequestMapping("/saveTableData")
    @ResponseBody
    public String saveTableData(@Param("olddata") String olddata, @Param("newdata") String newdata){

         JSONArray jsonArray1=JSONArray.parseArray(olddata);
         JSONArray jsonArray2=JSONArray.parseArray(newdata);

         JSONObject tableNameObjext=jsonArray1.getJSONObject(0);
        JSONObject dbNameObjext=jsonArray1.getJSONObject(1);
        String tableName= tableNameObjext.getString("value");
        String dbName=dbNameObjext.getString("value");

//        条件设置,拼串
        String conditionstr=" where ";
        for(int i=2;i<jsonArray1.size();i++){
            String column=jsonArray1.getJSONObject(i).getString("name");
            String value=jsonArray1.getJSONObject(i).getString("value");
            conditionstr+=""+column +"= '"+value+"' and ";
        }
  //更新的数据
     String updatestr=" set ";
        for(int i=2;i<jsonArray2.size();i++){
            String column=jsonArray2.getJSONObject(i).getString("name");
            String value=jsonArray2.getJSONObject(i).getString("value");
            updatestr+=""+column +"= '"+value+"' , ";
        }
        int l=conditionstr.length();
        String s1=conditionstr.substring(0,l-5);
        int ll=updatestr.length();
        String s2=updatestr.substring(0,ll-2);
        DataSrc datasrc=getDataSrc(dbName);
        dataSrcService.updateDate(s1,s2,tableName,datasrc);
        System.out.println(s2+"............"+ s1);

        return "修改成功";
    }
}
