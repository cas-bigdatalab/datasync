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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.sql.Connection;
import java.util.List;

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

    @Value("#{prop['SqlFilePath']}")
    private String sqlFilePath;

    private Logger logger = LoggerFactory.getLogger(DataTaskService.class);

    @Transactional(readOnly = true)
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
            //20181008可能有多个表,用","连接: t_metastruct,t_conceptword
            String[] tables = tableName.split(",");

            String sqlString = dataTask.getSqlString();
            String sqlTableNameEn = dataTask.getSqlTableNameEn();
            StringBuilder sqlSb = new StringBuilder();
            StringBuilder dataSb = new StringBuilder();
            for (String table : tables) {
                if (StringUtils.isNotEmpty(table)) {
                    sqlSb.append(DDL2SQLUtils.generateDDLFromTable(connection, null, null, table));
                    dataSb.append(DDL2SQLUtils.generateInsertSqlFromTable(connection, null, null, table));
                    dataSb.append("\n");
                }
            }

            if (StringUtils.isNotEmpty(sqlString) && StringUtils.isNotEmpty(sqlTableNameEn)){
                sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection,sqlString,sqlTableNameEn));
                dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection,sqlString,sqlTableNameEn));
            }

            logger.info("\n\n=========================SQL数据表结构:========================\n" + sqlSb.toString() +"\n");
            logger.info("\n\n=========================SQL数据内容:==========================\n" + dataSb.toString() +"\n");

            File filePath = new File(sqlFilePath + File.separator + dataTask.getDataTaskId());
            if (!filePath.exists() || !filePath.isDirectory())
            {
                filePath.mkdirs();
            }
            DDL2SQLUtils.generateFile(filePath.getPath(),"struct.sql",sqlSb.toString());

            //导出表数据
            DDL2SQLUtils.generateFile(filePath.getPath(),"data.sql",dataSb.toString());

            //保存 sql文件路径到datatask表中的sqlfilePath路径中，用分号隔开
            String sqlFilePathStr = filePath.getPath() +File.separator + "struct.sql;"+  filePath.getPath() +File.separator + "data.sql" ;
            dataTask.setSqlFilePath(sqlFilePathStr);
            boolean result = dataTaskDao.update(dataTask);
            logger.info("result="+ result) ;
            jsonObject.put("result","true");
        }
        catch (Exception ex){
            jsonObject.put("result","false");
        }
        return jsonObject;
    }

    @Transactional
    public boolean update(DataTask dataTask){
        return dataTaskDao.update(dataTask);
    }

    @Transactional(readOnly = true)
    public List<DataTask> getAllData(){
        return dataTaskDao.getAll();
    }

    public List<DataTask> getDatataskByPage(int start, int pageSize,String datataskType,String status){
        return dataTaskDao.getDatataskByPage(start,pageSize,datataskType,status);
    }

    public int deleteDatataskById(int datataskId) {
        return dataTaskDao.deleteDatataskById(datataskId);
    }

    public boolean insertDatatask(DataTask datatask) {
        return dataTaskDao.insertDatatask(datatask);
    }
}
