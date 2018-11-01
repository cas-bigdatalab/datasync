package cn.csdb.portal.service;


import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.TableFieldComs;
import cn.csdb.portal.model.TableInfo;
import cn.csdb.portal.repository.TableFieldComsDao;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;
import com.google.common.base.Joiner;
import com.google.common.collect.Maps;
import com.google.common.hash.Hashing;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.*;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2017/4/17 0017.
 */
@Service
public class TableFieldComsService {
    private Logger logger = LoggerFactory.getLogger(TableFieldComsService.class);

    /*@Resource
    private DataSrcDao dataSrcDao;*/

    @Resource
    private TableFieldComsDao tableFieldComsDao;

    private final static String URISPLIT = "#";

    @Transactional(readOnly = true)
    public Map<String, List<TableInfo>> getDefaultFieldComsByTableName(int dataSourceId, String tableName) {


        if (StringUtils.isBlank(tableName)) {
            return null;
        }
        tableName = tableName.trim();

/*
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
*/
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName("10.0.86.78_usdr");
        datasrc.setDataSourceType("db");
        datasrc.setDatabaseName("drsrnew");
        datasrc.setDatabaseType("mysql");
        datasrc.setHost("10.0.86.78");
        datasrc.setPort("3306");
        datasrc.setUserName("root");
        datasrc.setPassword("");
        if (datasrc == null) {
            return null;
        }
        Map<String, List<TableInfo>> maps = Maps.newHashMap();
        TableFieldComs tableFieldComs = getTableFieldComsByUriEx(datasrc, tableName);
        List<TableInfo> tableInfosCur = null;
        if (tableFieldComs != null) {
            String fieldComs = tableFieldComs.getFieldComs();
            tableInfosCur = JSON.parseArray(fieldComs, TableInfo.class);
        }

        IDataSource dataSource = DataSourceFactory.getDataSource(datasrc.getDatabaseType());
        Connection connection = dataSource.getConnection(datasrc.getHost(), datasrc.getPort(), datasrc.getUserName(), datasrc.getPassword(), datasrc.getDatabaseName());
        List<TableInfo> tableInfos = null;
        try {
            tableInfos = dataSource.getTableFieldComs(connection, datasrc.getDatabaseName(), tableName);
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

    @Transactional
    public boolean insertTableFieldComs(int dataSourceId, String tableName, List<TableInfo> tableInfos) {
/*
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
*/
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName("10.0.86.78_usdr");
        datasrc.setDataSourceType("db");
        datasrc.setDatabaseName("drsrnew");
        datasrc.setDatabaseType("mysql");
        datasrc.setHost("10.0.86.78");
        datasrc.setPort("3306");
        datasrc.setUserName("root");
        datasrc.setPassword("");
        if (datasrc == null) {
            return false;
        }
        TableFieldComs tableFieldComs = getTableFieldComsByUriEx(datasrc, tableName);
        if (tableFieldComs == null) {
            String fieldComs = JSON.toJSONString(tableInfos, new PropertyFilter() {
                @Override
                public boolean apply(Object object, String name, Object value) {
                    if (name.equalsIgnoreCase("columnNameLabel")) {
                        return false;
                    }
                    return true;
                }
            });
            tableFieldComs = new TableFieldComs();
            String uriEx = getUriEx(datasrc, tableName);
            int uriHash = getUriHash(datasrc, tableName);
            tableFieldComs.setFieldComs(fieldComs);
            tableFieldComs.setStatus(0);
            tableFieldComs.setCreateTime(new Date());
            tableFieldComs.setUriEx(uriEx);
            tableFieldComs.setUriHash(uriHash);
            tableFieldComsDao.saveTableFieldComs(tableFieldComs,tableName);
            return true;
        }
        tableFieldComs.setUpdateTime(new Date());
        String fieldComs = tableFieldComs.getFieldComs();
        if (StringUtils.isBlank(fieldComs)) {
            tableFieldComs.setFieldComs(fieldComs);
            tableFieldComsDao.updateFieldComs(tableFieldComs);
            return true;
        }
        List<TableInfo> tableInfosPre = JSON.parseArray(fieldComs, TableInfo.class);
        tableInfosPre.removeAll(tableInfos);
        tableInfosPre.addAll(tableInfos);
        tableFieldComs.setFieldComs(JSON.toJSONString(tableInfosPre, new PropertyFilter() {
            @Override
            public boolean apply(Object object, String name, Object value) {
                if (name.equalsIgnoreCase("columnNameLabel")) {
                    return false;
                }
                return true;
            }
        }));
        tableFieldComsDao.updateFieldComs(tableFieldComs);
        return true;
    }

    private TableFieldComs getTableFieldComsByUriEx(DataSrc dataSrc, String tableName) {
        TableFieldComs tableFieldComs = null;
        int uriHash = getUriHash(dataSrc, tableName);
        List<TableFieldComs> tableFieldComsList = tableFieldComsDao.getTableFieldComsByUriEx(uriHash);
        if (tableFieldComsList.size() == 1) {
            tableFieldComs = tableFieldComsList.get(0);
        }
        if (tableFieldComsList.size() > 1) {
            for (TableFieldComs tableFieldComsCur : tableFieldComsList) {
                if (StringUtils.equals(tableFieldComsCur.getUriEx(), getUriEx(dataSrc, tableName))) {
                    tableFieldComs = tableFieldComsCur;
                    break;
                }
            }
        }
        return tableFieldComs;
    }

    private int getUriHash(DataSrc dataSrc, String tableName) {
        String uriEx = getUriEx(dataSrc, tableName);
        return Hashing.murmur3_32().hashBytes(uriEx.getBytes()).asInt();
    }

    private String getUriEx(DataSrc dataSrc, String tableName) {
        String host = dataSrc.getHost();
        String port = dataSrc.getPort();
        String databaseName = dataSrc.getDatabaseName();
        return Joiner.on(URISPLIT).skipNulls().join(host, port, databaseName, tableName);
    }

}
