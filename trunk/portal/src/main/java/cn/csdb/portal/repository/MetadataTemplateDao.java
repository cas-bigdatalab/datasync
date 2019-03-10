package cn.csdb.portal.repository;

import cn.csdb.portal.model.MetadataTemplate;
import com.google.common.collect.Lists;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: metadata template dao
 * @author: xiajl
 * @create: 2019-03-08 14:08
 **/
@Repository
public class MetadataTemplateDao {
    @Resource
    private MongoTemplate mongoTemplate;

    //获取所有的扩展元数据字段信息
    public List<MetadataTemplate> getAll(){
        DBObject query = QueryBuilder.start().get();
        BasicQuery basicQuery = new BasicQuery(query);
        Sort.Order order = new Sort.Order(Sort.Direction.ASC, "sortOrder");
        List<Sort.Order> orders = Lists.newArrayList(order);
        basicQuery.with(new Sort(orders));
        List<MetadataTemplate> list = mongoTemplate.find(basicQuery, MetadataTemplate.class);
        return list;
    }
}
