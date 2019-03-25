<%--
  Created by IntelliJ IDEA.
  User: caohq
  Date: 2019/3/19
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>分布式多源异构数据资源汇聚传输系统</title>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/login/css/home.css" rel="stylesheet" type="text/css"/>
</head>
    <body class="loginbg">

    <%
        String username = "";
        String password = "";
        String remberPassword = "";
        Cookie[] c = request.getCookies();
        if (c != null) {
            for (int i = 0; i < c.length; i++) {
                if ("username".equals(c[i].getName())) {
                    username = c[i].getValue();
//                    System.out.println(username);
                } else if ("password".equals(c[i].getName())) {
                    password = c[i].getValue();
//                    System.out.println(password);
                }else if("remberPassword".equals(c[i].getName())){
                    remberPassword= c[i].getValue();
//                    System.out.println(remberPassword);
                }
            }
        } else {
            username = " ";
            password = " ";
            remberPassword="";
        }
    %>

        <div class="loginbox">
            <%--<h3>数据资源汇聚传输工具</h3>--%>
            <h3>分布式多源异构数据资源汇聚传输系统</h3>
            <table>
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" id="userName" value="<%=username%>"></td>
                </tr>
                <tr>
                    <td>密　码：</td>
                    <td><input type="password" id="passWord" value="<%=password%>"></td>
                </tr>
            </table>
            <div class="row">
                <div class="col-xs-6">
                    <input type="checkbox" id="remberPassword" <%=remberPassword%> <label>记住密码</label>
                </div>
                <div class="col-xs-6 text-right">
                    <%--<a href="#">注册</a>--%>
                    <butto class="btn btn-primary" id="login_btn" onclick="login()">登录</butto>
                </div>
            </div>
        </div>


        <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.js" type="text/javascript"></script>
        <script type="text/javascript">

            $(document).keypress(function(e) {
                if((e.keyCode || e.which)==13) {
                    $("#login_btn").click();
                }
            });

            function login(){
                var username=document.getElementById("userName").value;
                var password=document.getElementById("passWord").value;
                var remberPassword = document.getElementById('remberPassword').checked;

                $.ajax({
                    url:"${ctx}/login?userName=" + username + "&password=" + password+"&remberPassword="+remberPassword,
                    type:"POST",
                    success:function(data){
                        data=eval('(' + data + ')');
                        if(data==1){
                            location.href="${ctx}/subjectInfo";
                        }else if(data==2){
                            toastr["error"]("账号或者密码不能为空！", "提示！");
                        }else{
                            toastr["error"]("用户名或密码错误！", "提示！");
                        }
                    },
                    error:function(){
                        toastr["error"]("验证超时！", "提示！");

                    }

                })
            }


        </script>
    </body>
</html>
