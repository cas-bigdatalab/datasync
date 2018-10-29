<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/09/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>客户端首页</title>

    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>


</head>

<body>

<div class="page-content">

    <div class="source-head">
        <span>DataSync / 登录</span>
    </div>

    <div class="source-title" style="text-align: center">
        <span>客户端登录</span>
    </div>
<div style="width:40%; text-align: center;">
    <div class="source-table" style="float: left;margin: 0 auto">

        <label for="userName">
            用户名<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入用户名" id="userName" name="userName" required="required"/>
        <br />
        <br />

        <label>
            密&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入密码" id="password" name="password"  required="required" />
        <br />
        <br />

        <label>
            专题库代码<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入专题库代码" id="subjectCode" name="subjectCode"  required="required" />
        <br />
        <br />

        <button id="loginBtn" class="btn green" type="submit">
            登陆
        </button>
        <button id="resetBtn" class="btn default"  data-dismiss="modal">
            重置
        </button>
    </div>
</div>




</div>

</body>
</html>
