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
<%@ page import="cn.csdb.commons.utils.*" %>

<html>
<head>
    <title>DataSync烟草专题库客户端</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${ctx}/resources/bundles/metronic/global/css/gfonts1.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!--BEGIN PAGE STYLES-->
    <sitemesh:write property="head"/>
    <!--END PAGE STYLES-->
    <!-- BEGIN THEME STYLES -->
    <!-- DOC: To use 'rounded corners' style just load 'components-rounded.css' stylesheet instead of 'components.css' in the below style tag -->
    <link href="${ctx}/resources/bundles/metronic/global/css/components.css" id="style_components" rel="stylesheet"
          type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/layout.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/themes/light.css" rel="stylesheet" type="text/css"
          id="style_color"/>
    <link href="${ctx}/resources/bundles/metronic/css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/globle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="${ctx}/resources/img/favicon.ico"/>
    <style type="text/css">
        input,select{
            border: 1px solid rgb(169, 169, 169);
        }
        a, a:hover, a:link  ,a:visited, a:active, a:hover{
            text-decoration: none !important;
        }
    </style>
</head>
<body class="page-quick-sidebar-over-content page-style-square">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-static-top" style="background-color: #438eb9">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner">
        <!-- BEGIN LOGO -->
        <div class="page-logo" style="width: auto;">
            <a href="${ctx}/">
                <h4 style="margin-top:14px ">DataSync烟草专题库客户端</h4>
            </a>

            <div class="menu-toggler sidebar-toggler hide">
                <!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
            </div>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse"
           data-target=".navbar-collapse">
        </a>
        <!-- END RESPONSIVE MENU TOGGLER -->
        <!-- BEGIN TOP NAVIGATION MENU -->
        <div class="top-menu">
            <ul class="nav navbar-nav pull-right">
                <!-- BEGIN USER LOGIN DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-user">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        <i class="glyphicon glyphicon-user"></i>
                        <span class="username username-hide-on-mobile">
                           <%--<shiro:user>
                               欢迎您！${sessionScope.loginId} &nbsp;&nbsp;
                               &lt;%&ndash;<span>角色:${sessionScope.roleNames} </span>&ndash;%&gt;
                           </shiro:user>--%>
                        </span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">

                       <%-- <shiro:guest>
                            <li>
                                <a href="${applicationScope.systemPro['cas.url.prefix']}/login?service=${applicationScope.systemPro['drsr.url']}/shiro-cas">
                                    <i class="icon-rocket"></i>用户登录
                                </a>
                            </li>
                        </shiro:guest>--%>
                        <%--<shiro:user>
                            <li>
                                <a target='_blank'
                                   href="${applicationScope.systemPro['cas.url.prefix']}/reg01004Action.do?userID=<%=CasURLCode.encode(session.getAttribute("loginId").toString())%>">
                                    <i class="icon-calendar"></i>用户信息</a>
                            </li>
                            <li>
                                <a href="${applicationScope.systemPro['cas.url.prefix']}/logout?service=${applicationScope.systemPro['drsr.url']}/logout">
                                    <i class="icon-key"></i>退出</a>
                            </li>
                        </shiro:user>--%>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
            </ul>
        </div>
        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix"></div>
