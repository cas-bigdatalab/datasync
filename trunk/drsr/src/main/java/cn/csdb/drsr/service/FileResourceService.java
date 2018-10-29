package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.repository.FileResourceDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.ZipUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import com.google.common.io.Files;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @program: DataSync
 * @description: DataTask Service
 * @author: shibaoping
 * @create: 2018-10-09 16:29
 **/

@Service
public class FileResourceService {

    private Logger logger = LoggerFactory.getLogger(FileResourceService.class);

    @Resource
    private FileResourceDao fileResourceDao;

    @Resource
    private ConfigPropertyService configPropertyService;

    @Transactional
    public String addData(DataSrc datasrc) {
        try {
            int addedRowCnt = fileResourceDao.addRelationData(datasrc);
            if (addedRowCnt == 1) {
                return "1";
            } else {
                return "0";
            }
        } catch (Exception e) {
            return "0";
        }
    }

    public List<DataSrc> queryData() {

        return fileResourceDao.queryRelationData();

    }

    public String editData(DataSrc dataSrc) {
        try {
            int addedRowCnt = fileResourceDao.editRelationData(dataSrc);
            if (addedRowCnt == 1) {
                return "1";
            } else {
                return "0";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @Transactional
    public String deleteRelation(int id) {
        int deletedRowCnt = fileResourceDao.deleteRelationData(id);
        if (deletedRowCnt == 1) {
            return "1";
        } else {
            return "0";
        }
    }

    public List<DataSrc> editQueryData(int id) {
        return fileResourceDao.editQueryData(id);
    }

    public Map queryTotalPage() {
        return fileResourceDao.queryTotalPage();
    }

    public List<DataSrc> queryPage(int requestedPage) {
        return fileResourceDao.queryPage(requestedPage);
    }

    public List<JSONObject> fileTreeLoading(String data) {
        File file;
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>();
        if ("#".equals(data)) {
            //获取服务器盘符
            File[] roots = File.listRoots();
            for (int i =0; i < roots.length; i++) {
                String root = roots[i].toString();
                String rootName= root.substring(0, root.indexOf("\\"));
                JSONObject jsonObject = new JSONObject();
                if (roots[i].isDirectory()) {
                    File file1 = roots[i];
                    File[] rootNode = file1.listFiles();
                    if (rootNode != null) {
                        if (rootNode.length == 0) {
                            jsonObject.put("children", false);
                        } else {
                            jsonObject.put("children", true);
                        }
                    } else {
                        jsonObject.put("children", false);
                    }
                    jsonObject.put("type", "directory");
                    JSONObject jo = new JSONObject();
                    jo.put("disabled", "true");
                    jsonObject.put("state", jo);
                    jsonObject.put("id", root.replaceAll("\\\\", "%_%"));
                    jsonObject.put("name", rootName);
                } else {
                    jsonObject.put("type", "file");
                    jsonObject.put("id", root.replaceAll("\\\\", "%_%"));
                    jsonObject.put("name", rootName);
                }
                jsonObjects.add(jsonObject);
            }
            return jsonObjects;
        } else {
            file = new File(data);
            if (!file.exists() || !file.isDirectory()) {
                return jsonObjects;
            } else {
                File[] fileList = file.listFiles();
                for (int i = 0; i < fileList.length; i++) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("id", fileList[i].getPath().replaceAll("\\\\", "%_%"));
                    jsonObject.put("name", fileList[i].getName().replaceAll("\\\\", "%_%"));
                    if (fileList[i].isDirectory()) {
                        File file1 = fileList[i];
                        File[] fileNode = file1.listFiles();
                        if (fileNode != null) {
                            if (fileNode.length == 0) {
                                jsonObject.put("children", false);
                            } else {
                                jsonObject.put("children", true);
                            }
                        } else {
                            jsonObject.put("children", false);
                        }
                        jsonObject.put("type", "directory");
                        JSONObject jo = new JSONObject();
                        jo.put("disabled", "true");
                        jsonObject.put("state", jo);
                    } else {
                        jsonObject.put("type", "file");
                    }
                    jsonObjects.add(jsonObject);
                }
                return jsonObjects;

            }
        }

/*
        Collections.sort(jsonObjects, new FileComparator());
*/
    }

    public String traversingFiles(String nodeId) {
        File file = new File(nodeId);
        StringBuffer Sb = new StringBuffer();
        if (file.isDirectory()) {
            File[] fileNode = file.listFiles();
            if (fileNode != null) {
                if (fileNode.length == 0) {
                    String str1 = file.getPath() + ";";
                    Sb.append(str1);
                } else {
                    for (int i = 0; i < fileNode.length; i++) {
                        Sb.append(traversingFiles(fileNode[i].getPath()));
                    }
                }
            } else {
                String str2 = file.getPath() + ";";
                Sb.append(str2);
            }
        } else {
            String str3 = file.getPath() + ";";
            Sb.append(str3);
        }

        System.out.print("Service层中记录的文件路径为：" + Sb.toString());
        return Sb.toString();
    }

    //求两个字符串数组的并集，利用set的元素唯一性
    public static String[] union(String[] arr1, String[] arr2) {
        Set<String> set = new HashSet<String>();
        for (String str : arr1) {
            set.add(str);
        }
        for (String str : arr2) {
            set.add(str);
        }
        String[] result = {};
        return set.toArray(result);
    }


    /**
     * Function Description:
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/23 10:01
     */
    public List<DataSrc> findAll() {
        return fileResourceDao.findAll();
    }

    public List<JSONObject> fileSourceFileList(String filePath) {
        return fileResourceDao.fileSourceFileList(filePath);
    }

    public DataSrc findById(int id) {
        return fileResourceDao.findById(id);
    }

    private static final ExecutorService executor = Executors.newFixedThreadPool(4);

    /**
     *
     * Function Description: 压缩文件任务包含的文件
     *
     * @param: [datasrcId, filePaths, dbFlag]
     * @return: void
     * @auther: hw
     * @date: 2018/10/23 16:11
     */
    public void packDataResource(final String fileName ,final List<String> filePaths, final CountDownLatch dbFlag) {
        executor.submit(new Callable<String>() {
            @Override
            public String call() throws InterruptedException {
                dbFlag.await();
                String zipFilePath = "zipFile";
                String zipFile = System.getProperty("drsr.framework.root") + zipFilePath + File.separator + fileName + ".zip";
                ZipArchiveOutputStream outputStream = null;
                try {
                    if (new File(zipFile).exists()) {
                        new File(zipFile).delete();
                    }
                    Files.createParentDirs(new File(zipFile));
                    outputStream = new ZipArchiveOutputStream(new File(zipFile));
                    outputStream.setEncoding("utf-8"); //23412
                    outputStream.setCreateUnicodeExtraFields(ZipArchiveOutputStream.UnicodeExtraFieldPolicy.ALWAYS);
                    outputStream.setFallbackToUTF8(true);
                    logger.info(".zip:文件数据源,开始打包文件...");
                    for (String filePath : filePaths) {
                        File file = new File(filePath);
                        if (!file.exists()) {
                            continue;
                        }
                        ZipUtils.zipDirectory(file, "", outputStream);
                    }
                } catch (Exception e) {
                    logger.error("打包失败", e);
                    return "error";
                } finally {
                    try {
                        outputStream.finish();
                        outputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                return "ok";
            }
        });
    }

}








