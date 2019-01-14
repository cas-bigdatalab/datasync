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
                        <a href="#fileUpload" data-toggle="tab">
                            上传文件</a>
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
                        <div id="jstree_show"></div>
                    </div>

                    <!--excel 导入数据库-->
                    <div class="tab-pane" id="excelUpload" style="min-height: 400px;overflow: hidden">
                        <form name="form" id="fileForm" action="" class="form-horizontal" method="post">
                            <input id="fcupload" type="file" name="file" class="cus-input">
                            <input type="button" class="btn btn-default" onclick="doUpload();" value="上传"/>
                        </form>
                        <div tabindex="-1" data-width="200">
                            <div class="" style="width:auto">
                                <div class="">
                                    <div class="">
                                        <h4 class="modal-title" id="4"></h4>
                                    </div>
                                    <div class="modal-body">
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
                                                data-dismiss="modal" class="btn green">保存
                                        </button>
                                        <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--文件上传至ftp服务器-->
                    <div class="tab-pane" id="fileUpload" style="min-height: 400px;overflow: hidden">
                        <form enctype="multipart/form-data">
                            <div style="height: 200px">
                                <div class="file-loading">
                                    <input id="file-4" type="file" data-theme="fas" multiple>
                                </div>
                            </div>
                        </form>
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
    <%--
        <script src="${ctx}/resources/js/metaTemplate.js"></script>
    --%>
    <script>
        var ctx = '${ctx}', edit = false;
        var sub = '${sessionScope.SubjectCode}'
        var filePath = '${FtpFilePath}'
        $(function () {
            chooseTable(sub, 0);
            loadTree();
        });

        var sub1 = '${sessionScope.SubjectCode}'
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
                        html += "<label class='col-md-6' style='padding-left: 0px'><input type='checkbox' name='mapTable' onclick=\"staticSourceTableChoice(1,this" + ",'" + sub1 + "','" + list[i] + "','dataResource')\" value='" + list[i] + "'>&nbsp;" + list[i] + "</label>"
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

        function loadTree() {

            // 文件树 右键插件事件
            /*var contextmenu = {
                // select_node:
                items: {
                    "当前目录下增加目录": {
                        label: "当前目录下增加目录",
                        action: function (data) {
                            var selected = $('#jstree_show').jstree("get_selected");
                            $("#addDirectory").modal("show");
                            $("#parentURI").val(selected);
                            $("#directorName").val("");
                        }
                    },
                    "将文件上传至当前目录": {
                        label: "上传文件至该目录",
                        action: function (data) {
                            var selected = $('#jstree_show').jstree("get_selected");
                            $("#addFile").modal("show");
                            $("#parentURI").val(selected);
                        }
                    }
                }
            };*/
            var contextmenu = {
                items: function(node){
                    if("directory"===node.original.type){
                        return {
                            "增加同级目录":{
                                label: "增加同级目录",
                                action:function(data){
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if(length !== 1){
                                        toastr["error"]("错误！","请选择一个目录");
                                        return false;
                                    }
                                    var parentURI = selected[0];
                                    parentURI = parentURI.substring(0,parentURI.lastIndexOf("%_%"));
                                    $("#addBrotherDirectory").modal("show");
                                    $("#parentURI").val(parentURI);
                                    $("#brotherDirectorName").val("");
                                }
                            },
                            "增加子级目录": {
                                label: "增加子级目录",
                                action: function (data) {
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if(length !== 1){
                                        toastr["error"]("错误！","请选择一个目录");
                                        return false;
                                    }
                                    $("#addSonDirectory").modal("show");
                                    $("#parentURI").val(selected);
                                    $("#directorName").val("");
                                }
                            },
                            "将文件上传至当前目录": {
                                label: "上传文件至该目录",
                                action: function (data) {
                                    var selected = $('#jstree_show').jstree("get_selected");
                                    var length = selected.length;
                                    if(length !== 1){
                                        toastr["error"]("错误！","请选择一个目录");
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
                        /*else{
                         callback.call(this,);
                         }*/
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
                "plugins": [/*"dnd"*//*, "state"*/, "types", /*"checkbox",*/ "wholerow", "contextmenu"]
            });
        }

        // 增加目录
        function addDirectory(t) {
            var dirName = $.trim($("#directorName").val());
            if("brother"===t){
                dirName = $.trim($("#brotherDirectorName").val());
            }
            var parentURI = $("#parentURI").val();
            if (dirName === "") {
                toastr["warning"]("警告！", "请输入目录名称");
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
                        // jt.deselect_all();
                        // jt.select_node(jsonData.data);
                    }
                }
            });
        }

        function generateChildJson(childArray) {
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.type == 'directory') {
                    child.children = true;
                    child.icon = "jstree-folder";
                } else {
                    child.icon = "jstree-file";
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
            $.ajax({
                url: '${ctx}/fileImport/excel',
                type: 'post',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
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
                                    tableField = template("tableFieldIsExist", {"data": v});
                                } else {
                                    tableField = template("tableFieldNotExist", {"data": v});
                                }
                                $("#" + k).html("");
                                $("#" + k).append(tableField);
                            })

                        })
                    }
                },
                error: function (returndata) {
                    toastr["error"]("错误！", returndata);
                }
            });
        }

        /**
         * 创建表并保存数据 || 仅保存数据
         */
        function createTableAndInsertValue(_this) {
            var tableName = $(_this).parent().prev().find("li.active a").attr("href").substring(1);
            var tableNum = $(_this).parent().prev().find(".active table").length;
            if (tableNum === 0) {
                toastr["error"]("错误！", "请上传数据Excel");
                return;
            }
            var table = $(_this).parent().prev().find(".active table")[0];
            var tableData = getTableData(table);
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
                    success: function (data) {
                        var jsonData = JSON.parse(data);
                        if (jsonData.code === "error") {
                            toastr["error"]("错误！", jsonData.message);
                        } else {
                            toastr["success"]("提示！", jsonData.message);
                        }
                    }
                })
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
                        serializeTableFor6(cellLength, cells, trl, i);
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

        function serializeTableFor6(cellLength, cells, trl) {
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
            $("#file-4").fileinput({
                language: "zh",
                theme: 'fas',
                uploadUrl: "${ctx}/fileUpload/toFtp",
                showUpload: true,
                showCaption: false,
                // browseClass: "btn btn-primary btn-lg",
                browseClass: "btn btn-primary", //按钮样式
                dropZoneEnabled: true,//是否显示拖拽区域 默认显示
                fileType: "any",
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                overwriteInitial: false,
                hideThumbnailContent: true, // 隐藏文件的预览 以最小内容展示
                maxFileCount: 1, // 允许选中的文件数量
                uploadExtraData:function(){
                    return {
                        "subjectCode": $.trim($("#subjectCode").val())
                    }
                }

            });
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
                uploadExtraData: function () {
                    return {
                        "parentURI": $.trim($("#parentURI").val())
                    }
                }

            }).on("filebatchselected",function(event, files){
            }).on("fileuploaded",function(event,data){
            })
        })();

    </script>
</div>

</html>

