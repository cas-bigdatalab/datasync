package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.ConfigPropertyService;
import cn.csdb.drsr.service.DataSrcService;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.utils.FtpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;

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
        DataTask dataTask = dataTaskService.get(dataTaskId);
        String[] localFileList = dataTask.getSqlFilePath().split(";");
        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            System.out.println(ftpUtil.upload(host, userName, password, port, localFileList, processId,remoteFilepath));
            ftpUtil.disconnect();
        } catch (IOException e) {
            System.out.println("连接FTP出错：" + e.getMessage());
        }
        return "100";
    }

    @ResponseBody
    @RequestMapping("ftpUploadProcess")
    public String ftpUploadProcess(String processId){
        FtpUtil ftpUtil =new FtpUtil();
        Long process =  ftpUtil.getFtpUploadProcess(processId);
        return Long.toString(process);
    }

}
