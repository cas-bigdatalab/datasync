package cn.csdb.portal.repository;

import cn.csdb.portal.controller.SubjectMgmtController;
import cn.csdb.portal.model.Subject;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SubjectMgmtDao {
    private static int rowsPerPage = 10;
    private static final Logger logger = LogManager.getLogger(SubjectMgmtController.class);
    private JdbcTemplate jdbcTemplate;

    // create ftp directory
    @Value("#{systemPro['ftpServerAddr']}")
    private String ftpServerAddr;
    @Value("#{systemPro['ftpServerPort']}")
    private int ftpServerPort;

    @Resource
    private MongoTemplate mongoTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Function Description:
     *
     * @param subject, the wrapped object which contains information of the subject ot be added
     * @return  retValue, retValue inform user if create db info success or not
     * @author zzl
     * @date 2018/10/23
     */
    public int addSubject(Subject subject) {
        logger.info("enterring SubjectMgmtDao-addSubject");
        //create db and ftp
        createDb(subject.getSubjectCode());
        createFtp(subject.getFtpUser(), subject.getFtpPassword());
        boolean ftpPathCreated = createFtpPath(subject.getFtpUser(), subject.getFtpPassword());
        if (ftpPathCreated)
        {
            subject.setFtpFilePath(subject.getFtpUser());
        }
        else
        {
            subject.setFtpFilePath("");
        }
        logger.info("create db, ftp user, ftp path completed!");

        //insert subject into db
        String insertSql = "insert into subject(SubjectName, SubjectCode, ImagePath, Brief, Admin, AdminPasswd, Contact, Phone, Email, FtpUser, FtpPassword, SerialNo) " +
                " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] args = new Object[]{subject.getSubjectName(), subject.getSubjectCode(), subject.getImagePath(), subject.getBrief(), subject.getAdmin(), subject.getAdminPasswd(), subject.getContact(), subject.getPhone(), subject.getEmail(), subject.getFtpUser(), subject.getFtpPassword(), Integer.parseInt(subject.getSerialNo())};
        int addedRowCnt = 0;
        try {
            addedRowCnt = jdbcTemplate.update(insertSql, args);
            logger.info("insert subject success! inserted rows : " + addedRowCnt);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return addedRowCnt;
    }

    /**
     * Function Description:
     *
     * @param dbName, the db'name to be created
     * @return  retValue, retValue inform user if create db info success or not
     * @author zzl
     * @date 2018/10/23
     */
    private boolean createDb(String dbName) {
        logger.info("enterring SubjectMgmtDao-createDb, createDB = " + dbName);

        boolean retValue = false;
        String createDB = " create database " + " if not exists " + dbName;
        try {
            jdbcTemplate.execute(createDB);
            retValue = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("createDB completed!");

        return retValue;
    }

    /**
     * Function Description:
     *
     * @param ftpUser
     * @param ftpPassword
     * @return retValue, retValue inform user if create ftp info success or not
     * @author zzl
     * @date 2018/10/23
     */
    private boolean createFtp(String ftpUser, String ftpPassword) {
        logger.info("create ftp user and password.");
        String insertSql = "insert into vu_list.vuser(name, password) values(?, ?)";
        Object[] args = new Object[]{ftpUser, ftpPassword};
        int insertedRows = 0;
        try {
            insertedRows = jdbcTemplate.update(insertSql, args);
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean retValue = false;
        if (insertedRows == 1) {
            retValue = true;
        }

        logger.info("createFtp completed!");

        return retValue;
    }

    private boolean createFtpPath(String ftpUser, String ftpPassword)
    {
        logger.info("enterring SubjectMgmtDao-createFtpPath");
        boolean retValue = false;

        try {
            FTPClient ftpClient = new FTPClient();
            ftpClient.connect(ftpServerAddr, ftpServerPort);
            ftpClient.login(ftpUser, ftpPassword);
            ftpClient.mkd(ftpUser);
            retValue = true;
            logger.info("create ftp path success!");
        }
        catch (Exception e)
        {
            logger.info("failed to create ftp path!");
            e.printStackTrace();
        }

        return retValue;
    }

    /**
     *Function Description:
     *
     * @param id, the id of Subject to be deleted
     * @return  deletedRowCnt, the count of rows deleted
     * @author zzl
     * @date 2018/10/23
     */
    public int deleteSubject(int id) {
        logger.info("subject id to be deleted : " + id);

        //delete db and ftp info
        logger.info("delete db and ftp info.");
        Subject subject = findSubjectById(id);
        deleteDb(subject.getSubjectCode());
        deleteFtp(subject.getFtpUser(), subject.getFtpPassword());
        logger.info("db and ftp info deleted.");
        logger.info("deleting subject'image");
        deleteImage(subject.getImagePath());
        logger.info("subject'image deleted.");

        logger.info("deleting subject");
        String deleteSql = "delete from Subject where id = ?";
        Object[] args = new Object[]{id};

        int deletedRowCnt = 0;
        try {
            deletedRowCnt = jdbcTemplate.update(deleteSql, args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("delete subject completed.");

        return deletedRowCnt;
    }

    /**
     * Function Description:
     *
     * @param dbName, the name of database to be deleted
     * @author zzl
     * @date 2018/10/23
     */
    private void deleteDb(String dbName) {
        logger.info("deleting db info, dbName = " + dbName);
        String deleteDbSql = "drop database " + dbName;
        /*Object[] args = new Object[]{dbName};*/
        try {
            jdbcTemplate.update(deleteDbSql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("delete db info completed!");
    }

    /**
     * Function Description:
     *
     * @param ftpUser, ftp user name
     * @param ftpPassword, ftp password
     * @author zzl
     * @date 2018/10/23
     */
    private void deleteFtp(String ftpUser, String ftpPassword) {
        logger.info("deleting ftp info, ftpUser = " + ftpUser + ", ftpPassword = " + ftpPassword);
        String deleteFtpInfo = "delete from vu_list.vuser where name = ? and password=?";
        Object[] objs = new Object[]{ftpUser, ftpPassword};
        try {
            jdbcTemplate.update(deleteFtpInfo, objs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("delete ftp info completed!");
    }

    /**
     * Function Description:
     *
     * @param imagePath, the image' path which is about to be deleted
     * @author zzl
     * @date 2018/10/23
     */
    private void deleteImage(String imagePath) {
        logger.info("image path to be deleted : " + imagePath);
        try {
            File imagePathFileObj = new File(imagePath);
            imagePathFileObj.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("delete image completed!");
    }

    /**
     * Function Description:
     *
     * @param subject the subject to be updated
     * @return updatedRowCnt the count of rows updated
     * @author zzl
     * @date 2018/10/23
     */
    public int updateSubject(Subject subject) {
        logger.info("subject to be updated : " + subject);
        String updateSql = "update subject set SubjectName=?, SubjectCode=?, ImagePath=?, Brief=?, Admin=?, AdminPasswd=?, Contact=?, Phone=?, Email=?, FtpUser=?, FtpPassword=?, SerialNo=? where ID=?";
        Object[] args = new Object[]{subject.getSubjectName(), subject.getSubjectCode(), subject.getImagePath(),
                subject.getBrief(), subject.getAdmin(), subject.getAdminPasswd(),
                subject.getContact(), subject.getPhone(), subject.getEmail(),
                subject.getFtpUser(), subject.getFtpPassword(), subject.getSerialNo(), Integer.parseInt(subject.getId())};

        int updatedRowCnt = 0;

        try {
            updateDb(subject.getSubjectCode());
            updateFtp(subject.getFtpUser(), subject.getFtpPassword());

            updatedRowCnt = jdbcTemplate.update(updateSql, args);
        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("update subject completed!");

        return updatedRowCnt;
    }

    /**
     * Function Description: reserved, now not used
     *
     * @param newDbName
     * @author zzl
     * @date 2018/10/23
     */
    private void updateDb(String newDbName) {
    }

    /**
     * Function Description: reserved, now not used
     *
     * @param newFtpUser, newFtpPasswd
     * @author zzl
     * @date 2018/10/23
     */
    private void updateFtp(String newFtpUser, String newFtpPasswd) {
    }

    /**
     * Function Description:
     *
     * @param pageNumber
     * @return List<Subject>
     * @author zzl
     * @date 2018/10/23
     */
    public List<Subject> querySubject(int pageNumber) {
        //input parameter check， including lower bound and upper bound
        if (pageNumber < 1) {
            return null;
        }
        int totalPages = 1;
        totalPages = getTotalPages();
        if (pageNumber > totalPages) {
            return null;
        }

        //query intended page
        int startRowNum = 0;
        startRowNum = (pageNumber - 1) * rowsPerPage;

        final List<Subject> subjectsOfThisPage = new ArrayList<Subject>();
        String querySql = "select * from Subject limit " + startRowNum + ", " + rowsPerPage;

        try {
            jdbcTemplate.query(querySql, new RowCallbackHandler() {
                @Override
                public void processRow(ResultSet resultSet) throws SQLException {
                    do {
                        Subject subject = new Subject();
                        subject.setId(resultSet.getString("ID"));
                        subject.setSubjectName(resultSet.getString("SubjectName"));
                        subject.setSubjectCode(resultSet.getString("SubjectCode"));
                        subject.setImagePath(resultSet.getString("ImagePath"));
                        subject.setBrief(resultSet.getString("Brief"));
                        subject.setAdmin(resultSet.getString("Admin"));
                        subject.setAdminPasswd(resultSet.getString("AdminPasswd"));
                        subject.setContact(resultSet.getString("Contact"));
                        subject.setPhone(resultSet.getString("Phone"));
                        subject.setEmail(resultSet.getString("Email"));
                        subject.setFtpUser(resultSet.getString("FtpUser"));
                        subject.setFtpPassword(resultSet.getString("FtpPassword"));
                        subject.setSerialNo(resultSet.getString("SerialNo"));
                        System.out.println(subject);
                        subjectsOfThisPage.add(subject);
                    } while (resultSet.next());
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }

        return subjectsOfThisPage;
    }

    /**
     * Function Description:
     *
     * @return totalPages
     * @author zzl
     * @date 2018/10/23
     */
    public int getTotalPages() {
        //int rowsPerPage = 2;
        String rowSql = "select count(*) from Subject";
        int totalRows = (Integer) jdbcTemplate.queryForObject(rowSql, Integer.class);
        int totalPages = 0;
        totalPages = totalRows / rowsPerPage + (totalRows % rowsPerPage == 0 ? 0 : 1);

        return totalPages;
    }

    /**
     * Function Description:
     *
     * @param id
     * @return Subject
     * @author zzl
     * @date 2018/10/23
     */
    public Subject findSubjectById(int id) {
        final Subject subject = new Subject();
        String querySql = "select * from Subject where id = " + id;

        try {
            jdbcTemplate.query(querySql, new RowCallbackHandler() {
                @Override
                public void processRow(ResultSet resultSet) throws SQLException {
                    subject.setId(resultSet.getString("ID"));
                    subject.setSubjectName(resultSet.getString("SubjectName"));
                    subject.setSubjectCode(resultSet.getString("SubjectCode"));
                    subject.setBrief(resultSet.getString("Brief"));
                    subject.setAdmin(resultSet.getString("Admin"));
                    subject.setAdminPasswd(resultSet.getString("AdminPasswd"));
                    subject.setContact(resultSet.getString("Contact"));
                    subject.setPhone(resultSet.getString("Phone"));
                    subject.setEmail(resultSet.getString("Email"));
                    subject.setFtpUser(resultSet.getString("FtpUser"));
                    subject.setFtpPassword(resultSet.getString("FtpPassword"));
                    subject.setSerialNo(resultSet.getString("SerialNo"));
                    subject.setFtpFilePath(resultSet.getString("FtpPath"));
                    subject.setDbName(resultSet.getString("DbName"));

                    System.out.println("findSubjectById - " + subject);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }

        return subject;
    }

    /**
     * Function Description:
     *
     * @param: [code]
     * @return: cn.csdb.portal.model.Subject
     * @auther: hw
     * @date: 2018/10/22 15:03
     */
    public Subject findByCode(String code) {
        DBObject query = QueryBuilder.start().and("subjectCode").is(code).get();
        BasicQuery basicQuery = new BasicQuery(query);
        List<Subject> subjects = mongoTemplate.find(basicQuery, Subject.class);
        if (subjects.size() > 0) {
            return subjects.get(0);
        } else
            return null;
    }
}
