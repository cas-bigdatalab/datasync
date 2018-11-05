package cn.csdb.portal.service;

import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.UserDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: user service java
 * @author: xiajl
 * @create: 2018-11-05 15:15
 **/
@Service
public class UserService {
    @Resource
    private UserDao userDao;

    /**
     * Function Description: 获取所有的用户
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date:   2018/11/5 15:16
     */
    @Transactional(readOnly = true)
    public List<User> getAll(){
        return userDao.getAll();
    }
}
