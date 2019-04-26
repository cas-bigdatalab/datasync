package cn.csdb.portal.repository;

import cn.csdb.portal.model.MetaTemplate;
import com.google.common.collect.Lists;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.swing.*;
import java.util.List;

/**
 * @program: DataExplore
 * @description: meta template dao
 * @author: xiajl
 * @create: 2019-04-24 09:54
 **/
@Repository
public class MetaTemplateDao {
    @Resource
    private MongoTemplate mongoTemplate;

    /**
     * 增加保存元数据模板
     * @param metaTemplate
     */
    public void add(MetaTemplate metaTemplate){
        mongoTemplate.save(metaTemplate);
    }

    public MetaTemplate get(String id){
        return mongoTemplate.findById(id,MetaTemplate.class);
    }

    public void deleteById(String id){
        mongoTemplate.remove(new Query(Criteria.where("id").is(id)),MetaTemplate.class);
    }

    /**
     * 通过元数据板模名称获取内容信息
     * @param name:元数据模板书名称
     * @return: 元数据模板实体信息
     */
    public MetaTemplate findByName(String name){
        DBObject query = QueryBuilder.start().and("name").is(name).get();
        BasicQuery basicQuery = new BasicQuery(query);
        List<MetaTemplate> list = mongoTemplate.find(basicQuery,MetaTemplate.class);
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return null;
        }
    }

    /**
     * 获取指定subjectCode中所有的元数据模板信息内容
     * @param subjectCode：节点代码
     * @return
     */
    public List<MetaTemplate> getList(String subjectCode){
        DBObject query = QueryBuilder.start().and("subjectCode").is(subjectCode).get();
        BasicQuery basicQuery = new BasicQuery(query);
        Sort.Order order = new Sort.Order(Sort.Direction.DESC,"metaTemplateCreateDate");
        List<Sort.Order> orders = Lists.newArrayList(order);
        basicQuery.with(new Sort(orders));
        List<MetaTemplate> list = mongoTemplate.find(basicQuery,MetaTemplate.class);
        return list;
    }

    /**
     * 获取所有的元数据模板信息内容
     * ：节点代码
     * @return
     */
    public List<MetaTemplate> getAllList(){
        List<MetaTemplate> list=mongoTemplate.findAll(MetaTemplate.class);
        return list;
    }

}
