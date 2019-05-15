package cn.csdb.portal.repository;

import cn.csdb.portal.model.SynchronizationTables;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;


@Repository
public class SynchronizationTablesDao {

    @Resource
    private MongoTemplate mongoTemplate;

    /**
     * @Description: 根据表名和subjectCode查询该表是否同步
     * @Param: [subjectCode, tableName]
     * @return: cn.csdb.portal.model.SynchronizationTables
     * @Author: zcy
     * @Date: 2019/5/15
     */
    public SynchronizationTables selectOneBySubjectCodeAndTableName(String subjectCode, String tableName) {
        SynchronizationTables synchronizationTables = mongoTemplate.findOne(new Query(Criteria.where("subjectCode").is(subjectCode).and("tableName").is(tableName)), SynchronizationTables.class);
        return synchronizationTables;
    }
}
