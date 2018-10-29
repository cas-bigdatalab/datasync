<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/10/26
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>
<head>
    <title>login</title>
</head>
<body>

<div id="loginDialog">
    <h4 id="title">客户端登录</h4>

        <form id="loginForm" method="post" accept-charset="utf-8"  action="${ctx}/subjectAdmin/validateLogin">
            <label for="userName">
                用户名<span style="color: red;">*</span>
            </label>
            <input type="text" placeholder="请输入用户名" id="userName" name="userName" required="required"/>

            <label>
                密&nbsp;&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
            </label>
            <input type="text" placeholder="请输入密码" id="password" name="password"  required="required" />

            <div>
                ${loginNotice}
            </div>

            <div>
                <button id="login" class="btn green" type="submit">
                    登录
                </button>
                <button id="reset" class="btn default"  type="reset">
                    重置
                </button>
            </div>
        </form>
</div>

</body>
</html>
