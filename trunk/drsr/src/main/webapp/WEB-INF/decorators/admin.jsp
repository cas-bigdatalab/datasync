<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/4/5
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>分布式多源异构数据资源汇聚传输系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${ctx}/resources/bundles/metronic/global/css/gfonts1.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!--BEGIN PAGE STYLES-->
    <sitemesh:write property="head"/>
    <!--END PAGE STYLES-->
    <!-- BEGIN THEME STYLES -->
    <!-- DOC: To use 'rounded corners' style just load 'components-rounded.css' stylesheet instead of 'components.css' in the below style tag -->
    <link href="${ctx}/resources/bundles/metronic/global/css/components.css" id="style_components" rel="stylesheet"
          type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/layout.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/themes/light.css" rel="stylesheet" type="text/css"
          id="style_color"/>
    <link href="${ctx}/resources/bundles/metronic/css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/globle.css" rel="stylesheet" type="text/css"/>
    <%--  <link href="${ctx}/resources/css/reset.css" rel="stylesheet" type="text/css"/>--%>
    <link href="${ctx}/resources/css/main.css" rel="stylesheet" type="text/css"/>

    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="${ctx}/resources/img/favicon.ico"/>
    <style type="text/css">
        input,select{
            border: 1px solid rgb(169, 169, 169);
        }
        a, a:hover, a:link  ,a:visited, a:active, a:hover{
            text-decoration: none !important;
        }
        body table{
            font-size: 14px;
        }
        .tabWrap{
            position: absolute;
            left: 0px;
            top: 0px;
            width: 500px;
            height: 500px;
            opacity: 0.5;
            background-color: #747474;
            /*display: none;*/
            background-image: url("${ctx}/resources/img/loading2.gif");
            background-repeat: no-repeat;
            background-position: center center;
            -webkit-transition: opacity 0.15s linear;
            -o-transition: opacity 0.15s linear;
            transition: opacity 0.15s linear;
            z-index: 99999;
            display: none;
        }
        /* .tabWrap img{
             width: 200px;
             height: 200px;
         }*/

        /* 下拉按钮样式 */
        .dropbtn {
            background-color: #339e69;
            color: white;
            padding: 0 0 0 0;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        /* 容器 <div> - 需要定位下拉内容 */
        .dropdown {
            position: relative;
            display: inline-block;
            float: right;
            background-color: #339e69;
            height: 100%;
            /*padding: 0 25px 0 40px;*/
            width: 170px;
        }

        /* 下拉内容 (默认隐藏) */
        .dropdown-content {
            opacity:0.6;
            filter:alpha(opacity=40);
            display: none;
            position: absolute;
            background-color: #1e8753;
            width: 100%;
            margin-top: 50px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        }

        /* 下拉菜单的链接 */
        .dropdown-content a {
            color: white;
            /*// padding: 6px 10px;*/
            font-size: 16px;
            width: 100%;
            text-decoration: none;
            display: block;
            text-align: center;
        }

        /* 鼠标移上去后修改下拉菜单链接颜色 */
        .dropdown-content a:hover {background-color: #2128f1}

        /* 在鼠标移上去后显示下拉菜单 */
        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* 当下拉内容显示后修改下拉按钮的背景颜色 */
        .dropdown:hover .dropbtn {
            background-color: #339e69;
        }
        .page-header.navbar {
            height: 7.373% !important;
        }
        .page-sidebar-wrapper{
            width: 18%;
            height: 87.545%;
            float: left;
            background: #e1e5e3 url(${ctx}/resources/login/img/left_bg.png) bottom no-repeat;
            background-size: 100%;
        }
        .page-content-wrapper {
            float: left;
            width: 82%;
            height: 87%;
            overflow-y: auto;
            background-color: #f1f1f1;
        }
        .page-content-wrapper .page-content {
            margin-left: 0px !important;
            padding: 0px 20px 0px 20px;
            min-height: 0px !important;
            height: 92%;
            background-color: #f1f1f1;
        }
        .page-sidebar-menu{
            background-color: none;
            text-align: center;
        }
        .page-sidebar-menu >a{
            background: red;
        }
        .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active > a, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active.open > a, .page-sidebar .page-sidebar-menu > li.active > a, .page-sidebar .page-sidebar-menu > li.active.open > a {
           background-color:  #4ab380;
        }
        .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active.open > a > .selected, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active > a > .selected, .page-sidebar .page-sidebar-menu > li.active.open > a > .selected, .page-sidebar .page-sidebar-menu > li.active > a > .selected {
            background-color:  #e1e5e3;
        }
        .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active.open > a > .selected, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active > a > .selected, .page-sidebar .page-sidebar-menu > li.active.open > a > .selected, .page-sidebar .page-sidebar-menu > li.active > a > .selected {
            border-left: 8px solid #4ab380;
        }
        .page-sidebar {
            width: 96%;
        }
        .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover, .page-sidebar {
            background-color: none;
        }
        .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active > a:hover, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu > li.active.open > a:hover, .page-sidebar .page-sidebar-menu > li.active > a:hover, .page-sidebar .page-sidebar-menu > li.active.open > a:hover {
            background: #4ab380;
        }
        .col-sm-3 {
            width: 32%;
        }
        .form-group {
            margin-bottom: 0.6%;
        }
        .messageCon {
            padding: 6px 0;
            top: 10%;
            position: absolute;
            margin-left: 16%;
        }
        .task-title{
            margin-top: 1%;
        }
        .task-head{
            padding-top: 2%;
        }
        .page-sidebar {
            background-color: rgba(0, 0, 0, 0);
        }
        .title{
            font-size: 18;
            /*font-family: 宋体;*/
        }
        .page-sidebar .page-sidebar-menu > li.active > a > .selected{
            border-top: 25px double transparent !important;
        }

    </style>
</head>
<body class="page-quick-sidebar-over-content page-style-square" style="font-family: 微软 !important;">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-static-top" style="background-color: #1e8753">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner">
        <!-- BEGIN LOGO -->
        <div class="page-logo" style="width: auto;">
            <a href="#">
                <h4 style="margin-top:14px;font-size: 21px;">分布式多源异构数据资源汇聚传输系统</h4>
            </a>
        </div>

        <div class="dropdown">
            <div style="position: absolute;margin-top: 6%;">
                <div style="float: left;"><img src="${ctx}/resources/login/img/user.png" height="34" width="34" style="margin-left: 26px" /></div>
                <div style="float: left;padding-top: 3px;" class="dropbtn">
                    <button class="dropbtn" style="margin-top:2px;margin-left: 15px;">${sessionScope.userName}</button>
                    <td ><a href="/drsr/logout" style="color: #ef124d;margin-left: 6px"><span class="glyphicon glyphicon-off" ></span></a></td>
                </div>
                <%--<div class="dropdown-content">--%>
                    <%--<a href="/drsr/logout"> <i class="glyphicon glyphicon-off"></i> &nbsp;安全退出</a>--%>
                <%--</div>--%>
            </div>

        </div>

        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END HEADER INNER -->
</div>


<!-- END HEADER -->
<div class="clearfix"></div>
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar-wrapper">
        <div class="page-sidebar navbar-collapse collapse">
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li>
                    <div style="height: 32px"></div>
                </li>
                <li>
                    <a href="${ctx}/subjectInfo">
                        <%--<i class="icon-wrench"></i>--%>
                        <span class="title"><img style="width: 24px;display: inline;" src="${ctx}/resources/login/img/icon04.png">&nbsp;数据节点信息</span>
                        <span class="arrow "></span>
                    </a>
                </li>
                <li>
                    <a href="javascript:;">
                        <%--<i class=" icon-drawer"></i>--%>
                        <span class="title"><img style="width: 24px;display: inline;" src="${ctx}/resources/login/img/icon01.png">&nbsp;数据源管理&nbsp;&nbsp;&nbsp;</span>
                        <%--<span class="title">数据源管理</span>--%>
                        <span class="arrow "></span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="${ctx}/relationship/index">
                                关系数据源</a>
                        </li>
                        <li>
                            <a href="${ctx}/fileResource/index">
                                文件数据源</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="${ctx}/dataUpload">
                        <%--<i class="icon-wrench"></i>--%>
                        <span class="title"><img style="width: 24px;display: inline;" src="${ctx}/resources/login/img/icon02.png">&nbsp;数据任务管理</span>

                        <%--<span class="title">数据任务管理</span>--%>
                        <span class="arrow "></span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/createTask">
                        <%--<i class="icon-wrench"></i>--%>
                        <span class="title"><img style="width: 24px;display: inline;" src="${ctx}/resources/login/img/icon03.png">&nbsp;设置数据任务</span>

                        <%--<span class="title">设置数据任务</span>--%>
                        <span class="arrow "></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="page-content-wrapper">
        <sitemesh:write property="body"/>

    </div>
    <!-- END CONTENT -->
</div>
<!-- BEGIN FOOTER -->
<div class="page-footer" style="text-align: center;background-color: #454241;height: 4.92% !important;">
    <div class="page-footer-inner" style="color: #FFF;float: none">
        2018-2020 &copy; 中国科学院计算机网络信息中心大数据部.版权所有.
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<div class="tabWrap"></div>

<!--[if lt IE 9]>
<script src="${ctx}/resources/bundles/metronic/global/plugins/respond.min.js"></script>
<script src="${ctx}/resources/bundles/metronic/global/plugins/excanvas.min.js"></script>
<![endif]-->
<script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/jquery/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="${ctx}/resources/bundles/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="${ctx}/resources/bundles/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/jquery/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/jquery/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${ctx}/resources/bundles/metronic/global/scripts/metronic.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/metronic/scripts/layout.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/bootbox/bootbox.min.js"></script>
<script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
<script src="${ctx}/resources/bundles/bootbox/bootbox.min.js"></script>
<script src="${ctx}/resources/js/regex.js"></script>
<script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
    jQuery(document).ready(function () {
        $.ajaxSetup({ cache: false });
        Metronic.init('${ctx}'); // init metronic core componets
        Layout.init(); // init layout
        bootbox.setLocale("zh_CN");
        $(function () {
            var path = window.location.pathname;
            if (path.indexOf('?') > -1)
                path = path.substring(0, path.indexOf('?'));
            $("ul.page-sidebar-menu a").each(function () {
                var href = $(this).attr("href");
                if (href.indexOf('?') > -1)
                    href = href.substring(0, href.indexOf('?'));
                if (href === path) {
                    $(this).parent().addClass("active");
                    if ($(this).parent().parent().hasClass("sub-menu")) {
                        $(this).parent().parent().parent().children("a").trigger("click");
                        $(this).parent().parent().parent().children("a").append('<span class="selected"></span>');
                        $(this).parent().parent().parent().addClass("active");
                    } else {
                        $(this).parent().children("a").append('<span class="selected"></span>');
                    }
                }
            });
        });
        function getSubStr(val, maxLength) {
            if (maxLength <= 0) {
                return val;
            }
            var valLength = strLength(val);
            if (valLength > maxLength) {
                val = subStr(val, maxLength);
                val = val + "...";
            }
            return val;
        }
    });
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
    bootbox.setLocale("zh_CN");
    template.helper("dateFormat", convertMilsToDateString);
    template.helper("dateTimeFormat", convertMilsToDateTimeString);
    function convertMilsToDateTimeString(mil) {
        var date = new Date(mil);
        return date.Format("yyyy-MM-dd hh:mm:ss");
    }
    function convertMilsToDateString(mil) {
        var date = new Date(mil);
        return date.Format("yyyy-MM-dd");
    }
</script>
<!-- END JAVASCRIPTS -->
<sitemesh:write property="div.siteMeshJavaScript"/>
</body>
</html>
