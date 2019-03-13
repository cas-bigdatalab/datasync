package cn.csdb.portal.controller;

import cn.csdb.portal.service.FileNetService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
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
     * @param rootPath 需要展开的目录路径
     * @return
     */
    @RequestMapping(value = "/getCurrentFile")
    @ResponseBody
    public JSONObject getDirectoryUnderCurrent(HttpServletRequest request, String rootPath) {
        JSONObject jsonObject = new JSONObject();
        String parentPath = "";
//        String ftpRootPath = request.getSession().getAttribute("FtpFilePath") + "file";
        String ftpRootPath = "H:\\Cache\\file\\";
        if ("".equals(rootPath)) {
            parentPath = ftpRootPath;
        } else {
            parentPath = rootPath;
        }

        List<Map<String, String>> dirInfo = fileNetService.getDir(ftpRootPath, parentPath);
        jsonObject.put("data", dirInfo);
        jsonObject.put("code", "success");
        return jsonObject;
    }

    /**
     * @param response   返回文件
     * @param selectPath 选中需要下载的文件全路径
     * @return
     * @throws IOException
     */
    @RequestMapping("/downloadFile")
    public HttpServletResponse downloadFile(HttpServletResponse response, String selectPath) throws IOException {
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

}
