package cn.csdb.portal.repository;

import cn.csdb.portal.model.Subject;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: Subject Dao class
 * @author: xiajl
 * @create: 2018-10-22 15:54
 **/
@Repository
public class SubjectDao {
    @Resource
    private MongoTemplate mongoTemplate;

    /**
     * Function Description: 根据subjectCode查找对象
     *
     * @param:  subjectCode:专题库代码
     * @return: Sujbect对像
     * @auther: Administrator
     * @date:   2018/10/22 16:00
     */
    public Subject findBySubjectCode(String subjectCode){
        DBObject query = QueryBuilder.start().and("subjectCode").is(subjectCode).get();
        BasicQuery basicQuery = new BasicQuery(query);
        List<Subject> list = mongoTemplate.find(basicQuery,Subject.class);
        if(list.size() == 0){
            return null;
        }else{
            return list.get(0);
        }
    }


    public void save(Subject subject){
        mongoTemplate.save(subject);
    }
}
