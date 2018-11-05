package cn.csdb.portal.repository;

import cn.csdb.portal.model.User;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: user dao
 * @author: xiajl
 * @create: 2018-11-05 15:13
 **/
@Repository
public class UserDao {
    @Resource
    private MongoTemplate mongoTemplate;

    /**
     * Function Description: 获取所有的用户
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/5 15:14
     */
    public List<User> getAll(){
        return mongoTemplate.findAll(User.class);
    }
}
