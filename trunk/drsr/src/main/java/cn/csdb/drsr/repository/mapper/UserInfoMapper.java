package cn.csdb.drsr.repository.mapper;

import cn.csdb.drsr.model.UserInformation;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
* Created by caohq on 2019/5/16 .
*/

public class UserInfoMapper implements RowMapper {
    @Override
    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        UserInformation userInformation = new UserInformation();
        userInformation.setID(resultSet.getString("ID"));
        userInformation.setSubjectName(resultSet.getString("SubjectName"));
        userInformation.setSubjectCode(resultSet.getString("SubjectCode"));
        userInformation.setAdmin(resultSet.getString("Admin"));
        userInformation.setAdminPasswd(resultSet.getString("AdminPasswd"));
        userInformation.setContact(resultSet.getString("Contact"));
        userInformation.setPhone(resultSet.getString("Phone"));
        userInformation.setEmail(resultSet.getString("Email"));
        userInformation.setFtpUser(resultSet.getString("FtpUser"));
        userInformation.setFtpPassword(resultSet.getString("FtpPassword"));
        userInformation.setBrief(resultSet.getString("Brief"));
        userInformation.setLoginDate(resultSet.getString("LoginDate"));
        userInformation.setDbHost(resultSet.getString("dbHost"));
        userInformation.setDbPort(resultSet.getString("dbPort"));

        return userInformation;
    }

}
