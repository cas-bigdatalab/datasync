package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataTask;
import cn.csdb.portal.model.Site;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.ConfigPropertyService;
import cn.csdb.portal.service.DataTaskService;
import cn.csdb.portal.service.SubjectMgmtService;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.ZipUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
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
        System.out.println("000000000000000000000");
        JSONObject requestJson = JSON.parseObject(requestString);
        String subjectCode = requestJson.get("subjectCode").toString();
        String dataTaskString = requestJson.get("dataTask").toString();
        DataTask dataTask = JSON.parseObject(dataTaskString,DataTask.class);
//        Site site = siteService.getSiteByMarker(siteMarker);
        Subject subject = subjectMgmtService.findByCode(subjectCode);
        String siteFtpPath = subject.getFtpFilePath();
        dataTask.setSubjectCode(subject.getSubjectCode());
        String sqlFilePath = dataTask.getSqlFilePath();
        sqlFilePath = sqlFilePath.replaceAll("%_%",File.separator);
        String[] sqlfilePathList = sqlFilePath.split(";");
        String filepath = dataTask.getFilePath();
        StringBuffer sqlfilePathBuffer = new StringBuffer();
        StringBuffer filePathBuffer = new StringBuffer();
        String structDBFile = "";
        String dataDBFile = "";
        String zipFile="";
        String unZipPath = "";
        System.out.println("222222222222");
        for(String fp : sqlfilePathList){
            if(fp.equals("")){
                continue;
            }
            String fileName = "";
            if (fp.indexOf("/")>0){
                fileName = fp.substring(fp.lastIndexOf("/")+1);
            }else if(fp.indexOf("\\")>0){
                fileName = fp.substring(fp.lastIndexOf("\\")+1);
            }
            sqlfilePathBuffer.append(siteFtpPath+fileName+";");
            if(dataTask.getDataTaskType().equals("mysql")){
                String sqlZip = dataTask.getFilePath();
                if (sqlZip.indexOf("/")>0){
                    sqlZip = sqlZip.substring(sqlZip.lastIndexOf("/")+1);
                }else if(sqlZip.indexOf("\\")>0){
                    sqlZip = sqlZip.substring(sqlZip.lastIndexOf("\\")+1);
                }
                sqlZip = siteFtpPath+subjectCode+"_"+dataTask.getDataTaskId()+File.separator+sqlZip;
                File sqlfiles = new File(sqlZip);
                ZipUtil zipUtil = new ZipUtil();
                try {
                    zipUtil.unZip(sqlfiles,siteFtpPath+subjectCode+"_"+dataTask.getDataTaskId());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if(fileName.contains("data")){
                    dataDBFile = siteFtpPath+subjectCode+"_"+dataTask.getDataTaskId()+File.separator+fileName;
                    System.out.println("dataDBFile---------"+dataDBFile);
                }else if(fileName.contains("struct")){
                    structDBFile = siteFtpPath+subjectCode+"_"+dataTask.getDataTaskId()+File.separator+fileName;
                }
            }else if(dataTask.getDataTaskType().equals("file")){
                zipFile = siteFtpPath+fileName;
                System.out.println("+++++++++"+zipFile);
                System.out.println("=========="+fileName);
                unZipPath = siteFtpPath+fileName.substring(0,fileName.lastIndexOf("."));

            }

        }
        dataTask.setSqlFilePath(sqlfilePathBuffer.toString());
//        if (filepath.indexOf("/")>0){
//            filepath = filepath.substring(filepath.lastIndexOf("/")+1);
//        }else if(filepath.indexOf("\\")>0){
//            filepath = filepath.substring(filepath.lastIndexOf("\\")+1);
//        }
//        dataTask.setFilePath(siteFtpPath+filepath);
        System.out.println("11111111111111");
        if(dataTask.getDataTaskType().equals("mysql")){
            String username = configPropertyService.getProperty("db.username");
            String password = configPropertyService.getProperty("db.password");
            String dbName = subject.getDbName();

            SqlUtil sqlUtil = new SqlUtil();
            try {
                System.out.println("passwprd------"+password);
                sqlUtil.importSql("localhost",username,password,dbName,structDBFile,dataDBFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }else{
            File file = new File(zipFile);
            ZipUtil zipUtil = new ZipUtil();
            try {
                zipUtil.unZip(file,unZipPath);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        dataTask.setDataTaskId(null);
        dataTaskService.insertDataTask(dataTask);
        return 1;


    }
}
