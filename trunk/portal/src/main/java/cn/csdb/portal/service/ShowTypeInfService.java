package cn.csdb.portal.service;

import cn.csdb.portal.model.Described_Table;
import cn.csdb.portal.model.ShowTypeInf;
import cn.csdb.portal.repository.ShowTypeInfDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShowTypeInfService {
    @Resource
    private ShowTypeInfDao showTypeInfDao;

    public void saveTypeURL(int DisplayType, String tableName, String columnName, String optionMode, String address, String subjectCode) {
        showTypeInfDao.saveTypeURL(DisplayType, tableName, columnName, optionMode, address, subjectCode);
    }

    public void saveTypeEnum(int DisplayType, String tableName, String columnName, String optionMode, String address, String enumData, String subjectCode) {
        String s[];
        Map<String, String> map = new HashMap<>();
        if (optionMode.equals("1")) {
            s = enumData.split(",");
            for (int i = 0; i < s.length; i++) {
                String ss[] = s[i].split("=");
                if (ss.length == 2)
                    map.put(ss[0], ss[1]);
            }
            showTypeInfDao.saveTypeEnumText(DisplayType, tableName, columnName, optionMode, map, subjectCode);
        }
        if (optionMode.equals("2")) {
            String s1[] = address.split(",");
            String c2[] = s1[0].trim().split("select");
            String c3[] = s1[1].trim().split("from");
            String s_col = c2[1].trim();
            String s_col2 = c3[0].trim();
            String s_Table = c3[1].trim();
            String relationTable=s_Table;
            String relationColumnK = s_col;
            String relationColumnV = s_col2;

            System.out.println(s_col + "..." + s_col2 + "..." + s_Table);
//            if (columnName.equals(s_col)) {
//                relationColumn = s_col2;
//            }else if(columnName.equals(s_col2)){
//                relationColumn=s_col;
//            }

            showTypeInfDao.saveTypeEnumSql(DisplayType, tableName, columnName, optionMode, relationColumnK, relationColumnV, relationTable, subjectCode);
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
    public void saveTypeDatasheet(int DisplayType, String tableName, String columnName, String[] s_Table, String[] s_column, String subjectCode) {
        showTypeInfDao.saveTypeDatasheet(DisplayType, tableName, columnName, s_Table, s_column, subjectCode);
    }

    //    保存文件类型
    public void saveTypeFile(int DisplayType, String tableName, String columnName, String address, String optionMode, String Separator, String subjectCode) {
        showTypeInfDao.saveTypeFile(DisplayType, tableName, columnName, address, optionMode, Separator, subjectCode);
    }

    //    查询该表设置的显示类型
    public ShowTypeInf getShowTypeInf(String tableName){
        ShowTypeInf showTypeInf=showTypeInfDao.getShowTypeInf(tableName);
        return showTypeInf;
    }

    public List<String> getAllDescribed(String subjectCode, String tableName, String columnName) {
        List<Described_Table> list = showTypeInfDao.getAllDescribed(subjectCode); //已描述表
        List<String> list1 = new ArrayList<>();
        if (list != null) {
            for (Described_Table d : list) {
                if (!d.getTableName().equals(tableName)) {
                    list1.add(d.getTableName());
                }
            }
        }
        List<String> exitTable = showTypeInfDao.getSheetTable(tableName, columnName);
        if (exitTable != null) {
            for (int i = 0; i < list1.size(); i++) {
                for (int j = 0; j < exitTable.size(); j++) {
                    if (list1.get(i).equals(exitTable.get(j))) {
                        list1.remove(i);
                    }
                }
            }
        } else {
            return list1;
        }

        return list1;
    }

    }