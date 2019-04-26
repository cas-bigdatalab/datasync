package cn.csdb.portal.repository;

import cn.csdb.portal.model.EnumData;
import cn.csdb.portal.model.ShowTypeDetail;
import cn.csdb.portal.model.ShowTypeInf;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.swing.text.html.HTMLDocument;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Repository
public class ShowTypeInfDao {

    @Resource
    private MongoTemplate mongoTemplate;

    //该表是否设置过显示类型,是否有数据
    public int checkData(String tableName) {
        ShowTypeInf showTypeInf = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
        if (showTypeInf == null) {
            return 0;
        } else {
            return 1;
        }
    }

    //    判断该列是否设置过类型
    public List<ShowTypeDetail> checkColumn(List<ShowTypeDetail> list, String columnName) {
        for (int i = 0; i < list.size(); i++) {
            if (columnName.equals(list.get(i).getColumnName())) {
                list.remove(i);
            }
        }
        return list;
    }

    //    判断该列是否设置过显示类型
    public int isColumn(List<ShowTypeDetail> list, String columnName) {
        int count = 0;
        for (int i = 0; i < list.size(); i++) {
            if (columnName.equals(list.get(i).getColumnName())) {
                count++;
            }
        }
        return count;
    }

    //    删除status的数据
    public List<ShowTypeDetail> deleteColumn(List<ShowTypeDetail> list, String columnName) {
        for (int i = 0; i < list.size(); i++) {
            if (columnName.equals(list.get(i).getColumnName()) && list.get(i).getStatus() == 2) {
                list.remove(i);
            }
        }
        return list;
    }

    public ShowTypeInf setShowTypeInf(String tableName) {
        ShowTypeInf showTypeInf = new ShowTypeInf();
        showTypeInf.setTableName(tableName);
        return showTypeInf;
    }

    public ShowTypeDetail setShowTypeDetail(int DisplayType, String columnName, String optionMode, String address) {
        ShowTypeDetail showTypeDetail = new ShowTypeDetail();
        showTypeDetail.setType(DisplayType);
        showTypeDetail.setAddress(address);
        showTypeDetail.setColumnName(columnName);
        showTypeDetail.setOptionMode(optionMode);

        return showTypeDetail;
    }

    //    保存URL类型
    public void saveTypeURL(int DisplayType, String tableName, String columnName, String optionMode, String address) {
        ShowTypeInf showTypeInf = setShowTypeInf(tableName);
        ShowTypeDetail showTypeDetail = setShowTypeDetail(DisplayType, columnName, optionMode, address);

        int check = checkData(tableName);
        if (check == 1) {

            ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
            showTypeInf.setTableComment(s.getTableComment());
            List<ShowTypeDetail> list = s.getShowTypeDetailList();
            int count = isColumn(list, columnName);
            if (count == 1) {
                showTypeDetail.setStatus(2);
            } else if (count == 0) {
                showTypeDetail.setStatus(1);
            } else {
                showTypeDetail.setStatus(2);
                list = deleteColumn(list, columnName);
            }
//            list=checkColumn(list,columnName);
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
            mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
        } else {
            showTypeDetail.setStatus(1);
            List<ShowTypeDetail> list = new ArrayList<>();
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            mongoTemplate.insert(showTypeInf);
        }
    }

    //    返回枚举类型
    public List<EnumData> getEnumDatas(Map<String, String> map) {
        List<EnumData> list1 = new ArrayList<>();
        Iterator it = map.entrySet().iterator();
        while (it.hasNext()) {
            EnumData enumData = new EnumData();
            Map.Entry entry = (Map.Entry) it.next();
            enumData.setKey(entry.getKey().toString());
            enumData.setValue(entry.getValue().toString());
            list1.add(enumData);
        }
        return list1;
    }

    //    保存枚举类型
    public void saveTypeEnumText(int DisplayType, String tableName, String columnName, String optionMode, Map<String, String> map) {
        ShowTypeInf showTypeInf = setShowTypeInf(tableName);
        ShowTypeDetail showTypeDetail = setShowTypeDetail(DisplayType, columnName, optionMode, "");
        int check = checkData(tableName);
        List<EnumData> list1 = new ArrayList<>();
        if (check == 1) {
//            去掉ShowTypeInf中重复的ShowTypeDetail，
            ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
            showTypeInf.setTableComment(s.getTableComment());
            List<ShowTypeDetail> list = s.getShowTypeDetailList();
//            list=checkColumn(list,columnName);  //去掉要修改的列，重新插入一条
            int count = isColumn(list, columnName);
            if (count == 1) {
                showTypeDetail.setStatus(2);
            } else if (count == 0) {
                showTypeDetail.setStatus(1);
            } else {
                showTypeDetail.setStatus(2);
                list = deleteColumn(list, columnName);
            }
            list1 = getEnumDatas(map);
            showTypeDetail.setEnumData(list1);
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
            mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
        } else {
            showTypeDetail.setStatus(1);
            list1 = getEnumDatas(map);
            showTypeDetail.setEnumData(list1);
            List<ShowTypeDetail> list = new ArrayList<>();
            list.add(showTypeDetail);

            showTypeInf.setShowTypeDetailList(list);
            mongoTemplate.insert(showTypeInf);
        }
    }

