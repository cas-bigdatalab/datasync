package cn.csdb.portal.service;

import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.CheckUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiba on 2018/11/6.
 */
@Service
public class CheckUserService {
    @Autowired
    private CheckUserDao userDao;

    public User getByUserName(String username) {
        return userDao.getByUserName(username);
    }

    /*public Set<String> getRoles(String username) {
        return userDao.getRoles(username);
    }*/

    /*public Set<String> getPermissions(String username) {
        return userDao.getPermissions(username);
    }*/
}
