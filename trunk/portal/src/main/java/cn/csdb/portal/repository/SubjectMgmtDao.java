package cn.csdb.portal.repository;

import cn.csdb.portal.model.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SubjectMgmtDao {
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int addSubject(Subject subject)
    {
        String insertSql = "insert into Subject(SubjectName, SubjectCode, Brief, Contact, Phone, Address, Admin, FtpUser, FtpPassword) \n" +
                " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] args = new Object[] {subject.getSubjectName(), subject.getSubjectCode(), subject.getBrief(), subject.getContact(), subject.getPhone(), subject.getAddress(), subject.getAdmin(), subject.getFtpUser(), subject.getFtpPassword()};

        int addedRowCnt = jdbcTemplate.update(insertSql, args);

        return addedRowCnt;
    }

    public int deleteSubject(int id)
    {
        String deleteSql = "delete from Subject where id = ?";
        Object[] args = new Object[]{id};

        int deletedRowCnt = jdbcTemplate.update(deleteSql, args);

        return deletedRowCnt;
    }

    public int modifySubject(Subject subject)
    {
        deleteSubject(subject.getId());

        return  addSubject(subject);
    }

    public List<Subject> querySubject(int pageNumber)
    {
        if (pageNumber < 1)
        {
            return null;
        }

        int rowsPerPage = 10;

        int totalPages = 1;
        totalPages = getTotalPages();

        if (pageNumber > totalPages)
        {
            return null;
        }

        int startRowNum = 0;
        startRowNum = (pageNumber - 1) * rowsPerPage;

        final List<Subject> subjectsOfThisPage = new ArrayList<Subject>();
        String querySql = "select * from Subject limit " + startRowNum + ", " + rowsPerPage;
        jdbcTemplate.query(querySql, new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet resultSet) throws SQLException {
                do {
                    Subject subject = new Subject();
                    subject.setId(resultSet.getInt("id"));
                    subject.setSubjectName(resultSet.getString("SubjectName"));
                    subject.setSubjectCode(resultSet.getString("SubjectCode"));
                    subject.setBrief(resultSet.getString("Brief"));
                    subject.setContact(resultSet.getString("Contact"));
                    subject.setPhone(resultSet.getString("Phone"));
                    subject.setAddress(resultSet.getString("Address"));
                    subject.setAdmin(resultSet.getString("Admin"));
                    subject.setFtpUser(resultSet.getString("FtpUser"));
                    subject.setFtpPassword(resultSet.getString("FtpPassword"));

                    System.out.println(subject);
                    subjectsOfThisPage.add(subject);
                } while (resultSet.next());
            }
        });

        return subjectsOfThisPage;
    }

    public int getTotalPages()
    {
        int rowsPerPage = 10;
        String rowSql = "select count(*) from Subject";
        int totalRows = (Integer) jdbcTemplate.queryForObject(rowSql, Integer.class);
        int totalPages = 0;
        totalPages = totalRows / rowsPerPage + (totalRows % rowsPerPage == 0 ? 0 : 1);

        return totalPages;
    }

    public Subject findSubjectById(int id)
    {
        final Subject subject = new Subject();
        String querySql = "select * from Subject where id = " + id;
        jdbcTemplate.query(querySql, new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet resultSet) throws SQLException {
                subject.setId(resultSet.getInt("id"));
                subject.setSubjectName(resultSet.getString("SubjectName"));
                subject.setSubjectCode(resultSet.getString("SubjectCode"));
                subject.setBrief(resultSet.getString("Brief"));
                subject.setContact(resultSet.getString("Contact"));
                subject.setPhone(resultSet.getString("Phone"));
                subject.setAddress(resultSet.getString("Address"));
                subject.setAdmin(resultSet.getString("Admin"));
                subject.setFtpUser(resultSet.getString("FtpUser"));
                subject.setFtpPassword(resultSet.getString("FtpPassword"));
            }
        });

        return subject;
    }
}
