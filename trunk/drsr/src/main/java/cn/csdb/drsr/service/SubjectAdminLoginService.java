package cn.csdb.drsr.service;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

@Service
public class SubjectAdminLoginService
{
    public int validateLogin(String userName, String password)
    {

        //1、访问中心端验证登录是否成功
        int loginStatus = 0;
        String configFilePath = "config.properties";
        try {
            String portalIp = getConfigItem(configFilePath, "PortalIP");
            String portalPort = getConfigItem(configFilePath, "PortalPort");
            String loginApiPath = "/portal/api/clientLogin";
            String url = "http://" + portalIp + ":" + portalPort + loginApiPath + "?" + "userName=" + userName + "&password=" + password;

            RestTemplate restTemplate = new RestTemplate();
            JSONObject loginObject = restTemplate.getForObject(url, JSONObject.class);

            loginStatus = Integer.parseInt((String)(loginObject.get("loginStatus")));
            if (loginStatus == 1)
            {
               String isInitialized = getConfigItem(configFilePath, "IsInitialized");
               if (isInitialized.trim().equals(false))
               {
                   getSubjectConfig(userName, password);
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
        String configFilePath = "config.properties";
        String subjectCode = getConfigItem(configFilePath, "SubjectCode");
        String portalIp = getConfigItem(configFilePath, "PortalIP");
        String portalPort = getConfigItem(configFilePath, "PortalPort");
        String getSubjectApiPath = "/portal/api/getSubject/" + subjectCode;
        String url = "http://" + portalIp + ":" + portalPort + getSubjectApiPath;

        RestTemplate restTemplate = new RestTemplate();
        JSONObject subjectInfo = restTemplate.getForObject(url, JSONObject.class);

        //setConfigItem(configFilePath, "SubjectName", (JSONObject)(subjectInfo.get("data")).get("subjectName"));
        //setConfigItem(configFilePath, "ftpUser", (JSONObject)(subjectInfo.get("data")).get("ftpUser"));
        //setConfigItem(configFilePath, "ftpUser", (JSONObject)(subjectInfo.get("data")).get("ftpPassword"));

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
        String configItemValue = null;
        try {
            Properties properties = new Properties();
            properties.load(new FileInputStream(new File(configFilePath)));
            properties.setProperty(key, value);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
