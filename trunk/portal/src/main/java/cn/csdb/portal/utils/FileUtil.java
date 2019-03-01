package cn.csdb.portal.utils;

import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;

/**
 * @Author jinbao
 * @Date 2019/2/28 10:37
 * @Description 文件 重命名，复制移动 ，删除等
 **/
public class FileUtil {

    private static Logger logger = LoggerFactory.getLogger(FileUtil.class);

    /**
     * 删除选中的目录||文件
     * 目录：删除当前目录已经目录下的所有
     * 文件：删除当前文件
     *
     * @param folderPath 选中的路径
     * @return code=success :删除成功
     */
    public static JSONObject deleteFolder(String folderPath) {
        JSONObject jsonObject = new JSONObject();
        File f = new File(folderPath);
        boolean key = false;
        try {
            if (f.exists() && f.isDirectory()) {
                String[] list = f.list();
                if (list.length > 0) {
                    String path = f.getAbsolutePath();
                    for (String s : list) {
                        String tempPath = path + File.separator + s;
                        deleteFolder(tempPath);
                    }
                    File tempFile = new File(path);
                    key = tempFile.delete();
                } else {
                    key = f.delete();
                }
            } else if (f.exists() && f.isFile()) {
                key = f.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("code","error");
            jsonObject.put("message","文件删除异常！");
            logger.error("删除异常路径："+folderPath);
        }
        if(key){
            jsonObject.put("code","success");
            jsonObject.put("message","删除成功！");
        } else {
            jsonObject.put("code","error");
            jsonObject.put("message","文件删除失败！");
        }
        return jsonObject;
    }

    /**
     * 复制当前文件||目录（含目录下文件）到指定路径
     *
     * @param oldPath 要复制的文件||目录
     * @param newPath 目标目录
     */
    public static JSONObject copyFolder(String oldPath, String newPath) {
        JSONObject jsonObject = new JSONObject();
        File oldFile = new File(oldPath);
        File newFile = new File(newPath);
        try {
            if (oldFile.exists() && oldFile.isFile()) {
                jsonObject = copyFile(oldFile, newFile);
            } else if (oldFile.exists() && oldFile.isDirectory()) {
                // 新位置生成对应层级
                String oldName = oldFile.getName();
                File tempNewFile = new File(newPath, oldName);
                tempNewFile.mkdir();
                newPath = tempNewFile.getAbsolutePath();
                // System.out.println("新的文件位置：" + newPath);
                String[] list = oldFile.list();
                for (String s : list) {
                    // 同一个作用域变量名称不要使用自拼接 !!!
                    // oldPath = oldPath + File.separator +s;
                    String tempPath = oldPath + File.separator + s;
                    copyFolder(tempPath, newPath);
                }
            }
        } catch (Exception e){
            e.printStackTrace();
            jsonObject.put("code","error");
            jsonObject.put("message","文件复制失败！");
            logger.error("《"+oldPath+"》复制到=》《"+newPath+"》异常！");
        }
        jsonObject.put("code","success");
        jsonObject.put("message","文件复制成功！");
        return jsonObject;
    }

    /**
     * 单纯复制 文件 到指定目录下
     *
     * @param oldFile 被复制文件
     * @param newFile 新的指定目录
     * @return 结果集
     */
    private static JSONObject copyFile(File oldFile, File newFile) {
        JSONObject jsonObject = new JSONObject();
        String name = oldFile.getName();
        String newPath = newFile.getAbsolutePath();
        File tempFile = new File(newPath, name);
        if (tempFile.exists()) {
            jsonObject.put("code", "error");
            jsonObject.put("message", "当前文件下已存在" + name);
            return jsonObject;
        } else {
            try {
                tempFile.createNewFile();
                System.out.println("生成文件：" + tempFile.getAbsolutePath());
                FileInputStream fis = new FileInputStream(oldFile);
                FileOutputStream fos = new FileOutputStream(tempFile);
                byte[] b = new byte[1024];
                int k = 0;
                while ((k = fis.read(b)) != -1) {
                    fos.write(b);
                }
                fos.flush();
                fos.close();
                fis.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                jsonObject.put("code", "error");
                jsonObject.put("message", "复制读取流异常！");
            } catch (IOException e) {
                e.printStackTrace();
                jsonObject.put("code", "error");
                jsonObject.put("message", "复制写入流异常！");
            }
        }
        jsonObject.put("code", "success");
        jsonObject.put("message", "文件复制成功！");
        return jsonObject;
    }

    /**
     * 重命名当前文件||目录
     *
     * @param oldFilePath 被重命名文件||目录
     * @param fileNewName 新名称
     */
    public static JSONObject renameFolder(String oldFilePath, String fileNewName) {
        JSONObject jsonObject = new JSONObject();
        boolean reName = false;
        try {
            File oldFile = new File(oldFilePath);
            String fileOldParent = oldFile.getParent();
            String newName = "";
            if (oldFile.exists() && oldFile.isDirectory()) {
                newName = fileOldParent + File.separator + fileNewName;
            } else if (oldFile.exists() && oldFile.isFile()) {
                String oldFileName = oldFile.getName();
                int i = oldFileName.lastIndexOf(".");
                String fileSuffix = oldFileName.substring(i, oldFileName.length());
                newName = fileOldParent + File.separator + fileNewName + fileSuffix;
            } else {
                jsonObject.put("code", "error");
                jsonObject.put("message", oldFile.getName() + " 不存在！");
                return jsonObject;
            }
            File newFile = new File(newName);
            if (newFile.exists()) {
                jsonObject.put("code", "error");
                jsonObject.put("message", newFile.getName() + " 已存在！");
                return jsonObject;
            }
            reName = oldFile.renameTo(newFile);
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("code", "error");
            jsonObject.put("message", "文件重命名异常！");
        }
        if (reName) {
            jsonObject.put("code", "success");
            jsonObject.put("message", "文件重命名成功！");
        } else {
            jsonObject.put("code", "error");
            jsonObject.put("message", "文件重命名失败！");
        }
        return jsonObject;
    }

}
