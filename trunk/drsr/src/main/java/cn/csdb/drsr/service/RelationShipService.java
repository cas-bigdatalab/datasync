package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.model.TableInfo;
import cn.csdb.drsr.model.TableInfoR;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
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

    public Map queryTotalPage(){
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

    public static void main(String[] args){
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        //格式化当前日期
        SimpleDateFormat.format(current_date.getTime());
        //输出测试一下
        System.out.println("当前的系统日期为：" + SimpleDateFormat.format(current_date.getTime()));
        System.out.println(new Date());
    }

}
