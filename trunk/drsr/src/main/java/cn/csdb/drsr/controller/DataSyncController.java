package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.service.*;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.FileUtil;
import cn.csdb.drsr.utils.FtpUtil;
import cn.csdb.drsr.utils.sync.SyncUtil;
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
import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import java.io.*;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.*;

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

    @Resource
    private JdbcTemplate jdbcTemplate;

    private Logger logger = LoggerFactory.getLogger(DataSyncController.class);

    public FtpUtil ftpUtil=new FtpUtil();

    @Resource
    private UserInfoService userInfoService;


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
    public int ftpUpload(String dataTaskId, String processId) throws IOException {
        //FtpUtil ftpUtil = new FtpUtil();
        ftpUtil.numberOfRequest.put(dataTaskId+"Block",dataTaskId);//存放请求
        Long process= Long.valueOf(0);
        ftpUtil.progressMap.put(dataTaskId,process);//初始化进度
        DataTask dataTask = dataTaskService.get(String.valueOf(dataTaskId));
        String fileName = dataTask.getDataTaskName()+"log.txt";//文件名及类型
        String path = "/logs/";
        FileWriter fw = null;
        File file = new File(path, fileName);
        if(!file.exists()){
            try {
                file.createNewFile();
                fw = new FileWriter(file, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            try{
                fw = new FileWriter(file, true);
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================上传流程开始========================" + "\n");
        if("file".equals(dataTask.getDataTaskType())){
            dataTask.setStatus("0");
            dataTaskService.update(dataTask);
            pw.println("###########上传的文件为###########" + "\n");
            File f=new File(dataTask.getSqlFilePath().replace("%_%",File.separator));
            if(f.exists()){
                pw.println("文件大小：" +  FileUtil.getPrintSize(f.length())+"\n");
                pw.println("文件上传路径：" +  dataTask.getRemoteuploadpath()+"\n");
//              System.out.println("文件大小为"+ fileUtil.getPrintSize(file.length()));
            }

            String[] fileAttr = dataTask.getFilePath().split(";");
            for(String fileAttrName : fileAttr){
                pw.println(fileAttrName+ "\n");
            }
        }
        dataTaskService.insertLog(dataTask.getDataTaskId(),"true");
        String subjectCode = (String) ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession().getAttribute("userName");

        UserInformation userInformation=userInfoService.getUserInfoByCode(subjectCode);
        String configFilePath = LoginService.class.getClassLoader().getResource("drsr.properties").getFile();
//        String subjectCode = userInformation.getSubjectCode();
        String userName = userInformation.getFtpUser();
        String password = userInformation.getFtpPassword();
        String host = ConfigUtil.getConfigItem(configFilePath, "host");
        String port = ConfigUtil.getConfigItem(configFilePath, "ftpPort");
        String ftpRootPath = ConfigUtil.getConfigItem(configFilePath, "ftpRootPath");
        String portalUrl =ConfigUtil.getConfigItem(configFilePath, "PortalUrl");
/*
        DataTask dataTask = dataTaskService.get(dataTaskId);
*/
        pw.println("数据任务名称为：" + dataTask.getDataTaskName() +"\n");
        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password,dataTaskId);
//            ftpUtil.ftpClientList.put(dataTaskId,ftpUtil.ftpClient);
            String result = "";
            if(dataTask.getDataTaskType().equals("file")){
                String[] localFileList = {dataTask.getSqlFilePath()};
               File fi=new File(localFileList[0].replaceAll("%_%","/"));
               if(!fi.exists()){
                   pw.println("上传文件不存在！"+ "\n");
                   ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
                   return 4;
               }
                result = ftpUtil.upload(localFileList, dataTaskId,ftpRootPath,dataTask,subjectCode).toString();
                if(result.equals("File_Exits") || result.equals("Remote_Bigger_Local")){
                    ftpUtil.removeDirectory("/temp/"+ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId());
                    ftpUtil.deleteFile("/temp/"+ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+".zip");
                    result = ftpUtil.upload(localFileList, dataTaskId,ftpRootPath,dataTask,subjectCode).toString();
                }
                if(localFileList.length == 0){
                    now = new Date();
                    dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String current1 = dateFormat.format(now);
                    pw.println(current1+":"+"上传失败"+ "\n");
                    dataTask.setStatus("0");
                    dataTaskService.update(dataTask);
                    ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
                    return 0;
                }
            }else {//if(dataTask.getDataTaskType().equals("mysql") || dataTask.getDataTaskType().equals("oracle")){
                String remoteFilepath = ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+"_sql/";
                String[] localFileList = {dataTask.getFilePath()};
                result = ftpUtil.upload(localFileList, processId,remoteFilepath,dataTask,subjectCode+"_sql").toString();
                if(result.equals("File_Exits") || result.equals("Remote_Bigger_Local")){
//                    有时候会因为同一个ftp连接在删除文件后无法创建目录，所以此处重新建立连接ftp
//                    ftpUtil.disconnect();
//                    ftpUtil.connect(host, Integer.parseInt(port), userName, password,dataTaskId);
//                    ftpUtil.removeDirectory(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+"_sql");
                    ftpUtil.deleteFile(dataTask.getDataTaskId()+".zip");
                    result = ftpUtil.upload(localFileList, processId,remoteFilepath,dataTask,subjectCode).toString();
                }
                if(localFileList.length == 0){
                    now = new Date();
                    dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String current1 = dateFormat.format(now);
                    pw.println(current1+":"+"上传失败"+ "\n");
                    dataTask.setStatus("0");
                    dataTaskService.update(dataTask);
                    ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
                    return 0;
                }
            }
            pw.println("ftpDataTaskId"+dataTask.getDataTaskId()+"上传状态:" + result + "\n");

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
                    if("mysql".equals(dataTask.getDataTaskType()) || "oracle".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"=========================导入流程开始========================" + "\n");
                    }
                    if("file".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"=========================解压流程开始========================" + "\n");
                    }
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
                    //DIR_ERROR  工作空间异常
                    //UNZIP_FILE_ERROR  文件任务解压错误
                    //UNZIP_SQL_ERROR 数据类型任务解压错误
                    //EXECUTE_SQL_ERROR 数据类型任务执行错误
                    //SUCCESS 成功
                    if(reponseContent.equals("\"SUCCESS\"")){
                        if("mysql".equals(dataTask.getDataTaskType()) || "oracle".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"导入成功"+ "\n");
                            pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                        }
                        if("file".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"解压成功"+ "\n");
                            pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                        }
                        dataTask.setStatus("1");
                        dataTask.setSynctime(new Date());
//                        ftpUtil.removeDirectory(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+".zip");
                       // ftpUtil.deleteFile(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+".zip");
                        dataTaskService.update(dataTask);
                        ftpUtil.numberOfRequest.remove(dataTask.getDataTaskId()+"Block");
                        ftpUtil.progressMap.put(dataTask.getDataTaskId(),Long.valueOf(100));
                        return 1;
                    }else{
                        System.out.println(reponseContent+"");
                        if("mysql".equals(dataTask.getDataTaskType()) || "oracle".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"导入失败"+ "\n");
                            pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                        }
                        if("file".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"解压失败"+ "\n");
                            pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                        }
                        dataTask.setStatus("0");
                        dataTaskService.update(dataTask);
                        ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
                        return 0;
                    }
                } catch (IOException e) {
                    ftpUtil.disconnect();
                    e.printStackTrace();
                    if("mysql".equals(dataTask.getDataTaskType()) || "oracle".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"导入失败"+ e+"\n");
                        pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                    }
                    if("file".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"解压失败"+ e+"\n");
                        pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                    }
                }
            }else{
                dataTask.setStatus("0");
                dataTaskService.update(dataTask);
                ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
                return 0;
            }
        } catch (IOException e) {
            if(ftpUtil.pauseTasks.get(dataTaskId)!=null && ftpUtil.pauseTasks.get(dataTaskId)!=""){//点击暂停时触发
                ftpUtil.disconnect();
                pw.println(current+":"+"暂停传输:"+e+ "\n");
                System.out.println("暂停传输！" );
                ftpUtil.numberOfRequest.remove(dataTaskId+"Block");

                ftpUtil.pauseTasks.remove(dataTaskId);
                dataTask.setStatus("0");
                dataTaskService.update(dataTask);
                return 3;//暂停
            }else{
                ftpUtil.disconnect();
                now = new Date();
                dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                current = dateFormat.format(now);
                pw.println(current+":"+"连接FTP出错:"+e+ "\n");
                System.out.println("连接FTP出错：" + e.getMessage());
                for(Iterator<Map.Entry<String, String>> it = ftpUtil.numberOfRequest.entrySet().iterator(); it.hasNext();){
                    Map.Entry<String, String> item = it.next();
                    it.remove();
                }
                dataTask.setStatus("0");
                dataTaskService.update(dataTask);
                return 0;
            }
        }finally {
            if( ftpUtil.numberOfRequest.get(dataTaskId+"Block")!=null){
                ftpUtil.numberOfRequest.remove(dataTaskId+"Block");
            }
            ftpUtil.disconnect();
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+"=========================上传流程结束========================" + "\r\n"+"\n\n\n\n\n");
            try {
                fw.flush();
                pw.close();
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return 1;
    }

    @ResponseBody
    @RequestMapping("ftpUploadProcess")
    public JSONObject ftpUploadProcess(String processId){
        JSONObject jsonObject = new JSONObject();
        List<Long> processList=new ArrayList<Long>();
        List<String> blockList=new ArrayList<String>();
        for(String value:ftpUtil.numberOfRequest.values()){
            blockList.add(value);
        }
        Long process =  ftpUtil.getFtpUploadProcess(processId);
        processList.add(process);
        jsonObject.put("process",processList);
        jsonObject.put("blockList",blockList);
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping("pauseUpLoading")
    public void pauseUpLoading(String taskId){
        try {
            ftpUtil.ftpOutputStream.get(taskId).flush();
            ftpUtil.ftpOutputStream.get(taskId).close();
            ftpUtil.pauseTasks.put(taskId,taskId);
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("暂停异常！");
        }
    }

    @ResponseBody
    @RequestMapping("changeSyncStatus")
    public int changeSyncStatus(String taskId,String sync){
        SyncUtil syncUtil=new SyncUtil();
        DataTask dataTask = dataTaskService.get(String.valueOf(taskId));
        JSONObject jsonObject=null;
        int result=-1;
        if("true".equals(sync)){
            jsonObject =syncUtil.executeTask(dataTask, jdbcTemplate);
            if (jsonObject.size() != 0 && "success".equals(jsonObject.getString("result"))) {
                 dataTask.setSynctime(new Date());
                dataTask.setSync(sync);
                result=dataTaskService.update(dataTask);
            }
        }else{
            //取消同步
            dataTask.setSync(sync);
            result=dataTaskService.update(dataTask);
           SyncUtil syncUtil1=new SyncUtil();
           syncUtil.callRemoteSyncMethod("false",dataTask);
        }


        return  result;
    }

}
