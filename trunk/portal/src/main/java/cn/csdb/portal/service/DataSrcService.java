package cn.csdb.portal.service;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.repository.DataSrcDao;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

/**
 * Created by huangwei on 2016/4/6.
 */
@Service
@Transactional
public class DataSrcService {

    @Autowired
    private DataSrcDao dataSrcDao;


    public List<String> relationalDatabaseTableList(DataSrc dataSrc) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return null;
        return dataSource.getTableList(connection);
    }

//获得列名和字段类型
    public  Map<String,List<String>> getColumnName(DataSrc dataSrc,String tableName){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<String> list1=new ArrayList<>();
        List<String> list2=new ArrayList<>();
        List<String> list3=new ArrayList<>();
        Map<String,List<String>> map=new HashMap<>();
        try{
            String sql="select  COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where TABLE_SCHEMA= ? and table_name =?";
            PreparedStatement pst=connection.prepareStatement(sql);
            pst.setString(1,dataSrc.getDatabaseName());
            pst.setString(2,tableName);
            ResultSet set=pst.executeQuery();
            while (set.next()){
//                String name=set.getString("COLUMN_NAME");
//                System.out.println(name);
                list1.add(set.getString("COLUMN_NAME"));
                list2.add(set.getString("DATA_TYPE"));
                list3.add(set.getString("COLUMN_COMMENT"));
//                System.out.println(set.getString("COLUMN_NAME"));

            }
            map.put("COLUMN_NAME",list1);
            map.put("DATA_TYPE",list2);
            map.put("COLUMN_COMMENT",list3);
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return map;
    }
//    更新数据
    public  int updateDate(String condition,String setData,String tableName,DataSrc dataSrc){
        int i=0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try{
            String sql="update "+tableName+""+setData+condition;
            PreparedStatement pst=connection.prepareStatement(sql);
            i= pst.executeUpdate();
            System.out.println("测试："+sql);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{
                connection.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
//        System.out.println("测试dddddd："+i);
        return i;
    }
//    分页
    public int countData(DataSrc dataSrc,String tableName){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String,Object>> listMap=new ArrayList<Map<String,Object>>();
        int count=0;
        try{
            String sql="select count(*) as num from "+tableName+"";

            //         时间格式的数据怎么获得
            PreparedStatement pst=connection.prepareStatement(sql);
            ResultSet rs=pst.executeQuery();
            while(rs.next()){
                count=rs.getInt("num");
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return count;
    }

//    连接mysql数据库，根据表明查出所有数据，供编辑
    public List<Map<String,Object>>  getTableData(DataSrc dataSrc,String tableName,int pageNo,int pageSize){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String,Object>> listMap=new ArrayList<Map<String,Object>>();
         int start=pageSize*(pageNo-1);
       try{
//           select COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where table_name = '表名' and table_schema = '数据库名称';
           String sql="select * from "+tableName+" limit "+start+" ,"+ pageSize+"";

           //         时间格式的数据怎么获得
           PreparedStatement pst=connection.prepareStatement(sql);
           ResultSet set=pst.executeQuery();
           ResultSetMetaData rsm=set.getMetaData();

           while(set.next()){
               Map<String,Object> map=new HashMap<>();
               for(int i=1;i<=rsm.getColumnCount();i++){
                       map.put(rsm.getColumnName(i),set.getString(rsm.getColumnName(i)));
//                       System.out.println("第"+i+"列的值"+"列名："+rsm.getColumnName(i)+",,,"+set.getString(rsm.getColumnName(i)));
               }
               listMap.add(map);
           }
       }catch (Exception e){
           e.printStackTrace();
       }finally {
          try{ connection.close();}catch (Exception e){
              e.printStackTrace();
          }
       }
return listMap;
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
}
