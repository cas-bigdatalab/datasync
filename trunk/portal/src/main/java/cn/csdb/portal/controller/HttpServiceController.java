package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataTask;
import cn.csdb.portal.model.Site;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.ConfigPropertyService;
import cn.csdb.portal.service.DataTaskService;
import cn.csdb.portal.service.SiteService;
import cn.csdb.portal.service.SubjectMgmtService;
import cn.csdb.portal.utils.SqlUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-12 10:15
 **/
@Controller
@RequestMapping("/service")
public class HttpServiceController {

    @Autowired
    private DataTaskService dataTaskService;

    @Autowired
    private SubjectMgmtService subjectMgmtService;

    @Autowired
    private ConfigPropertyService configPropertyService;

    @ResponseBody
    @RequestMapping(value = "getDataTask", method = {RequestMethod.POST,RequestMethod.GET})
    public int getDataTask(@RequestBody String requestString){
        JSONObject requestJson = JSON.parseObject(requestString);
        String subjectCode = requestJson.get("subjectCode").toString();
        String dataTaskString = requestJson.get("dataTask").toString();
        DataTask dataTask = JSON.parseObject(dataTaskString,DataTask.class);
        dataTask.setDataTaskId(0);
//        Site site = siteService.getSiteByMarker(siteMarker);
        Subject subject = subjectMgmtService.findByCode(subjectCode);
        String siteFtpPath = subject.getFtpFilePath();
        dataTask.setSubjectCode(subject.getSubjectCode());
        String sqlFilePath = dataTask.getSqlFilePath();
        String[] filePathList = sqlFilePath.split(";");
        StringBuffer filePathBuffer = new StringBuffer();
        String structDBFile = "";
        String dataDBFile = "";
        for(String filePath : filePathList){
            if(filePath.equals("")){
                continue;
            }
            String fileName = "";
            if (filePath.indexOf("/")>0){
                fileName = filePath.substring(filePath.lastIndexOf("/")+1);
            }else if(filePath.indexOf("\\")>0){
                fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
            }
            filePathBuffer.append(siteFtpPath+fileName+";");
            if(fileName.contains("data")){
                dataDBFile = siteFtpPath+fileName;
            }else if(fileName.contains("struct")){
                structDBFile = siteFtpPath+fileName;
            }
        }
        dataTask.setSqlFilePath(filePathBuffer.toString());

        String username = configPropertyService.getProperty("db.username");
        String password = configPropertyService.getProperty("db.password");
        String dbName = subject.getDbName();

        SqlUtil sqlUtil = new SqlUtil();
        try {
            sqlUtil.importSql("localhost",username,password,dbName,structDBFile,dataDBFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int insertSuccess = dataTaskService.insertDataTask(dataTask);
        if(insertSuccess>0){
            return 1;
        }else{
            return 0;
        }

    }
}
