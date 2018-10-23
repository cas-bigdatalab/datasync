package cn.csdb.drsr.repository;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.mapper.DataTaskMapper;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: dataTask dao
 * @author: xiajl
 * @create: 2018-09-30 16:18
 **/

@Repository
public class DataTaskDao {
    @Resource
    private JdbcTemplate jdbcTemplate;

    public DataTask get(int id){
        String sql="select * from t_datatask where dataTaskId = ?" ;
        List<DataTask> list = jdbcTemplate.query(sql,new Object[]{id}, new DataTaskMapper()) ;
        return  list.size() > 0 ? list.get(0) : null;
    }

    //更新
    public boolean update(DataTask dataTask){
        boolean result = false;
        String sql="update T_dataTask set DataSourceId=?,DataTaskType=?,TableName=?,SqlString=?,SqlTableNameEn=?,SqlFilePath=?,FilePath=?,creator=?,status=? where DataTaskId=? ";
        int i= jdbcTemplate.update(sql,new Object[]{dataTask.getDataSourceId(),dataTask.getDataTaskType(),dataTask.getTableName(),dataTask.getSqlString(),
                dataTask.getSqlTableNameEn(),dataTask.getSqlFilePath(),dataTask.getFilePath(),dataTask.getCreator(),dataTask.getStatus(),dataTask.getDataTaskId()});
        if (i >= 0 ){
            result = true;
        }
        return result;
    }

    //获取所有的任务信息
    public List<DataTask> getAll(){
        String sql="Select * from T_dataTask";
        return jdbcTemplate.query(sql,new DataTaskMapper());
    }

    /**
     *
     * Function Description: 数据任务展示、查找列表
     *
     * @param: [start, pageSize, datataskType, status]
     * @return: java.util.List<cn.csdb.drsr.model.DataTask>
     * @auther: hw
     * @date: 2018/10/23 15:46
     */
    public List<DataTask> getDatataskByPage(int start, int pageSize,String datataskType,String status){
        StringBuilder sb = new StringBuilder();
        sb.append("select * from t_datatask where ");
        List<Object> params = getSql(datataskType, status, sb);
        sb.append(" order by resourceId desc limit ?,? ");
        params.add(start);
        params.add(pageSize);
        return jdbcTemplate.query(sb.toString(), params.toArray(), new DataTaskMapper());
    }

    /**
     *
     * Function Description: sql语句组织
     *
     * @param: [datataskType, status, sb]
     * @return: java.util.List<java.lang.Object>
     * @auther: hw
     * @date: 2018/10/23 15:46
     */
    List<Object> getSql(String datataskType,String status, StringBuilder sb) {
        List<Object> params = Lists.newArrayList();
        if (StringUtils.isNoneBlank(datataskType)) {
            sb.append(" and datataskType=? ");
            params.add(datataskType);
        }
        if (StringUtils.isNoneBlank(status)) {
            sb.append(" and status=? ");
            params.add(status);
        }
        return params;
    }
}
