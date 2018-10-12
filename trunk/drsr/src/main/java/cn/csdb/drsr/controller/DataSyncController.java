package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.ConfigPropertyService;
import cn.csdb.drsr.service.DataSrcService;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.utils.FtpUtil;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

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
        DataTask dataTask = dataTaskService.get(dataTaskId);
        String[] localFileList = dataTask.getSqlFilePath().split(";");
        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            String result = ftpUtil.upload(host, userName, password, port, localFileList, processId,remoteFilepath).toString();
            ftpUtil.disconnect();
            if(result.equals("Upload_New_File_Success")||result.equals("Upload_From_Break_Succes")){
                RequestConfig requestConfig = RequestConfig.custom().setCookieSpec(CookieSpecs.STANDARD_STRICT).build();
                CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
                HttpGet httpGet = new HttpGet(portalUrl);
                CloseableHttpResponse response = null;
                String httpResult = "";
                try {
                    response = httpClient.execute(httpGet);
                    HttpEntity entity = response.getEntity();
                    if (entity != null) {
                        InputStream inputStream = entity.getContent();
                        httpResult = IOUtils.toString(inputStream, "UTF-8");
                    }
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
