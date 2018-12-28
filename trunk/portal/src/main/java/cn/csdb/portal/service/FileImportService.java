package cn.csdb.portal.service;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;

/**
 * @ClassName FileImportService
 * @Description
 * @Author jinbao
 * @Date 2018/12/26 11:25
 * @Version 1.0
 **/
@Service
public class FileImportService {
    private Logger logger = LoggerFactory.getLogger(FileImportService.class);
    @Resource
    private CheckUserDao checkUserDao;

    @Transactional
    public JSONObject processExcel(Workbook workbook, String subjectCode) {
        // 接收excel 判断excel类型
        JSONObject jsonObject = new JSONObject();
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        boolean equals = xssfWorkbook.getClass().equals(workbook.getClass());
        Map<String, List<List<String>>> mapSheet = new LinkedHashMap<>();

        // 解析excel 隐藏的sheet，row跳过
        if (equals) {
            xssfWorkbook = (XSSFWorkbook) workbook;
            int numberOfSheets = xssfWorkbook.getNumberOfSheets();
            for (int s = 0; s < numberOfSheets; s++) {
                XSSFSheet sheet = xssfWorkbook.getSheetAt(s);
                if (xssfWorkbook.isSheetHidden(s) || sheet == null) {
                    continue;
                }
                List<List<String>> listString = new LinkedList<>();
                String sheetName = sheet.getSheetName();
                int physicalNumberOfRows = sheet.getPhysicalNumberOfRows();
                for (int r = 0; r < physicalNumberOfRows; r++) {
                    XSSFRow row = sheet.getRow(r);
                    if (sheet.isColumnHidden(r) || row == null) {
                        continue;
                    }
                    List<String> list = new LinkedList<>();
                    int physicalNumberOfCells = row.getPhysicalNumberOfCells();
                    for (int c = 0; c < physicalNumberOfCells; c++) {
                        XSSFCell cell = row.getCell(c);
                        String s1 = cell == null ? "" : cell.toString();
                        list.add(s1);
                    }
                    listString.add(list);
                }
                mapSheet.put(sheetName, listString);
            }
        }

        // 获取当前用户的MySQL连接
        DataSrc dataSrc = getDataSrc(subjectCode, "mysql");
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null) {
            jsonObject.put("code", "error");
            jsonObject.put("message", "数据库连接异常");
            return jsonObject;

        }
        // sheet中  第一行为字段中文名称，第二行为数据库字段名称， sheet页名称为表名称
        //判断表是否存在 存在则判断字段是否对应   不存在则新增数据表
        Iterator<Map.Entry<String, List<List<String>>>> iterator = mapSheet.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, List<List<String>>> next = iterator.next();
            String key = next.getKey();
            List<List<String>> value = next.getValue();
            boolean tableIsExist = DDL2SQLUtils.tableIsExist(connection, null, dataSrc.getDatabaseName(), key);

            if (tableIsExist) {
                // excel 数据表存在 校验数据表字段信息
                jsonObject = DDL2SQLUtils.verifyField(connection, null, null, key, value.get(1));
                if ("error".equals(jsonObject.getString("code"))) {
                    return jsonObject;
                }
                jsonObject = insertValue(connection, key, value);
                if ("success".equals(jsonObject.get("code"))) {
                    jsonObject.put("message", "增加数据成功");
                }
            } else {
                // excel 数据表不存在新增数据表 并 插入数据
                String newTable = DDL2SQLUtils.createNewTable(connection, null, null, key, value.get(1), "1");
                try {
                    PreparedStatement preparedStatement = connection.prepareStatement(newTable);
                    int i = preparedStatement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                    logger.error("Error:" + key + "表创建失败");
                    jsonObject.put("code", "error");
                    jsonObject.put("message", key + "表创建失败");
                    return jsonObject;
                }

                jsonObject = insertValue(connection, key, value);
                if ("success".equals(jsonObject.get("code"))) {
                    jsonObject.put("message", "新增数据表，并增加数据成功");
                }
            }
        }
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Error:数据连接关闭错误");
            jsonObject.put("code", "error");
            jsonObject.put("message", "数据连接关闭错误");
            return jsonObject;
        }
        return jsonObject;
    }

    private JSONObject insertValue(Connection connection, String key, List<List<String>> value) {
        JSONObject jsonObject = new JSONObject();
        String insertString = DDL2SQLUtils.insertSql(connection, key, value.subList(2, value.size()));
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(insertString);
            int i = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Error:" + key + "插入数据失败");
            jsonObject.put("code", "error");
            jsonObject.put("message", key + "插入数据失败");
            return jsonObject;
        }
        jsonObject.put("code", "success");
        jsonObject.put("message", "");
        return jsonObject;
    }

    DataSrc getDataSrc(String subjectCode, String DatabaseType) {
        Subject subject = checkUserDao.getSubjectByCode(subjectCode);
        DataSrc datasrc = new DataSrc();
        datasrc.setDatabaseName(subject.getDbName());
        datasrc.setDatabaseType(DatabaseType);
        datasrc.setHost(subject.getDbHost());
        datasrc.setPort(subject.getDbPort());
        datasrc.setUserName(subject.getDbUserName());
        datasrc.setPassword(subject.getDbPassword());
        return datasrc;
    }
}
