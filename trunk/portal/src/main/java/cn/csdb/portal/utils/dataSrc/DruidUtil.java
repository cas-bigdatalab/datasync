package cn.csdb.portal.utils.dataSrc;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.commons.lang3.StringUtils;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by shibaoping on 2019/6/11.
 * Druid连接池工具类
 */
public class DruidUtil {

        //获得连接
        public static Connection getConnection(String driverClass, String host, String port, String username, String password, String db) throws SQLException
        {
            DruidDataSource druidDataSource = new DruidDataSource();
            druidDataSource.setUrl(getJdbcUrl(driverClass.trim(), host, port, db));
            druidDataSource.setUsername(username);
            druidDataSource.setPassword(password);
            //初始化时建立物理连接的个数
            druidDataSource.setInitialSize(5);
            //最小连接池数量
            druidDataSource.setMinIdle(5);
            //最大连接池数量
            druidDataSource.setMaxActive(15);
            //获取连接时最大等待时间，单位毫秒
            druidDataSource.setMaxWait(10000);
            //连接间隔时间
            druidDataSource.setTimeBetweenEvictionRunsMillis(60000);
            //连接在池中的最小生存时间，单位毫秒
            druidDataSource.setMinEvictableIdleTimeMillis(300000);
            //申请连接时执行validationQuery检测连接是否有效(开启后会影响一些性能)
            druidDataSource.setTestOnBorrow(true);
            //归还连接时执行validationQuery检测连接是否有效(开启后会影响一些性能)
            druidDataSource.setTestOnReturn(false);
            //建议配置为true，不影响性能，并且保证安全性。申请连接的时候检测，如果空闲时间大于timeBetweenEvictionRunsMillis，执行validationQuery检测连接是否有效。
            druidDataSource.setTestWhileIdle(true);
            //用来检测连接是否有效的SQL，要求是一个查询语句
            druidDataSource.setValidationQuery("SELECT 1");
            //对于长时间不使用的连接强制关闭
            druidDataSource.setRemoveAbandoned(true);
            //数据库连接超过80s开始关闭空闲连接 秒为单位
            druidDataSource.setRemoveAbandonedTimeout(80);
            //是否缓存preparedStatement，也就是PSCache，在mysql5.5以下的版本中没有PSCache功能，建议关闭掉
            druidDataSource.setPoolPreparedStatements(false);
            //要启用PSCache，必须配置大于0，当大于0时，poolPreparedStatements自动触发修改为true。
            druidDataSource.setMaxPoolPreparedStatementPerConnectionSize(20);
            return druidDataSource.getConnection();
        }

        //适配于不同数据库的JDBC连接
        private static String getJdbcUrl(String driverClass, String host, String port, String db) {

        if (StringUtils.startsWith(driverClass,"oracle.jdbc.")) {
            return "jdbc:oracle:thin:@" + host + ":" + port + ":" + db;
        }
        if (StringUtils.startsWith(driverClass,"com.mysql.jdbc.")) {
            return "jdbc:mysql://" + host + ":" + port + "/" +db+"?zeroDateTimeBehavior=convertToNull&Unicode=true&characterEncoding=UTF-8&useSSL=false";
        }
        return null;
    }
}
