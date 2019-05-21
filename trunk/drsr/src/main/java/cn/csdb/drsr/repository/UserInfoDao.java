package cn.csdb.drsr.repository;

import cn.csdb.drsr.model.UserInformation;
import cn.csdb.drsr.repository.mapper.UserInfoMapper;
import com.google.common.collect.Lists;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Repository
public class UserInfoDao {
    @Resource
    private JdbcTemplate jdbcTemplate;

    public int saveUserinfo(final UserInformation userInformation){
        final String sql = "INSERT INTO main.user_information  " +
                "( SubjectName, SubjectCode, Admin, AdminPasswd, Contact, Phone, Email, " +
                " FtpUser, FtpPassword, Brief, LoginDate,dbHost,dbPort)  " +
                "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

                PreparedStatement ps = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
//                ps.setString(1,userInformation.getID());
                ps.setString(1,userInformation.getSubjectName());
                ps.setString(2,userInformation.getSubjectCode());
                ps.setString(3,userInformation.getAdmin());
                ps.setString(4,userInformation.getAdminPasswd());
                ps.setString(5,userInformation.getContact());
                ps.setString(6,userInformation.getPhone());
                ps.setString(7,userInformation.getEmail());
                ps.setString(8,userInformation.getFtpUser());
                ps.setString(9,userInformation.getFtpPassword());
                ps.setString(10,userInformation.getBrief());
                ps.setString(11,userInformation.getLoginDate());
                ps.setString(12,userInformation.getDbHost());
                ps.setString(13,userInformation.getDbPort());

                return ps;
            }
        },keyHolder);
        int generatedId = keyHolder.getKey().intValue();

        //删除七天前的登录记录
        String sql2="DELETE  FROM user_information WHERE julianday('now') - julianday(LoginDate) >= 7;";
        try{
            int result=jdbcTemplate.update(sql2);
            System.out.println("清除七天前的登录日志！--"+result);
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("清除七天前的登录日志失败！");
        }


        return  generatedId;
    }


    public UserInformation getUserInfoByCode(String subjectCode){
        UserInformation userInformationt=new UserInformation();
        StringBuffer sql = new StringBuffer("select * from user_information where SubjectCode=? ORDER BY ID DESC");
        List<Object> params = Lists.newArrayList();
        params.add(subjectCode);
        List<UserInformation> userInformationList= jdbcTemplate.query(sql.toString(), params.toArray(), new UserInfoMapper());
        userInformationt=userInformationList.get(0);
        return  userInformationt;
    }


}
