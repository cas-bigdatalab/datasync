package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.DataSrcService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class PageTestController {
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

//    @RequestMapping("/showTableDataTest")
//    public void test1(HttpServletRequest request){
//
//        String tableName=request.getParameter("dataName");
//        System.out.println(tableName);
//    }

    @ResponseBody
    @RequestMapping("/showTableDataTest")
    public JSONObject test(String subjectCode, String tableName, @RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                           @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        DataSrc datasrc=getDataSrc(subjectCode);
        List<Map<String,Object>> list=new ArrayList<>();

        System.out.println(subjectCode+"..."+tableName);
//        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
//        List<String> list3=map.get("COLUMN_NAME");
//        List<String> list4=map.get("DATA_TYPE");
//        List<String> list5=map.get("COLUMN_COMMENT");
//        List<String> list6=map.get("pkColumn");
//        List<String> list7=map.get("autoAdd");
//        List<String> list8=map.get("COLUMN_TYPE");
        list=dataSrcService.getTableData(datasrc,tableName,pageNo,pageSize);
        List<String> list1=new ArrayList<>();

        int countNum=dataSrcService.countData(datasrc,tableName);
        JSONObject jsonObject=new JSONObject();
//        jsonObject.put("totalCount", countNum);
//        jsonObject.put("currentPage", pageNo);
//        jsonObject.put("pageSize", pageSize);
//        jsonObject.put("totalPages", countNum % pageSize == 0 ? countNum / pageSize : countNum / pageSize + 1);

        jsonObject.put("dataDatil",list);
//        jsonObject.put("columns",list3);
//        jsonObject.put("dataType",list4);
//        jsonObject.put("columnComment",list5);
//        jsonObject.put("pkColumn",list6);
//        jsonObject.put("autoAdd",list7);
//        jsonObject.put("columnType",list8);
        return jsonObject;
    }


}
