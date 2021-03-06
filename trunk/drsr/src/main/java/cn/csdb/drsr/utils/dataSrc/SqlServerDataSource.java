package cn.csdb.drsr.utils.dataSrc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: DataSync
 * @description:
 * @author: caohq
 * @create: 2019-04-26 10:52
 **/
public class SqlServerDataSource extends IDataSource {
    private Logger logger = LoggerFactory.getLogger(SqlServerDataSource.class);

    @Override
    public Connection getConnection(String host, String port, String userName, String password, String databaseName) {
        String url="";
        Connection conn=null;
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        if(databaseName!=null && !databaseName.equals("")){
            url = "jdbc:sqlserver://"+host+":1433;DatabaseName="+databaseName+";";
        }else {
            url = "jdbc:sqlserver://"+host+":1433;";
        }
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, userName, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return conn;
    }

    @Override
    public List<String> getTableList(Connection connection) {
        List<String> tables = new ArrayList<>();
        try (Statement statement = connection.createStatement(); ResultSet rs = statement.executeQuery("select name from sysobjects where type='U'")) {
            while (rs.next()) {
                tables.add(rs.getString(1));
            }
            return tables;
        } catch (SQLException e) {
            logger.error("查询失败", e);
            return null;
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error("数据连接关闭错误", e);
            }
        }
    }

    @Override
    public Map<String, Map<String, String>> getTableColumns(Connection connection, String databaseName, String tableName) {
        Map<String, Map<String, String>> map = new HashMap<>();
        try (PreparedStatement statement = connection.prepareStatement("select a.column_name,a.data_type,b.comments from user_tab_columns a join USER_COL_COMMENTS b on a.column_name=b.column_name where a.table_name=? and b.table_name=?")) {
            statement.setString(1, tableName);
            statement.setString(2, tableName);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Map<String, String> row = new HashMap<String, String>();
                row.put("type", rs.getString("DATA_TYPE"));
                row.put("value", "1");
                row.put("comment", rs.getString(3));
                map.put(rs.getString("COLUMN_NAME"), row);
            }
            rs.close();
            return map;
        } catch (SQLException e) {
            logger.error("查询失败", e);
            return null;
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error("数据连接关闭错误", e);
            }
        }
    }


    @Override
    public PreparedStatement getPaginationSql(Connection connection, String sql, List<Object> params, int start, int pageSize) {
        sql = "select * from (select a.*,rownum from(" + sql + ")a where rownum<=?) where rownum>=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (params == null)
                params = new ArrayList<>();
            params.add(start + pageSize);
            params.add(start + 1);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            return ps;
        } catch (SQLException e) {
            logger.error("无法获取分页sql", e);
            return null;
        }
    }

//    @Override
//    public boolean validateSql(Connection connection, String sql) {
//        try (Statement statement = connection.createStatement()) {
//            return statement.execute(sql);
//        } catch (SQLException e) {
//            return false;
//        } finally {
//            try {
//                connection.close();
//            } catch (SQLException e) {
//                logger.error("数据连接关闭错误", e);
//            }
//        }
//    }

//    @Override
//    public boolean validateConnection(String host, String port, String userName, String password, String database) {
//        Connection connection = getConnection(host, port, userName, password, database);
//        try {
//            if (connection == null) {
//                return false;
//            }
//        } finally {
//            try {
//                connection.close();
//            } catch (SQLException e) {
//                logger.error("数据连接关闭错误", e);
//            }
//        }
//        return true;
//    }

//    @Override
//    public List<TableInfo> getTableFieldComs(Connection connection, String tableName) throws SQLException {

//        HashMap<String, String> map = Maps.newHashMap();
//        PreparedStatement preparedStatement = connection.prepareStatement(
//                "select * from USER_COL_COMMENTS where TABLE_NAME = ? ");
//        preparedStatement.setString(1, tableName);
//        ResultSet resultSet = preparedStatement.executeQuery();
//        while (resultSet.next()) {
//            String field = resultSet.getString("column_name");
//            String comment = resultSet.getString("COMMENTS");
//            map.put(field, StringUtils.isBlank(comment) ? "" : comment);
//        }
//        return map;
//    }
}
