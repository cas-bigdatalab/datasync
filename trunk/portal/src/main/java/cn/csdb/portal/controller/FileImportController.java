package cn.csdb.portal.controller;

import cn.csdb.portal.model.TableField;
import cn.csdb.portal.service.FileImportService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @ClassName FileImportController
 * @Description
 * @Author jinbao
 * @Date 2018/12/26 9:32
 * @Version 1.0
 **/
@Controller
@RequestMapping("/fileImport")
public class FileImportController {
    private Logger logger = LoggerFactory.getLogger(FileImportController.class);
    @Resource
    private FileImportService fileImportService;

    /**
     * 接到文件生成excel
     *
     * @param request
     * @param file
     * @return
     */
    @PostMapping("/excel")
    @ResponseBody
    public JSONObject fileImport(HttpServletRequest request, @RequestParam(value = "file") MultipartFile file) {
        JSONObject jsonObject = new JSONObject();
        String subjectCode = request.getParameter("subjectCode");
        String realPath = request.getRealPath("/") + "temp/";
        String tempFilePath = "";
        if (!file.isEmpty()) {
            try {
                tempFilePath = createTempFile(file, realPath);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if ("".equals(tempFilePath)) {
                jsonObject.put("code", "error");
                jsonObject.put("message", "文件缓冲异常，请联系管理员");
                return jsonObject;
            }
            jsonObject = fileImportService.processExcel(tempFilePath, subjectCode);
        } else {
            jsonObject.put("code", "error");
            jsonObject.put("message", "上传文件为空,请重新选择");
        }
        boolean b = deleteTempFile(tempFilePath);
        jsonObject.put("fileStatus", b);
        return jsonObject;
    }

    @PostMapping("/createTableAndInsertValue")
    @ResponseBody
    public JSONObject createTableAndInsertValue(HttpServletRequest request, @RequestParam(value = "file") MultipartFile file) {
        JSONObject jsonObject = new JSONObject();
        String subjectCode = request.getParameter("subjectCode");
        String tableData = request.getParameter("tableData");
        String tableName = request.getParameter("tableName");
        String realPath = request.getRealPath("/") + "temp/";
        String tempFilePath = "";
        List<TableField> tableFields = JSON.parseArray(tableData, TableField.class);
        if (!file.isEmpty()) {
            try {
                tempFilePath = createTempFile(file, realPath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        jsonObject = fileImportService.createTableAndInsertValue(tableName, tableFields, tempFilePath, subjectCode);
        boolean b = deleteTempFile(tempFilePath);
        jsonObject.put("fileStatus", b);
        return jsonObject;
    }

    @PostMapping("/onlyInsertValue")
    @ResponseBody
    public JSONObject onlyInsertValue(HttpServletRequest request, @RequestParam(value = "file") MultipartFile file) {
        JSONObject jsonObject = new JSONObject();
        String subjectCode = request.getParameter("subjectCode");
        String tableData = request.getParameter("tableData");
        String tableName = request.getParameter("tableName");
        String realPath = request.getRealPath("/") + "temp/";
        String tempFilePath = "";
        List<TableField> tableFields = JSON.parseArray(tableData, TableField.class);
        if (!file.isEmpty()) {
            try {
                tempFilePath = createTempFile(file, realPath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        jsonObject = fileImportService.onlyInsertValue(tableName, tableFields, tempFilePath, subjectCode);
        boolean b = deleteTempFile(tempFilePath);
        jsonObject.put("fileStatus", b);
        return jsonObject;
    }

    private String createTempFile(MultipartFile file, String realPath) throws IOException {
        String tempFilePath = "";
        InputStream inputStream = file.getInputStream();
        byte[] b = new byte[16];
        int flg = -1;
        String name = file.getOriginalFilename();
        File fileTemp = new File(realPath);
        if (!fileTemp.exists()) {
            fileTemp.mkdirs();
        } else {
            File f = new File(realPath + name);
            if (!f.exists()) {
                f.createNewFile();
            }
            FileOutputStream fos = new FileOutputStream(f);
            while ((flg = inputStream.read(b, 0, 16)) != -1) {
                fos.write(b, 0, 16);
            }
            fos.flush();
            fos.close();
            tempFilePath = f.getPath();
        }
        return tempFilePath;
    }

    private boolean deleteTempFile(String realPath) {
        boolean del = false;
        File f = new File(realPath);
        if (f.exists()) {
            del = f.delete();
        }
        return del;
    }
}
