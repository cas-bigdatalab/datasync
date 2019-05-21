package cn.csdb.drsr.model;


import java.util.Date;

/**
 * @program: UserInformation
 * @description: data task
 * @author: caohq
 * @create: 2019-05-16 15:37
 **/
public class UserInformation {
    private String ID;
    private String SubjectName;
    private String SubjectCode;
    private String Admin;
    private String AdminPasswd;
    private String Contact;
    private String Phone;
    private String Email;
    private String FtpUser;
    private String FtpPassword;
    private String Brief;
    private String LoginDate;
    private String dbHost;
    private String dbPort;

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getSubjectName() {
        return SubjectName;
    }

    public void setSubjectName(String subjectName) {
        SubjectName = subjectName;
    }

    public String getSubjectCode() {
        return SubjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        SubjectCode = subjectCode;
    }

    public String getAdmin() {
        return Admin;
    }

    public void setAdmin(String admin) {
        Admin = admin;
    }

    public String getAdminPasswd() {
        return AdminPasswd;
    }

    public void setAdminPasswd(String adminPasswd) {
        AdminPasswd = adminPasswd;
    }

    public String getContact() {
        return Contact;
    }

    public void setContact(String contact) {
        Contact = contact;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String phone) {
        Phone = phone;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getFtpUser() {
        return FtpUser;
    }

    public void setFtpUser(String ftpUser) {
        FtpUser = ftpUser;
    }

    public String getFtpPassword() {
        return FtpPassword;
    }

    public void setFtpPassword(String ftpPassword) {
        FtpPassword = ftpPassword;
    }

    public String getBrief() {
        return Brief;
    }

    public void setBrief(String brief) {
        Brief = brief;
    }

    public String getLoginDate() {
        return LoginDate;
    }

    public void setLoginDate(String loginDate) {
        LoginDate = loginDate;
    }

    public String getDbHost() {
        return dbHost;
    }

    public void setDbHost(String dbHost) {
        this.dbHost = dbHost;
    }

    public String getDbPort() {
        return dbPort;
    }

    public void setDbPort(String dbPort) {
        this.dbPort = dbPort;
    }
}
