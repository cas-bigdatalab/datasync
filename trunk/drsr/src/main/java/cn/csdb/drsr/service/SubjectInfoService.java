package cn.csdb.drsr.service;

import cn.csdb.drsr.model.Subject;
import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.utils.ConfigUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import sun.security.krb5.Config;

import javax.annotation.Resource;

@Service
public class SubjectInfoService {
    @Resource
    private UserInfoService userInfoService;

    public Subject getSubjectInfo()
    {
        Subject subject = new Subject();

        String subjectCode = (String) ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession().getAttribute("userName");

        UserInformation userInformation=userInfoService.getUserInfoByCode(subjectCode);

       // String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        subject.setSubjectName(userInformation.getSubjectName());
        subject.setSubjectCode(userInformation.getSubjectCode());
        subject.setAdmin(userInformation.getAdmin());
        subject.setAdminPasswd(userInformation.getAdminPasswd());
        subject.setContact(userInformation.getContact());
        subject.setPhone(userInformation.getPhone());
        subject.setEmail(userInformation.getEmail());
        subject.setFtpUser(userInformation.getFtpUser());
        subject.setFtpPassword(userInformation.getFtpPassword());
        subject.setBrief(userInformation.getBrief());
        return subject;

    }
}
