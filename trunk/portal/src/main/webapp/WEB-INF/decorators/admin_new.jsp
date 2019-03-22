<%--
  Created by IntelliJ IDEA.
  User: jinbao
  Date: 2019/3/18
  Time: 15:02
  To change this template use File | Settings | File Templates.

  replace admin.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<c:set value="${sessionScope.SubjectCode}" var="sub2"/>
<html>
<head>
    <title>
        <shiro:hasRole name="root">
            主题库后台管理系统
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            集中式数据管理与定制化融合发布工具
        </shiro:hasRole>
    </title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>

    <link rel="stylesheet" href="${ctx}/resources/bundles/font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/components.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/layout.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/themes/light.css" rel="stylesheet" type="text/css"
          id="style_color"/>
    <link href="${ctx}/resources/bundles/metronic/css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/customUserLogin.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-fileinput/css/bootstrap.min.css"/>

    <%--样式bule: 2019年3月18日引入--%>
    <link href="${ctx}/resources/css/home.css" rel="stylesheet" type="text/css"/>

    <!--BEGIN PAGE STYLES-->
    <sitemesh:write property="head"></sitemesh:write>
    <!--END PAGE STYLES-->

    <!-- BEGIN THEME STYLES -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/style.css">
    <!-- END THEME STYLES -->

    <link rel="shortcut icon" href="${ctx}/resources/img/favicon.ico"/>

    <style>
        .page-sidebar .page-sidebar-menu > li > a {
            padding: 8px 15px;
        }

        .navbar-nav > li > a {
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .btn {
            border-radius: 6px !important;
        }

        table td, table th {
            border-right: none !important;
            border-left: none !important;
        }

        .page-content table tbody tr:hover {
            background: #dddddd;
        }
    </style>

</head>


<body>

<div class="con_div">

    <div class="page-container" style="min-height: 550px;width: 100%;margin: 0 auto;">
        <!-- BEGIN SIDEBAR -->
        <div class="page-sidebar-wrapper">
            <%--NEW BAR ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！--%>
            <div class="page-sidebar" style="width: 18%">
                <div class="left_bottom">
                    <div class="left_top"><img src="${ctx}/resources/img/logo.png"></div>
                    <div class="user_div">
                        <table cellspacing="0" cellpadding="0" border="0" align="center">
                            <tbody>
                            <tr>
                                <td colspan="2"><img src="${ctx}/resources/img/user.png" width="65" height="65"></td>
                            </tr>
                            <tr>
                                <td>欢迎您！${sessionScope.userName}</td>
                                <td class="tuichu"><a style="border-radius: 6px" href="${ctx}/logout">退出</a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="left_div">
                        <shiro:hasRole name="root">
                            <ul>
                                <li><a class="active" href="${ctx}/subjectMgmt/subjectIndex"><i class="fa fa-cog"
                                                                                                aria-hidden="true"></i>
                                    主题库注册管理</a>
                                </li>
                                <li><a class="" href="${ctx}/resCatalog"><i class="fa fa-cog"
                                                                            aria-hidden="true"></i> 数据分类管理</a>
                                </li>
                                <li><a class="" href="${ctx}/group/list"><i class="fa fa-cog"
                                                                            aria-hidden="true"></i> 用户与组管理</a>
                                </li>
                                <li><a class="" href="${ctx}/dataRelease"><i class="fa fa-cog"
                                                                             aria-hidden="true"></i> 发布审核管理</a>
                                </li>
                                <li><a class="" href="javaScript:void(0);"><i class="fa fa-cog"
                                                                              aria-hidden="true"></i> 数据统计管理</a>
                                    <ul>
                                        <li class="l2-menu"><a href="${ctx}/statisticalDataDetail"><i
                                                class="fa fa-bars"></i> 专题detail</a></li>
                                        </li>
                                    </ul>
                                </li>
                            </ul>

                        </shiro:hasRole>
                        <shiro:hasRole name="admin">
                            <ul>
                                <li><a href="javaScript:void(0);"><i class="fa fa-file-text-o" aria-hidden="true"></i>
                                    关系数据管理</a>
                                    <ul>
                                        <li class="l2-menu"><a href="${ctx}/dataConfiguration"><i class="fa fa-bars"></i>数据字段配置</a></li>
                                        <li class="l2-menu"><a href="${ctx}/"><i class="fa fa-bars"></i>导入式建表</a></li>
                                        <li class="l2-menu"><a href="${ctx}/datatest"><i
                                                class="fa fa-bars"></i>数据记录管理</a>
                                            <div id="alltableName" style="height:400px;overflow-y: scroll;display:none;margin-top:1%;">

                                            </div>
                                        </li>
                                        </li>
                                    </ul>
                                </li>
                                <li><a href="${ctx}/dataRelease"><i class="fa fa-file-text-o" aria-hidden="true"></i>
                                    数据发布管理</a></li>
                                <li><a href="${ctx}/fileMange"><i class="fa fa-file-text-o" aria-hidden="true"></i>
                                    文件数据管理</a></li>

                            </ul>
                        </shiro:hasRole>

                    </div>
                </div>
            </div>
            <%--NEW BAR ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！--%>

        </div>
        <!-- END SIDEBAR -->

        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <sitemesh:write property="body"/>

        </div>
        <!-- END CONTENT -->
    </div>
</div>

<div class="foot_div">2018-2020 &copy; 中国科学院计算机网络信息中心.版权所有.</div>
<script type="text/html" id="tableNameTempl">
    {{each list as value i}}
    <li class="l3-menu" style=" border-bottom: 1px #cad9ea solid"><a href="javaScript:void(0)"
                                                                        onclick="editTableData(this,1)" id="{{value}}">{{value}}</a>
    </li>
    {{/each}}
</script>

<script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
<%--<script src="${ctx}/resources/bundles/artTemplate/template.js"></script>--%>
<script src="${ctx}/resources/bundles/jquery/jquery-migrate.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/back-to-top.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/layout.js"></script>
<script src="${ctx}/resources/bundles/bootbox/bootbox.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/metronic/global/scripts/metronic.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/metronic/scripts/layout.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/artTemplate/template.js"></script>
<script src="${ctx}/resources/js/regex.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
<script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
<script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
<script src="${ctx}/resources/bundles/bootstrap-closable-tab/bootstrap-closable-tab.js"></script>


<script type="text/javascript">
    var userName = "${sessionScope.userName}";
    // var S_columnType;

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

    $("#cus_User_id").click(function (ev) {
        if ($(".cus_drop").is(":hidden")) {
            $(".cus_drop").show();
        } else {
            $(".cus_drop").hide();
        }
        $("#cus_User_id").css("background-color", "#eee");
        ev.stopPropagation()
    });
    $("body:not(.cus_ul)").click(function () {
        $(".cus_drop").hide();
        $("#cus_User_id").css("background-color", "")
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
    jQuery(document).ready(function () {
        scrolltotop.init('${ctx}');
        Layout.init();
        bootbox.setLocale("zh_CN");
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

        $(".page-content").css("margin-left", $(".page-sidebar").width());
    });

    function editTableData(i) {
        var tableName = $(i).attr("id");
        var subjectCode = userName;
        var pageNo = 1;
        editTable_func(subjectCode, tableName, pageNo);
    }


</script>
<sitemesh:write property="div.siteMeshJavaScript"/>


</body>
</html>
