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
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>DataSync专题库门户管理系统</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="page-content">
    <h3><b>欢迎使用DataSync专题库门户管理系统</b></h3>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script src="${ctx}/resources/js/subStrLength.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</div>

</html>
