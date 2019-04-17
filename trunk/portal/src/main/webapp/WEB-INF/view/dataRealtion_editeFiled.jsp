<%--
  Created by IntelliJ IDEA.
  User: shibaoping
  Date: 2018/10/30
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>数据发布管理系统</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jstree/dist/themes/default/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/dataConfig.css">
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-fileinput/css/bootstrap.min.css">--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-fileinput/css/fileinput.min.css">
    <link href="${ctx}/resources/bundles/layerJs/theme/default/layer.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .qiehuan_div li a.active {
            background: #2a6ebf !important;
            margin-right: 1px !important;
            color: #fff !important;
        }
    </style>
</head>

<body>

<div class="qiehuan_div" >
    <ul id="tabDescribe">
        <li class="active" value="0"><a id="nodescribe" href="#undescribe" data-toggle="tab">待描述数据表</a></li>
        <li class="active" value="1"><a id="described" href="#isdescribe" data-toggle="tab">已描述数据表</a></li>
    </ul>
</div>
<div class="tab-content" style="background-color: white;">
    <div class="tab-pane active" id="undescribe" style="min-height: 400px;overflow: hidden">

    </div>

    <div class="tab-pane" id="isdescribe" style="min-height: 400px;overflow: hidden">

    </div>
</div>
<div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
    <div class="modal-dialog" style="height:600px;width:auto;max-width: 55%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                        id="editTableFieldComsCloseId"></button>
                <h4 class="modal-title" id="relationalDatabaseModalTitle">编辑表字段注释</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box green-haze" style="border:0;">
                            <div class="portlet-title" style="background-color: white;">
                                <ul class="nav nav-tabs" style="width:100%;padding-left: 0%;margin-top: 0px;">
                                    <li class="active">
                                        <a href="#editTableFieldComsId" data-toggle="tab"
                                           id="editTableDataAndComsButtonId" aria-expanded="true">
                                            <button id="btn_eidt" type="button" class="btn btn-primary">
                                                编辑
                                            </button>
                                        </a>
                                    </li>
                                    <li class="" style="padding-left: 0px;">
                                        <a href="#previewTableDataAndComsId"
                                           id="previewTableDataAndComsButtonId"
                                           data-toggle="tab" aria-expanded="false">
                                            <button id="btn_check" type="button" class="btn btn-default">
                                                预览
                                            </button>
                                        </a>
                                    </li>
                                </ul>

                                <%--<div class="btn-box">--%>
                                <%--<button  type="button" class="btn btn-primary">--%>
                                <%--<a href="#editTableFieldComsId" id="editTableDataAndComsButtonId" class="active" style="color: white">编辑</a></button>--%>
                                <%--<button type="button" class="btn btn-default">--%>
                                <%--<a href="#previewTableDataAndComsId" id="previewTableDataAndComsButtonId" style="color: black">预览</a></button>--%>
                                <%--</div>--%>
                                <%--<div class="btn-box">--%>
                                <%--<button  type="button" class="btn btn-primary" id="editTableDataAndComsButtonId">--%>
                                <%--编辑</button>--%>
                                <%--<button type="button" class="btn btn-default" id="previewTableDataAndComsButtonId">--%>
                                <%--预览</button>--%>
                                <%--</div>--%>
                            </div>

                            <div class="tab-content"
                                 style="background-color: white;max-height:70%;max-width:100%; ">
                                <div class="tab-pane active" id="editTableFieldComsId" style="width:99%;max-height:70%;overflow: hidden;overflow: auto;" >
                                </div>

                                <div class="tab-pane" id="previewTableDataAndComsId" style="width:99%;max-height:70%;overflow: hidden;overflow: auto;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="editTableFieldComsSaveId" data-dismiss="modal">保存
                </button>
                <button type="button" data-dismiss="modal" class="btn default">取消</button>
            </div>
        </div>
    </div>
</div>
    </div>
</div>
<input type="hidden" id="subjectCode" value="${sessionScope.SubjectCode}"/>
<input type="hidden" id="FtpFilePath" value="${sessionScope.FtpFilePath}"/>
<%@ include file="./tableFieldComsTmpl.jsp" %>
</body>
<%--为了加快页面加载速度，请把js文件放到这个div里--%>
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script src="${ctx}/resources/js/jquery.json.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/bundles/layerJs/layer.js"></script>
    <script src="${ctx}/resources/bundles/context/context.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-closable-tab/bootstrap-closable-tab.js"></script>
    <%--
        <script src="${ctx}/resources/js/metaTemplate.js"></script>
    --%>
    <script>
        var ctx = '${ctx}', edit = false;
        var sub = '${sessionScope.SubjectCode}';
        $(function () {
            chooseTable(sub, 0);
            $(".qiehuan_div li:eq(0) a").addClass("active");
        });

        var sub1 = '${sessionScope.SubjectCode}';
        $("#tabDescribe li").click(function () {
            var flag = $(this).val();
            $(this).siblings().removeClass("active");
            $(this).siblings().find("a").removeClass("active");
            $(this).addClass("active");
            $(this).find("a").addClass("active");
            chooseTable(sub1, flag);
        });
        $("#described").click(function () {
            $("#undescribe").hide();
            $("#isdescribe").show();
        });
        $("#nodescribe").click(function () {
            $("#isdescribe").hide();
            $("#undescribe").show();
        });
        function chooseTable(subjectCode, flag) {
            $.ajax({
                type: "GET",
                url: '${ctx}/relationalDatabaseTableList',
                data: {"subjectCode": subjectCode, "flag": flag},
                dataType: "json",
                success: function (data) {
                    var html = "<div class='form-group'>" +
                        "<div class='col-md-12'>" +
                        "<div class='icheck-list' style='padding-top: 7px;width: 100%;'>";
                    var list = data.list;
                    for (var i = 0; i < list.length; i++) {
                        html += "<span style='width:33%;height:40px;padding-left: 0px;font-size: 15px' class='col-md-6'>" +
                            "<input type='radio' id='" + list[i] + "' name='mapTable' onclick=\"staticSourceTableChoice(1,this" + ",'" + sub1 + "','" + list[i] + "','dataResource','" + flag + "')\" value='" + list[i] + "'>&nbsp;<label for='" + list[i] + "'> " + list[i] + "</label></span>"
                    }
                    html += "</div><input type='text' class='form-control' name='maptableinput' id='maptableinput' style='display:none;'/></div></div>";
                    if (flag == '0') {
                        $("#undescribe").html(html);
                    } else {
                        $("#isdescribe").html(html);
                    }
                }
            });
        }

        $("#btn_eidt").click(function () {
            $("#btn_check").removeClass("btn btn-primary");
            $("#btn_eidt").removeClass("btn btn-default");

            $("#btn_eidt").addClass("btn btn-primary");
            $("#btn_check").addClass("btn btn-default");

        });

        $("#btn_check").click(function () {
            $("#btn_check").removeClass("btn btn-default");
            $("#btn_eidt").removeClass("btn btn-primary");

            $("#btn_check").addClass("btn btn-primary");
            $("#btn_eidt").addClass("btn btn-default");
        });

    </script>
</div>

</html>

