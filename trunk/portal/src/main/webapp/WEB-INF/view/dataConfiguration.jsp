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
        /* .nav-tabs li a{
             font-size: 16px;
             background-color: gainsboro;
         }*/
        /*   .nav-tabs>li.active>a{
               background-color: #28a4a4!important;
               border: 1px solid black!important;
               border-bottom-color:transparent!important;
           }
           .nav-tabs>li.active>a:hover{
               background-color: #28a4a4!important;
           }*/
        .cus-input {
            font-size: 14px;
            font-weight: normal;
            color: #333333;
            background-color: white;
            border: 1px solid #e5e5e5;
        }

        .tr_class {
            text-align: center;
        }

        .portlet-title {
            /*margin-left: 5%;*/
            /*border:1px red solid;*/
            /*width:500px;*/
            /*width: auto;*/

        }

        table.table_class td {
            text-align: center;
            /*border-width: 1px;*/
            /*padding: 8px;*/
            /*border-style: solid;*/
            /*border-color: #666666;*/
            /*min-height:300px;*/
            /*min-width:500px;*/
        }

        #tableDatil table {
            text-align: center;
            table-layout: fixed;
            white-space: normal;
            word-break: break-all;
            /*width: 1300px;*/
        }

        #tableDatil table td {
            /*border:1px #666666 solid;*/
            border-width: 1px;
            border-style: solid;
            /*border-color: #fbe6e6;*/
            border-color: #ddd;
            width: 30px;
            height: 39px;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }

        table {
            table-layout:fixed;
            border-collapse: collapse;
            margin: 0 auto;
            text-align: center;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }

        table td, table th {
            text-align: center;
            border: 1px solid #cad9ea;
            color: #666;
            height: 39px;
            width: 200px;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        #fileBody tr td{
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
            /*border: 1px red solid;*/
        }

        table thead th {
            background-color: #CCE8EB;
            /*width: 100px;*/
        }

        input {
            border: 1px solid #cad9ea;
        }

        #div_head input {
            background-color: #CCE8EB;
            width: 200px;
            border-collapse: collapse;
            text-align: center;


        }

        #form_id input {
            /*width: 200px;*/
            height: 39px;
            border-collapse: collapse;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="page-content">
    <h3>数据配置</h3>
    <hr>
    <%-- <div class="config-head">
         <span>DataSync / 传输信息</span>
     </div>--%>
    <div>
        <!-- Nav tabs -->
        <%--<ul class="nav nav-tabs" role="tablist" id="tabDescribe">
            <li role="presentation" class="active" value="0"><a href="#undescribe" aria-controls="undescribe" role="tab" data-toggle="tab">待描述数据表</a></li>
            <li role="presentation" value="1"><a href="#isdescribe" aria-controls="isdescribe" role="tab" data-toggle="tab">已描述数据表</a></li>
            <li role="presentation" value="2"><a href="#filedata" aria-controls="filedata" role="tab" data-toggle="tab">文件数据</a></li>
        </ul>--%>
        <!-- Tab panes -->
        <%--<div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="undescribe">
                &lt;%&ndash;<div class="col-md-3" style="font-size: 18px">
                    <span>选择表资源进行描述</span>
                </div>
                <div class="col-md-9" >
                    <div class="row undeslist" >
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>

                    </div>
                </div>&ndash;%&gt;
            </div>
            <div role="tabpanel" class="tab-pane" id="isdescribe">
                &lt;%&ndash;<div class="col-md-3" style="font-size: 18px">
                    <span>选择表资源查看/修改描述</span>
                </div>
                <div class="col-md-9" >
                    <div class="row undeslist" >
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>

                    </div>
                </div>&ndash;%&gt;
            </div>
            <div role="tabpanel" class="tab-pane" id="filedata">
                <div id="jstree_show"></div>
            </div>
        </div>--%>

        <div class="col-md-12">
            <div class="tabbable-custom ">
                <!-- tab header --->
                <ul class="nav nav-tabs " id="tabDescribe">
                    <li class="active" value="0">
                        <a href="#undescribe" data-toggle="tab">
                            待描述数据表 </a>
                    </li>
                    <li value="1">
                        <a href="#isdescribe" data-toggle="tab">
                            已描述数据表</a>
                    </li>
                    <li value="2">
                        <a href="#filedata" data-toggle="tab">
                            文件数据</a>
                    </li>
                    <li value="3">
                        <a href="#excelUpload" data-toggle="tab">
                            Excel上传</a>
                    </li>
                    <li value="4">
                        <a href="#editData" data-toggle="tab">
                            数据编辑</a>
                    </li>
                </ul>
                <!--tab content-->
                <div class="tab-content">

                    <!--用户管理标签页-->
                    <div class="tab-pane active" id="undescribe" style="min-height: 400px;overflow: hidden">

                    </div>

                    <!--group tab-->
                    <div class="tab-pane" id="isdescribe" style="min-height: 400px;overflow: hidden">

                    </div>
                    <div class="tab-pane" id="filedata" style="min-height: 400px;overflow: hidden">
                        <form>
                            <p>
                                <label style="padding-left: 10px;">文件检索:</label>
                                <input id="jstreeSearch" placeholder="输入文件名称"/>
                            </p>
                        </form>
                        <div id="jstree_show"></div>
                    </div>

                    <!--excel 导入数据库-->
                    <div class="tab-pane" id="excelUpload" style="min-height: 400px;overflow: hidden">
                        <form name="form" id="fileForm" action="" class="form-horizontal" method="post">
                            <a href="${ctx}/fileImport/getExcelTemplate">点击下载Excel模板</a>
                            <input id="excelFile" type="file" name="file" class="cus-input">
                            <%--<input id="excelTemplate" type="button" onclick="getExcelTemplate()">--%>
                            <input id="excelFileUpload" type="button" class="btn btn-default" onclick="doUpload();"
                                   value="上传"/>
                            <input id="excelFileReset" type="reset" class="btn btn-default" style="display: none;"
                                   onclick="removeElement()" value="重置"/>
                        </form>
                        <div tabindex="-1" data-width="200" id="ExcelData" hidden="hidden">
                            <div class="" style="width:auto">
                                <div class="">
                                    <div class="">
                                        <h4 class="modal-title" id="4"></h4>
                                    </div>
                                    <div class="modal-body ">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="portlet box green-haze" style="border:0;">
                                                    <div class="portlet-title">
                                                        <ul class="nav nav-tabs" style="float:left;" id="tableNameUl">
                                                        </ul>
                                                    </div>
                                                    <div class="tab-content" style="background-color: white;min-height:300px;
                                                    max-height:70%;padding-top: 20px ;"
                                                         id="tableNamePDiv"> <%--overflow: scroll;--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" onclick="createTableAndInsertValue(this)"
                                                data-dismiss="modal" class="btn green" id="saveExcelSuccess">保存
                                        </button>
                                        <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--数据编辑-->
                    <div class="tab-pane" id="editData" style="min-height: 600px;overflow: hidden;" >
                        <div id="alltables" class="tab-pane"
                             style="margin-left:1%;max-width:98%;margin-right:1%;max-height: 300px;overflow: auto;">

                        </div>

                        <div id="tableDatil" style="margin-top:2px;">
                            <div class="portlet-title" style="max-width:98%;margin-left: 1%;margin-right: 1%; max-height:800px;overflow-x: auto">
                                <div id="nodata" style="display:none;margin-left: 25%;margin-top: 8%;">
                                    <span id="span1" style="font-size: 25px">该表暂时没有数据</span>
                                    <span id="span2" style="margin-left: 5%"></span>
                                </div>
                                <table border="1" id="table1" class="table table-bordered data-table" style="width:100%;">
                                    <thead id="thead_id">
                                    </thead>

                                    <tbody id="fileBody">
                                    </tbody>
                                </table>
                                <div class="review-item clearfix">

                                    <div id="page_div" style="padding-top: 25px; float: left; display: none;">
                                        当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span
                                            style="color:blue;"
                                            id="totalPages"></span>页,<span
                                            style="color:blue;" id="totalCount"></span>条数据
                                    </div>
                                    <div style="float: right;" >
                                        <div id="pagination"></div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <script type="text/html" id="resourceTmp1">

                     </script>
                </div>
            </div>
        </div>

        <%--修改数据--%>
        <div id="staticUpdateData" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="editTableFieldComsCloseId11"></button>
                        <h4 class="modal-title" id="title_id1">表数据编辑</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;">

                        <div class="tab-content"
                             style="background-color: white;min-height:300px;max-height:50%;padding-top: 20px ;">
                            <div style="margin-left: 1%;margin-right: 1%;width:98%;">
                                <%--style="margin-left: 5%;"--%>
                                <div id="div_head">

                                </div>
                                <div>
                                    <form id="form_id" action="#" method="post" name="form_id">

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="update_div" class="modal-footer">
                        <%--<button id="updatebtn"  style="width: 80px;height: 30px; border: 1px solid #cad9ea;">保存</button>--%>
                    </div>
                </div>
            </div>
        </div>

        <%--表数据查看详情--%>
        <div id="staticShowDataDetail" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="editTableFieldComsCloseId1"></button>
                        <h4 class="modal-title" id="checkDetial">查看详情</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;max-height:600px;">
                        <div class="tab-content"
                             style="background-color: white;padding-top: 20px ;">
                            <div class="tab-pane active" id="checkData1" style="width: 98%;margin-right: 1%;margin-left: 1%; ">
                                <table border="1" id="checkTable">
                                    <thead>
                                    <th style="width:20%;" >字段名</th>
                                    <th style="width:20%;">字段类型</th>
                                    <th style="width:20%;">注释</th>
                                    <th style="width:40%;">字段值</th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%--新增表数据--%>
        <div id="staticAddData" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="addTableData"></button>
                        <h4 class="modal-title" id="adddata1">新增数据</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;">
                        <div class="tab-content"
                             style="background-color: white;min-height:300px;max-height:60%;padding-top: 20px ;">
                            <div class="tab-pane active" id="adddata" style=" ">
                                <table border="1" id="addTable">
                                    <thead>
                                    <th style="width:20%;">字段名</th>
                                    <th style="width:20%;">字段类型</th>
                                    <th style="width:20%;">注释</th>
                                    <th style="width:40%;">字段值</th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="add_div" class="modal-footer">
                        <button id="addbtn" style="width: 80px;height: 30px; border: 1px solid #cad9ea;"
                                onclick="addTablefuntion()">保存
                        </button>
                    </div>
                </div>
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
                                    <div class="portlet-title">
                                        <ul class="nav nav-tabs" style="float:left;">
                                            <li class="active">
                                                <a href="#editTableFieldComsId" data-toggle="tab"
                                                   id="editTableDataAndComsButtonId" aria-expanded="true">
                                                    编辑 </a>
                                            </li>
                                            <li class="">
                                                <a href="#previewTableDataAndComsId"
                                                   id="previewTableDataAndComsButtonId"
                                                   data-toggle="tab" aria-expanded="false">
                                                    预览 </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="tab-content"
                                         style="background-color: white;min-height:300px;max-height:70%;padding-top: 20px ; overflow: scroll;">
                                        <div class="tab-pane active" id="editTableFieldComsId">
                                        </div>
                                        <div class="tab-pane" id="previewTableDataAndComsId">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editTableFieldComsSaveId" data-dismiss="modal" class="btn green">保存
                        </button>
                        <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                    </div>
                </div>
            </div>
        </div>

        <!--文件树创建目录弹窗页-->
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
        <!--文件树新增文件弹窗页-->
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
    </div>
