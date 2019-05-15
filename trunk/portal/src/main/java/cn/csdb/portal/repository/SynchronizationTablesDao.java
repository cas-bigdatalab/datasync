package cn.csdb.portal.repository;

import cn.csdb.portal.common.SynchronizeTable;
import cn.csdb.portal.model.SynchronizationTable;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;


@Repository
public class SynchronizationTablesDao {

    @Resource
    private MongoTemplate mongoTemplate;

    public void save(SynchronizeTable synchronizeTable) {
        mongoTemplate.save(synchronizeTable);
    }

    public List<SynchronizationTable> selectAll() {
        List<SynchronizationTable> all = mongoTemplate.findAll(SynchronizationTable.class);
        return all;
    }

    /**
     * @Description: 根据表名和subjectCode查询该表是否同步
     * @Param: [subjectCode, tableName]
     * @return: cn.csdb.portal.model.SynchronizationTables
     * @Author: zcy
     * @Date: 2019/5/15
     */
    public SynchronizationTable selectOneBySubjectCodeAndTableName(String subjectCode, String tableName) {
        SynchronizationTable synchronizationTables = mongoTemplate.findOne(new Query(Criteria.where("subjectCode").is(subjectCode).and("tableName").is(tableName)), SynchronizationTable.class);
        return synchronizationTables;
    }
}
