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

    public long getTotalUsers()
    {
        return userDao.getTotalUsers();
    }

    @Transactional
    public int updateGroups(String loginId, String group)
    {
        return userDao.updateGroups(loginId, group);
    }
}
