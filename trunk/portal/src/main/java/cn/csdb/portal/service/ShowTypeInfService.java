package cn.csdb.portal.service;

import cn.csdb.portal.model.ShowTypeInf;
import cn.csdb.portal.repository.ShowTypeInfDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Service
public class ShowTypeInfService {
    @Resource
    private ShowTypeInfDao showTypeInfDao;

    public void saveTypeURL(int DisplayType, String tableName, String columnName, String optionMode, String address) {
        showTypeInfDao.saveTypeURL(DisplayType, tableName, columnName, optionMode, address);
    }

    public void saveTypeEnum(int DisplayType, String tableName, String columnName, String optionMode, String address, String enumData) {
        String s[];
        Map<String, String> map = new HashMap<>();
        if (optionMode.equals("1")) {
            s = enumData.split(",");
            for (int i = 0; i < s.length; i++) {
                String ss[] = s[i].split("=");
                if (ss.length == 2)
                    map.put(ss[0], ss[1]);
            }
            showTypeInfDao.saveTypeEnumText(DisplayType, tableName, columnName, optionMode, map);
        }
        if (optionMode.equals("2")) {
            String s1[] = address.split(",");
            String c2[] = s1[0].trim().split("select");
            String c3[] = s1[1].trim().split("from");
            String s_col = c2[1].trim();
            String s_col2 = c3[0].trim();
            String s_Table = c3[1].trim();
            String relationTable=s_Table;
            String relationColumn="";
            System.out.println(s_col + "..." + s_col2 + "..." + s_Table);
            if (columnName.equals(s_col)) {
                relationColumn = s_col2;
            }else if(columnName.equals(s_col2)){
                relationColumn=s_col;
            }
           showTypeInfDao.saveTypeEnumSql( DisplayType, tableName,  columnName,  optionMode,  relationColumn, relationTable);
        }
    }

    //    删除status=2的值
    public void deleteStatusTwo(String tableName) {
        showTypeInfDao.deleteStatusTwo(tableName);
    }

    //    保存表名注释
    public void saveTableComment(String tableName, String tableComment) {
        showTypeInfDao.saveTableComment(tableName, tableComment);
    }

    //点击外层保存按钮
    public void updateSatusOne(String tableName) {
        showTypeInfDao.updateSatusOne(tableName);
    }

    //    数据库关联表
    public void saveTypeDatasheet(int DisplayType, String tableName, String columnName, String relationTable, String relationColumn) {
        showTypeInfDao.saveTypeDatasheet(DisplayType, tableName, columnName, relationTable, relationColumn);
    }

    //    保存文件类型
    public void saveTypeFile(int DisplayType, String tableName, String columnName, String address, String optionMode, String Separator) {
        showTypeInfDao.saveTypeFile(DisplayType, tableName, columnName, address, optionMode, Separator);
    }

    //    查询该表设置的显示类型
    public ShowTypeInf getShowTypeInf(String tableName){
        ShowTypeInf showTypeInf=showTypeInfDao.getShowTypeInf(tableName);
        return showTypeInf;
    }

    }
