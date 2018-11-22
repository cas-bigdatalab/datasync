package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-11-22 10:52
 **/
@Document(collection = "t_auditMessage")
public class AuditMessage {
    @Id
    private String id;
    @Field("resourceId")
    private String resourceId;
    @Field("auditContent")
    private String auditContent;
    @Field("auditTime")
    private Date auditTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String audAtContent() {
        return auditContent;
    }

    public void setAuditContent(String auditContent) {
        this.auditContent = auditContent;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }
}