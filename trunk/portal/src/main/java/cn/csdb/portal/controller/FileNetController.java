package cn.csdb.portal.controller;

import cn.csdb.portal.service.FileNetService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
}
