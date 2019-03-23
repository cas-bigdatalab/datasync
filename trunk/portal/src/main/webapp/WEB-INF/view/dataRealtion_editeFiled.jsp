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
    </style>
</head>

<body>

<div class="page-content">
    <div class="right_div">
        <div class="time_div"><a><i class="fa fa-chevron-circle-right" aria-hidden="true"></i>关系数据管理</a>--><a>数据字段配置</a></div>
        <div class="fabu_div2">数据字段配置</div>
        <div class="qiehuan_div">
            <ul id="tabDescribe">
                <li class="active" value="0"><a  id="nodescribe" href="#undescribe" data-toggle="tab">待描述数据表</a></li>
                <li class="active" value="1"><a id="described" href="#isdescribe" data-toggle="tab">已描述数据表</a></li>
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane active" id="undescribe" style="min-height: 400px;overflow: hidden">

            </div>

            <div class="tab-pane" id="isdescribe" style="min-height: 400px;overflow: hidden">

            </div>
        </div>
        <div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
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
                                                    <button type="button" class="btn btn-primary">
                                                    编辑</button> </a>
                                            </li>
                                            <li class="" style="padding-left: 0px;" >
                                                <a href="#previewTableDataAndComsId"
                                                   id="previewTableDataAndComsButtonId"
                                                   data-toggle="tab" aria-expanded="false">
                                                    <button type="button" class="btn btn-default">
                                                    预览</button> </a>
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

                                    <div class="tab-content" style="background-color: white;min-height:300px;max-height:70%; overflow: hidden">
                                        <div class="tab-pane active" id="editTableFieldComsId" style="overflow: scroll;">
                                        </div>

                                        <div class="tab-pane" id="previewTableDataAndComsId" style="overflow: scroll;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-success" id="editTableFieldComsSaveId" data-dismiss="modal">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <%--文件树创建目录弹窗页--%>
        <div id="addSonDirectory" class="modal fade" tabindex="-1" data-width="200">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">子集目录名称</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="parentURI">
                        <input id="directorName" placeholder="请输入目录名称"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="addDirectory(this)" class="btn green">创建目录
                        </button>
                        <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                    </div>
                </div>
            </div>
        </div>
        <div id="addBrotherDirectory" class="modal fade" tabindex="-1" data-width="200">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">同级目录名称</h4>
                    </div>
                    <div class="modal-body">
                        <input id="brotherDirectorName" placeholder="请输入目录名称"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="addDirectory('brother')" class="btn green">创建目录
                        </button>
                        <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                    </div>
                </div>
            </div>
        </div>
        <%--文件树新增文件弹窗页--%>
        <div id="addFile" class="modal fade" tabindex="-1" data-width="200">
            <div class="modal-dialog" style="min-width:400px;width:auto;max-width: 35%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">选择文件并上传</h4>
                    </div>
                    <div class="modal-body" style="height: 600px">
                        <form enctype="multipart/form-data">
                            <div style="height: 400px">
                                <div class="file-loading">
                                    <input id="file-5" type="file" multiple>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%--重命名文件弹窗页--%>
        <div id="renameDialog" class="modal fade" tabindex="-1" data-width="200">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">重命名文件</h4>
                    </div>
                    <div class="modal-body">
                        <input id="newName" placeholder="请输入新名称"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="reNameFile(this)" class="btn green">确定重命名
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="subjectCode" value="${sessionScope.SubjectCode}"/>
<input type="hidden" id="FtpFilePath" value="${sessionScope.FtpFilePath}"/>
<%@ include file="./tableFieldComsTmpl.jsp" %>

<script type="text/html" id="systemTmpl">
    {{each list}}
    <tr>
        <td style="text-align: center">{{(currentPage-1)*pageSize+$index+1}}</td>
        <td><a href="javascript:viewData('{{$value.templateId}}');">{{$value.templateName}}</a>
        </td>
        <td style="text-align: center">{{$value.creator}}</td>
        <td style="text-align: center">{{dateFormat($value.createDate)}}</td>
        <td style="text-align: center">{{$value.memo}}</td>
        <td id="{{$value.templateId}}" style="text-align: center">
            <button type="button" class="btn default btn-xs purple updateButton"
                    onclick="selectData('{{$value.templateId}}')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
            </button>
            &nbsp;&nbsp;
        </td>
    </tr>
    {{/each}}
</script>
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
        var filePath = '${FtpFilePath}';
        $(function () {
            chooseTable(sub, 0);
            loadTree();
        });

        var sub1 = '${sessionScope.SubjectCode}';
        $("#tabDescribe li").click(function () {
            var flag = $(this).val();
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
                        "<div class='icheck-list' style='padding-top: 7px'>";
                    var list = data.list;
                    for (var i = 0; i < list.length; i++) {
                        html += "<label class='col-md-6' style='padding-left: 0px'><input type='radio' name='mapTable' onclick=\"staticSourceTableChoice(1,this" + ",'" + sub1 + "','" + list[i] + "','dataResource','" + flag + "')\" value='" + list[i] + "'>&nbsp;" + list[i] + "</label>"
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


    </script>
</div>

</html>

