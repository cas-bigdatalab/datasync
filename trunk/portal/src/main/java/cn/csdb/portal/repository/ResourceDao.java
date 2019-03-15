package cn.csdb.portal.repository;

import cn.csdb.portal.model.FileInfo;
import cn.csdb.portal.model.ResourceDelete;
import cn.csdb.portal.model.Subject;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
//import cn.csdb.portal.model.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;


/**
 * @program: DataSync
 * @description: Resource Dao 资源操作类
 * @author: xiajl
 * @create: 2018-10-23 14:21
 **/
@Repository
public class ResourceDao {
    @javax.annotation.Resource
    private MongoTemplate mongoTemplate;

    /**
     * Function Description: 保存资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date:   2018/10/23 14:34
     */
    public String save(cn.csdb.portal.model.Resource resource){
        mongoTemplate.save(resource);
        return resource.getId();
    }

    public void saveFileInfo(cn.csdb.portal.model.FileInfo fileInfo){
        mongoTemplate.save(fileInfo);
    }

    public void saveDeleteId(String id){
        ResourceDelete resourceDelete = new ResourceDelete();
        resourceDelete.setResourceId(id);
        mongoTemplate.save(resourceDelete);
    }
    /**
     * Function Description: 删除记录
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date:   2018/10/23 14:44
     */
    public void delete(String id){
        DBObject query = QueryBuilder.start().and("_id").is(id).get();
        BasicQuery basicQuery = new BasicQuery(query);
        mongoTemplate.remove(basicQuery, cn.csdb.portal.model.Resource.class);
    }

    public void delete(cn.csdb.portal.model.Resource resource){
        mongoTemplate.remove(resource);
    }

    public void deleteFileInfo(String id){
        List<FileInfo> fileInfos= mongoTemplate.find(new Query(Criteria.where("resourceId").is(id)),FileInfo.class);
        for(FileInfo fileInfo:fileInfos){
            mongoTemplate.remove(fileInfo);
        }
    }

    /**
     * Function Description: 分页查询获取资源List
     *
     * @param:  subjectCode:专题库代码, title:资源名称, status:状态, pageNo:页数, pageSize:第页记录条数
     * @return: 资源List列表
     * @auther: Administrator
     * @date:   2018/10/23 16:11
     */
    public List<cn.csdb.portal.model.Resource> getListByPage(String subjectCode, String title, String publicType, String resState, int pageNo, int pageSize){
        QueryBuilder queryBuilder = QueryBuilder.start();
        if(StringUtils.isNotEmpty(subjectCode)){
            queryBuilder = queryBuilder.and("subjectCode").is(subjectCode);
        }
        if (StringUtils.isNotEmpty(title)){
            queryBuilder = queryBuilder.and("title").regex(Pattern.compile("^.*"+title+".*$"));
        }
        if (StringUtils.isNotEmpty(publicType)){
            queryBuilder =queryBuilder.and("publicType").is(publicType);
        }
        if (StringUtils.isNotEmpty(resState)){
            queryBuilder =queryBuilder.and("status").is(resState);
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        Sort.Order so = new Sort.Order(Sort.Direction.DESC, "creationDate");
        List<Sort.Order> sos = new ArrayList<>();
        sos.add(so);
        basicQuery.with(new Sort(sos));
        basicQuery.skip((pageNo-1)*pageSize );
        basicQuery.limit(pageSize);
        return mongoTemplate.find(basicQuery, cn.csdb.portal.model.Resource.class);
    }


    public long countByPage(String subjectCode, String title, String publicType, String resState){
        QueryBuilder queryBuilder = QueryBuilder.start();
        if(StringUtils.isNotEmpty(subjectCode)){
            queryBuilder = queryBuilder.and("subjectCode").is(subjectCode);
        }
        if (StringUtils.isNotEmpty(title)){
            queryBuilder = queryBuilder.and("title").regex(Pattern.compile("^.*"+title+".*$"));
        }
        if (StringUtils.isNotEmpty(publicType)){
            queryBuilder =queryBuilder.and("publicType").is(publicType);
        }
        if (StringUtils.isNotEmpty(resState)){
            queryBuilder =queryBuilder.and("status").is(resState);
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        return mongoTemplate.count(basicQuery,cn.csdb.portal.model.Resource.class);
    }

    public cn.csdb.portal.model.Resource getById(String resourceId){
        return mongoTemplate.findById(resourceId, cn.csdb.portal.model.Resource.class);
    }


//    根据subjectCode查询
    public long getBySubject(String subjectCode){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query(Criteria.where("subjectCode").is(subjectCode)),cn.csdb.portal.model.Resource.class);
//        Aggregation aggregation=Aggregation.newAggregation(Aggregation.match(Criteria.where("subjectCode").is(subjectCode)),
//                                Aggregation.group("subjectCode").sum("vCount").as("visitCount"));
//        AggregationResults<cn.csdb.portal.model.Resource> result=
//                                    mongoTemplate.aggregate(aggregation,"resource",cn.csdb.portal.model.Resource.class);
//        List<cn.csdb.portal.model.Resource> list=result.getMappedResults();
        long l=0;
        if(list.size()>0){
            for(cn.csdb.portal.model.Resource r:list){
                l+=r.getvCount();
            }
        }
        return l;
    }


    public long getDownladCount(String subjectCode){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query(Criteria.where("subjectCode").is(subjectCode)),cn.csdb.portal.model.Resource.class);
        long l=0;
        if(list.size()>0){
            for(cn.csdb.portal.model.Resource r:list){
                l+=r.getdCount();
            }
        }
        return l;
    }

//    统计数据集访问量
    public List<cn.csdb.portal.model.Resource> getResourceVisit(){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query().with(new Sort(Sort.Direction.DESC,
                                                  "vCount")),cn.csdb.portal.model.Resource.class);

        return list;
    }

//    统计数据集下载量
    public List<cn.csdb.portal.model.Resource> getResourceDown(){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query().with(new Sort(Sort.Direction.DESC,
                "dCount")),cn.csdb.portal.model.Resource.class);

        return list;
    }

//根据专题统计该专题内访问量
    public List <cn.csdb.portal.model.Resource> getResouceVisitBySCode(String subjectCode){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query(Criteria.where("subjectCode").is(subjectCode)).with(new Sort(Sort.Direction.DESC,
                "vCount")),cn.csdb.portal.model.Resource.class);
        return list;
    }

    //根据专题统计该专题内访问量
    public List <cn.csdb.portal.model.Resource> getResouceDownBySCode(String subjectCode){
        List<cn.csdb.portal.model.Resource> list=mongoTemplate.find(new Query(Criteria.where("subjectCode").is(subjectCode)).with(new Sort(Sort.Direction.DESC,
                "dCount")),cn.csdb.portal.model.Resource.class);
        return list;
    }
}
