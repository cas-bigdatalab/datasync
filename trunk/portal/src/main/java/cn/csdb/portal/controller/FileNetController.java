package cn.csdb.portal.controller;

import cn.csdb.portal.service.FileNetService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Iterator;
import java.util.Map;

/**
 * @Author jinbao
 * @Date 2019/3/12 11:02
 * @Description 网盘功能模块
 **/
@Controller()
@RequestMapping("/fileNet")
public class FileNetController {

    @Resource
    private FileNetService fileNetService;


    /**
     * 获取展开目录信息
     *
     * @param request
     * @param rootPath 编码后需要展开的目录路径
     * @return
     */
    @RequestMapping(value = "/getCurrentFile")
    @ResponseBody
    public JSONObject getDirectoryUnderCurrent(HttpServletRequest request, String rootPath) {
        JSONObject jsonObject = new JSONObject();
        String parentPath = "";
        String ftpRootPath = splitFtpRootPathEnd(request);
        if ("".equals(rootPath)) {
            parentPath = ftpRootPath;
        } else {
            parentPath = rootPath;
        }
        parentPath = fileNetService.decodePath(parentPath, ftpRootPath);
        jsonObject = fileNetService.getDir(ftpRootPath, parentPath);
        return jsonObject;
    }

    /**
     * @param request 获取session中的"FtpFilePath"并处理
     * @return
     */
    String splitFtpRootPathEnd(HttpServletRequest request) {
        String ftpRootPath = (String) request.getSession().getAttribute("FtpFilePath");
        // TODO 部署时候请注释下一行
        ftpRootPath = "H:\\Cache\\file\\";

        boolean linux = ftpRootPath.endsWith("/");
        boolean win = ftpRootPath.endsWith("\\");
        if (linux || win) {
            String substring = ftpRootPath.substring(0, ftpRootPath.length() - 1);
            return substring;
        }
        return ftpRootPath;
    }


    /**
     * @param response   返回文件
     * @param selectPath 选中需要下载的文件全路径
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/downloadFile")
    public HttpServletResponse downloadFile(HttpServletRequest request, HttpServletResponse response, String selectPath) throws IOException {
        String ftpRootPath = splitFtpRootPathEnd(request);
        selectPath = fileNetService.decodePath(selectPath, ftpRootPath);
        File file = new File(selectPath);
        String fileName = file.getName();
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Type", "multipart/form-data");
        fileName = new String(fileName.getBytes("gb2312"), "ISO8859-1");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        InputStream input = new FileInputStream(file);
        OutputStream out = response.getOutputStream();
        byte[] buff = new byte[1024];
        int index = 0;
        while ((index = input.read(buff)) != -1) {
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();
        return response;
    }


    /**
     * 添加目录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addDirectory")
    @ResponseBody
    public JSONObject addDirectory(HttpServletRequest request) {
        JSONObject jsonObject = null;
        String dirName = request.getParameter("dirName");
        String s = request.getParameter("parentURI");
        String parentURI = s.replace("%_%", File.separator);
        String ftpRootPath = splitFtpRootPathEnd(request);
        parentURI = fileNetService.decodePath(parentURI, ftpRootPath);
        jsonObject = fileNetService.addDirectory(dirName, parentURI);
        return jsonObject;
    }


    /**
     * 上传文件到位置
     *
     * @return
     */
    @PostMapping("/addFile")
    @ResponseBody
    public JSONObject addFile(HttpServletRequest request) {
        String parentURI = request.getParameter("parentURI");
        String ftpRootPath = splitFtpRootPathEnd(request);
        parentURI = parentURI.replace("%_%", File.separator);
        parentURI = fileNetService.decodePath(parentURI, ftpRootPath);
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartHttpServletRequest.getFileMap();
        Iterator<Map.Entry<String, MultipartFile>> iterator = fileMap.entrySet().iterator();
        synchronized (this) {
            while (iterator.hasNext()) {
                Map.Entry<String, MultipartFile> next = iterator.next();
                fileNetService.addFile(parentURI, next);
            }
        }
        JSONObject jsonObject = new JSONObject();

        return jsonObject;
    }

    /**
     * 重命名文件
     *
     * @param currentPath 当前要被重命名的文件
     * @param newName     新的名字
     * @return
     */
    @RequestMapping(value = "/renameFile")
    @ResponseBody
    public JSONObject renameFile(HttpServletRequest request, String currentPath, String newName) {
        JSONObject jsonObject = new JSONObject();
        String ftpRootPath = splitFtpRootPathEnd(request);
        currentPath = fileNetService.decodePath(currentPath, ftpRootPath);
        jsonObject = fileNetService.renameFile(currentPath, newName);
        return jsonObject;
    }


    /**
     * 复制 粘贴文件
     *
     * @param oldFile 被复制项
     * @param newFile 粘贴位置
     * @return
     */
    @RequestMapping(value = "/copyPasteFile")
    @ResponseBody
    public JSONObject copyPasteFile(HttpServletRequest request, String oldFile, String newFile) {
        JSONObject jsonObject = new JSONObject();
        String ftpRootPath = splitFtpRootPathEnd(request);
        oldFile = fileNetService.decodePath(oldFile, ftpRootPath);
        newFile = fileNetService.decodePath(newFile, ftpRootPath);
        jsonObject = fileNetService.copyFolder(oldFile, newFile);
        return jsonObject;
    }
}
