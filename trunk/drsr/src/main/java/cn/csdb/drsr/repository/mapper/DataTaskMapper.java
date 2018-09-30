package cn.csdb.drsr.repository.mapper;

import cn.csdb.drsr.model.DataTask;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by xiajl on 2018/9/30 .
 */
public class DataTaskMapper implements RowMapper {

    @Override
    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        DataTask dataTask = new DataTask();
        dataTask.setDataTaskId(resultSet.getInt("DataTaskId"));
        dataTask.setDataSourceId(resultSet.getInt("DataSourceId"));
        dataTask.setTableName(resultSet.getString("TableName"));
        dataTask.setSqlString(resultSet.getString("SqlString"));
        dataTask.setSqlTableNameEn(resultSet.getString("SqlTableNameEn"));
        dataTask.setFilePath(resultSet.getString("FileName"));
        dataTask.setCreator(resultSet.getString("Creator"));
        dataTask.setCreateTime(resultSet.getTimestamp("CreateTime"));
        dataTask.setStatus(resultSet.getString("Status"));
        return dataTask;
    }
}
