package cn.csdb.drsr.service;

import cn.csdb.drsr.controller.LoginController;
import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.utils.ConfigUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.UUID;


@Service
public class LoginService
{
    @Resource
    private JdbcTemplate jdbcTemplate;

    @Resource
    private UserInfoService userInfoService;

    private static final Logger logger = LogManager.getLogger(LoginController.class);
    public int validateLogin(String userName, String password)
    {
        //1、访问中心端验证登录是否成功
        int loginStatus = 0;

        String configFilePath = LoginService.class.getClassLoader().getResource("drsr.properties").getFile();

        try {
            String portalUrl = ConfigUtil.getConfigItem(configFilePath, "PortalUrl");
            String loginApiPath = "/api/clientLogin";
            String url = "http://" + portalUrl + loginApiPath + "?" + "userName=" + userName + "&password=" + password;
            logger.info("before portal login: portal login api, url = " + url);
            RestTemplate restTemplate = new RestTemplate();
            JSONObject loginObject = restTemplate.getForObject(url, JSONObject.class);
            logger.info("after portal login: loginObject = " + loginObject);

            loginStatus = Integer.parseInt((String)(loginObject.get("loginStatus")));

            //validate user pass
            if (loginStatus == 1)
            {
                logger.info("log in success: loginStatus = " + loginStatus);

                //String isInitialized = ConfigUtil.getConfigItem(configFilePath, "IsInitialized");

                //config file not initialized
                /*if (isInitialized.trim().equals("false"))
                {*/
                logger.info("start to get portal subject info");
                getSubjectConfig(userName);
                logger.info("get portal subject info completed!");
                /*}*/
            }
       }
       catch (Exception e)
       {
           e.printStackTrace();
       }

       return  loginStatus;
    }

    private boolean getSubjectConfig(String userName)
    {
        String configFilePathDrsr = LoginService.class.getClassLoader().getResource("drsr.properties").getFile();
        //String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();

        String portalUrl = ConfigUtil.getConfigItem(configFilePathDrsr, "PortalUrl");
        String getSubjectApiPath = "/api/getSubjectByUser/" + userName;

        String url = "http://" + portalUrl + getSubjectApiPath;

        RestTemplate restTemplate = new RestTemplate();
        JSONObject subjectInfo = restTemplate.getForObject(url, JSONObject.class);

        logger.info("getSubject - data : " + subjectInfo.get("data"));
        LinkedHashMap dataMap = (LinkedHashMap) subjectInfo.get("data");

        String subjectName = "";
        if (dataMap.get("subjectName") != null)
        {
            subjectName = dataMap.get("subjectName").toString();
        }
        String subjectCode = "";
        if (dataMap.get("subjectCode") != null)
        {
            subjectCode = dataMap.get("subjectCode").toString();
        }
        String admin = "";
        if (dataMap.get("admin") != null)
        {
            admin = dataMap.get("admin").toString();
        }
        String adminPasswd = "";
        if (dataMap.get("adminPasswd") != null)
        {
            adminPasswd = dataMap.get("adminPasswd").toString();
        }
        String contact = "";
        if(dataMap.get("contact") != null)
        {
            contact = dataMap.get("contact").toString();
        }
        String phone = "";
        if(dataMap.get("phone") != null)
        {
            phone = dataMap.get("phone").toString();
        }
        String email = "";
        if(dataMap.get("email") != null)
        {
            email = dataMap.get("email").toString();
        }
        String ftpUser = "";
        if (dataMap.get("ftpUser") != null)
        {
            ftpUser = dataMap.get("ftpUser").toString();
        }
        String ftpPassword = "";
        if (dataMap.get("ftpPassword") != null)
        {
            ftpPassword = dataMap.get("ftpPassword").toString();
        }
        String brief = "";
        if (dataMap.get("brief") != null)
        {
            brief = dataMap.get("brief").toString();
        }
        String dbHost="";
        if (dataMap.get("dbHost") != null)
        {
            dbHost = dataMap.get("ftpServerAddr").toString();
        }
        String dbPort="";
        if (dataMap.get("dbPort") != null)
        {
            dbPort = dataMap.get("dbPort").toString();
        }

        //登陸成功
      ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession().setAttribute("subjectCode",userName);
      ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession().setAttribute("userName",subjectCode);

        UserInformation userInformation=new UserInformation();
        SimpleDateFormat sDateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String date=sDateFormat.format(new Date());


//      userInformation.setID(UUID.randomUUID().toString());
        userInformation.setSubjectName(subjectName);
        userInformation.setSubjectCode(subjectCode);
        userInformation.setAdmin(admin);
        userInformation.setAdminPasswd(adminPasswd);
        userInformation.setContact(contact);
        userInformation.setPhone(phone);
        userInformation.setEmail(email);
        userInformation.setFtpUser(ftpUser);
        userInformation.setFtpPassword(ftpPassword);
        userInformation.setBrief(brief);
        userInformation.setLoginDate(date);
        userInformation.setDbHost(dbHost);
        userInformation.setDbPort(dbPort);


        userInfoService.saveUserinfo(userInformation);



//        ConfigUtil.setConfigItem(configFilePath, "IsInitialized", "true");
//        ConfigUtil.setConfigItem(configFilePath, "SubjectName", subjectName);
//        ConfigUtil.setConfigItem(configFilePath, "SubjectCode", subjectCode);
//        ConfigUtil.setConfigItem(configFilePath, "Admin", admin);
//        ConfigUtil.setConfigItem(configFilePath, "AdminPasswd", adminPasswd);
//        ConfigUtil.setConfigItem(configFilePath, "Contact", contact);
//        ConfigUtil.setConfigItem(configFilePath, "Phone", phone);
//        ConfigUtil.setConfigItem(configFilePath, "Email", email);
//        ConfigUtil.setConfigItem(configFilePath, "FtpUser", ftpUser);
//        ConfigUtil.setConfigItem(configFilePath, "FtpPassword", ftpPassword);
//        ConfigUtil.setConfigItem(configFilePath, "Brief", brief);

        return true;
    }
}
