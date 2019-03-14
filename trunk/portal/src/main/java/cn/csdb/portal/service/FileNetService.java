package cn.csdb.portal.service;

import org.springframework.stereotype.Service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author jinbao
 * @Date 2019/3/12 11:22
 * @Description 网盘功能
 **/
@Service
public class FileNetService {

    /**
     * @param parentPath 父级目录
     * @return 指定目录中文件的 名称、类型、大小、最后修改时间、路径
     */
    public List<Map<String, String>> getDir(String ftpRootPath, String parentPath) {
        File f = new File(parentPath);
        File[] files = f.listFiles();
        List<Map<String, String>> fList = new ArrayList<>(20);

        // 校验并返回父级目录
        Map<String, String> mParent = verifyParentPath(ftpRootPath, parentPath);
        fList.add(mParent);
        if (files.length != 0) {
            for (File file : files) {
                Map<String, String> map = new HashMap<>(16);
                String fileName = file.getName();
                map.put("fileName", fileName);

                String fileType = file.isFile() ? "file" : "dir";
                map.put("fileType", fileType);

                if ("file".equals(fileType)) {
                    String fileLength = getFormateFileLength(file.length());
                    map.put("fileLength", fileLength);
                }

                long lastModified = file.lastModified();
                Date date = new Date(lastModified);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String fileLastModified = sdf.format(date);
                map.put("fileLastModified", fileLastModified);

                String filePath = file.getPath();
                map.put("filePath", filePath);

                fList.add(map);
            }
        }

        return fList;
    }

    /**
     * @param ftpRootPath 用户文件根目录
     * @param parentPath  请求目录
     * @return 处理后的父级目录
     */
    Map<String, String> verifyParentPath(String ftpRootPath, String parentPath) {
        Map<String, String> map = new HashMap<>(16);
        if (ftpRootPath != null && parentPath != null && ftpRootPath.equals(parentPath)) {
            map.put("filePath", ftpRootPath);
            map.put("fileName", "...");
        } else {
            File f = new File(parentPath);
            String parent = f.getParent();
            map.put("filePath", parent + File.separator);
            map.put("fileName", "返回上级");
        }
        map.put("fileType", "dir");
        return map;
    }

    /**
     * @return 文件大小进位 例：1024B —> 1KB
     */
    private String getFormateFileLength(long fileLength) {
        if (fileLength <= 1024) {
            return fileLength + " B";
        } else {
            fileLength /= 1024;
        }

        if (fileLength <= 1024) {
            return fileLength + "KB";
        } else {
            fileLength /= 1024;
        }

        //因为如果以MB || GB为单位的话，要保留最后1位小数，
        //因此，把此数乘以100之后再取余
        if (fileLength <= 1024) {
            fileLength = fileLength * 100;
            return (fileLength / 100) + "." + (fileLength % 100) + "MB";
        } else {
            fileLength = fileLength * 100;
            return (fileLength / 100) + "." + (fileLength % 100) + "GB";
        }
    }
}
