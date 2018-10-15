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

    @ResponseBody
    @RequestMapping("/ftpUpload")
    public String ftpUpload(int dataTaskId,String processId){
        FtpUtil ftpUtil = new FtpUtil();
        String host = configPropertyService.getProperty("FtpHost");
        String userName = configPropertyService.getProperty("FtpUser");
        String password = configPropertyService.getProperty("FtpPassword");
        String port = configPropertyService.getProperty("FrpPort");
        String remoteFilepath = configPropertyService.getProperty("FtpRootPath");
        String portalUrl = configPropertyService.getProperty("PortalUrl");
        String siteMarker = configPropertyService.getProperty("SiteMarker");
        DataTask dataTask = dataTaskService.get(dataTaskId);
        String[] localFileList = dataTask.getSqlFilePath().split(";");
        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            String result = ftpUtil.upload(host, userName, password, port, localFileList, processId,remoteFilepath).toString();
            ftpUtil.disconnect();
            if(result.equals("Upload_New_File_Success")||result.equals("Upload_From_Break_Succes")){
                String dataTaskString = JSONObject.toJSONString(dataTask);
                JSONObject requestJSON = new JSONObject();
                requestJSON.put("dataTask",dataTaskString);
                requestJSON.put("siteMarker",siteMarker);
                String requestString = JSONObject.toJSONString(requestJSON);
                HttpClient httpClient = null;
                HttpPost postMethod = null;
                HttpResponse response = null;
//                RequestConfig requestConfig = RequestConfig.custom().setCookieSpec(CookieSpecs.STANDARD_STRICT).build();
//                CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
//                HttpGet httpGet = new HttpGet(portalUrl);
//                CloseableHttpResponse response = null;
//                String httpResult = "";
                try {
//                    response = httpClient.execute(httpGet);
//                    HttpEntity entity = response.getEntity();
//                    if (entity != null) {
//                        InputStream inputStream = entity.getContent();
//                        httpResult = IOUtils.toString(inputStream, "UTF-8");
//                    }
                    httpClient = HttpClients.createDefault();
                    postMethod = new HttpPost("http://159.226.193.142:8080/portal/service/getDataTask");
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
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            System.out.println("连接FTP出错：" + e.getMessage());
        }
        return "100";
    }

    @ResponseBody
    @RequestMapping("ftpUploadProcess")
    public Long ftpUploadProcess(String processId){
        FtpUtil ftpUtil =new FtpUtil();
        Long process =  ftpUtil.getFtpUploadProcess(processId);
        return process;
    }

}
