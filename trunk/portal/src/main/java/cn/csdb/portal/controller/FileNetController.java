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
//        String ftpRootPath = request.getSession().getAttribute("FtpFilePath") + "file";
        String ftpRootPath = "H:\\Cache\\file\\";
        ftpRootPath = splitFtpRootPathEnd(ftpRootPath);
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
     * @param ftpRootPath 抹去ftpRootPath最后一位的分隔符
     * @return
     */
    String splitFtpRootPathEnd(String ftpRootPath) {
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
//        String ftpRootPath = (String) request.getSession().getAttribute("FtpFilePath");
        String ftpRootPath = "H:\\Cache\\file\\";
        ftpRootPath = splitFtpRootPathEnd(ftpRootPath);
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

//        String ftpFilePath = (String)request.getSession().getAttribute("FtpFilePath");
        String ftpFilePath = "H:\\Cache\\file\\";
        parentURI = fileNetService.decodePath(parentURI, ftpFilePath);
        jsonObject = fileNetService.addDirectory(dirName, parentURI);
        return jsonObject;
    }


    /**
     * 上传文件到位置
     *
     * @param request
     * @return
     */
    @PostMapping("/addFile")
    @ResponseBody
    public JSONObject addFile(HttpServletRequest request) {
        String s = request.getParameter("parentURI");
        //        String ftpRootPath = (String) request.getSession().getAttribute("FtpFilePath");
        String ftpRootPath = "H:\\Cache\\file\\";
        ftpRootPath = splitFtpRootPathEnd(ftpRootPath);
        String parentURI = s.replace("%_%", File.separator);
        parentURI = fileNetService.decodePath(s, ftpRootPath);
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

}