</div>
<input type="hidden" id="subjectCode" value="${sessionScope.SubjectCode}"/>
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
<!--为了加快页面加载速度，请把js文件放到这个div里-->
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
    <%--
        <script src="${ctx}/resources/js/metaTemplate.js"></script>
    --%>
    <script>
        var ctx = '${ctx}', edit = false;
        var sub = '${sessionScope.SubjectCode}';
        var filePath = '${FtpFilePath}';
        var olddata = {};
        var S_subjectCode;
        var S_tableName;
        var S_column;
        var S_dataType;
        var S_updateData;
        var S_columnType;
        var S_pkColumnArr;
        var S_autoAddArr;
        $(function () {
            chooseTable(sub, 0);
            loadTree();
            clickEditData(sub);//数据编辑
        });

        var sub1 = '${sessionScope.SubjectCode}';
        $("#tabDescribe li").click(function () {
            var flag = $(this).val();
            chooseTable(sub1, flag);
        })

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
                        html += "<label class='col-md-6' style='padding-left: 0px'><input type='radio' name='mapTable' onclick=\"staticSourceTableChoice(1,this" + ",'" + sub1 + "','" + list[i] + "','dataResource','"+ flag +"')\" value='" + list[i] + "'>&nbsp;" + list[i] + "</label>"
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

        // 数据编辑方法
        function clickEditData(subjectCode) {
            $.ajax({
                url: "${ctx}/showTable",
                type: "POST",
                data: {"subjectCode": subjectCode},
                dataType: "json",
                success: function (data) {
                    var html = "";
                    var list = data.list;
                    for (var i = 0; i < list.length; i++) {
                        html += "<span style='display:inline-block;width:25%;'><label><input type='radio' name='mapTable'  value='" + list[i] + "' onclick=\"editTableData('" + sub1 + "','" + list[i] + "')\">&nbsp;" + list[i] + "</label></span>"
                    }
                    $("#alltables").append(html);
                }
            })
        }

        //数据库数据编辑方法
        function editTableData(subjectCode, tableName, pageNo) {
            $("#page_div").hide();
            $("#nodata").hide();
            $("#span2").html("");
            $("#thead_id").html("");
            $("#fileBody").html("");
            $.ajax({
                url: "${ctx}/showTableData",
                type: "POST",
                data: {
                    "subjectCode": subjectCode,
                    "tableName": tableName,
                    "pageNo": pageNo
                },
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
                    var s = "<tr class='tr_class' style='background-color:gainsboro;'>";
                    //表头
                    var il = 0;

                    if (dataArry.length > 0) {
                        for (var i = 0; i < arr.length; i++) {
                            if (il <= 5) {
                                if (arr[i] === "PORTALID") {
                                    s += "<th style='display:none;border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                                } else {
                                    s += "<th style='border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "<br/><p title="+columnComment[i]+">"+ columnComment[i]+"</p></th>";
                                    il++;
                                }
                            } else {
                                s += "<th style='display:none;border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                            }
                        }
                    }
                    var pkColumn = data.pkColumn;
                    var autoAdd = data.autoAdd;
                    var ss = "";
                    var m = 0;

                    if (dataArry.length > 0) {

                        for (var key in dataArry) {
                            m++;
                            ss += "<tr>";
                            var d = dataArry[key];

                            var eachData = [];

                            var i = 0;
                            var j = 0;
                            var n = 0;
                            for (var k in d) {
                                n++;
                                if (j <= 5) {
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

                            ss += "<td ><a src='#' onclick=\" updateData('" + arr + "','" + tableName + "','" + subjectCode + "','" + dataType + "','" + columnComment + "','" + m + "','" + n + "')\">修改 | </a>" +
                                "<a href='#' onclick=\"addTableData('" + arr + "','" + dataType + "','" + columnComment + "','" + tableName + "','" + subjectCode + "','" + pkColumn + "','" + autoAdd + "')\">增加 | </a>" +
                                "<a href='#' onclick=\"checkDada('" + arr + "','" + dataType + "','" + columnComment + "','" + m + "','" + n + "')\">查看 | </a>" +
                                "<a href='#' onclick=\"deleteDate('" + delPORTALID + "','" + tableName + "','" + subjectCode + "')\">删除</a></td></tr>";
                        }
                        s += "<th style='border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:22%;height:60px;'>操作</th></tr>";
                        $("#page_div").show();
                        $("#pagination").show();
                        fun_limit(subjectCode, tableName, data);
                    } else {
                        var t = "<a style='font-size: 17px;background-color: whitesmoke' href='#' onclick=\"addTableData('" + arr + "','" + dataType + "','" + columnComment + "','" + tableName + "','" + subjectCode + "','" + pkColumn + "','" + autoAdd + "')\">增加数据</a></th></tr>";
                        $("#nodata").show();
                        $("#span2").append(t);
                        $("#pagination").hide();
                    }

                    $("#thead_id").append(s);
                    $("#fileBody").append(ss);


                }
            });
        }

        //删除数据
        function deleteDate(delPORTALID, tableName, subjectCode) {

            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>", function (r) {
                if (r) {
                    //获得当前页码
                    var currentPage = $("#currentPageNo").html();
                    $.ajax({
                        url: "${ctx}/deleteData",
                        type: "POST",
                        dataType: "json",
                        data: {
                            "subjectCode": subjectCode,
                            "tableName": tableName,
                            "delPORTALID": delPORTALID
                        },
                        success: function (data) {
                            if (data.data === "1") {
                                toastr.success("删除成功!");
                                editTableData(subjectCode, tableName, currentPage);
                            }
                            if (data.data === "0") {
                                toastr.error("删除失败！");
                            }
                        }
                    })
                }
            })
        }

        function checkDada(columns, dataType, columnComment, m, n) {
            $("#checkTable tbody").html(" ");

            var strs = new Array();
            for (var i = (m - 1) * n; i < m * n; i++) {
                strs.push(S_updateData[i]);
            }
            var strs2 = new Array(); //定义一数组
            strs2 = columns.split(",");
            var dataTypeArr = dataType.split(",");
            var columnComments = columnComment.split(",");
            var s = "";
            for (var i = 0; i < strs2.length; i++) {
                if (strs2[i] === "PORTALID") {
                    s += "<tr style='display:none;'><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td>" + strs[i] + "</td></tr>";
                } else {
                    s += "<tr><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td title='" + strs[i] + "'>" + strs[i] + "</td></tr>";
                }
            }
            $("#checkTable tbody").append(s);
            $("#staticShowDataDetail").modal("show");
        }

        function fun_limit(subjectCode, tableName, data) {

            $("#currentPageNo").html(data.currentPage);
            $("#totalPages").html(data.totalPages);
            $("#totalCount").html(data.totalCount);
            if ($("#pagination .bootpag").length != 0) {
                $("#pagination").off();
                $('#pagination').empty();
            }

            $('#pagination').bootpag({
                total: data.totalPages,
                page: data.currentPage,
                maxVisible: 5,
                leaps: true,
                firstLastUse: true,
                first: '首页',
                last: '尾页',
                wrapClass: 'pagination',
                activeClass: 'active',
                disabledClass: 'disabled',
                nextClass: 'next',
                prevClass: 'prev',
                lastClass: 'last',
                firstClass: 'first'
            }).on('page', function (event, num) {
                editTableData(subjectCode, tableName, num);
            });
        }

        function updateData(columns, tableName, subjectCode, dataType, columnComment, m, n) {

            var strs = new Array();
            for (var i = (m - 1) * n; i < m * n; i++) {
                strs.push(S_updateData[i]);
            }

            $("#form_id").html(" ");
            $("#updateTable tbody").html(" ");
            $("#div_head").html("");
            $("#update_div").html("");
            //获得当前页码
            var currentPage = $("#currentPageNo").html();

            var strs2 = new Array(); //定义一数组
            strs2 = columns.split(",");
            var dataTypeArr = dataType.split(",");
            var columnComments = columnComment.split(",");
            var alert_column = [];
            var s_head = "<input style='width:20%;' type='text' value='字段名' readonly='true'/><input style='width:20%;' type='text'  value='字段类型' readonly='true'/><input style='width:20%;' type='text'  value='注释' readonly='true'/><input style='width:40%;' type='text'  value='字段值' readonly='true'/><br/>";
            // var s_head = "<table><tr><td><input style='width:20%;' type='text' value='字段名' readonly='true'/></td><td><input style='width:20%;' type='text'  value='字段类型' readonly='true'/></td><td><input style='width:20%;' type='text'  value='注释' readonly='true'/></td><td><input style='width:40%;' type='text'  value='字段值' readonly='true'/></td></tr>";//<br/>

            var ss = "<input type='text' name='tableName'style='display:none;' value=" + tableName + " />";
            ss += "<input type='text' name='subjectCode'style='display:none;' value=" + subjectCode + " />";

            for (var i = 0; i < strs2.length; i++) {
                if (strs2[i] === "PORTALID") {
                    ss += "<input style='display:none;' type='text' value='" + strs2[i] + "' readonly='true'/><input style='display:none;' type='text'  value='" + S_columnType[i] + "' readonly='true'/><input style='display:none;' type='text'  value='" + columnComments[i] + "' readonly='true' /><input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' />";
                } else if(dataTypeArr[i]==="text"||dataTypeArr[i]==="longtext"){
                    // ss += "<input style='width:20%;height:60px;' type='text' value='" + strs2[i] + "' readonly='true'/><input style='width:20%;height:60px;' type='text'  value='" + S_columnType[i] + "' readonly='true'/><input style='width:20%;height:60px;' type='text'  value='" + columnComments[i] + "' readonly='true' /><textarea title='" + strs[i] + "'style='width:40%;'rows='1' class='" + dataTypeArr[i] + "'  name=" + strs2[i] + " value='" + strs[i] + "' >"+ strs[i] +"</textarea><br/>";
                    // ss += "<input style='width:20%;' type='text' value='" + strs2[i] + "' readonly='true'/><input style='width:20%;' type='text'  value='" + S_columnType[i] + "' readonly='true'/><input style='width:20%;' type='text'  value='" + columnComments[i] + "' readonly='true' /><input type='text' title='" + strs[i] + "'style='width:40%;'rows='1' class='" + dataTypeArr[i] + "'  name=" + strs2[i] + " value='" + strs[i] + "' /><br/>";
                    ss += "<table ><tr><td  ><input style='width:100%;height:100%;' type='text' value='" + strs2[i] + "' readonly='true'/></td><td><input style='width:100%;height:100%;' type='text'  value='" + S_columnType[i] + "' readonly='true'/></td><td><input  style='width:100%;height:100%;' type='text'  value='" + columnComments[i] + "' readonly='true' /></td><td style='width: 40%;'><textarea  style='width:100%;height:100%'  title='" + strs[i] + "' class='" + dataTypeArr[i] + "'  name=" + strs2[i] + " value='" + strs[i] + "' >"+ strs[i] +"</textarea></td></tr>";
                }else{
                    // ss += "<input style='width:20%;' type='text' value='" + strs2[i] + "' readonly='true'/><input style='width:20%;' type='text'  value='" + S_columnType[i] + "' readonly='true'/><input style='width:20%;' type='text'  value='" + columnComments[i] + "' readonly='true' /><input title='" + strs[i] + "'style='width:40%;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' /><br/>";
                    ss += "<tr><td><input style='width:20%;' type='text' value='" + strs2[i] + "' readonly='true'/></td><td><input style='width:20%;' type='text'  value='" + S_columnType[i] + "' readonly='true'/></td><td><input style='width:20%;' type='text'  value='" + columnComments[i] + "' readonly='true' /></td><td><input title='" + strs[i] + "' style='width:40%;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' /></td></tr>";
                }
                ss+="</table>"
                alert_column.push(strs2[i]);
            }
            var s_save = "<input class='eee'id='btn_save'type='button' value='保存' style='width:80px;height:35px;' onclick=\" saveData('" + tableName + "','" + subjectCode + "','" + dataType + "','" + currentPage + "','" + alert_column + "')\"/>";

            $("#div_head").append(s_head);
            $("#form_id").append(ss);

            $("#update_div").append(s_save);
            $("#staticUpdateData").modal("show");

            olddata = $('#form_id').serializeArray();
        }

        //新增数据
        function addTableData(columns, dataType, columnComment, tableName, subjectCode, pkColumn, autoAdd) {

            $("#addTable tbody").html(" ");

            var strs2 = columns.split(",");
            var dataTypeArr = dataType.split(",");
            var columnComments = columnComment.split(",");
            var pkColumnArr = pkColumn.split(",");
            var autoAddArr = autoAdd.split(",");
            var s = "";
            for (var i = 0; i < strs2.length; i++) {
                if (pkColumnArr[i] === "PRI" && autoAddArr[i] === "auto_increment") {
                    if (strs2[i] === "PORTALID") {
                        s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                    } else {
                        s += "<tr style='display: none;'><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td><input class='addClass' value='0' name='" + strs2[i] + "'/></td></tr>";
                    }
                } else if (pkColumnArr[i] === "PRI" && autoAddArr[i] !== "auto_increment") {
                    if (strs2[i] === "PORTALID") {
                        s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                    } else {
                        s += "<tr><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>  " + columnComments[i] + "</td><td><input class='addClass' style='width: 100%;height:100%;' value='' name='" + strs2[i] + "'/></td></tr>";
                    }
                } else {
                    if (strs2[i] === "PORTALID") {
                        s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                    } else {
                        s += "<tr><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td><input class='addClass' style='width: 100%;height:100%;' value='' name='" + strs2[i] + "'/></td></tr>";
                    }
                }
            }
            $("#addTable tbody").append(s);
            $("#staticAddData").modal("show");
            S_subjectCode = subjectCode;
            S_tableName = tableName;
            S_dataType = dataTypeArr;
            S_column = strs2;
            S_pkColumnArr = pkColumnArr;
            S_autoAddArr = autoAddArr;
        }

        //增加数据
        function addTablefuntion() {
            //获得当前页码
            var currentPage = $("#currentPageNo").html();
            var dataArr = [];
            $('#addTable input').each(function () {
                dataArr.push($(this).val());
            });
            var data1 = [];
            var j = 0;
            var datacon = [];
            for (var i = 0, ii = 0; i < S_column.length; i++) {

                //隐藏字段
                if (S_column[i] === "PORTALID") {
                    datacon[i] = "";
                } else if (S_pkColumnArr[i] === "PRI" && S_autoAddArr[i] === "auto_increment") {
                    datacon[i] = "";
                } else {
                    datacon[i] = dataArr[ii];
                    ii++;
                }
            }

            for (var i = 0; i < S_column.length; i++) {
                var data2 = {};
                if (datacon[i] !== "" && datacon[i] !== null) {

                    //char类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "char") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount.length > 255) {
                            toastr.warning(S_column[i] + "字段超出范围！");
                            return;
                        }
                    }

                    //text类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "text") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 65535) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }
                    //longtext类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "longtext") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 4294967295) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }
                    //mediumtext类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "mediumtext") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 16777215) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }

                    // bit数据类型判断
                    if (dataArr[i] !== "" && datacon[i] !== null && S_dataType[i] === "bit") {
                        if (dataArr[i] !== "0" && dataArr[i] !== "1") {
                            toastr.warning(S_column[i] + " 字段应是boolean类型！");
                            return;
                        }
                    }
                    if (datacon[i] !== null && datacon[i] !== "" && S_dataType[i] === "tinyint") {
                        if (!isNaN(datacon[i])) {
                            if (parseInt(datacon[i]) > 127 || parseInt(datacon[i]) < -128) {
                                toastr.warning(S_column[i] + " 字段超出范围！");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是tinyint类型！");
                            return;
                        }
                    }

                    //smallint数据类型判断
                    if (S_dataType[i] === "smallint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是smallint类型！");
                                return;
                            } else {
                                if (parseInt(datacon[i]) > 32767 || parseInt(datacon[i]) < -32768) {
                                    toastr.warning(S_column[i] + " 字段超出范围！");
                                    return;
                                }
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }

                    //mediumint数据类型判断
                    if (S_dataType[i] === "mediumint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是mediumint类型！");
                                return;
                            } else {
                                if (parseInt(datacon[i]) > 8388607 || parseInt(datacon[i]) < -8388608) {
                                    toastr.warning(S_column[i] + " 字段超出范围！");
                                    return;
                                }
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }
                    //bigint数据类型判断
                    if (S_dataType[i] === "bigint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是bigint类型！");
                                return;
                            }
                            // else {
                            //     if (datacon[i] > '9223372036854775807' || datacon[i] > '-9223372036854775808') {
                            //         toastr.warning(S_column[i]+" 字段超出范围！");
                            //         return;
                            //     }
                            // }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }
                    //int数据类型
                    if (datacon[i] !== "" && (S_dataType[i] === "int" || S_dataType[i] === "integer")) {
                        if (!isNaN(datacon[i])) {
                            var reg = /^-?\d+$/;
                            if (!reg.exec(datacon[i])) {
                                toastr.warning(S_column[i] + " 字段应是int或integer类型！");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "float") {
                        if (isNaN(datacon[i])) {
                            toastr.warning(S_column[i]+" 字段应是float类型！");
                            return;
                        }
                    }
                    if (datacon[i] !== "" && S_dataType[i] === "double") {
                        if (isNaN(datacon[i])) {
                            toastr.warning(S_column[i]+" 字段应是double类型！");
                            return;
                        }
                    }
                    if (S_dataType[i] === "date" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        // var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
                        var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                        var regExp = new RegExp(reg);
                        if (!regExp.test(datacon[i])) {
                            toastr.warning(S_column[i]+" 字段是时间格式,正确格式应为: xxxx-xx-xx ");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "datetime") {
                        var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\s+(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
                        var regExp = new RegExp(reg);
                        if (!regExp.test(datacon[i]) && datacon[i] !== null && datacon[i] !== "") {
                            toastr.warning(S_column[i]+" 字段正确格式应为: xxxx-xx-xx xx:xx:xx ");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "decimal") {
                        var col_type_str = S_columnType[i].split(",");
                        var m = col_type_str[0].split("(")[1];
                        var s = col_type_str[1].split(")")[0];
                        var n = m - s;
                        var pattern = /^(-?\d+)(\.\d+)?$/;    //浮点数
                        var reg = new RegExp(pattern);
                        if (reg.test(datacon[i])) {
                            var ss = datacon[i].split(".");
                            if (ss[0].length > n) {
                                toastr.warning(S_column[i]+" 数据超出范围！ ");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i]+" 字段是decimal类型！ ");
                            return;
                        }
                    }
                    data2.columnName = S_column[i];
                    data2.columnValue = datacon[i];
                    data1.push(data2);
                } else {
                    data2.columnName = S_column[i];
                    data2.columnValue = datacon[i];
                    data1.push(data2);
                }
            }

            $.ajax({
                url: "${ctx}/addTableData",
                type: "POST",
                data: {
                    "subjectCode": S_subjectCode,
                    "tableName": S_tableName,
                    "addData": JSON.stringify(data1)
                },
                dataType: "json",
                success: function (data) {
                    if (data.data === "0") {
                        // alert("添加数据失败，主键重复！");
                        toastr.error("添加数据失败，主键重复！");
                    } else if (data.data === "1") {

                        toastr.success("添加成功!");
                        editTableData(S_subjectCode, S_tableName, 1);
                        $("#staticAddData").modal("hide");
                    } else if (data.data === "-1") {

                        toastr.error("添加数据失败，主键不能为空！");
                    } else {
                        var arr = data.data.split("+");
                        if (arr[0] === "-2") {
                            toastr.error("添加数据失败，" + arr[1] + " 列不能为空！");
                        }
                    }
                },
                error: function () {
                    alert("error!!!");
                }
            })
        }

        //取消事件
        function fun_cancel() {
            $("#staticUpdateData").modal("hide");
        };

        //修改数据,保存
        function saveData(tableName, subjectCode, dataType, currentPage,alert_column) {
            var newdata = $('#form_id').serializeArray();
            var dataTypeArr = dataType.split(",");
            var columnName=alert_column.split(",");
            var form1 = document.getElementById("form_id");
            var kk = 5;
            var checkdataArr = [];

            for (var i = 5; i < form1.elements.length; i++) {
                var e = document.form_id.elements[kk];
                checkdataArr.push(e.value);
                kk = kk + 4;
                if (kk > form1.elements.length) {
                    break;
                }
            }
            for (var i = 0; i < checkdataArr.length; i++) {
                //char类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "char") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount.length > 255) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }

                //text类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "text") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 65535) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }
                //longtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "longtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 4294967295) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }
                //mediumtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "mediumtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 16777215) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }

                //bit数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "bit") {
                    if (checkdataArr[i] !== "0" && checkdataArr[i] !== "1") {
                        toastr.warning(columnName[i]+" 字段应是bit类型！");
                        return;
                    }
                }
                //tinyint数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && dataTypeArr[i] === "tinyint") {
                    if (!isNaN(checkdataArr[i])) {
                        if (parseInt(checkdataArr[i]) > 127 || parseInt(checkdataArr[i]) < -128) {
                            toastr.warning(columnName[i]+" 字段超出范围！");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是tinyint等类型！");
                        return;
                    }
                }

                //smallint数据类型判断
                if (dataTypeArr[i] === "smallint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是smallint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 32767 || parseInt(checkdataArr[i]) < -32768) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 该字段应是数字类型！");
                        return;
                    }
                }

                //mediumint数据类型判断
                if (dataTypeArr[i] === "mediumint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是mediumint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 8388607 || parseInt(checkdataArr[i]) < -8388608) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }
                //bigint数据类型判断
                if (dataTypeArr[i] === "bigint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是bigint类型！");
                            return;
                        }
                        // else {
                        //     if (checkdataArr[i] > '9223372036854775807' || checkdataArr[i] > '-9223372036854775808') {
                        //         toastr.warning(columnName[i]+" 字段超出范围！");
                        //         return;
                        //     }
                        // }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }
                //int数据类型判断
                if ((dataTypeArr[i] === "int" || dataTypeArr[i] === "integer") && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是int或integer等类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 2147483647 || parseInt(checkdataArr[i]) < -2147483648) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }

                //float数据类型判断
                if (dataTypeArr[i] === "float" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段应是float类型！");
                        return;
                    }
                    // if(parseFloat(checkdataArr[i]>)){
                    // }
                }
                //double数据类型判断
                if (dataTypeArr[i] === "double" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段应是double类型！");
                        return;
                    }
                }
                //date数据类型判断
                if (dataTypeArr[i] === "date" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    // var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段是时间格式,正确格式应为: xxxx-xx-xx ");
                        return;
                    }
                }
                //datetime数据类型判断
                if (dataTypeArr[i] === "datetime" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\s+(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段正确格式应为: xxxx-xx-xx xx:xx:xx ");
                        return;
                    }
                }
                //decimal数据类型判断
                if (dataTypeArr[i] === "decimal" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var col_type_str = S_columnType[i].split(",");
                    var m = col_type_str[0].split("(")[1];
                    var s = col_type_str[1].split(")")[0];
                    var n = m - s;
                    var pattern = /^(-?\d+)(\.\d+)?$/;    //浮点数

                    var reg = new RegExp(pattern);
                    if (reg.test(checkdataArr[i])) {
                        var ss = checkdataArr[i].split(".");
                        if (ss[0].length > n) {
                            toastr.warning(columnName[i]+" 字段数据超出范围！ ");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段是decimal类型！ ");
                        return;
                    }
                }

            }
            $.ajax({
                url: "${ctx}/saveTableData",
                type: "POST",
                data: {"olddata": JSON.stringify(olddata), "newdata": JSON.stringify(newdata)},
                dataType: "json",
                success: function (data) {
                    if (data.data === "0") {
                        // alert("更新数据失败！");
                        //错误消息提示，默认背景为浅红色
                        toastr.error("更新数据失败!");
                    } else if (data.data === "1") {
                        //成功消息提示，默认背景为浅绿色
                        toastr.success("更新成功!");
                        // alert("更新成功！");
                        $("#staticUpdateData").modal("hide");
                        editTableData(subjectCode, tableName, currentPage);
                    } else {
                        var arr = data.data.split("+");
                        if (arr[0] === "-2") {
                            toastr.error("更新数据失败，" + arr[1] + " 列不能为空！");
                        }
                    }
                },
                error: function () {
                    alert("error!!!!!");
                }
            })
        };

        function loadTree() {

            // 文件树 右键插件事件
            var contextmenu = {
                items: function (node) {
                    if ("directory" === node.original.type) {
                        return {
                            "增加同级目录": {
                                label: "增加同级目录",
                                action: function (data) {
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if (length !== 1) {
                                        toastr["error"]("错误！", "请选择一个目录");
                                        return false;
                                    }
                                    var parentURI = selected[0];
                                    var reg = /%_%/;
                                    if (reg.test(parentURI)) {
                                        parentURI = parentURI.substring(0, parentURI.lastIndexOf("%_%"));
                                    } else {
                                        parentURI = parentURI.substring(0, parentURI.lastIndexOf("/"));
                                    }
                                    $("#addBrotherDirectory").modal("show");
                                    $("#parentURI").val(parentURI);
                                    $("#brotherDirectorName").val("Customdir-");
                                }
                            },
                            "增加子级目录": {
                                label: "增加子级目录",
                                action: function (data) {
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if (length !== 1) {
                                        toastr["error"]("错误！", "请选择一个目录");
                                        return false;
                                    }
                                    $("#addSonDirectory").modal("show");
                                    $("#parentURI").val(selected);
                                    $("#directorName").val("Customdir-");
                                }
                            },
                            "将文件上传至当前目录": {
                                label: "上传文件至该目录",
                                action: function (data) {
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if (length !== 1) {
                                        toastr["error"]("错误！", "请选择一个目录");
                                        return false;
                                    }
                                    $("#addFile").modal("show");
                                    $("#parentURI").val(selected);
                                }
                            }
                        }
                    }
                }
            };
            // 树搜索
            $(function () {
                var $jstreeSearch = $("#jstreeSearch");
                $jstreeSearch.on("keydown", function (e) {
                    var ev = (typeof event != 'undefined') ? window.event : e;
                    console.log(ev.keyCode + "down");
                    if (ev.keyCode == 13 && document.activeElement.id == "jstreeSearch") {
                        return false;//禁用回车事件
                    }
                }).on("keyup", function (e) {
                    var ev = (typeof event != 'undefined') ? window.event : e;
                    console.log(ev.keyCode + "up");
                    var seachString = $("#jstreeSearch").val();
                    $("#jstree_show").jstree(true).search(seachString);
                });
            });
            // 重新实现文件树的加载
            $('#jstree_show').jstree({
                "core": {
                    "themes": {
                        "responsive": false
                    },
                    // so that create works
                    "check_callback": true,
                    'data': function (obj, callback) {
                        var jsonstr = "[]";
                        var jsonarray = eval('(' + jsonstr + ')');
                        var children;
                        if (obj.id != '#') {
                            var str = obj.id;
                            var str1 = str.replace(/%_%/g, "/");
                        } else {
                            str1 = filePath;
                        }
                        if (str1 == filePath) {
                            $.ajax({
                                type: "GET",
                                url: "${ctx}/resource/treeNodeFirst",
                                dataType: "json",
                                data: {"filePath": str1},
                                // data: {"filePath": "H:\\testftp"},
                                async: false,
                                success: function (data) {
                                    $.each(data, function (k, v) {
                                        v["state"] = {};
                                    });
                                    children = data;
                                }

                            });
                        } else {
                            $.ajax({
                                type: "GET",
                                url: "${ctx}/resource/treeNode",
                                dataType: "json",
                                data: {"filePath": str1},
                                async: false,
                                success: function (data) {
                                    $.each(data, function (k, v) {
                                        v["state"] = {};
                                    });
                                    children = data;
                                }

                            });
                        }
                        generateChildJson(children);
                        callback.call(this, children);
                    }
                },
                "types": {
                    "default": {
                        "icon": "glyphicon glyphicon-flash"
                    },
                    "file": {
                        "icon": "glyphicon glyphicon-ok"
                    }
                },
                "contextmenu": contextmenu,
                "plugins": ["types", "wholerow", "contextmenu", "search"]
            });
        }

        // 增加目录
        function addDirectory(t) {
            var dirName = $.trim($("#directorName").val());
            if ("brother" === t) {
                dirName = $.trim($("#brotherDirectorName").val());
            }
            var parentURI = $("#parentURI").val();
            if (dirName === "") {
                toastr["warning"]("警告！", "请输入目录名称");
                return;
            }
            var regDirName = /^Customdir-/g;
            if (!regDirName.test(dirName)) {
                toastr["warning"]("警告！", "目录前缀不可更改");
                $("#brotherDirectorName").val("Customdir-");
                return;
            }
            $.ajax({
                type: "POST",
                url: "${ctx}/fileUpload/addDirectory",
                data: {
                    "dirName": dirName,
                    "parentURI": parentURI
                },
                success: function (data) {
                    var jsonData = JSON.parse(data);
                    if (jsonData.code === "error") {
                        toastr["error"]("错误！", jsonData.message);
                    } else {
                        toastr["success"]("成功！", jsonData.message);
                        $("#addSonDirectory").modal("hide");
                        $("#addBrotherDirectory").modal("hide");
                        var jt = $("#jstree_show").jstree(true);
                        jt.refresh();
                    }
                }
            });
        }

        // 格式化文件树
        function generateChildJson(childArray) {
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.children !== undefined) {
                    if (child.type == 'directory') {
                        // child.children = true;
                        child.icon = "jstree-folder";
                    } else {
                        child.icon = "jstree-file";
                    }
                    generateChildJson(child.children);
                } else {
                    if (child.type == 'directory') {
                        child.children = true;
                        child.icon = "jstree-folder";
                    } else {
                        child.icon = "jstree-file";
                    }
                }
            }
        }

        /**
         * 上传excel 成功后显示字段内容
         */
        function doUpload() {
            var formData = new FormData($("#fileForm")[0]);
            var fileName = formData.get("file").name;

            if (fileName === undefined) {
                toastr["warning"]("提示！", "请选择文件");
                return;
            }
            var allFileType = ".xlsx|";
            var s = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
            if (allFileType.indexOf(s + "|") === -1) {
                toastr["warning"]("提示！", "请选择上传Excel2007及以上版本文件");
                return;
            }
            formData.append("subjectCode", $.trim($("#subjectCode").val()));
            var filePath = $("#excelFile").val();
            formData.append("filePath", filePath);
            $.ajax({
                url: '${ctx}/fileImport/excel',
                type: 'post',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                beforeSend: function () {
                    index = layer.load(1, {
                        shade: [0.5, '#fff'] //0.1透明度的白色背景
                    });
                    $("#excelFile").attr("disabled", "disabled");
                },
                success: function (result) {
                    var resultJson = JSON.parse(result);
                    if (resultJson["code"] === "error") {
                        toastr["error"]("错误！", resultJson["message"]);
                    } else {
                        var data = resultJson.data;
                        var tableName = template("tableNameLi", {"data": data});
                        $("#tableNameUl").html("");
                        $("#tableNameUl").html(tableName);

                        var tableNameDiv = template("tableNameDiv", {"data": data});
                        $("#tableNamePDiv").html("");
                        $("#tableNamePDiv").html(tableNameDiv);
                        $.each(data, function (key, value) {
                            $.each(value, function (k, v) {
                                var tableField;
                                var exist = v[0][0];
                                if (exist === "isExist") {
                                    tableField = template("tableFieldIsExist", {"data": v, "tableName": k});
                                } else {
                                    tableField = template("tableFieldNotExist", {"data": v, "tableName": k});
                                }
                                $("#" + k).html("");
                                $("#" + k).append(tableField);
                            })

                        });
                        $("#ExcelData").show();
                    }
                },
                complete: function () {
                    $("#layui-layer-shade" + index + "").remove();
                    $("#layui-layer" + index + "").remove();
                    $("#excelFileUpload").hide();
                    $("#excelFileReset").show();
                },
                error: function (returndata) {
                    toastr["error"]("错误！", returndata);
                }
            });
        }

        function removeElement() {
            $("#excelFile").removeAttr("disabled");
            var $saveExcelSuccess = $("#saveExcelSuccess");
            $saveExcelSuccess.removeAttr("disabled");
            $saveExcelSuccess.text("保存");
            $("#tableNamePDiv div").remove();
            $("#tableNameUl li").remove();
            $("#excelFileUpload").show();
            $("#excelFileReset").hide();
            $("#ExcelData").hide();
        }


        /**
         * 创建表并保存数据 || 仅保存数据
         */
        function createTableAndInsertValue(_this) {
            $("#excelFile").removeAttr("disabled");
            var tableName = $(_this).parent().prev().find("li.active a").attr("href").substring(1);
            var tableNum = $(_this).parent().prev().find(".active table").length;
            if (tableNum === 0) {
                toastr["error"]("错误！", "请上传数据Excel");
                return;
            }
            var table = $(_this).parent().prev().find(".active table")[0];
            var tableData = getTableData(table);
            if (tableData === undefined) {
                return;
            }
            var size = tableData.data.length;
            if (size) {
                var data = new FormData($("#fileForm")[0]);
                var s = JSON.stringify(tableData.data);
                data.append("tableData", s);
                data.append("subjectCode", $.trim($("#subjectCode").val()));
                data.append("tableName", tableName);

                var requestUrl = "";
                if (tableData.type === "insert") {
                    requestUrl = "${ctx}/fileImport/onlyInsertValue";
                } else {
                    requestUrl = "${ctx}/fileImport/createTableAndInsertValue";
                }
                $.ajax({
                    type: "POST",
                    url: requestUrl,
                    data: data,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        index = layer.load(1, {
                            shade: [0.5, '#fff'] //0.1透明度的白色背景
                        });
                    },
                    success: function (data) {
                        var jsonData = JSON.parse(data);
                        if (jsonData.code === "error") {
                            toastr["error"]("错误！", jsonData.message);
                        } else {
                            toastr["success"]("提示！", jsonData.message);
                            var $saveExcelSuccess = $("#saveExcelSuccess");
                            $saveExcelSuccess.text("保存成功");
                            $saveExcelSuccess.attr('disabled', 'disabled');

                        }
                    },
                    complete: function () {
                        $("#layui-layer-shade" + index + "").remove();
                        $("#layui-layer" + index + "").remove();
                    }
                });
                $("#excelFile").attr("disabled", "disabled");
            }

            /**
             * 将表格数据转化为 json格式
             * @param table
             * @returns {*}
             */
            function getTableData(table) {
                var result = {};
                var rows = table.rows;
                var rowLength = rows.length;
                var trl = [];
                for (var i = 1; i < rowLength; i++) {
                    var cells = rows[i].cells;
                    var cellLength = cells.length;
                    /*
                    * 根据cellLength 区分
                    * 6:新增表 并新增数据
                    * 5：比对数据库已存在表字段 与excel新导入字段 导入新增数据
                    * */
                    if (cellLength === 6) {
                        var b = serializeTableFor6(cellLength, cells, trl, i);
                        if (b === false) {
                            return b;
                        }
                        result["type"] = "createAndInsert";
                    }
                    if (cellLength === 5) {
                        serializeTableFor5(cellLength, cells, trl, i);
                        result["type"] = "insert";
                    }
                }
                result["data"] = trl;
                return result;
            }
        }

        function serializeTableFor6(cellLength, cells, trl, i) {
            var tdl = {};
            for (var j = 0; j < cellLength; j++) {
                if (j === 1) {
                    var fieldName = $.trim($(cells[j]).find("input").val());
                    if (fieldName === "") {
                        toastr["error"]("错误！", "第" + i + "行 请输入字段名称！");
                        return false;
                    }
                    tdl["field"] = fieldName;
                } else if (j === 2) {
                    var fieldComment = $.trim($(cells[j]).find("input").val());
                    if (fieldComment === "") {
                        toastr["error"]("错误！", "第" + i + "行 请输入字段注释！");
                        return false;
                    }
                    tdl["comment"] = fieldComment;
                } else if (j === 3) {
                    var fieldType = $(cells[j]).find("select :selected").val();
                    if (fieldType === "0") {
                        toastr["error"]("错误！", "第" + i + "行 请选择字段类型！");
                        return false;
                    }
                    tdl["type"] = fieldType;
                } else if (j === 4) {
                    var fieldLength = $.trim($(cells[j]).find("input").val());
                    var reg = /^[1-9]\d*$/;
                    if (!reg.test(fieldLength)) {
                        toastr["error"]("错误！", "第" + i + "行 字段长度有误！");
                        return false;
                    }
                    tdl["length"] = fieldLength;
                } else if (j === 5) {
                    var length = $(cells[j]).find("input:checked").length;
                    tdl["pk"] = length;
                }
            }
            trl.push(tdl);
        }

        function serializeTableFor5(cellLength, cells, trl, i) {
            var tdl = {};
            for (var j = 0; j < cellLength; j++) {
                if (j === 0) {
                    tdl["oldField"] = $.trim($(cells[j]).text());
                }
                if (j === 2) {
                    tdl["field"] = $.trim($(cells[j]).find("select :selected").val());
                    var num = $(cells[j]).find(":checked").val();
                    tdl["insertNum"] = num === -1 ? -1 : num - 1;
                }
            }
            trl.push(tdl);
        }

        // 初始化 bootstrap-fileinput 上传组件
        (function () {
            $("#file-5").fileinput({
                language: "zh",
                theme: 'fas',
                uploadUrl: "${ctx}/fileUpload/addFile",
                showUpload: true,
                showCaption: false,
                // browseClass: "btn btn-primary btn-lg",
                browseClass: "btn btn-primary", //按钮样式
                dropZoneEnabled: true,//是否显示拖拽区域 默认显示
                fileType: "any",
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                overwriteInitial: false,
                hideThumbnailContent: true, // 隐藏文件的预览 以最小内容展示
                maxFileCount: 5, // 允许选中的文件数量
                maxFileSize: 1000000, // 允许选中的文件大小 KB
                uploadExtraData: function () {
                    return {
                        "parentURI": $.trim($("#parentURI").val())
                    }
                }

            }).on("filebatchselected", function (event, files) {
            }).on("fileuploaded", function (event, data) {
                var jt = $("#jstree_show").jstree(true);
                jt.refresh();
            })
        })();

        // 初始化 主键清除按钮事件
        (function () {
            $("body").on("click", "#clearPK", function () {
                $("[name=isPK]").prop("checked", false);
            });
            $("#excelFile").val("");
        })();

    </script>
</div>

</html>

