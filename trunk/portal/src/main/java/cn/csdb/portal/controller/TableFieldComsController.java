package cn.csdb.portal.controller;

/**
 * Created by Administrator on 2017/4/19 0019.
 */

import cn.csdb.portal.model.TableInfo;
import cn.csdb.portal.service.TableFieldComsService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class TableFieldComsController {
    private Logger logger = LoggerFactory.getLogger(TableFieldComsController.class);

    @Resource
    private TableFieldComsService tableFieldComsService;

    /**
     * 获取表的字段注释
     *
     * @param subjectCode
     * @param tableName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getTableFieldComs")
    public JSONObject getFieldComsByTableName(String subjectCode, String tableName) {
        JSONObject jsonObject = new JSONObject();
        Map<String, List<TableInfo>> fieldComsByTableName = tableFieldComsService.getDefaultFieldComsByTableName(subjectCode, tableName);
        if (fieldComsByTableName != null) {
            List<TableInfo> tableInfos = fieldComsByTableName.get(tableName);
            jsonObject.put("tableInfos", tableInfos);
        }
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value = "saveTableFieldComs")
    public JSONObject saveTableFieldComs(HttpServletRequest request,
                                         @RequestParam(required = false) String curDataSubjectCode,
                                         @RequestParam(required = false) String tableName,
                                         @RequestParam(required = false) String tableInfos,
                                         @RequestParam(required = false) String state ) {
        JSONObject jsonObject = new JSONObject();
        List<TableInfo> tableInfosList = JSON.parseArray(tableInfos, TableInfo.class);
        boolean result = tableFieldComsService.insertTableFieldComs(curDataSubjectCode, tableName, tableInfosList, state);
        // 注释完整之后更新MySQL中的注释
        if ("1".equals(state)) {
            String realPath = request.getRealPath("/") + "temp/";
            tableFieldComsService.syncMySQLComment(curDataSubjectCode, tableName, tableInfosList, realPath);
        }
        jsonObject.put("result", result);
        return jsonObject;
    }
}
