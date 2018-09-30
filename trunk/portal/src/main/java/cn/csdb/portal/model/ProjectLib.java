package cn.csdb.portal.model;

public class ProjectLib {
    private int id;
    private String projectLibName;
    private String projectLibCode;
    private String projectLibIntro;
    private String projectLibAdmin;
    private String adminPhone;
    private String adminAddress;
    private String adminAccount;
    private String ftpAccount;
    private String ftpPassword;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProjectLibName() {
        return projectLibName;
    }

    public void setProjectLibName(String projectLibName) {
        this.projectLibName = projectLibName;
    }

    public String getProjectLibCode() {
        return projectLibCode;
    }

    public void setProjectLibCode(String projectLibCode) {
        this.projectLibCode = projectLibCode;
    }

    public String getProjectLibIntro() {
        return projectLibIntro;
    }

    public void setProjectLibIntro(String projectLibIntro) {
        this.projectLibIntro = projectLibIntro;
    }

    public String getProjectLibAdmin() {
        return projectLibAdmin;
    }

    public void setProjectLibAdmin(String projectLibAdmin) {
        this.projectLibAdmin = projectLibAdmin;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }

    public String getAdminAddress() {
        return adminAddress;
    }

    public void setAdminAddress(String adminAddress) {
        this.adminAddress = adminAddress;
    }

    public String getAdminAccount() {
        return adminAccount;
    }

    public void setAdminAccount(String adminAccount) {
        this.adminAccount = adminAccount;
    }

    public String getFtpAccount() {
        return ftpAccount;
    }

    public void setFtpAccount(String ftpAccount) {
        this.ftpAccount = ftpAccount;
    }

    public String getFtpPassword() {
        return ftpPassword;
    }

    public void setFtpPassword(String ftpPassword) {
        this.ftpPassword = ftpPassword;
    }

    @Override
    public String toString() {
        return "ProjectLib{" +
                "id=" + id +
                ", projectLibName='" + projectLibName + '\'' +
                ", projectLibCode='" + projectLibCode + '\'' +
                ", projectLibIntro='" + projectLibIntro + '\'' +
                ", projectLibAdmin='" + projectLibAdmin + '\'' +
                ", adminPhone='" + adminPhone + '\'' +
                ", adminAddress='" + adminAddress + '\'' +
                ", adminAccount='" + adminAccount + '\'' +
                ", ftpAccount='" + ftpAccount + '\'' +
                ", ftpPassword='" + ftpPassword + '\'' +
                '}';
    }
}
