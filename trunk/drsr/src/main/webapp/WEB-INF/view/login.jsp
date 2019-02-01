<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/10/30
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>分布式数据汇交管理系统</title>
    <link href="${ctx}/resources/bundles/loginPlug-in/css/style.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div id="container">
    <div id="output">
        <div class="containerT">
            <h1>用户登录</h1>
            <form class="form" id="entry_form" action="${ctx}/login" method="post">
                <input type="text" placeholder="用户名" id="userName" name="userName" >
                <input type="password" placeholder="密码" id="password" name="password">
                <p <%--style="display: none"--%>>
                    <font color="red">${loginNotice}</font>
                </p>
                <button type="submit" id="entry_btn">登录</button>
                <div id="prompt" class="prompt"></div>
            </form>
        </div>
    </div>
</div>
<script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/loginPlug-in/js/vector.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
        Victor("container", "output");   //登陆背景函数
       // $("#entry_name").focus();
        $(document).keydown(function(event){
            if(event.keyCode==13){
                $("#entry_btn").click();
            }
        });
    });

    $(document).ready(function () {
        var username = $('#userName'), password = $('#password');
        var erroru = $('erroru'), errorp = $('errorp');
        var submit = $('#submit'), udiv = $('#u'), pdiv = $('#p');
        username.blur(function () {
            if (username.val() == '') {
                udiv.attr('errr', '');
            } else {
                udiv.removeAttr('errr');
            }
        });
        password.blur(function () {
            if (password.val() == '') {
                pdiv.attr('errr', '');
            } else {
                pdiv.removeAttr('errr');
            }
        });

        submit.on('click', function (event) {
            event.preventDefault();
        });
    });

</script>
</body>

</html>

