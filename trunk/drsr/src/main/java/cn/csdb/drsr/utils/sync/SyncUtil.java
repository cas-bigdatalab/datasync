package cn.csdb.drsr.utils.sync;


import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.repository.mapper.DataSrcMapper;
import cn.csdb.drsr.repository.mapper.UserInfoMapper;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.service.LoginService;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import cn.csdb.drsr.utils.ftpUtils.FtpUtil;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.*;
import java.nio.charset.Charset;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                    endSb.append(" RENAME TABLE "+table+"_sync_bak to "+table+"; \n");
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
                    endSb.append(" RENAME TABLE "+sqlTableArray[i]+"_sync_bak to "+sqlTableArray[i]+"; \n");
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
           // String[] strArray={filePath.getPath()+File.separator+"syncStruct.sql", filePath.getPath()+File.separator+"syncData.sql"};
            FileInputStream in=new FileInputStream(new File(filePath.getPath()+File.separator+"syncStruct.sql"));
            FileInputStream in2=new FileInputStream(new File(filePath.getPath()+File.separator+"syncData.sql"));


            //获取登录人员信息 begin
            UserInformation userInformationt=new UserInformation();
            StringBuffer usersql = new StringBuffer("select * from user_information where SubjectCode=? ORDER BY ID DESC");
            List<Object> params = Lists.newArrayList();
            params.add(dataTask.getSubjectCode());
            List<UserInformation> userInformationList= jdbcTemplate.query(usersql.toString(), params.toArray(), new UserInfoMapper());
            userInformationt=userInformationList.get(0);
            //获取登录人员信息 end


            Map<String ,InputStream > fileMap=new HashMap<>();
            fileMap.put("syncStruct.sql",in);
            fileMap.put("syncData.sql",in2);
            boolean test = FtpUtil.uploadFile(userInformationt.getDbHost(), userInformationt.getFtpUser(), userInformationt.getFtpPassword(), 21, "/temp/", fileMap);
         //   scpUtils.scpUpload(strArray,dataTask.getDataTaskId(),dataTask.getSubjectCode());




            pw.println("###########SQL数据表结构:###########\n" + sqlSb.toString() + "\n");
            pw.println("###########SQL数据内容:###########\n" + dataSb.toString() + "\n");
            pw.println("###########数据库脚本:###########\n" +endSb.toString()+ "\n");


            logger.info("=========================开始同步==========================\n");
            pw.println(current+":"+"=========================开始执行脚本========================" + "\n");
            String syncResult=callRemoteSyncMethod("/home/vftpuser/ftpUser"+dataTask.getSubjectCode()+"/temp",dataTask.getSubjectCode());

            if("1".equals(syncResult)){
                pw.println(current+":"+"=========================同步流程结束========================" + "\n");
                jsonObject.put("result", "success");
            }else{
                pw.println(current+":"+"=========================同步流程失败========================" + "\n");
                jsonObject.put("result", "false");

            }
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


    public String callRemoteSyncMethod(String syncFilePath,String subjectCode){
        HttpClient httpClient = null;
        HttpPost postMethod = null;
        HttpResponse response = null;
        String reponseContent="";
        JSONObject requestJSON = new JSONObject();
        httpClient = HttpClients.createDefault();
        requestJSON.put("syncFilePath",syncFilePath);
        requestJSON.put("subjectCode",subjectCode);
        String requestString = JSONObject.toJSONString(requestJSON);
        String portalUrl="10.0.86.77";
//                    postMethod = new HttpPost("http://localhost:8080/portal/service/getDataTask");
        postMethod = new HttpPost("http://"+portalUrl+"/service/syncDataTask");
//                    postMethod = new HttpPost(portalUrl);
        postMethod.addHeader("Content-type", "application/json; charset=utf-8");
//                    postMethod.addHeader("X-Authorization", "AAAA");//设置请求头
        postMethod.setEntity(new StringEntity(requestString, Charset.forName("UTF-8")));
        try {
            response = httpClient.execute(postMethod);//获取响应
            int statusCode = response.getStatusLine().getStatusCode();
            System.out.println("HTTP Status Code:" + statusCode);
            if (statusCode != HttpStatus.SC_OK) {
                System.out.println("HTTP请求未成功！HTTP Status Code:" + response.getStatusLine());
            }
            HttpEntity httpEntity = response.getEntity();
            reponseContent = EntityUtils.toString(httpEntity);
            EntityUtils.consume(httpEntity);//释放资源
            System.out.println("响应内容：" + reponseContent);
        } catch (IOException e) {
            e.printStackTrace();
        }


        return reponseContent;
    }


}
