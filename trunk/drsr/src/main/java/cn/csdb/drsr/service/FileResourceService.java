package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.model.FileTreeNode;
import cn.csdb.drsr.repository.FileResourceDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.ConfigUtil;
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
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;

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

    public Map queryTotalPage(String SubjectCode) {
        return fileResourceDao.queryTotalPage(SubjectCode);
    }

    public List<DataSrc> queryPage(int requestedPage,String SubjectCode) {
        return fileResourceDao.queryPage(requestedPage,SubjectCode);
    }

    public JSONObject fileTreeLoading(String data,String localFilePath) {
        String FILE_SEPARATOR = System.getProperties().getProperty("file.separator");
        JSONObject jsonObject = new JSONObject();
        File file;
        data = data.replaceAll("%_%",Matcher.quoteReplacement(File.separator));
        localFilePath = localFilePath.replaceAll("%_%",Matcher.quoteReplacement(File.separator));
        List<Object> list=new ArrayList<Object>();
        list=getJobTree(localFilePath,list);
        jsonObject.put("list",list);
        return jsonObject;

    }

    //获取--树--数据源
    public List<Object> getJobTree(String path,List<Object> list){
        System.out.println("服务器系统:"+System.getProperties().getProperty("os.name"));
        String systemName=System.getProperties().getProperty("os.name");
        int isWindows=systemName.indexOf("Windows");
        // List<Object> list=new ArrayList<Object>();//递归获取文件
        List<Object> fileList=new ArrayList<Object>();//递归获取文件
        File dirFile = new File(path);//获取文件第一层
        File[] fs = dirFile.listFiles();
        list.add("{ id:\""+path+"\", pid:0, name:\""+path+"\", open:true,checked:false}");
        for (int i = 0; i < fs.length; i++) {
            if(fs[i].isFile()){//当对象为文件时
                boolean checked=false;
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                list.add("{ id:\""+fs[i].toString()+"\", pid:\""+pidStr+"\", name:\""+fs[i].getName()+"\", open:true,checked:\""+checked+"\"}");
                System.out.println();
            }else if(fs[i].isDirectory()){//当对象为路径时
                boolean checked=false;
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                list.add("{ id:\""+fs[i].toString()+"\", pid:\""+pidStr+"\", name:\""+fs[i].getName()+"\", open:false,isParent:true,checked:\""+checked+"\"}");
                List<Object> listStr=new ArrayList<Object>();//递归获取文件
                fileList=getFileList( fs[i].toString(),listStr);
                for(Object o:fileList){
                    list.add(o);
                }
            }
        }
        return list;
    }

    public List<Object> getFileList(String path, List<Object> list){
        String systemName=System.getProperties().getProperty("os.name");
        int isWindows=systemName.indexOf("Windows");
        File dirFile = new File(path);//获取文件第一层
        File[] fs = dirFile.listFiles();
        for(int i=0; i < fs.length; i++){
            if(fs[i].isDirectory()){
                boolean checked=false;
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                list.add("{ id:\""+fs[i].toString()+"\", pid:\""+pidStr+"\", name:\""+fs[i].getName()+"\", open:false,isParent:true,checked:\""+checked+"\"}");
              //  getFileList(fs[i].toString(),list);
            }else if (fs[i].isFile()){
                boolean checked=false;
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                list.add("{ id:\""+fs[i].toString()+"\", pid:\""+pidStr+"\", name:\""+fs[i].getName()+"\", open:false,checked:\""+checked+"\"}");
            }
        }
        return list;
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

    public Boolean checkFilePath(String filePath){
        File file = new File(filePath);
        boolean flag = file.exists();
        return flag;
    }
    /**
     * Function Description:
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/23 10:01
     */
    public List<DataSrc> findAll(String subjectCode) {

        return fileResourceDao.findAll(subjectCode);
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
    public String packDataResource(final String fileName , final List<String> filePaths, DataTask datatask) {
        String fileName1 = datatask.getDataTaskName()+"log.txt";//文件名及类型
        String path = "/logs/";
        FileWriter fw = null;
        File file1 = new File(path, fileName1);
        if(!file1.exists()){
            try {
                file1.createNewFile();
                fw = new FileWriter(file1, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            try{
                fw = new FileWriter(file1, true);
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================打包流程开始========================" + "\n");
//        dbFlag.await();
        String zipFilePath = "zipFile";
        File dir  = new File(System.getProperty("drsr.framework.root") + zipFilePath );
        if(!dir.exists()){
            dir.mkdirs();
        }
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
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+".zip:文件数据源,开始打包文件..." + "\n");
            for (String filePath : filePaths) {
                filePath = filePath.replace("%_%",File.separator);
                File file = new File(filePath);
                if (!file.exists()) {
                    continue;
                }
                ZipUtils.zipDirectory(file, "", outputStream);
            }
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"打包成功" + "\n");
        } catch (Exception e) {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"打包失败"+ e+"\n");
            return "error";
        } finally {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"=========================打包流程结束========================" + "\n");
            try {
                outputStream.finish();
                outputStream.close();
                pw.flush();
                fw.flush();
                pw.close();
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "ok";
    }


    public List<FileTreeNode> asynLoadingTree(String data,String path,String result){
        System.out.println("服务器系统:"+System.getProperties().getProperty("os.name"));
        String systemName=System.getProperties().getProperty("os.name");
        int isWindows=systemName.indexOf("Windows");
        List<FileTreeNode> nodeList=new ArrayList<FileTreeNode>();
        File dirFile = new File(path);//获取文件第一层
        File[] fs = dirFile.listFiles();
        if("init".equals(result)){
           nodeList.add(new FileTreeNode(path,"0",path,"true","true","false"));
        }
        for (int i = 0; i < fs.length; i++) {
            if(fs[i].isFile()){//当对象为文件时
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                nodeList.add(new FileTreeNode(fs[i].toString(),pidStr,fs[i].getName(),"false","false","false"));
            }else if(fs[i].isDirectory()){//当对象为路径时
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                nodeList.add(new FileTreeNode(fs[i].toString(),pidStr,fs[i].getName(),"false","true","false"));
              //  nodeList=loadingTree(fs[i].toString(),nodeList);
            }
        }
        return nodeList;
    }

    public  List<FileTreeNode> loadingTree(String path,List<FileTreeNode> nodeList){
        String systemName=System.getProperties().getProperty("os.name");
        File dirFile = new File(path);//获取文件第一层
        File[] fs = dirFile.listFiles();
        int isWindows=systemName.indexOf("Windows");
        for (int i = 0; i < fs.length; i++) {
            if(fs[i].isFile()){//当对象为文件时
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                nodeList.add(new FileTreeNode(fs[i].toString(),pidStr,fs[i].getName(),"false","false","false"));
            }else if(fs[i].isDirectory()){//当对象为路径时
                String pidStr="";
                if("-1".equals(isWindows+"")){//linux
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("/"));
                }else {
                    pidStr=fs[i].toString().substring(0,fs[i].toString().lastIndexOf("\\"));
                }
                nodeList.add(new FileTreeNode(fs[i].toString(),pidStr,fs[i].getName(),"false","true","false"));
               // nodeList=loadingTree(fs[i].toString(),nodeList);
            }
        }

        return nodeList;
    }

}








