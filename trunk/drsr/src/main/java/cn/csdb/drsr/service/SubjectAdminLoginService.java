package cn.csdb.drsr.service;

import cn.csdb.drsr.controller.SubjectAdminLoginController;
import cn.csdb.drsr.model.Subject;
import com.alibaba.fastjson.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

@Service
public class SubjectAdminLoginService
{
    private static final Logger logger = LogManager.getLogger(SubjectAdminLoginController.class);

    public int validateLogin(String userName, String password)
    {
        //1、访问中心端验证登录是否成功
        int loginStatus = 0;

        String configFilePath = SubjectAdminLoginService.class.getClassLoader().getResource("config.properties").getFile();

        try {
            String portalIp = getConfigItem(configFilePath, "PortalIP");
            String portalPort = getConfigItem(configFilePath, "PortalPort");
            String loginApiPath = "/portal/api/clientLogin";
            String url = "http://" + portalIp + ":" + portalPort + loginApiPath + "?" + "userName=" + userName + "&password=" + password;
            logger.info("before portal login: portal login api, url = " + url);
            RestTemplate restTemplate = new RestTemplate();
            JSONObject loginObject = restTemplate.getForObject(url, JSONObject.class);
            logger.info("after portal login: loginObject = " + loginObject);

            loginStatus = Integer.parseInt((String)(loginObject.get("loginStatus")));
            if (loginStatus == 1)
            {
                logger.info("log in success: loginStatus = " + loginStatus);
               String isInitialized = getConfigItem(configFilePath, "IsInitialized");
               if (isInitialized.trim().equals(false))
               {
                   logger.info("start to get portal subject info");
                   getSubjectConfig(userName, password);
                   logger.info("get portal subject info completed!");
               }
            }
       }
       catch (Exception e)
       {
           e.printStackTrace();
       }

       return  loginStatus;
    }

    private boolean getSubjectConfig(String userName, String password)
    {
        String configFilePath = SubjectAdminLoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = getConfigItem(configFilePath, "SubjectCode");
        String portalIp = getConfigItem(configFilePath, "PortalIP");
        String portalPort = getConfigItem(configFilePath, "PortalPort");
        String getSubjectApiPath = "/portal/api/getSubject/" + subjectCode;
        String url = "http://" + portalIp + ":" + portalPort + getSubjectApiPath;

        RestTemplate restTemplate = new RestTemplate();
        JSONObject subjectInfo = restTemplate.getForObject(url, JSONObject.class);
        Subject subject = (Subject) subjectInfo.get("data");

        setConfigItem(configFilePath, "SubjectName", subject.getSubjectName());
        setConfigItem(configFilePath, "FtpUser", subject.getFtpUser());
        setConfigItem(configFilePath, "FtpPassword", subject.getFtpPassword());
        setConfigItem(configFilePath, "IsInitialized", "true");

        return true;
    }

    private static String getConfigItem(String configFilePath, String key) {
        String value = null;
        try {
            Properties properties = new Properties();
            properties.load(new FileInputStream(new File(configFilePath)));
            value = properties.getProperty(key);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return value;
    }

    private static void setConfigItem(String configFilePath, String key, String value) {
        try {
            Properties properties = new Properties();
            properties.load(new FileInputStream(new File(configFilePath)));
            properties.setProperty(key, value);
            FileOutputStream fos = new FileOutputStream(new File(configFilePath));
            properties.store(fos, "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
