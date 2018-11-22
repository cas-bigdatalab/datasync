package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.ConfigPropertyService;
import cn.csdb.drsr.service.DataSrcService;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.utils.FtpUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-09 15:59
 **/
@Controller
public class DataSyncController {

    @Resource
    private DataTaskService dataTaskService;
    @Resource
    private DataSrcService dataSrcService;
    @Autowired
    private ConfigPropertyService configPropertyService;

    private Logger logger = LoggerFactory.getLogger(DataSyncController.class);



    /**
     *
     * Function Description: 数据任务文件上传到中心端
     *
     * @param: [dataTaskId, processId]
     * @return: java.lang.String
     * @auther: hw
     * @date: 2018/10/26 10:12
     */
    @ResponseBody
    @RequestMapping("/ftpUpload")
    public int ftpUpload(int dataTaskId,String processId){
        logger.info("\n\n======进入ftp上传功能======\n");
        String host = configPropertyService.getProperty("FtpHost");
        String userName = configPropertyService.getProperty("FtpUser");
        String password = configPropertyService.getProperty("FtpPassword");
        String port = configPropertyService.getProperty("FrpPort");
        String remoteFilepath = configPropertyService.getProperty("FtpRootPath");
        String portalUrl = configPropertyService.getProperty("PortalUrl");
        String subjectCode = configPropertyService.getProperty("SubjectCode");
        FtpUtil ftpUtil = new FtpUtil();
        DataTask dataTask = dataTaskService.get(dataTaskId);

        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            String result = "";
            if(dataTask.getDataTaskType().equals("file")){
                String[] localFileList = {dataTask.getSqlFilePath()};
                result = ftpUtil.upload(host, userName, password, port, localFileList, processId,remoteFilepath,dataTask,subjectCode).toString();
                if(localFileList.length == 0){
                    return 0;
                }
            }else if(dataTask.getDataTaskType().equals("mysql")){
                remoteFilepath = remoteFilepath+subjectCode+"_"+dataTask.getDataTaskId()+"/";
                String[] localFileList = {dataTask.getFilePath()};
                result = ftpUtil.upload(host, userName, password, port, localFileList, processId,remoteFilepath,dataTask,subjectCode).toString();
                if(localFileList.length == 0){
                    return 0;
                }
            }
            logger.info("\n\nftpDataTaskId"+dataTask.getDataTaskId()+"上传状态:" + result + "\n");
            ftpUtil.disconnect();
            if(result.equals("Upload_New_File_Success")||result.equals("Upload_From_Break_Succes")){
                String dataTaskString = JSONObject.toJSONString(dataTask);
                JSONObject requestJSON = new JSONObject();
                requestJSON.put("dataTask",dataTaskString);
                requestJSON.put("subjectCode",subjectCode);
                String requestString = JSONObject.toJSONString(requestJSON);
                HttpClient httpClient = null;
                HttpPost postMethod = null;
                HttpResponse response = null;
                try {
                    httpClient = HttpClients.createDefault();
//                    postMethod = new HttpPost("http://localhost:8080/portal/service/getDataTask");
                    postMethod = new HttpPost("http://"+portalUrl+"/service/getDataTask");
//                    postMethod = new HttpPost(portalUrl);
                    postMethod.addHeader("Content-type", "application/json; charset=utf-8");
//                    postMethod.addHeader("X-Authorization", "AAAA");//设置请求头
                    postMethod.setEntity(new StringEntity(requestString, Charset.forName("UTF-8")));
                    response = httpClient.execute(postMethod);//获取响应
                    int statusCode = response.getStatusLine().getStatusCode();
                    System.out.println("HTTP Status Code:" + statusCode);
                    if (statusCode != HttpStatus.SC_OK) {
                        System.out.println("HTTP请求未成功！HTTP Status Code:" + response.getStatusLine());
                    }
                    HttpEntity httpEntity = response.getEntity();
                    String reponseContent = EntityUtils.toString(httpEntity);
                    EntityUtils.consume(httpEntity);//释放资源
                    System.out.println("响应内容：" + reponseContent);
                    if(reponseContent.equals("1")){
                        dataTask.setStatus("1");
                        dataTaskService.update(dataTask);
                        logger.info("\n\n导入成功"+ "\n");
                        return 1;
                    }else{
                        logger.info("\n\n导入失败"+ "\n");
                        return 0;
                    }
                } catch (IOException e) {
                    logger.info("\n\n导入失败"+ "\n");
                    logger.error("\n\n导入异常IOException:"+e+ "\n");
                    e.printStackTrace();
                }
            }else{
                logger.info("\n\n导入失败"+ "\n");
                return 0;
            }
        } catch (IOException e) {
            System.out.println("连接FTP出错：" + e.getMessage());
            return 0;
        }
        return 1;
    }

    @ResponseBody
    @RequestMapping("ftpUploadProcess")
    public Long ftpUploadProcess(String processId){
        FtpUtil ftpUtil =new FtpUtil();
        Long process =  ftpUtil.getFtpUploadProcess(processId);
        return process;
    }

}
