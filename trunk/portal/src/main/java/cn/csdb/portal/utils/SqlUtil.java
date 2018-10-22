package cn.csdb.portal.utils;

import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-15 14:42
 **/
public class SqlUtil {
    public void importSqlByShell(String username,String password,String importDatabaseName, String structImportPath,String dataImportPath) throws IOException {
        Runtime runtime = Runtime.getRuntime();
        StringBuffer command = new StringBuffer().append("mysql -u").append(username);
        if (password!=null&&!password.equals("")) {
            command.append(" -p").append(password);
        }
        command.append(" "+importDatabaseName);
        command.append(" < "+structImportPath);
        Process process = runtime.exec(new String[]{"bash", "-c", command.toString()});
        try {
            process.waitFor();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        StringBuffer command2 = new StringBuffer().append("mysql -u").append(username);
        if (password!=null&&!password.equals("")) {
            command2.append(" -p").append(password);
        }
        command2.append(" "+importDatabaseName);
        command2.append(" < "+dataImportPath);
        process = runtime.exec(new String[]{"bash", "-c", command2.toString()});
    }


    public void importSql(String host,String username,String password,String importDatabaseName, String structImportPath,String dataImportPath)  throws Exception {
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://"+host+"/"+importDatabaseName;

        Exception error = null;
        Connection conn = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
            ScriptRunner runner = new ScriptRunner(conn);
            //下面配置不要随意更改，否则会出现各种问题
            runner.setAutoCommit(true);//自动提交
            runner.setFullLineDelimiter(false);
            runner.setDelimiter(";");////每条命令间的分隔符
            runner.setSendFullScript(false);
            runner.setStopOnError(false);
            //	runner.setLogWriter(null);//设置是否输出日志
            //如果又多个sql文件，可以写多个runner.runScript(xxx),
            runner.runScript(new InputStreamReader(new FileInputStream(structImportPath), "utf-8"));
            runner.runScript(new InputStreamReader(new FileInputStream(dataImportPath), "utf-8"));
            close(conn);
        } catch (Exception e) {
            error = e;
        } finally {
            close(conn);
        }
        if (error != null) {
            throw error;
        }
    }

    private static void close(Connection conn){
        try {
            if(conn != null){
                conn.close();
            }
        } catch (Exception e) {
            if(conn != null){
                conn = null;
            }
        }
    }

}
