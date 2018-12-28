package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.FileImportService;
import com.alibaba.fastjson.JSONObject;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;

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
    private Logger logger= LoggerFactory.getLogger(FileImportController.class);
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
        InputStream inputStream = null;
        Workbook workBook = null;
        String subjectCode = request.getParameter("subjectCode");
        if (!file.isEmpty()) {
            try {
                inputStream = file.getInputStream();
                workBook = WorkbookFactory.create(inputStream);
            } catch (InvalidFormatException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            jsonObject = fileImportService.processExcel(workBook, subjectCode);
        }
        return jsonObject;
    }

}
