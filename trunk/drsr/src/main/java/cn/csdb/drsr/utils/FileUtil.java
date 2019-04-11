package cn.csdb.drsr.utils;

import com.alibaba.fastjson.JSONObject;

import java.io.*;

/**
 * @Author jinbao
 * @Date 2019/2/28 10:37
 * @Description 文件 重命名，复制移动 ，删除等
 **/
public class FileUtil {


    /**
     * 删除选中的目录||文件
     * 目录：删除当前目录已经目录下的所有
     * 文件：删除当前文件
     *
     * @param folderPath 选中的路径
     * @return true:删除成功
     */
    public static boolean deleteFolder(String folderPath) {
        File f = new File(folderPath);
        boolean key = true;
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
                    tempFile.delete();
                } else {
                    f.delete();
                }
            } else if (f.exists() && f.isFile()) {
                f.delete();
            }
        } catch (Exception e) {
            key = false;
            e.printStackTrace();
        }
        return key;
    }

    /**
     * 复制当前文件||目录（含目录下文件）到指定路径
     *
     * @param oldPath 要复制的文件||目录
     * @param newPath 目标目录
     */
    public static void copyFolder(String oldPath, String newPath) {
        File oldFile = new File(oldPath);
        File newFile = new File(newPath);
        if (oldFile.exists() && oldFile.isFile()) {
            JSONObject jsonObject = copyFile(oldFile, newFile);
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
                jsonObject.put("message", "复制读取流异常");
            } catch (IOException e) {
                e.printStackTrace();
                jsonObject.put("code", "error");
                jsonObject.put("message", "复制写入流异常");
            }
        }
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


    /**
     * 获取文件大小--进行换算
     *
     * @param size 文件大小
     * @auther caohq
     */
    public static String getPrintSize(long size) {
        //如果字节数少于1024，则直接以B为单位，否则先除于1024，后3位因太少无意义
        if (size < 1024) {
            return String.valueOf(size) + "B";
        } else {
            size = size / 1024;
        }
        //如果原字节数除于1024之后，少于1024，则可以直接以KB作为单位
        //因为还没有到达要使用另一个单位的时候
        //接下去以此类推
        if (size < 1024) {
            return String.valueOf(size) + "KB";
        } else {
            size = size / 1024;
        }
        if (size < 1024) {
            //因为如果以MB为单位的话，要保留最后1位小数，
            //因此，把此数乘以100之后再取余
            size = size * 100;
            return String.valueOf((size / 100)) + "."
                    + String.valueOf((size % 100)) + "MB";
        } else {
            //否则如果要以GB为单位的，先除于1024再作同样的处理
            size = size * 100 / 1024;
            return String.valueOf((size / 100)) + "."
                    + String.valueOf((size % 100)) + "GB";
        }
    }

}
