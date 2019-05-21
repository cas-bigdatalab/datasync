package cn.csdb.drsr.service;

import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.repository.UserInfoDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service
public class UserInfoService {
    @Resource
    private UserInfoDao userInfoDao;
    public UserInformation getUserInfoByCode(String subjectCode){
        return  userInfoDao.getUserInfoByCode(subjectCode);
    }

    public int saveUserinfo(UserInformation userInformation){
        return  userInfoDao.saveUserinfo(userInformation);

    }
}