    //    枚举sql类型
    public void saveTypeEnumSql(int DisplayType,String tableName, String columnName, String optionMode, String relationColumn,String relationTable) {
        ShowTypeInf showTypeInf = setShowTypeInf(tableName);
        ShowTypeDetail showTypeDetail = setShowTypeDetail(DisplayType, columnName, optionMode, "");
        showTypeDetail.setRelationTable(relationTable);
        showTypeDetail.setRelationColumn(relationColumn);

        int check = checkData(tableName);
        if (check == 1) {
            ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
            showTypeInf.setTableComment(s.getTableComment());
            List<ShowTypeDetail> list = s.getShowTypeDetailList();
            int count = isColumn(list, columnName);
            if (count == 1) {
                showTypeDetail.setStatus(2);
            } else if (count == 0) {
                showTypeDetail.setStatus(1);
            } else {
                showTypeDetail.setStatus(2);
                list = deleteColumn(list, columnName);
            }
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
            mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
        }else{
            showTypeDetail.setStatus(1);
            List<ShowTypeDetail> list = new ArrayList<>();
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            mongoTemplate.insert(showTypeInf);
        }

    }


    //    删除status=2的值
    public void deleteStatusTwo(String tableName) {
        ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
        List<ShowTypeDetail> list = s.getShowTypeDetailList();
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getStatus() == 2) {
                list.remove(i);
            }
        }
        Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
        mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
    }


    //    删除status=2的列的status=1的数据，并将status=2改为status=1；
    public void updateSatusOne(String tableName) {
        ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
        List<ShowTypeDetail> list = s.getShowTypeDetailList();
        List<String> columns = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getStatus() == 2) {
                columns.add(list.get(i).getColumnName());
            }
        }
        if (columns.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                for (int ii = 0; ii < columns.size(); ii++) {
                    if (list.get(i).getStatus() == 1 && list.get(i).getColumnName().equals(columns.get(ii))) {
                        list.remove(i);
                    }
                }
            }
        }
        for (int i = 0; i < list.size(); i++) {
            list.get(i).setStatus(1);
        }
        Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
        mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
    }

    //    保存表名注释
    public void saveTableComment(String tableName, String tableComment) {
        Update update = Update.update("tableName", tableName).set("tableComment", tableComment);
        mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
    }

    //    保存关联数据表
    public void  saveTypeDatasheet(int DisplayType, String tableName, String columnName, String relationTable, String relationColumn) {
        ShowTypeInf showTypeInf = setShowTypeInf(tableName);
        ShowTypeDetail showTypeDetail = setShowTypeDetail(DisplayType, columnName, "", "");
        showTypeDetail.setRelationTable(relationTable);
        showTypeDetail.setRelationColumn(relationColumn);

        int check = checkData(tableName);
        if (check == 1) {
            ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
            showTypeInf.setTableComment(s.getTableComment());
            List<ShowTypeDetail> list = s.getShowTypeDetailList();
            int count = isColumn(list, columnName);
            if (count == 1) {
                showTypeDetail.setStatus(2);
            } else if (count == 0) {
                showTypeDetail.setStatus(1);
            } else {
                showTypeDetail.setStatus(2);
                list = deleteColumn(list, columnName);
            }
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
            mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
        }else{
            showTypeDetail.setStatus(1);
            List<ShowTypeDetail> list = new ArrayList<>();
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            mongoTemplate.insert(showTypeInf);
        }
    }

//    保存文件类型
    public void saveTypeFile(int DisplayType, String tableName, String columnName, String address, String optionMode,String Separator){
        ShowTypeInf showTypeInf = setShowTypeInf(tableName);
        ShowTypeDetail showTypeDetail = setShowTypeDetail(DisplayType, columnName, optionMode, address);
        showTypeDetail.setSeparator(Separator);
        int check = checkData(tableName);
        if (check == 1) {
            ShowTypeInf s = mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)), ShowTypeInf.class);
            showTypeInf.setTableComment(s.getTableComment());
            List<ShowTypeDetail> list = s.getShowTypeDetailList();
            int count = isColumn(list, columnName);
            if (count == 1) {
                showTypeDetail.setStatus(2);
            } else if (count == 0) {
                showTypeDetail.setStatus(1);
            } else {
                showTypeDetail.setStatus(2);
                list = deleteColumn(list, columnName);
            }
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            Update update = Update.update("tableName", tableName).set("showTypeDetailList", list);
            mongoTemplate.updateFirst(new Query(Criteria.where("tableName").is(tableName)), update, ShowTypeInf.class);
        }else{
            showTypeDetail.setStatus(1);
            List<ShowTypeDetail> list = new ArrayList<>();
            list.add(showTypeDetail);
            showTypeInf.setShowTypeDetailList(list);
            mongoTemplate.insert(showTypeInf);
        }
    }

//    查询该表设置的显示类型
    public ShowTypeInf getShowTypeInf(String tableName){
           ShowTypeInf showTypeInf=mongoTemplate.findOne(new Query(Criteria.where("tableName").is(tableName)),ShowTypeInf.class);

           return showTypeInf;
    }

}
