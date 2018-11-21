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
    <title>数据发布管理系统</title>
</head>

<body>

<div class="page-content">
    <h3><b>欢迎使用数据发布管理系统</b></h3>
    <shiro:hasRole name="root">
        系统管理员才可以看见
    </shiro:hasRole>
    <shiro:hasRole name="admin">
        专题库管理员才可以看见
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
