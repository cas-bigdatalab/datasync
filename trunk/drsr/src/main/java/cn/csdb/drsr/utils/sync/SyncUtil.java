package cn.csdb.drsr.utils.sync;


import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.mapper.DataSrcMapper;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.service.LoginService;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SyncUtil {

    private Logger logger = LoggerFactory.getLogger(DataTaskService.class);
    public ScpUtils scpUtils=new ScpUtils();

    public JSONObject executeTask(DataTask dataTask,JdbcTemplate jdbcTemplate) {
        String fileName ="Sync"+dataTask.getDataTaskName()+"log.txt";//文件名及类型
        String path = "/logs/";
        FileWriter fw = null;
        File file = new File(path, fileName);
        if(!file.exists()){
            try {
                file.createNewFile();
                fw = new FileWriter(file, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            try {
                file.delete();
                file.createNewFile();
                fw = new FileWriter(file, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================任务"+dataTask.getDataTaskName()+"同步流程开始========================");
        JSONObject jsonObject = new JSONObject();
        Connection connection=null;
        Connection portalConnection=null;
        try {
            //dataTaskDao.insertLogPath(dataTask.getDataTaskId(),"true");
        /*
            logger.info("=========================导出流程开始========================" + "\n");
        */
            String sql = "select * from t_datasource where DataSourceId=?";
            DataSrc dataSrc = jdbcTemplate.queryForObject(sql, new Object[]{dataTask.getDataSourceId()}, new int[]{Types.INTEGER}, new DataSrcMapper());
//            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
             connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
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
            StringBuffer  endSb=new StringBuffer();

            for (String table : tables) {
                if (StringUtils.isNotEmpty(table)) {
                    endSb.append(" DROP TABLE  IF EXISTS "+table+"; \n");
                    endSb.append(" RENAME TABLE "+table+"_bak to "+table+"; \n");
                    sqlSb.append(SYNCSQLUtils.generateDDLFromTable(connection, null, null, table));
                    dataSb.append(SYNCSQLUtils.generateInsertSqlFromTable(connection, null, null, table));
                    dataSb.append("\n");
                }
            }

            String[] sqlArray = sqlString.split(";");
            String[] sqlTableArray = sqlTableNameEn.split(";");
            for (int i=0;i<sqlArray.length;i++){
                if (StringUtils.isNotEmpty(sqlArray[i]) && StringUtils.isNotEmpty(sqlTableArray[i])) {
                    endSb.append(" DROP TABLE  IF EXISTS "+sqlTableArray[i]+"; \n");
                    endSb.append(" RENAME TABLE "+sqlTableArray[i]+"_bak to "+sqlTableArray[i]+"; \n");
                    sqlSb.append(SYNCSQLUtils.generateDDLFromSql(connection, sqlArray[i], sqlTableArray[i]));
                    dataSb.append(SYNCSQLUtils.generateInsertSqlFromSQL(connection, sqlArray[i], sqlTableArray[i]));
                }
            }

            StringBuffer allSql=new StringBuffer();
//            allSql.append(sqlSb);
            allSql.append(dataSb);
            allSql.append(endSb);

            //创建sql文件
            File sqlFilePath  = new File(System.getProperty("drsr.framework.root")+"syncSql");
            if(!sqlFilePath.exists()){
                sqlFilePath.mkdirs();
            }
            File filePath = new File(sqlFilePath + File.separator + dataTask.getDataTaskId());

            if (!filePath.exists() || !filePath.isDirectory()) {
                filePath.mkdirs();
            }

            SYNCSQLUtils.generateFile(filePath.getPath(), "syncData.sql", allSql.toString());
            SYNCSQLUtils.generateFile(filePath.getPath(), "syncStruct.sql", sqlSb.toString());
            String[] strArray={filePath.getPath()+File.separator+"syncStruct.sql", filePath.getPath()+File.separator+"syncData.sql"};
            scpUtils.scpUpload(strArray,dataTask.getDataTaskId(),dataTask.getSubjectCode());








            //if (StringUtils.isNotEmpty(sqlString) && StringUtils.isNotEmpty(sqlTableNameEn)) {
            //    sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection, sqlString, sqlTableNameEn));
            //    dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection, sqlString, sqlTableNameEn));
            //}
            pw.println("###########SQL数据表结构:###########\n" + sqlSb.toString() + "\n");
            pw.println("###########SQL数据内容:###########\n" + dataSb.toString() + "\n");
            pw.println("###########数据库脚本:###########\n" +endSb.toString()+ "\n");
//            logger.info("=========================SQL数据表结构:========================\n" + sqlSb.toString() + "\n");
//            logger.info("=========================SQL数据内容:==========================\n" + dataSb.toString() + "\n");
//            logger.info("=========================SQL数据内容:==========================\n" + endSb.toString() + "\n");
            logger.info("=========================开始同步==========================\n");
            pw.println(current+":"+"=========================开始执行脚本========================" + "\n");

//            String configFilePath = LoginService.class.getClassLoader().getResource("drsr.properties").getFile();
//            String portalUrl = ConfigUtil.getConfigItem(configFilePath, "PortalUrl");
//            String port = ConfigUtil.getConfigItem(configFilePath, "port");
//            String userName = ConfigUtil.getConfigItem(configFilePath, "userName");
//            String password = ConfigUtil.getConfigItem(configFilePath, "password");
//            IDataSource portalDataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
//            portalConnection = portalDataSource.getConnection(portalUrl.replaceAll("/",""), port,
//                    userName, password, dataTask.getSubjectCode());
//            Statement stmt=portalConnection.createStatement();
//            System.out.println(allSql+"");
//           boolean result=stmt.execute(allSql+"");
//            jsonObject.put("result","success");
            pw.println(current+":"+"=========================同步流程结束========================" + "\n");
            logger.info("=========================同步流程结束========================" + "\n");

        } catch (Exception ex) {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            current = dateFormat.format(now);
            jsonObject.put("result", "false");
            logger.error(current+":"+"导出失败，result = false" + "\n");
            pw.println(current+":"+"=========================同步流程失败,开始执行回滚操作========================" + "\n");
            pw.println(current+":"+"失败原因"+ex + "\n");
//            try {
//                //portalConnection.rollback();//如果两句sql语句中只要有一个语句出错，则回滚，都不执行
//                pw.println(current+":"+"=========================回滚操作成功========================" + "\n");
//            } catch (SQLException e1) {
//                pw.println(current+":"+"=========================回滚操作失败========================" + "\n");
//                // TODO Auto-generated catch block
//                e1.printStackTrace();
//            }
            logger.info("=========================同步流程结束========================" + "\n");
        }finally {
            try {
                fw.flush();
                pw.close();
                fw.close();
                connection.close();
              //  portalConnection.close();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                System.out.println("连接关闭失败！");
                e.printStackTrace();
            }
        }
        return jsonObject;
    }

    /**
     * 以行为单位读取文件，常用于读面向行的格式化文件
     */
    private String readFileByLines(String filePath) throws Exception {
        StringBuffer str = new StringBuffer();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(
                    new FileInputStream(filePath), "UTF-8"));
            String tempString = null;
            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                // 显示行号
                // System.out.println("line " + line + ": " + tempString);

                str = str.append(" " + tempString);
                line++;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }

        return str.toString();
    }

}
