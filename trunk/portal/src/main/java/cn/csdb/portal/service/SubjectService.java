package cn.csdb.portal.service;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.SubjectDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @program: DataSync
 * @description: Subject Service class
 * @author: xiajl
 * @create: 2018-10-22 15:53
 **/
@Service
public class SubjectService {
    @Resource
    private SubjectDao subjectDao;

    /**
     * Function Description: 根据subjectCode查找对象
     *
     * @param:  subjectCode:专题库代码
     * @return: Sujbect对像
     * @auther: Administrator
     * @date:   2018/10/22 16:02
     */
    public Subject findBySubjectCode(String subjectCode){
        return subjectDao.findBySubjectCode(subjectCode);
    }


    /**
     * Function Description: validate subject code login
     * @param userName
     * @param password
     * @return loginStatus
     */
    public int validateLogin(String userName, String password) {
        int loginStatus = 0;
        loginStatus = subjectDao.validateLogin(userName, password);

        return loginStatus;
    }
}
