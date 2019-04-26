package cn.csdb.portal.model;

import java.util.List;

/**
 * Created by shiba on 2019/4/24.
 */
public class ShowTypeDetail {
    private int status; //最外层保存使用，确定--删除相关列的status等于1的数据，取消，删除相关列status=2的数据
    private int type;  //字段显示类型
    private String columnName;//枚举暂用（sql）
    private String optionMode; //选项模式，
    private String relationTable;//关联表名，枚举暂用（sql）
    private String relationColumn;//关联表中列，枚举暂用（sql）
    private String address;//缺省值，主路径
    private String Separator;//分隔符
    private List<EnumData> enumData; //枚举类型对应关系

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getOptionMode() {
        return optionMode;
    }

    public void setOptionMode(String optionMode) {
        this.optionMode = optionMode;
    }

    public String getRelationTable() {
        return relationTable;
    }

    public void setRelationTable(String relationTable) {
        this.relationTable = relationTable;
    }

    public String getRelationColumn() {
        return relationColumn;
    }

    public void setRelationColumn(String relationColumn) {
        this.relationColumn = relationColumn;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSeparator() {
        return Separator;
    }

    public void setSeparator(String separator) {
        Separator = separator;
    }

    public List<EnumData> getEnumData() {
        return enumData;
    }

    public void setEnumData(List<EnumData> enumData) {
        this.enumData = enumData;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