<div class="page-container" style="min-height: 750px">
    <!-- BEGIN SIDEBAR -->
    <%--<div class="page-sidebar-wrapper">
        <div class="page-sidebar navbar-collapse collapse">
            <!-- BEGIN SIDEBAR MENU -->
            <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
            <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
            <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
            <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
            <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
            <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li>
                    <div style="height: 70px"></div>
                </li>
                <li class="start">
                    <a href="${ctx}/">
                        <i class="icon-home"></i>
                        <span class="title">首页</span>
                        <span class="arrow"></span>
                    </a>
                </li>
                &lt;%&ndash; <shiro:hasRole name="Register">&ndash;%&gt;
                <li>
                    <a href="javascript:;">
                        <i class=" icon-drawer"></i>
                        <span class="title">数据源管理</span>
                        <span class="arrow "></span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="${ctx}/relationalDatabase?currentPage=1">
                                关系数据库</a>
                        </li>
                        <li>
                            <a href="${ctx}/fileSource?currentPage=1">
                                文件数据源</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="${ctx}/resource/manager">
                        <i class="icon-wrench"></i>
                        <span class="title">注册资源管理</span>
                        <span class="arrow "></span>
                    </a>
                </li>
                &lt;%&ndash; </shiro:hasRole>
                 <shiro:hasRole name="管理员">&ndash;%&gt;
                &lt;%&ndash;<li>
                    <a href="${ctx}/resource/audit/localAudit">
                        <i class="icon-lock"></i>
                        <span class="title">注册资源审核</span>
                        <span class="arrow "></span>
                    </a>
                </li>

                <li>
                    <a href="${ctx}/resCatalog">
                        <i class="icon-list"></i>
                        <span class="title">本地资源目录管理</span>
                        <span class="arrow "></span>
                    </a>
                </li>

                <li>
                    <a href="${ctx}/metaTemplate/">
                        <i class="icon-layers"></i>
                        <span class="title">元数据模板管理</span>
                        <span class="arrow "></span>
                    </a>
                </li>&ndash;%&gt;

            </ul>
            <!-- END SIDEBAR MENU -->
        </div>
    </div>--%>
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <%--<sitemesh:write property="body"/>--%>
            <div>
                <div class="uplod-head">
                    <span>DataSync / 传输信息</span>
                </div>
                <div class="upload-title">
                    <span>数据上传任务列表</span>
                    <a href="">新建任务</a>
                </div>
                <div class="upload-search">
                    <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="名称">
                    <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="数据类型">
                    <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="状态">
                    <button type="button" class="btn btn-success" style="margin-left: 166px">查询</button>
                    <button type="button" class="btn btn-success">全部上传</button>
                </div>
                <div class="upload-table">
                    <div class="table-message">列表加载中......</div>
                    <table class="table table-bordered data-table" id="upload-list" >
                        <thead>
                        <tr>
                            <th>任务编号</th>
                            <th>名称</th>
                            <th>数据来源</th>
                            <th>上传位置</th>
                            <th>创建时间</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="bd-data">
                        <%--<tr>
                            <td>1</td>
                            <td>aaaa</td>
                            <td>aaaaaa</td>
                            <td>aaaaaa</td>
                            <td>aaaaaa</td>
                            <td>aaaaaa</td>
                            <td><button type="button" class="btn btn-success upload">上传</button></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>高能物理主题数据库</td>
                            <td>关系数据库</td>
                            <td>dataOneDB</td>
                            <td>2018-04-12 09:12</td>
                            <td>成功</td>
                            <td><button type="button" class="btn btn-success">重新上传</button></td>
                        </tr>--%>
                        </tbody>
                    </table>
                    <div class="page-message">

                    </div>
                    <div class="page-list"></div>
                </div>
            </div>
            <script type="text/html" id="resourceTmp1">
                {{each list as value i}}
                <tr keyIdTr="{{value.id}}">
                    <td>{{i + 1}}</td>
                    <td>{{value.name}}</td>
                    <td>{{value.data}}</td>
                    <td>{{value.source}}</td>
                    <td>{{value.time}}</td>
                    <td class="upload-percent">--</td>
                    <td><button type="button" class="btn btn-success" keyIdTd="{{value.id}}" >{{btnName(value.num)}}</button></td>
                </tr>
                {{/each}}
            </script>
    </div>
    <!-- END CONTENT -->
</div>
<!-- BEGIN FOOTER -->
<div class="page-footer" style="text-align: center;background-color: #454241">
    <div class="page-footer-inner" style="color: #FFF;float: none">
        2018-2020 &copy; 中国科学院计算机网络信息中心大数据部.版权所有.
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
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
<script src="${ctx}/resources/bundles/uploadify/jquery.uploadify.min.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
    console.log(new Date().getTime() + "122s2dasd")
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
    });
    var uploadList=[];
    template.helper("btnName",function (num) {
        var name=""
        if(num ==0){
            name="上传"
        }else if(num == 1){
            name ="正在上传"
        }else {
            name="重新上传"
        }
        return name
    })
    $("#upload-list").delegate("button","click",function () {
        /*send request*/
        var souceID = $(this).attr("keyIdTd");
        var keyID = souceID + new Date().getTime()
        $.ajax({
            url:"${ctx}/sendSouce",
            type:"POST",
            data:{souceID:souceID},
            success:function (data) {
                console.log(data)

            },
            error:function () {
                console.log("请求失败")
            }
        })
        /*send upload request*/
        getProcess();

    })
    var List ={
        list:[
            {
                id:"111111111",
                name:"aaa",
                data:"关系数据库",
                source:"a数据库",
                time:"2018-04-12 09:12",
                num:0
            },
            {
                id:"222222",
                name:"aaa",
                data:"关系数据库",
                source:"a数据库",
                time:"2018-04-12 09:12",
                num:1
            },
            {
                id:"3333333",
                name:"aaa",
                data:"关系数据库",
                source:"a数据库",
                time:"2018-04-12 09:12",
                num:2
            },
            {
                id:"4444444",
                name:"aaa",
                data:"关系数据库",
                source:"a数据库",
                time:"2018-04-12 09:12",
                num:1
            }
        ]
    }

    var aaa = template("resourceTmp1", List);
    $("#bd-data").append(aaa);
    function getProcess() {
        $.ajax({
            url:"${ctx}/getProcess",
            type:"POST",
            data:{
                souceID:souceID,
                keyID:keyID
            },
            success:function (data) {
                getProcess();
            }
        })
    }
    function getPrecent(id) {
        setInterval(function () {
            console.log(id)
        },1100)
    }

</script>
<!-- END JAVASCRIPTS -->
<sitemesh:write property="div.siteMeshJavaScript"/>
</body>
</html>
