package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.utils.ZipUtils;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import com.google.common.io.Files;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * @program: DataSync
 * @description: DataTask Service
 * @author: xiajl
 * @create: 2018-09-30 16:29
 **/

@Service
public class DataTaskService {
    @Resource
    private DataTaskDao dataTaskDao;

    @Resource
    private DataSrcDao dataSrcDao;

//    @Value("#{prop['SqlFilePath']}")
//    private String sqlFilePath;

    private Logger logger = LoggerFactory.getLogger(DataTaskService.class);

    @Transactional(readOnly = true)
    public DataTask get(int dataTaskId) {
        return dataTaskDao.get(dataTaskId);
    }


    public JSONObject executeTask(DataTask dataTask) {
        JSONObject jsonObject = new JSONObject();
        try {
            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
            Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
                    dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());

            //导出表结构
            String tableName = dataTask.getTableName();
            //20181008可能有多个表,用","连接: t_metastruct,t_conceptword
            String[] tables = tableName.split(";");

            String sqlString = dataTask.getSqlString();
            if (StringUtils.isNoneBlank(sqlString)) {
                sqlString = sqlString.substring(0, sqlString.length() - 1);
            }
            String sqlTableNameEn = dataTask.getSqlTableNameEn();
            if (StringUtils.isNoneBlank(sqlTableNameEn)) {
                sqlTableNameEn = sqlTableNameEn.substring(0, sqlTableNameEn.length() - 1);
            }
            StringBuilder sqlSb = new StringBuilder();
            StringBuilder dataSb = new StringBuilder();
            for (String table : tables) {
                if (StringUtils.isNotEmpty(table)) {
                    sqlSb.append(DDL2SQLUtils.generateDDLFromTable(connection, null, null, table));
                    dataSb.append(DDL2SQLUtils.generateInsertSqlFromTable(connection, null, null, table));
                    dataSb.append("\n");
                }
            }

            if (StringUtils.isNotEmpty(sqlString) && StringUtils.isNotEmpty(sqlTableNameEn)) {
                sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection, sqlString, sqlTableNameEn));
                dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection, sqlString, sqlTableNameEn));
            }

            logger.info("\n\n=========================SQL数据表结构:========================\n" + sqlSb.toString() + "\n");
            logger.info("\n\n=========================SQL数据内容:==========================\n" + dataSb.toString() + "\n");

            File sqlFilePath  = new File(System.getProperty("drsr.framework.root")+"exportSql");
            if(!sqlFilePath.exists()){
                sqlFilePath.mkdirs();
            }
            File filePath = new File(sqlFilePath + File.separator + dataTask.getDataTaskId());

            if (!filePath.exists() || !filePath.isDirectory()) {
                filePath.mkdirs();
            }
            DDL2SQLUtils.generateFile(filePath.getPath(), "struct.sql", sqlSb.toString());

            //导出表数据
            DDL2SQLUtils.generateFile(filePath.getPath(), "data.sql", dataSb.toString());

            //保存 sql文件路径到datatask表中的sqlfilePath路径中，用分号隔开
            String sqlFilePathStr = filePath.getPath() + File.separator + "struct.sql;" + filePath.getPath() + File.separator + "data.sql";
            dataTask.setSqlFilePath(sqlFilePathStr);
            boolean result = dataTaskDao.update(dataTask);
            logger.info("result=" + result);
            jsonObject.put("result", "true");
            jsonObject.put("filePath", filePath.getPath());
        } catch (Exception ex) {
            jsonObject.put("result", "false");
        }
        return jsonObject;
    }

    @Transactional
    public boolean update(DataTask dataTask) {
        return dataTaskDao.update(dataTask);
    }

    @Transactional(readOnly = true)
    public List<DataTask> getAllData() {
        return dataTaskDao.getAll();
    }

    public List<DataTask> getDatataskByPage(int start, int pageSize, String datataskType, String status) {

        List<DataTask> dataTasks = dataTaskDao.getDatataskByPage(start, pageSize, datataskType, status);
        for (DataTask dataTask : dataTasks) {
            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            dataTask.setDataSrc(dataSrc);
        }
        return dataTasks;
    }

    public int getCount(String datataskType, String status) {
        return dataTaskDao.getCount(datataskType, status);
    }

    public int deleteDatataskById(int datataskId) {
        return dataTaskDao.deleteDatataskById(datataskId);
    }

    public int insertDatatask(DataTask datatask) {


        return dataTaskDao.insertDatatask(datatask);
    }

    public String packDataResource(final String fileName ,final List<String> filePaths) {
//        dbFlag.await();
//        String zipFilePath = "zipFile";
//        File dir  = new File(System.getProperty("drsr.framework.root") + zipFilePath );
//        if(!dir.exists()){
//            dir.mkdirs();
//        }
//        String zipFile = System.getProperty("drsr.framework.root") + zipFilePath + File.separator + fileName + ".zip";
        ZipArchiveOutputStream outputStream = null;
        try {
//            if (new File(dirName).exists()) {
//                new File(dirName).delete();
//            }
            Files.createParentDirs(new File(fileName));
            outputStream = new ZipArchiveOutputStream(new File(fileName));
            outputStream.setEncoding("utf-8"); //23412
            outputStream.setCreateUnicodeExtraFields(ZipArchiveOutputStream.UnicodeExtraFieldPolicy.ALWAYS);
            outputStream.setFallbackToUTF8(true);
            logger.info(".zip:文件数据源,开始打包文件...");
            for (String filePath : filePaths) {
                filePath = filePath.replace("%_%",File.separator);
                File file = new File(filePath);
                if (!file.exists()) {
                    continue;
                }
                ZipUtils.zipDirectory(file, "", outputStream);
            }
        } catch (Exception e) {
            logger.error("打包失败", e);
            return "error";
        } finally {
            try {
                outputStream.finish();
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "ok";
    }
}
