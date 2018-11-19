package cn.csdb.portal.repository;

import cn.csdb.portal.model.User;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import com.mongodb.WriteResult;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

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

        QueryBuilder queryBuilder = null;

        if (loginId != null && userName != null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId != null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId != null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId == null && userName != null && groups != null)
        {

            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));;
        }
        else if (loginId != null && userName == null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$"));
        }
        else if (loginId == null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId == null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else
        {
            queryBuilder = QueryBuilder.start();
        }

        dbObject = queryBuilder.get();
        Query query = new BasicQuery(dbObject).skip(start).limit(pageSize);

        //排序
        Sort.Direction direction = false ? Sort.Direction.ASC : Sort.Direction.DESC;
        //query.with(new Sort(direction, "_id"));
        query.with(new Sort(direction, "createTime"));

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
            dbObject = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$")).get();
        }
        else if (loginId != null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).get();
        }
        else if (loginId != null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$")).get();
        }
        else if (loginId == null && userName != null && groups != null)
        {
            dbObject = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$")).get();
        }
        else if (loginId != null && userName == null && groups == null)
        {
            dbObject = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).get();
        }
        else if (loginId == null && userName != null && groups == null)
        {
            dbObject = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).get();
        }
        else if (loginId == null && userName == null && groups != null)
        {
            dbObject = QueryBuilder.start().and("groups").regex(Pattern.compile("^.*" + groups + ".*$")).get();
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

    /**
     * Function Description: 根据用户组名称获取此组中的所有用户
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/17 12:09
     */
    public List<User> queryByGroupName(String groupName){
        QueryBuilder queryBuilder = QueryBuilder.start();

        if (StringUtils.isNotEmpty(groupName)){
            queryBuilder = queryBuilder.and("groups").regex(Pattern.compile("^.*"+groupName+".*$"));;
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        List<User> list = mongoTemplate.find(basicQuery,User.class);
        return list;
    }


    public long queryLoginId(String loginId)
    {
        DBObject dbObject = QueryBuilder.start().and("loginId").is(loginId).get();
        Query query = new BasicQuery(dbObject);
        long loginIdCnt = mongoTemplate.count(query, "t_user");

        return loginIdCnt;
    }
}
