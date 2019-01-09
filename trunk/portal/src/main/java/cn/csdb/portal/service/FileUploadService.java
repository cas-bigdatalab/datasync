package cn.csdb.portal.service;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.utils.ConfigUtil;
import cn.csdb.portal.utils.FtpUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 * @ClassName FileUploadService
 * @Description 文件 FTP 上传
 * @Author jinbao
 * @Date 2019/1/2 10:50
 * @Version 1.0
 **/
@Service
public class FileUploadService {
    private Logger logger = LoggerFactory.getLogger(FileUploadService.class);
    @Resource
    private CheckUserDao checkUserDao;

    private FtpUtil ftpUtil = new FtpUtil();

    public JSONObject ftpUpload(String subjectCode, Map.Entry<String, MultipartFile> map) {
        JSONObject jsonObject = new JSONObject();
        String key = map.getKey();
        MultipartFile value = map.getValue();
        FileItem fileItem = ((CommonsMultipartFile) value).getFileItem();
        try {
            InputStream inputStream = value.getInputStream();
            String name = fileItem.getName();
            System.out.println(name);
            Subject mysql = getDataSrc(subjectCode, "mysql");
            String host = mysql.getDbHost();
            String userName = mysql.getFtpUser();
            String password = mysql.getFtpPassword();
            String configFilePath = FileUploadService.class.getClassLoader().getResource("config.properties").getFile();
            String port = ConfigUtil.getConfigItem(configFilePath, "FrpPort");
            String ftpRootPath = ConfigUtil.getConfigItem(configFilePath, "FtpRootPath");
            boolean connect = ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            ftpUtil.upload(name, fileItem.getInputStream());
//            ftpUtil.disconnect();

//            ftpUtil.uploadFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

    Subject getDataSrc(String subjectCode, String DatabaseType) {
        Subject subject = checkUserDao.getSubjectByCode(subjectCode);
//        DataSrc datasrc = new DataSrc();
//        datasrc.setDatabaseName(subject.getDbName());
//        datasrc.setDatabaseType(DatabaseType);
//        datasrc.setHost(subject.getDbHost());
//        datasrc.setPort(subject.getDbPort());
//        datasrc.setUserName(subject.getDbUserName());
//        datasrc.setPassword(subject.getDbPassword());
        return subject;
    }

}
