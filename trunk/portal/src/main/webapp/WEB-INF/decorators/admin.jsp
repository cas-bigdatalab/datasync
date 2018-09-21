<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/9/21
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>DataSync专题库门户管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>

    <!--BEGIN PAGE STYLES-->
    <sitemesh:write property="head"/>
    <!--END PAGE STYLES-->
    <!-- BEGIN THEME STYLES -->

    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/frontend/layout/css/style.css">
    <link rel="stylesheet" type="text/css"
          href="${ctx}/resources/bundles/frontend/pages/css/style-shop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/frontend/layout/css/style-responsive.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/frontend/layout/css/themes/blue.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/frontend/layout/css/custom.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/style.css">
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="${ctx}/resources/img/favicon.ico"/>
    <style>

    </style>
</head>
<body>
<div class="top_div">
    <div class="container">

    </div>
</div>

<div class="con_div">
    <div class=" container tatle_div">DataSync专题库门户管理系统</div>
    <div class="container daohang_div">
        <div class="col-xs-6 nav_div">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td><a href="${ctx}/">首页</a></td>
                    <td><a href="${ctx}/resource/resourcesList">资源与服务</a></td>
                    <td><a href="${ctx}/demcons/main/list/all">需求与咨询</a></td>
                    <td><a href="${ctx}/person/myApplyPage">个人中心</a></td>
                </tr>
            </table>
        </div>
        <div class="col-xs-6"></div>
    </div>
    <div class="container neirong_div">
        <sitemesh:write property="body"/>
    </div>
</div>

<div class="foot_div">2018-2020 &copy; 中国科学院计算机网络信息中心大数据部.版权所有.</div>


<script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
<script src="${ctx}/resources/bundles/jquery/jquery-migrate.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/back-to-top.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/layout.js"></script>
<script src="${ctx}/resources/bundles/bootbox/bootbox.min.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        scrolltotop.init('${ctx}');
        Layout.init();
        bootbox.setLocale("zh_CN");
    });
</script>
<sitemesh:write property="div.siteMeshJavaScript"/>
</body>
</html>
