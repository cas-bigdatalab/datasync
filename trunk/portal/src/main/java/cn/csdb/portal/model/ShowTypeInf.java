package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

/**
 * Created by shiba on 2019/4/24.
 */
@Document(collection = "t_showTypeInf")
public class ShowTypeInf {
    @Id
    private String id;
    @Field("tableName")
    private String tableName;
    @Field("tableComment")
    private String tableComment;//表名注释

    @Field("showTypeDetailList")
    private List<ShowTypeDetail> showTypeDetailList;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableComment() {
        return tableComment;
    }

    public void setTableComment(String tableComment) {
        this.tableComment = tableComment;
    }

    public List<ShowTypeDetail> getShowTypeDetailList() {
        return showTypeDetailList;
    }

    public void setShowTypeDetailList(List<ShowTypeDetail> showTypeDetailList) {
        this.showTypeDetailList = showTypeDetailList;
    }
}
