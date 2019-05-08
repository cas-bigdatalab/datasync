package cn.csdb.portal.service;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.EnumData;
import cn.csdb.portal.repository.DataSrcDao;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by huangwei on 2016/4/6.
 */
@Service
@Transactional
public class DataSrcService {

    @Autowired
    private DataSrcDao dataSrcDao;

    private Logger logger = LoggerFactory.getLogger(DataSrcService.class);


    public List<String> relationalDatabaseTableList(DataSrc dataSrc) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null) {
            return null;
        }
        List<String> tableList = dataSource.getTableList(connection);
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableList;
    }

    //    表结构
    public Map<String, List<String>> getTableStructure(DataSrc dataSrc, String tableName) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        Map<String, List<String>> map = new HashMap<>();
        List<String> list1 = new ArrayList<>();
        List<String> list2 = new ArrayList<>();
        List<String> list3 = new ArrayList<>();
        List<String> list4 = new ArrayList<>();
        List<String> list5 = new ArrayList<>();
        List<String> list6 = new ArrayList<>();
        List<String> list7 = new ArrayList<>();
        try {
            String sql = "SELECT COLUMN_NAME,IS_NULLABLE,DATA_TYPE,COLUMN_KEY,COLUMN_COMMENT,EXTRA,COLUMN_TYPE " +
                    "FROM information_schema. COLUMNS WHERE table_schema = ? AND table_name = ? ";

            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, dataSrc.getDatabaseName());
            pst.setString(2, tableName);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                list1.add(set.getString("COLUMN_NAME"));
                list2.add(set.getString("DATA_TYPE"));
                list3.add(set.getString("COLUMN_COMMENT"));
                list4.add(set.getString("COLUMN_KEY"));
                list5.add(set.getString("EXTRA"));
                list6.add(set.getString("IS_NULLABLE"));
                list7.add(set.getString("COLUMN_TYPE"));
            }
            map.put("COLUMN_NAME", list1);
            map.put("DATA_TYPE", list2);
            map.put("COLUMN_COMMENT", list3);
            map.put("pkColumn", list4);
            map.put("autoAdd", list5);
            map.put("IS_NULLABLE", list6);
            map.put("COLUMN_TYPE", list7);
            pst.close();
            set.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return map;
    }

    //    根据PORTALID查询数据
    public List<String> getDataByPORTALID(DataSrc dataSrc, String tableName, String PORTALID) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<String> list = new ArrayList<>();
        try {
            String sql = "SELECT * from " + tableName + " where PORTALID=?";

            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, PORTALID);
            ResultSet set = pst.executeQuery();
            ResultSetMetaData rsm = set.getMetaData();
            while (set.next()) {
                for (int i = 1; i <= rsm.getColumnCount(); i++) {
                    if (set.getString(rsm.getColumnName(i)) == null || set.getString(rsm.getColumnName(i)).equals("")) {
                        list.add("");
                    } else {
                        list.add(set.getString(rsm.getColumnName(i)));
                    }
                    System.out.println("aaaaaaaallll" + set.getString(rsm.getColumnName(i)));
                }
            }

            pst.close();
            set.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //    删除表数据
    public int deleteDate(String tableName, String delPORTALID, DataSrc dataSrc) {
        int i = 0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try {
            String sql = "delete from " + tableName + " where PORTALID=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, delPORTALID);
            i = ps.executeUpdate();
            System.out.println(sql);

            ps.close();
        } catch (Exception e) {

        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return i;
    }

    //获得表列名
    public List<String> getColumnName(DataSrc dataSrc, String tableName) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<String> list1 = new ArrayList<>();
        try {
            String sql = "SELECT COLUMN_NAME FROM information_schema. COLUMNS WHERE table_schema = ? AND table_name = ? ";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, dataSrc.getDatabaseName());
            pst.setString(2, tableName);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                list1.add(set.getString("COLUMN_NAME"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list1;
    }

    //    更新数据
    public int updateDate(String condition, String setData, String tableName, DataSrc dataSrc) {
        int i = 0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try {
            String sql = "update " + tableName + "" + setData + condition;
            System.out.println("更新：" + sql);
            PreparedStatement pst = connection.prepareStatement(sql);
            i = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return i;
    }

    //    新增数据
    public int addData(DataSrc dataSrc, String tableName, String col, String val) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        int i = 0;
        try {
            String sql = "insert into  " + tableName + "(" + col + ")  values(" + val + ")";
            System.out.println("新增：" + sql);
            PreparedStatement pst = connection.prepareStatement(sql);
            i = pst.executeUpdate();

            System.out.println("影响数据行：" + i);
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return i;
    }

    //判断主键是否重复
    public int checkPriKey(DataSrc dataSrc, String tableName, String primaryKey, String colName) {
        int i = 0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try {
            String sql = "select count(" + colName + ") as num " + "from " + tableName + " where " + colName + "= ?";
            System.out.println("判断主键是否重复：" + sql);
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setObject(1, primaryKey);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                i = rs.getInt("num");
                System.out.println("是否重复" + i);
            }
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return i;
    }

    //    分页，统计数据总数
    public int countData(DataSrc dataSrc, String tableName) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
        int count = 0;
        try {
            String sql = "select count(*) as num from " + tableName + "";

            //         时间格式的数据怎么获得
            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                count = rs.getInt("num");
            }
            pst.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    //    连接mysql数据库，根据表明查出所有数据，供编辑
    public List<Map<String, Object>> getTableData(DataSrc dataSrc, String tableName, int pageNo, int pageSize) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
        int start = pageSize * (pageNo - 1);
        try {
//           select COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where table_name = '表名' and table_schema = '数据库名称';
            String sql = "select * from " + tableName + " limit " + start + " ," + pageSize + "";

            //         时间格式的数据怎么获得
            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet set = pst.executeQuery();
            ResultSetMetaData rsm = set.getMetaData();

            while (set.next()) {
                Map<String, Object> map = new HashMap<>();
                for (int i = 1; i <= rsm.getColumnCount(); i++) {
                    if (set.getString(rsm.getColumnName(i)) == null) {
                        map.put(rsm.getColumnName(i), "");
                    } else {
                        map.put(rsm.getColumnName(i), set.getString(rsm.getColumnName(i)));
                    }
                }
                listMap.add(map);
            }
            pst.close();
            set.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return listMap;
    }


    public List<EnumData> getEnumData(DataSrc dataSrc, String tableName, String colK, String colV) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<EnumData> list = new ArrayList<>();
        try {
            String sql = "select distinct " + colK + "," + colV + " from " + tableName;
            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                EnumData enumData = new EnumData();
                enumData.setKey(set.getString(colK));
                enumData.setValue(set.getString(colV));
                list.add(enumData);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<String> getDataByColumn(DataSrc dataSrc, String tableName, String columnName) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<String> list = new ArrayList<>();
        try {
            String sql = "select distinct " + columnName + " from " + tableName;
            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                list.add(set.getString(columnName));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //    显示表数据
    public List<List<Object>> getTableDataTestTmpl(DataSrc dataSrc, String tableName, int pageNo, int pageSize) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
        List<List<Object>> lists = new ArrayList<>();

        int start = pageSize * (pageNo - 1);
        try {
//           select COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where table_name = '表名' and table_schema = '数据库名称';
            String sql = "select * from " + tableName + " limit " + start + " ," + pageSize + "";

            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet set = pst.executeQuery();
            ResultSetMetaData rsm = set.getMetaData();
            while (set.next()) {
                List<Object> list = new ArrayList<>();
                for (int i = 1; i <= rsm.getColumnCount(); i++) {
                    if (set.getString(rsm.getColumnName(i)) == null) {
                        list.add("");
                    } else {
                        list.add(set.getString(rsm.getColumnName(i)));
                    }
                }
                lists.add(list);
            }
            pst.close();
            set.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return lists;
    }

    public boolean validateSql(String sql, int dataSourceId) {
        if (!SqlUtil.validateSelectSql(sql)) {
            return false;
        }
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return false;
        return dataSource.validateSql(connection, sql);
    }

    /**
     * @Description:
     * @Param: [list, enumDataList]
     * @return: cn.csdb.portal.model.EnumData
     * @Author: zcy
     * @Date: 2019/5/7
     */
    public EnumData enumCorresponding(List<String> list, List<EnumData> enumDataList) {
        EnumData enumDataList1 = new EnumData();
        String ss = "";
        for (String s : list) {
            for (EnumData e : enumDataList) {
                if (s.equals(e.getKey())) {
                    ss += e.getValue() + ",";
                }
            }
        }
        enumDataList1.setValue(ss);
        return enumDataList1;
    }

    /**
     * @Description: 新增数据，sql类型，根据val的值回找key值
     * @Param: [dataSrc, tableName, recolK, recolV]
     * @return: java.lang.String
     * @Author: zcy
     * @Date: 2019/5/7
     */
    public String getSqlEnumData(DataSrc dataSrc, String tableName, String recolK, String recolV, String recolValue) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        String colKey = "";
        try {

            String sql = "select distinct " + recolK + " from " + tableName + " where " + recolV + "='" + recolValue + "'";
            System.out.println(sql);
            PreparedStatement pst = connection.prepareStatement(sql);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                colKey = set.getString(recolK);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return colKey;
    }

}
