package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Connection;

/**
 * @program: DataSync
 * @description:  DataTask Service
 * @author: xiajl
 * @create: 2018-09-30 16:29
 **/

@Service
public class DataTaskService {
    @Resource
    private DataTaskDao dataTaskDao;

    @Resource
    private DataSrcDao dataSrcDao;

    public DataTask get(int dataTaskId){
        return dataTaskDao.get(dataTaskId);
    }

    public JSONObject executeTask(DataTask dataTask){
        JSONObject jsonObject = new JSONObject();
        try
        {
            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
            Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
                    dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());

            //导出表结构
            String tableName = dataTask.getTableName();
            String sqlString = dataTask.getSqlString();
            String sqlTableNameEn = dataTask.getSqlTableNameEn();
            StringBuilder sqlSb = new StringBuilder();
            StringBuilder dataSb = new StringBuilder();
            if (StringUtils.isNotEmpty(tableName))
            {
                sqlSb.append(DDL2SQLUtils.generateDDLFromTable(connection,null,null,tableName));
                dataSb.append(DDL2SQLUtils.generateInsertSqlFromTable(connection,null,null,tableName));
                dataSb.append("\n");
            }
            if (StringUtils.isNotEmpty(sqlString) && StringUtils.isNotEmpty(sqlTableNameEn)){
                sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection,sqlString,sqlTableNameEn));
                dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection,sqlString,sqlTableNameEn));
            }
            DDL2SQLUtils.generateFile("D:/data","struct.sql",sqlSb.toString());

            //导出表数据
            DDL2SQLUtils.generateFile("D:/data","data.sql",dataSb.toString());
            jsonObject.put("result","true");
        }
        catch (Exception ex){
            jsonObject.put("result","false");
        }
        return jsonObject;
    }
}
