package cn.csdb.drsr.service;

import cn.csdb.drsr.model.*;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Joiner;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.hash.Hashing;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.sql.*;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @program: DataSync
 * @description:  DataTask Service
 * @author: shibaoping
 * @create: 2018-10-09 16:29
 **/

@Service
public class RelationShipService {

    private Logger logger = LoggerFactory.getLogger(RelationShipService.class);

    @Resource
    private RelationDao relationDao;

    private final static String URISPLIT = "#";

   @Transactional
    public String addData(DataSrc datasrc)
    {
        try {
            int addedRowCnt = relationDao.addRelationData(datasrc);
            if(addedRowCnt == 1){
                return "1";
            }else{
                return "0";
            }
        }catch(Exception e){
            return "0";
        }
    }

    public List<DataSrc> queryData(){

        return relationDao.queryRelationData();

    }

    public String editData(DataSrc dataSrc){
        try {
            int addedRowCnt = relationDao.editRelationData(dataSrc);
            if(addedRowCnt == 1){
                return "1";
            }else{
                return "0";
            }
        }catch (Exception e){
            e.printStackTrace();
            return "0";
        }
    }

    @Transactional
    public String deleteRelation(int id)
    {
        int deletedRowCnt = relationDao.deleteRelationData(id);
        if (deletedRowCnt == 1)
        {
            return "1";
        }
        else
        {
            return "0";
        }
    }

    public List<DataSrc> editQueryData(int id){
        return relationDao.editQueryData(id);
    }

    public Integer queryTotalPage(){
        return relationDao.queryTotalPage();
    }

    public List<DataSrc> queryPage(int requestedPage)
    {
        return relationDao.queryPage(requestedPage);
    }

    public String testCon(String host, String port, String userName, String password, String databaseName) {
        String url = "jdbc:mysql://" + host + ":" + port + "/" + databaseName;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, userName, password);
            con.close();
            return "success";
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return "false";
        } catch (SQLException e) {
            e.printStackTrace();
            return "false";
        }catch (Exception e) {
            e.printStackTrace();
            return "false";
        }
    }





    public List<DataSrc> findAll() {
       return relationDao.findAll();
    }

    public List<String> relationalDatabaseTableList(DataSrc dataSrc) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return null;
        return dataSource.getTableList(connection);
    }

    public DataSrc findById(int id) {
       return relationDao.findById(id);
    }

    public List<List<Object>> getDataBySql(String sql, Map<String, List<TableInfo>> tableComsMap,
                                           int dataSourceId, int start, int limit) {
        DataSrc dataSrc = relationDao.findById(dataSourceId);
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
                dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        PreparedStatement paginationSql = dataSource.getPaginationSql(connection, sql, null, start, limit);
        List<List<Object>> datas = Lists.newArrayList();
        try {
            ResultSet resultSet = paginationSql.executeQuery();
            while (resultSet.next()) {
                ArrayList<Object> objects = Lists.newArrayList();
                Set<String> keySet = tableComsMap.keySet();
                for (String key : keySet) {
                    List<TableInfo> tableInfos = tableComsMap.get(key);
                    for (TableInfo tableInfo : tableInfos) {
                        if (StringUtils.isNoneBlank(tableInfo.getColumnNameLabel())) {
                            Object object1 = resultSet.getObject(tableInfo.getColumnNameLabel());
                            objects.add(object1);
                        } else {
                            Object object1 = resultSet.getObject(tableInfo.getColumnName());
                            objects.add(object1);
                        }
                    }
                }
                datas.add(objects);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
            }
        }
        return datas;
    }

    public List<List<Object>> getDataByTable(String tableName, HashMap<String, List<TableInfo>> tableComsMap,
                                             int dataSourceId, int start, int limit) {
        return getDataBySql("select * from " + tableName, tableComsMap, dataSourceId, start, limit);
    }


    @Transactional(readOnly = true)
    public Map<String, List<TableInfo>> getDefaultFieldComsBySql(int dataSourceId, String sqlStr) {
        if (StringUtils.isBlank(sqlStr) || !StringUtils.startsWithIgnoreCase(sqlStr.trim(), "select ")) {
            return null;
        }
        DataSrc dataSrc = relationDao.findById(dataSourceId);
        if (dataSrc == null) {
            return null;
        }
        Map<String, List<TableInfo>> fieldComsByTableNames = Maps.newHashMap();
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        PreparedStatement preparedStatement = dataSource.getPaginationSql(connection, sqlStr, null, 0, 1);

        try {
            ResultSet resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            String tableNameCur = null;
            List<TableInfo> tableInfos = null;
            List<TableInfo> tableInfosCur = null;
            for (int index = 1; index <= columnCount; index++) {
                String columnLabel = metaData.getColumnLabel(index);
                String columnName = metaData.getColumnName(index);
                String tableName = metaData.getTableName(index);
                if (tableNameCur == null || !StringUtils.equals(tableNameCur, tableName)) {
                    tableNameCur = tableName;
                    tableInfosCur = Lists.newArrayList();
                    Map<String, List<TableInfo>> fieldComsByTableName = getDefaultFieldComsByTableName(dataSourceId, tableName);
                    tableInfos = fieldComsByTableName.get(tableName);
                    if (fieldComsByTableNames.get(tableName) == null) {
                        fieldComsByTableNames.put(tableName, tableInfosCur);
                    }
                }
                for (TableInfo tableInfo : tableInfos) {
                    if (StringUtils.equals(columnName, tableInfo.getColumnName())) {
                        tableInfo.setColumnNameLabel(columnLabel);
                        tableInfosCur.add(tableInfo);
                        continue;
                    }
                }
            }
        } catch (SQLException e) {
            logger.error("数据库操作失败", e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {

            }
        }
        return fieldComsByTableNames;

    }

    @Transactional(readOnly = true)
    public Map<String, List<TableInfo>> getDefaultFieldComsByTableName(int dataSourceId, String tableName) {


        if (StringUtils.isBlank(tableName)) {
            return null;
        }
        tableName = tableName.trim();

        DataSrc dataSrc = relationDao.findById(dataSourceId);
        if (dataSrc == null) {
            return null;
        }
        Map<String, List<TableInfo>> maps = Maps.newHashMap();
//        TableFieldComs tableFieldComs = getTableFieldComsByUriEx(dataSrc, tableName);
        TableFieldComs tableFieldComs = null;
        List<TableInfo> tableInfosCur = null;
        if (tableFieldComs != null) {
            String fieldComs = tableFieldComs.getFieldComs();
            tableInfosCur = JSON.parseArray(fieldComs, TableInfo.class);
        }

        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<TableInfo> tableInfos = null;
        try {
            tableInfos = dataSource.getTableFieldComs(connection, dataSrc.getDatabaseName(), tableName);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {

            }
        }
        if (tableInfos != null && tableInfosCur != null) {
            List intersectionList = ListUtils.intersection(tableInfos, tableInfosCur);//1 获取交集，取tableInfosCur中元素
            tableInfos.removeAll(tableInfosCur);//2 去除重复元素
            tableInfos.addAll(intersectionList);//3 然后取并集
            maps.put(tableName, tableInfos);
        } else if (tableInfos != null) {
            maps.put(tableName, tableInfos);
        }
        return maps;

    }


}
