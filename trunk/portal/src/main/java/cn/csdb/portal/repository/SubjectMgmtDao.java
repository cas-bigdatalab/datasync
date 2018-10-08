package cn.csdb.portal.repository;

import cn.csdb.portal.model.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SubjectMgmtDao {
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int addSubject(Subject subject)
    {
        String insertSql = "insert into Subject(subjectName, subjectCode, brief, contact, phone, address, admin, ftpUser, ftpPassword) \n" +
                " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] args = new Object[] {subject.getSubjectName(), subject.getSubjectCode(), subject.getBrief(), subject.getContact(), subject.getPhone(), subject.getAdmin(), subject.getFtpUser(), subject.getFtpPassword()};

        int affectedRows = jdbcTemplate.update(insertSql, args);

        return affectedRows;
    }

    public int deleteSubject(int id)
    {
        String deleteSql = "delete from Subject where id = ?";
        Object[] args = new Object[]{id};

        int affectedRows = jdbcTemplate.update(deleteSql, args);

        return affectedRows;
    }

    public int modifySubject(Subject subject)
    {
        deleteSubject(subject.getId());

        return  addSubject(subject);
    }

    public List<Subject> querySubject(int currentNum)
    {
        return null;
    }

    public String dbConnectable()
    {
        String testSql = "insert into Subject(subjectName, subjectCode, brief, contact, phone, address, admin, ftpUser, ftpPassword) \n" +
                " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] args = new Object[]{"subjectNameTest", "subjectCodeTest", "test subject", "subjectContact", "13245678910", "北京市海淀区", "admin@test.cn", "abc", "def"};
        int cnt = jdbcTemplate.update(testSql, args);

        String testMsg = "test message";
        if (cnt > 0)
        {
            testMsg = "test data inserted successfully";
        }
        else
        {
            testMsg = "test data insertion failed.";
        }

        return testMsg;
    }
}
