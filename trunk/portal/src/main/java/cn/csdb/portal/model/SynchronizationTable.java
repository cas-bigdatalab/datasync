package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = "t_synchronization_tables")
public class SynchronizationTable {
    @Id
    private String id;
    @Field("tableName")
    private String tableName; //同步表名
    @Field("subjectCode")
    private String subjectCode;
    @Field("frequency")
    private Long frequency; // 同步频次 毫秒值
    @Field("sqlString")
    private String sqlString; // 关联创建时的 DDL
    @Field("lastModify")
    private Long lastModify; // 最后一次修改的时间 毫秒值

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

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public Long getFrequency() {
        return frequency;
    }

    public void setFrequency(Long frequency) {
        this.frequency = frequency;
    }

    public String getSqlString() {
        return sqlString;
    }

    public void setSqlString(String sqlString) {
        this.sqlString = sqlString;
    }

    public Long getLastModify() {
        return lastModify;
    }

    public void setLastModify(Long lastModify) {
        this.lastModify = lastModify;
    }
}
