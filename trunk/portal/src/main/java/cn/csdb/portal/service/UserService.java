package cn.csdb.portal.service;

import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.UserDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;

@Service
public class UserService {
    @Resource
    UserDao userDao;

    @Transactional
    public int addUser(User user)
    {
        int addedUserCnt = userDao.addUser(user);

        return addedUserCnt;
    }

    public List<User> queryUser(String loginId, String userName, String groups, int curUserPageNum, int pageSize)
    {

        return userDao.queryUser(loginId, userName, groups, curUserPageNum, pageSize);
    }

    public long getTotalUsers(String loginId, String userName, String groups)
    {
        return userDao.getTotalUsers(loginId, userName, groups);
    }

    @Transactional
    public int updateGroups(String loginId, String group) {
        return userDao.updateGroups(loginId, group);
    }

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
