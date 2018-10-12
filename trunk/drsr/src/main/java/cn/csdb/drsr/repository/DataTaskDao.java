package cn.csdb.drsr.repository;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.mapper.DataTaskMapper;
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
}
