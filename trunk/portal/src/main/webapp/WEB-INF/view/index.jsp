<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2017/9/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>主题库后台管理系统
    </title>
</head>

<body>

<div class="page-content">
    <shiro:hasRole name="root">
        <h3><b>欢迎使用主题库后台管理系统</b></h3>
    </shiro:hasRole>
    <shiro:hasRole name="admin">
        <h3><b>欢迎使用烟草科研主题库构建与发布工具</b></h3>

        <div class="task-title" style="font-size: 16px; font-weight: bold; padding-top: 50px; padding-right:250px;text-align: center;">
            <span>主题库信息</span>
        </div>

        <div class="messageCon"  style="font-size: 14px; padding-left: 50px; padding-right: 50px;">



                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;">主题库名称:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.subjectName}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4 " style="text-align: right;">主题库代码:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.subjectCode}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;">管理员账号:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.admin}</div>
                </div>

                <%--<div class="form-group">
                    <label  class="col-sm-3 control-label">密码:</label>
                    <div class="col-sm-8">${subject.adminPasswd}</div>
                </div>--%>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;">联系人:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.contact}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;">电话:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.phone}</div>
                </div>

                <div class="form-group">
                    <div class="col-sm-4" style="text-align: right;">邮箱:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.email}</div>
                </div>


                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;">描述:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.brief}</div>
                </div>
        </div>

    </shiro:hasRole>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</div>

</html>
