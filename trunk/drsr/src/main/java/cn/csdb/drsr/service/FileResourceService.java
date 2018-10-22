package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.repository.FileResourceDao;
import cn.csdb.drsr.repository.RelationDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;

/**
 * @program: DataSync
 * @description:  DataTask Service
 * @author: shibaoping
 * @create: 2018-10-09 16:29
 **/

@Service
public class FileResourceService {
    @Resource
    private FileResourceDao fileResourceDao;

   @Transactional
    public String addData(DataSrc datasrc)
    {
        try {
            int addedRowCnt = fileResourceDao.addRelationData(datasrc);
            if(addedRowCnt == 1){
                return "1";
            }else{
                return "0";
            }
        }catch(Exception e){
            return "0";
        }
    }

    public List<DataSrc> queryData(){

        return fileResourceDao.queryRelationData();

    }

    public String editData(DataSrc dataSrc){
        try {
            int addedRowCnt = fileResourceDao.editRelationData(dataSrc);
            if(addedRowCnt == 1){
                return "1";
            }else{
                return "0";
            }
        }catch (Exception e){
            e.printStackTrace();
            return "0";
        }
    }

    @Transactional
    public String deleteRelation(int id)
    {
        int deletedRowCnt = fileResourceDao.deleteRelationData(id);
        if (deletedRowCnt == 1)
        {
            return "1";
        }
        else
        {
            return "0";
        }
    }

    public List<DataSrc> editQueryData(int id){
        return fileResourceDao.editQueryData(id);
    }

    public Integer queryTotalPage(){
        return fileResourceDao.queryTotalPage();
    }

    public List<DataSrc> queryPage(int requestedPage)
    {
        return fileResourceDao.queryPage(requestedPage);
    }

    public String testFileIsExist(String filePath) {
        File rfile = new File(filePath);
        if (!rfile.exists()) {

            return "fileIsNull";

        } else {
            return "fileIsNotNull";
        }
    }

    public String testOsName(){
        Properties prop = System.getProperties();
        String os = prop.getProperty("os.name");
        if (os != null && os.toLowerCase().indexOf("linux") > -1) {

            return "linux";

        } else {

            return "windows";

        }
    }


   /* public static void main(String[] arg){
        File[] roots = File.listRoots();
        for (File file : roots) {
            System.out.println(file.getAbsolutePath());
        }

    }*/


    public static void main(String []args){
//获取系统的所有盘符
        File[] file = File.listRoots();
        for (int i = 0; i < file.length; i++) {
            getAllFile(file[i]);
        }
    }



    private static void getAllFile(File dir) {
        LinkedList<File> list = new LinkedList<>();
//把文件夹放入队列容器
        list.addFirst(dir);
//首先判断文件是否存在
        System.out.println(list.size());
        while(!list.isEmpty()){//判断该目录下是否为空文件
//取出文件夹
            File fisrstfile = list.removeLast();
//去出该文件所有文件
            File[] files = fisrstfile.listFiles();
//如果该文件夹不是空文件
            if(files!=null){
//取出文件夹 判断是文件还是文件夹?
                for (File file : files) {
                    if (file.isDirectory()) {
//文件夹
                        System.out.println("文件夹:"+file.getAbsolutePath());
                        list.add(file);
                    }else{
//文件
                        System.out.println(file);
                    }
                }
            }
        }
    }
}


