package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataTask;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.ConfigPropertyService;
import cn.csdb.portal.service.DataTaskService;
import cn.csdb.portal.service.SubjectMgmtService;
import cn.csdb.portal.utils.FileUtil;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.TreeNode;
import cn.csdb.portal.utils.ZipUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-12 10:15
 **/
@Controller
@RequestMapping("/service")
public class HttpServiceController {

    @Autowired
    private DataTaskService dataTaskService;

    @Autowired
    private SubjectMgmtService subjectMgmtService;

    @Autowired
    private ConfigPropertyService configPropertyService;

    @Value("#{systemPro['ftpRootPath']}")
    private String ftpRootPath;

    @Value("#{systemPro['ftpFilePath']}")
    private String ftpFilePath;

    @ResponseBody
    @RequestMapping(value = "getDataTask", method = {RequestMethod.POST, RequestMethod.GET})
    public int getDataTask(@RequestBody String requestString) {
        System.out.println(requestString);
        JSONObject requestJson = JSON.parseObject(requestString);
        String subjectCode = requestJson.get("subjectCode").toString();
        String dataTaskString = requestJson.get("dataTask").toString();
        DataTask dataTask = JSON.parseObject(dataTaskString, DataTask.class);
//        String realPath = dataTask.getRealPath();
        Subject subject = subjectMgmtService.findByCode(subjectCode);
        String siteFtpPath = subject.getFtpFilePath();
        siteFtpPath += "temp/";
        try {
            FileUtil.createFileByPathAndType(siteFtpPath, "dir");
        } catch (IOException e) {
            e.printStackTrace();
        }
        dataTask.setSubjectCode(subject.getSubjectCode());
        String sqlFilePath = dataTask.getSqlFilePath();
        sqlFilePath = sqlFilePath.replaceAll("%_%", File.separator);
        System.out.println("sqlFilePath========" + sqlFilePath);
        String[] sqlfilePathList = sqlFilePath.split(";");
        String filepath = dataTask.getFilePath();
        StringBuffer sqlfilePathBuffer = new StringBuffer();
        String structDBFile = "";
        String dataDBFile = "";
        String zipFile = "";
        String unZipPath = "";
        for (String fp : sqlfilePathList) {
            if (fp.equals("")) {
                continue;
            }
            String fileName = "";
            if (fp.indexOf("/") > 0) {
                fileName = fp.substring(fp.lastIndexOf("/") + 1);
            } else if (fp.indexOf("\\") > 0) {
                fileName = fp.substring(fp.lastIndexOf("\\") + 1);
            }
            sqlfilePathBuffer.append(siteFtpPath + fileName + ";");
            if (dataTask.getDataTaskType().equals("mysql")) {
                String sqlZip = siteFtpPath + dataTask.getDataTaskId() + ".zip";
//                System.out.println("-------sqlZip"+sqlZip);
                File sqlfiles = new File(sqlZip);
                ZipUtil zipUtil = new ZipUtil();
                try {
                    zipUtil.unZip(sqlfiles, siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql");
                    zipFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql";

                } catch (Exception e) {
                    e.printStackTrace();
                }
                dataDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "data.sql";
                structDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "struct.sql";
                System.out.println("dataDBFile---------" + dataDBFile);
                System.out.println("structDBFile---------" + structDBFile);
            } else if (dataTask.getDataTaskType().equals("file")) {
                zipFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + ".zip";
                System.out.println("+++++++++" + zipFile);
//                System.out.println("=========="+fileName);
//                unZipPath = siteFtpPath + File.separator + "file" + File.separator + subjectCode + "_" + dataTask.getDataTaskId();
                unZipPath = dataTask.getRemoteuploadpath();
                System.out.println("dataTask.getRemoteuploadpath()" + dataTask.getRemoteuploadpath());
                File tempFile = new File(unZipPath);
                if (!tempFile.exists()) {
                    tempFile.mkdirs();
                }

                File f = new File(siteFtpPath + File.separator + "file" + File.separator);
                if (!f.exists()) {
                    f.mkdirs();
                }

            } else if (dataTask.getDataTaskType().equals("oracle")) {
                String sqlZip = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + dataTask.getDataTaskId() + ".zip";
//                System.out.println("-------sqlZip"+sqlZip);
                File sqlfiles = new File(sqlZip);
                ZipUtil zipUtil = new ZipUtil();
                try {
                    zipUtil.unZip(sqlfiles, siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql");
                    zipFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql";

                } catch (Exception e) {
                    e.printStackTrace();
                }
                dataDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "data.sql";
                structDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "struct.sql";
                System.out.println("dataDBFile---------" + dataDBFile);
                System.out.println("structDBFile---------" + structDBFile);
            }
        }
        dataTask.setSqlFilePath(sqlfilePathBuffer.toString());
        if (dataTask.getDataTaskType().equals("mysql") || "oracle".equals(dataTask.getDataTaskType())) {
            String username = configPropertyService.getProperty("db.username");
            String password = configPropertyService.getProperty("db.password");
            String dbName = subject.getDbName();

            SqlUtil sqlUtil = new SqlUtil();
            try {
                System.out.println("passwprd------" + password);
                sqlUtil.importSql("localhost", username, password, dbName, structDBFile, dataDBFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            File file = new File(zipFile);
            ZipUtil zipUtil = new ZipUtil();
            try {
                List<String> listName = zipUtil.unZip(file, unZipPath);
                System.out.println("解压的文件名称集合" + listName.toString());
                System.out.println("源路径：" + zipFile);
                System.out.println("目标路径：" + unZipPath);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        dataTask.setDataTaskId(null);
        dataTaskService.insertDataTask(dataTask);

        // 删除上传无用的源文件
        JSONObject jsonObject = FileUtil.deleteFolder(zipFile);
        System.out.println("文件路径：" + zipFile);
        System.out.println("文件删除状态：" + jsonObject.get("code"));
        return 1;
    }

    @RequestMapping(value = "/treeNodeAsync")
    @ResponseBody
    public JSONObject treeNodes(String subName, String asyncString) {
        boolean async = true;
        if (!"async".equals(asyncString)) {
            async = false;
        }
        String rootPath = ftpRootPath + subName + ftpFilePath;
        JSONObject jsonObject = new TreeNode().jsTreeNodes(rootPath, async);
        return jsonObject;
    }
}
