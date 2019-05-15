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
     * @Description: 根据subject查询同步表名
     * @Param: [subjectCode]
     * @return: java.util.List<cn.csdb.portal.model.SynchronizationTables>
     * @Author: zcy
     * @Date: 2019/5/13
     */
    public SynchronizationTables getListSync(String subjectCode, String tableName) {
        SynchronizationTables synchronizationTables = mongoTemplate.findOne(new Query(Criteria.where("subjectCode").is(subjectCode).and("tableName").is(tableName)), SynchronizationTables.class);
        return synchronizationTables;
    }
}
