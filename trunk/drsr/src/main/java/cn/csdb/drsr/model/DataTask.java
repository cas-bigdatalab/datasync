package cn.csdb.drsr.model;

import java.util.Date;

/**
 * @program: DataSync
 * @description: data task
 * @author: xiajl
 * @create: 2018-09-30 15:37
 **/
public class DataTask {
    private int dataTaskId;
    private int dataSourceId;
    private String tableName;
    private String sqlString;
    private String sqlTableNameEn;
    private String sqlFilePath;
    private String filePath;
    private Date createTime;
    private String creator;
    private String status;

    public int getDataTaskId() {
        return dataTaskId;
    }

    public void setDataTaskId(int dataTaskId) {
        this.dataTaskId = dataTaskId;
    }

    public int getDataSourceId() {
        return dataSourceId;
    }

    public void setDataSourceId(int dataSourceId) {
        this.dataSourceId = dataSourceId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getSqlString() {
        return sqlString;
    }

    public void setSqlString(String sqlString) {
        this.sqlString = sqlString;
    }

    public String getSqlTableNameEn() {
        return sqlTableNameEn;
    }

    public void setSqlTableNameEn(String sqlTableNameEn) {
        this.sqlTableNameEn = sqlTableNameEn;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSqlFilePath() {
        return sqlFilePath;
    }

    public void setSqlFilePath(String sqlFilePath) {
        this.sqlFilePath = sqlFilePath;
    }
}
