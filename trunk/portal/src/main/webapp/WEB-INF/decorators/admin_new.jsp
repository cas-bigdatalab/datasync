<%--
  Created by IntelliJ IDEA.
  User: jinbao
  Date: 2019/3/18
  Time: 15:02
  To change this template use File | Settings | File Templates.

  TODO: replace admin.jsp
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

    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
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
    </style>

</head>


<body>
<div class="top_div">

    <ul class="cus_ul">
        <li>
            <a href="#" id="cus_User_id">
                <i class="glyphicon glyphicon-user"></i>
                &nbsp;&nbsp;
                <span>欢迎您！${sessionScope.userName}</span>
                &nbsp;
                <i class="fa fa-angle-down"></i>
            </a>
            <ul class="cus_drop">
                <li>
                    <a href="logout"><i class="icon-key"></i>&nbsp;安全退出</a>
                </li>
            </ul>
        </li>
    </ul>

</div>

<div class="con_div">

    <div class=" container tatle_div">
        <shiro:hasRole name="root">
            主题库后台管理系统
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            集中式数据管理与定制化融合发布工具
        </shiro:hasRole>
    </div>

    <div class="page-container" style="min-height: 550px;width: 90%;margin: 0 auto">
        <!-- BEGIN SIDEBAR -->
        <div class="page-sidebar-wrapper">
            <div class="page-sidebar navbar-collapse" style="min-height: 500px">
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

                    <shiro:hasRole name="root">


                        <li class="start">
                            <a href="${ctx}/subjectMgmt/subjectIndex">
                                <i class="icon-user"></i>
                                <span class="title">主题库注册管理</span>
                                <span class="arrow"></span>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/resCatalog">
                                <i class="icon-settings"></i>
                                <span class="title">数据分类管理</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/group/list">
                                <i class="icon-user"></i>
                                <span class="title">用户与组管理</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/dataRelease">
                                <i class="icon-layers"></i>
                                <span class="title">发布审核管理</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <i class=" icon-drawer"></i>
                                <span class="title">数据统计管理</span>
                                <span class="arrow "></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="${ctx}/statisticalDataDetail">
                                        专题detail</a>
                                </li>
                                <li>
                                    <a href="${ctx}/statisticalDataTotal">
                                        专题total</a>
                                </li>
                            </ul>
                        </li>
                    </shiro:hasRole>
                    <shiro:hasRole name="admin">

                        <li>
                            <a href="${ctx}/dataConfiguration">
                                <i class="icon-wrench"></i>
                                <span class="title">数据配置管理</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/dataRelease">
                                <i class="icon-layers"></i>
                                <span class="title">数据发布管理</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                        <li>
                                <%--<a href="${ctx}/datatest">--%>
                            <a href="${ctx}/fileMange">
                                <i class="icon-layers"></i>
                                <span class="title">测试</span>
                                <span class="arrow "></span>
                            </a>
                            <div id="alltableName"
                                 style="width: 100%;height:500px;overflow-y: scroll;display:none;margin-top:1%;">

                            </div>

                        </li>

                        <li>
                            <a href="javascript:void(0);">
                                <i class="icon-layers"></i>
                                <span class="title">ssssssss</span>
                                <span class="arrow "></span>
                            </a>
                        </li>
                    </shiro:hasRole>

                </ul>
                <!-- END SIDEBAR MENU -->
            </div>
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
    <li style="text-align: center; border-bottom: 1px #cad9ea solid"><a href="javaScript:void(0)"
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
    var S_columnType;

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
    });

    function editTableData(i) {
        var tableName = $(i).attr("id");
        var subjectCode = userName;
        var pageNo = 1;
        editTable_func(subjectCode, tableName, pageNo);
    }

    function editTable_func(subjectCode, tableName, pageNo) {
        var ids = "#tab_container_" + tableName;
        $.ajax({
            type: "post",
            url: "${ctx}/showTableData",
            data: {"subjectCode": subjectCode, "tableName": tableName, "pageNo": pageNo},
            dataType: "json",
            success: function (data) {
                S_updateData = [];
                var arr = data.columns;
                var dataType = data.dataType;
                S_columnType = [];
                S_columnType = data.columnType;
                var columnComment = data.columnComment;
                var dataArry = data.dataDatil;
                console.log(dataArry);
                var delPORTALID;
                var tabs = "";
                var s = " ";
                s = "<table id='" + tableName + "' class='table table-bordered data-table' style='width:100%;'><thead ><tr class='tr_class' style='background-color:gainsboro;'>";
                //表头
                var il = 0;
                if (dataArry.length > 0) {
                    for (var i = 0; i < arr.length; i++) {
                        if (il < 5) {
                            if (arr[i] === "PORTALID") {
                                s += "<th style='display:none;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                            } else {
                                s += "<th style='overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "<br/><p title=" + columnComment[i] + ">" + columnComment[i] + "</p></th>";
                                il++;
                            }
                        } else {
                            s += "<th style='display:none;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                        }
                    }
                }
                var ss = "";
                var m = 0;
                if (dataArry.length > 0) {
                    for (var key in dataArry) {
                        m++;
                        ss += "<tbody><tr>";
                        var d = dataArry[key];
                        var eachData = [];
                        var i = 0;
                        var j = 0;
                        var n = 0;
                        for (var k in d) {
                            n++;
                            if (j < 5) {
                                if (k === arr[i]) {
                                    if (dataType[i] === "datetime" && d[k] !== null && d[k] !== " ") {
                                        var date = d[k].split(".");
                                        d[k] = date[0];
                                    }
                                    if (k === "PORTALID") {
                                        delPORTALID = d[k];
                                        ss += "<td  style='display:none;' title='" + d[k] + "'>" + d[k] + "</td>";
                                    } else {
                                        ss += "<td title='" + d[k] + "' style='word-break:keep-all;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;'><xmp>" + d[k] + "</xmp></td>";
                                        j++;
                                    }
                                    eachData.push(d[k]);
                                    S_updateData.push(d[k]);
                                } else {
                                    if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                        var date = d[arr[i]].split(".");
                                        d[arr[i]] = date[0];
                                    }
                                    if (arr[i] === "PORTALID") {
                                        delPORTALID = d[arr[i]];
                                        ss += "<td style='display:none;' title='" + d[arr[i]] + "'>" + d[arr[i]] + "</td>";
                                    } else {
                                        ss += "<td title='" + d[arr[i]] + "' style='word-break:keep-all;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;'><xmp>" + d[arr[i]] + "</xmp></td>";
                                        j++;
                                    }
                                    eachData.push(d[arr[i]]);
                                    S_updateData.push(d[arr[i]]);
                                }
                                i++;
                            } else {
                                if (k === arr[i]) {
                                    if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                        var date = d[k].split(".");
                                        d[k] = date[0];
                                    }
                                    if (k === "PORTALID") {
                                        delPORTALID = d[k];
                                    }
                                    eachData.push(d[k]);
                                    S_updateData.push(d[k]);
                                } else {
                                    if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                        var date = d[arr[i]].split(".");
                                        d[arr[i]] = date[0];
                                    }
                                    if (arr[i] === "PORTALID") {
                                        delPORTALID = d[arr[i]];
                                    }
                                    eachData.push(d[arr[i]]);
                                    S_updateData.push(d[arr[i]]);
                                }
                                i++;
                            }
                        }
                        ss += "<td ><a src='#' onclick=\" updateData('" + arr + "','" + delPORTALID + "','" + tableName + "','" + subjectCode + "')\">修改 | </a>" +
                            "<a href='#' onclick=\"checkDada('" + arr + "','" + delPORTALID + "','" + tableName + "','" + subjectCode + "')\">查看 | </a>" +
                            "<a href='#' onclick=\"deleteDate('" + delPORTALID + "','" + tableName + "','" + subjectCode + "')\">删除</a></td></tr>";
                    }
                    ss += "</tbody>";
                    s += "<th style='border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:22%;height:60px;'>操作</th></tr></thead>";
                    tabs = s + ss + "</table>";

                    tabs += "<div class='review-item clearfix'><div id='page_div" + tableName + "' style='padding-top: 25px; float: left;'>" +
                        "当前第<span style='color:blue;' id='currentPageNo" + tableName + "'></span>页,共<span style='color:blue;' id='totalPages" + tableName + "'></span>页,<span style='color:blue;' id='totalCount" + tableName + "'></span>" +
                        "条数据</div><div style='float: right;' ><div id='pagination" + tableName + "'></div></div></div>";

                    var item = {'id': tableName, 'name': tableName, 'closable': true, 'template': tabs};
                    closableTab.addTab(item); // 执行创建页签
                    fun_limit(subjectCode, tableName, data);
                } else {
                    tabs = "";
                    $(ids).html(" ");
                    var item = {'id': tableName, 'name': tableName, 'closable': true, 'template': tabs};
                    // 执行创建页签
                    closableTab.addTab(item);
                    var click = " <h5 style='font-size: 20px;text-align: center;margin-right: 30%;'>该表暂时没有数据</h5>";
                    $(ids).append(click);
                }
            }
        });
    }


</script>
<sitemesh:write property="div.siteMeshJavaScript"/>


</body>
</html>
