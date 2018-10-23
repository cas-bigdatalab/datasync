package cn.csdb.portal.repository;

import cn.csdb.portal.model.Subject;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SubjectMgmtDao {
    private static int rowsPerPage = 10;
    private JdbcTemplate jdbcTemplate;

    @Resource
    private MongoTemplate mongoTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int addSubject(Subject subject)
    {
        //存图片
        String imagePath = "";
        //imagePath = saveImageFile(subject.getImagePath());

        //创建数据库和ftp的信息
        createDb(subject.getSubjectCode());
        createFtp(subject.getFtpUser(), subject.getFtpPassword());

        //插入数据库记录
        String insertSql = "insert into subject(SubjectName, SubjectCode, ImagePath, Brief, Admin, AdminPasswd, Contact, Phone, Email, FtpUser, FtpPassword, SerialNo) " +
                " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] args = new Object[] {subject.getSubjectName(), subject.getSubjectCode(), imagePath, subject.getBrief(), subject.getAdmin(), subject.getAdminPasswd(), subject.getContact(), subject.getPhone(), subject.getEmail(), subject.getFtpUser(), subject.getFtpPassword(), Integer.parseInt(subject.getSerialNo())};

        int addedRowCnt = 0;

        try
        {
            addedRowCnt = jdbcTemplate.update(insertSql, args);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return addedRowCnt;
    }

    private String saveImageFile(MultipartFile image)
    {
        String imagesPath = (new File(this.getClass().getResource("").getPath())).getParentFile().getAbsolutePath() + "/SubjectImages/";
        String fileName = image.getOriginalFilename();

        String imageFilePath = "";
        if (!(fileName==null || fileName.equals("")))
        {
            imageFilePath = imagesPath + fileName;
        }

        File imageFilePathObj = new File(imageFilePath);
        if(!imageFilePathObj.getParentFile().exists())
        {
            imageFilePathObj.getParentFile().mkdirs();
        }

        try {
            image.transferTo(new File(imageFilePath));
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        System.out.println("save image file completed!");

        return imageFilePathObj.getAbsolutePath();
    }

    private boolean createDb(String dbName)
    {
        String createDB = " create database "  + " if not exists " + dbName;

        System.out.println("createDB = " + createDB);

        try
        {
            jdbcTemplate.execute(createDB);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        System.out.println("createDB completed!");
        return true;
    }

    private boolean createFtp(String ftpUser, String ftpPassword)
    {
        String insertSql = "insert into vu_list.vuser(name, password) values(?, ?)";
        Object[] args = new Object[]{ftpUser, ftpPassword};
        int insertedRows = 0;

        try {
            insertedRows = jdbcTemplate.update(insertSql, args);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        boolean retValue = false;
        if (insertedRows == 1)
        {
            retValue = true;
        }

        System.out.println("createFtp completed!");

        return retValue;
    }

    public int deleteSubject(int id)
    {
        //删除数据库和ftp相关信息
        Subject subject = findSubjectById(id);
        deleteDb(subject.getSubjectCode());
        deleteFtp(subject.getFtpUser(), subject.getFtpPassword());
        //deleteImage(subject.getImagePath().getOriginalFilename());

        String deleteSql = "delete from Subject where id = ?";
        Object[] args = new Object[]{id};

        int deletedRowCnt = 0;
        try
        {
            deletedRowCnt = jdbcTemplate.update(deleteSql, args);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return deletedRowCnt;
    }

    private void deleteDb(String dbName)
    {
        String deleteDbSql = "drop database " + dbName;
        /*Object[] args = new Object[]{dbName};*/
        try {
            jdbcTemplate.update(deleteDbSql);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        System.out.println("delete db completed!");
    }

    private void deleteFtp(String ftpUser, String ftpPassword)
    {
        String deleteFtpInfo = "delete from vu_list.vuser where name = ? and password=?";
        Object[] objs = new Object[]{ftpUser, ftpPassword};
        try {
            jdbcTemplate.update(deleteFtpInfo, objs);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        System.out.println("delete ftp completed!");

    }

    private void deleteImage(String imagePath)
    {
        try {
            File imagePathFile = new File(imagePath);
            imagePathFile.delete();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        System.out.println("delete image completed!");
    }

    public int modifySubject(Subject subject)
    {
        String imagePath = updateImage(subject);
        String updateSql = "update subject set SubjectName=?, SubjectCode=?, ImagePath=?, Brief=?, Admin=?, AdminPasswd=?, Contact=?, Phone=?, Email=?, FtpUser=?, FtpPassword=?, SerialNo=? where ID=?";
        Object[] args = new Object[]{
                subject.getSubjectName(), subject.getSubjectCode(), imagePath,
                subject.getBrief(), subject.getAdmin(), subject.getAdminPasswd(),
                subject.getContact(), subject.getPhone(), subject.getEmail(),
                subject.getFtpUser(), subject.getFtpPassword(), subject.getSerialNo(), Integer.parseInt(subject.getId())};

        int updatedRowCnt = 0;
        try
        {
            updateDb(subject.getSubjectCode());
            updateFtp(subject.getFtpUser(), subject.getFtpPassword());

            updatedRowCnt = jdbcTemplate.update(updateSql, args);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }


        return  updatedRowCnt;
    }

    private String updateImage(Subject subject)
    {
        //处理修改图片的情况
        int id = Integer.parseInt(subject.getId());
        String imagePath = "";
        Subject tmpSubject = findSubjectById(Integer.parseInt(subject.getId()));
        /*if (subject.getImagePath().getOriginalFilename() != "")
        {
            deleteImage(tmpSubject.getImagePath().getOriginalFilename());
            imagePath = saveImageFile(subject.getImagePath());
        }
        else
        {
            imagePath = tmpSubject.getImagePath().getOriginalFilename();
        }*/

        return imagePath;
    }

    private void updateDb(String newDbName)
    {

    }

    private void updateFtp(String newFtpUser, String newFtpPasswd)
    {

    }

    public List<Subject> querySubject(int pageNumber)
    {
        if (pageNumber < 1)
        {
            return null;
        }

        //int rowsPerPage = 2;

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

        try
        {
            jdbcTemplate.query(querySql, new RowCallbackHandler() {
                @Override
                public void processRow(ResultSet resultSet) throws SQLException {
                    do {
                        Subject subject = new Subject();
                        subject.setId(resultSet.getString("ID"));
                        subject.setSubjectName(resultSet.getString("SubjectName"));
                        subject.setSubjectCode(resultSet.getString("SubjectCode"));
                       // subject.setImagePath(getImageFile(resultSet.getString("ImagePath")));
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
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return subjectsOfThisPage;
    }

    public int getTotalPages()
    {
        //int rowsPerPage = 2;
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

        try {
            jdbcTemplate.query(querySql, new RowCallbackHandler() {
                @Override
                public void processRow(ResultSet resultSet) throws SQLException {
                    subject.setId(resultSet.getString("ID"));
                    subject.setSubjectName(resultSet.getString("SubjectName"));
                    subject.setSubjectCode(resultSet.getString("SubjectCode"));
                   //subject.setImagePath(getImageFile(resultSet.getString("ImagePath")));
                    subject.setBrief(resultSet.getString("Brief"));
                    subject.setAdmin(resultSet.getString("Admin"));
                    subject.setAdminPasswd(resultSet.getString("AdminPasswd"));
                    subject.setContact(resultSet.getString("Contact"));
                    subject.setPhone(resultSet.getString("Phone"));
                    subject.setEmail(resultSet.getString("Email"));
                    subject.setFtpUser(resultSet.getString("FtpUser"));
                    subject.setFtpPassword(resultSet.getString("FtpPassword"));
                    subject.setSerialNo(resultSet.getString("SerialNo"));
                    subject.setFtpPath(resultSet.getString("FtpPath"));
                    subject.setDbName(resultSet.getString("DbName"));

                    System.out.println("findSubjectById - " + subject);

                }
            });
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return subject;
    }

    private MultipartFile getImageFile(String imageServerPath)
    {
        System.out.println("getImageFile-" + imageServerPath);

        MultipartFile multipartFile = null;
        try
        {
            if (imageServerPath==null || imageServerPath.trim().equals(""))
            {
                imageServerPath = "";
            }

            FileInputStream input = new FileInputStream(imageServerPath);
            multipartFile = new MockMultipartFile("file", imageServerPath, "text/plain", input);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return multipartFile;
    }

    /**
     *
     * Function Description:
     *
     * @param: [code]
     * @return: cn.csdb.portal.model.Subject
     * @auther: hw
     * @date: 2018/10/22 15:03
     */
    public Subject findByCode(String code){
        DBObject query = QueryBuilder.start().and("subjectCode").is(code).get();
        BasicQuery basicQuery = new BasicQuery(query);
        List<Subject> subjects = mongoTemplate.find(basicQuery, Subject.class);
        if (subjects.size() > 0){
            return subjects.get(0);
        }else
            return null;
    }
}
