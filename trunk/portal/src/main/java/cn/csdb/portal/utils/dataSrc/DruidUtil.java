package cn.csdb.portal.utils.dataSrc;

import cn.csdb.portal.common.SpringFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by shibaoping on 2019/6/11.
 * Druid连接池工具类
 */
public class DruidUtil {
        private  static DataSource dataSource;
        static
        {
            dataSource =  (DataSource) SpringFactory.getObject("dataSource");

        }
        //获得连接
        public static Connection getConnection() throws SQLException
        {
            return dataSource.getConnection();
        }
}
