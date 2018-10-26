package cn.csdb.drsr.service;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class SubjectAdminLoginService
{
    public int validateLogin(String userName, String password)
    {
        //1、访问中心端验证登录是否成功

        //2、如果登录成功，验证专题库信息是否同步，如果没有同步下来，则同步一次
        //localhost:8080/api/getSubject/{subjectCode}
        //   /api/getSubject/{subjectCode}
        getSubjectConfig();


        return  0;
    }

    private boolean getSubjectConfig()
    {
<<<<<<< HEAD
<<<<<<< HEAD
        //JSONObject subjectObject = RestTemplate.
=======
        JSONObject subjectObject = RestTemplate.
>>>>>>> 4a6d188de5820c0e7a52a54f729881a3a1daf816
=======
        JSONObject subjectObject = RestTemplate.
>>>>>>> 4a6d188de5820c0e7a52a54f729881a3a1daf816
        return true;
    }
}
