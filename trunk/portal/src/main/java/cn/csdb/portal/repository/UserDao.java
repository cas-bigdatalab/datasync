package cn.csdb.portal.repository;

import cn.csdb.portal.model.User;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import com.mongodb.WriteResult;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserDao {
    @Resource
    MongoTemplate mongoTemplate;

    public int addUser(User user)
    {
        int addedUserCnt = 1;
        mongoTemplate.insert(user);

        return addedUserCnt;
    }

    public List<User> queryUser(String loginId, String userName, String groups, int curUserPageNum, int pageSize)
    {
        long totalUsers =  0;
        totalUsers = getTotalUsers(loginId, userName, groups);
        long totalUserPages = 0;
        totalUserPages = totalUsers / pageSize + (totalUsers % pageSize == 0 ? 0 : 1);
        int start = 0;
        start = (curUserPageNum - 1) * pageSize;

        DBObject dbObject = null;

        if (loginId.trim().equals(""))
        {
            loginId = null;
        }
        if (userName.trim().equals(""))
        {
            userName = null;
        }
        if (groups.trim().equals(""))
        {
            groups = null;
        }

        if (loginId != null && userName != null && groups != null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).and("groups").is(groups).get();
        }
        else if (loginId != null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).get();
        }
        else if (loginId != null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("groups").is(groups).get();
        }
        else if (loginId == null && userName != null && groups != null)
        {
            dbObject = QueryBuilder.start().and("userName").is(userName).and("groups").is(groups).get();
        }
        else if (loginId != null && userName == null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).get();
        }
        else if (loginId == null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("userName").is(userName).get();
        }
        else if (loginId == null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("groups").is(groups).get();
        }
        else
        {
            dbObject = QueryBuilder.start().get();
        }

        Query query = new BasicQuery(dbObject).skip(start).limit(pageSize);
        List<User> users = mongoTemplate.find(query, User.class);

        return users;
    }

    public long getTotalUsers(String loginId, String userName, String groups)
    {
/*
        DBObject dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).and("groups").exists(groups).get();
*/
        DBObject dbObject = null;

        if (loginId.trim().equals(""))
        {
            loginId = null;
        }
        if (userName.trim().equals(""))
        {
            userName = null;
        }
        if (groups.trim().equals(""))
        {
            groups = null;
        }

        if (loginId != null && userName != null && groups != null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).and("groups").is(groups).get();
        }
        else if (loginId != null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).get();
        }
        else if (loginId != null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).and("groups").is(groups).get();
        }
        else if (loginId == null && userName != null && groups != null)
        {
            dbObject = QueryBuilder.start().and("userName").is(userName).and("groups").is(groups).get();
        }
        else if (loginId != null && userName == null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").is(loginId).get();
        }
        else if (loginId == null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("userName").is(userName).get();
        }
        else if (loginId == null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("groups").is(groups).get();
        }
        else
        {
            dbObject = QueryBuilder.start().get();
        }

        Query query = new BasicQuery(dbObject);
        long totalUsers = mongoTemplate.count(query, "t_user");
        return totalUsers;
    }

    public int updateGroups(String loginId, String group) {
        int updatedUserCnt = 1;

        Query query = new Query();
        query.addCriteria(Criteria.where("loginId").is(loginId));
        Update update = Update.update("group", group);
        mongoTemplate.upsert(query, update, "t_user");

        return updatedUserCnt;
    }

    public int deleteUser(String id)
    {
        int deletedUserCnt = 0;
        DBObject dbObject = QueryBuilder.start().and("_id").is(id).get();
        Query query = new BasicQuery(dbObject);
        WriteResult writeResult = mongoTemplate.remove(query, "t_user");
        deletedUserCnt = writeResult.getN();

        return deletedUserCnt;
    }

    public User getUserById(String id)
    {
        DBObject dbObject = QueryBuilder.start().and("_id").is(id).get();
        Query query = new BasicQuery(dbObject);
        User user = mongoTemplate.findOne(query, User.class);

        return user;
    }

    public int updateUser(User user)
    {
        int updatedUserCnt = 1;
        mongoTemplate.save(user);

        return updatedUserCnt;
    }

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

    public long queryLoginId(String loginId)
    {
        DBObject dbObject = QueryBuilder.start().and("loginId").is(loginId).get();
        Query query = new BasicQuery(dbObject);
        long loginIdCnt = mongoTemplate.count(query, "t_user");

        return loginIdCnt;
    }
}
