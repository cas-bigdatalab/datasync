package cn.csdb.portal.utils.dataSrc;

import cn.csdb.portal.model.Subject;
import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
import org.springframework.context.annotation.Bean;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.sql.Connection;
/**
 * Created by shibaoping on 2019/6/13.
 * Druid连接池工具类
 */
public class DruidUtil {
    private static DruidUtil single = null;

    public static Map<String,DruidDataSource> map = new HashMap<>();

    public DruidUtil() {
    }

    /**
     * 获取实例 重启tomcat之后清空Druid连接池
     * @return
     */
    @Bean(initMethod = "init", destroyMethod = "destroy")
    public static DruidUtil getInstance(){
        if (single == null) {
            synchronized (DruidUtil.class) {
                if (single == null) {
                    single = new DruidUtil();
                }
            }
        }
        return single;
    }

    //获取连接
    public Connection getConnection(String id) throws SQLException {
        DruidDataSource source = map.get(id);
        return source.getConnection();
    }

    //新增连接池功能
    public void addDruidDataSource(String host, String port, String username, String password, String databaseName){
        Properties prop = new Properties();
        prop.setProperty("driverClassName","com.mysql.jdbc.Driver");
        prop.setProperty("validationQuery","SELECT 1 FROM DUAL");
        prop.setProperty("url","jdbc:mysql://"+host+":"+port+"/"+databaseName);
        prop.setProperty("connectionProperties","zeroDateTimeBehavior=convertToNull;Unicode=true;characterEncoding=UTF-8;UseSSL=false");
        prop.setProperty("username",username);
        prop.setProperty("password",password);
        prop.setProperty("initialSize","3");
        prop.setProperty("maxActive","10");
        prop.setProperty("minIdle","3");
        prop.setProperty("maxWait","10000");
        prop.setProperty("filters","stat");
        prop.setProperty("timeBetweenEvictionRunsMillis","60000");
        prop.setProperty("minEvictableIdleTimeMillis","300000");
        prop.setProperty("testWhileIdle","true");
        prop.setProperty("testOnBorrow","true");
        prop.setProperty("testOnReturn","false");
        prop.setProperty("poolPreparedStatements","false");
        prop.setProperty("maxPoolPreparedStatementPerConnectionSize","20");
        prop.setProperty("removeAbandoned","true");
        prop.setProperty("removeAbandonedTimeout","180");
        prop.setProperty("logAbandoned","true");
        try {
            DruidDataSource druidDataSource = (DruidDataSource) DruidDataSourceFactory
                    .createDataSource(prop);
            map.put(host+port+databaseName,druidDataSource);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("新增数据库创建连接池失败！");
        }
    }

    //删除连接池
    public void removeDruidDataSource(Subject subject){
        DruidDataSource source = map.get(subject.getDbHost()+subject.getDbPort()+subject.getDbName());
        source.close();
        map.remove(subject.getDbHost()+subject.getDbPort()+subject.getDbName());
    }

    //查询连接池是否存在
    public boolean containsId(String id){
        return map.containsKey(id);
    }
}
