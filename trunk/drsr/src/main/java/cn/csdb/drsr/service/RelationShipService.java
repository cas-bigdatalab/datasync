package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @program: DataSync
 * @description:  DataTask Service
 * @author: shibaoping
 * @create: 2018-10-09 16:29
 **/

@Service
public class RelationShipService {
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
}
