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
        <div class="time_div"><a><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 数据管理</a>--><a>专题库</a></div>
        <div class="fabu_div2">数据配置</div>
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

        // $("#editTableDataAndComsButtonId").click(function () {
        //     $("#previewTableDataAndComsId").hide();
        //     $("#editTableFieldComsId").show();
        // });
        //
        // $("#previewTableDataAndComsButtonId").click(function () {
        //     $("#editTableFieldComsId").hide();
        //     $("#previewTableDataAndComsId").show();
        // });

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
            /*var regDirName = /^Customdir-/g;
            if (!regDirName.test(dirName)) {
                toastr["warning"]("警告！", "目录前缀不可更改");
                $("#brotherDirectorName").val("Customdir-");
                return;
            }*/
            $.ajax({
                type: "POST",
                url: "${ctx}/fileNet/addDirectory",
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
                        fileNet(parentURI);
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
                                    tableField = template("tableFieldIsExist", {"data": v});
                                } else {
                                    tableField = template("tableFieldNotExist", {"data": v});
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
                uploadUrl: "${ctx}/fileNet/addFile",
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
                fileNet($("#parentURI").val());
            })
        })();

        (function () {
            var $body = $("body");
            // excel上传模块  主键清除按钮事件
            $body.on("click", "#clearPK", function () {
                $("[name=isPK]").prop("checked", false);
            });
            $("#excelFile").val("");


            // 网盘功能模块  双击事件
            $body.on("dblclick", "#bd-data td.fileName", function (item) {
                var $td = "";
                if ($(item.target).is("a")) {
                    $td = $(item.target).parent();
                } else {
                    $td = $(item.target);
                }
                var fileType = $td.attr("class").split(" ")[0];
                var selectPath = $td.attr("path");
                if (fileType === "dir") {
                    // 类型为目录的打开
                    fileNet(selectPath);
                } else {
                    // 类型为文件的询问是否下载
                    var fileName = $td.text();
                    bootbox.confirm("<span style='font-size: 16px'>是否下载  " + fileName + "</span>", function (r) {
                        if (r) {
                            downloadFile(selectPath);
                        }
                    })
                }
            });


            // 选择多选框触发事件
            $body.on("click", ".fileNetCheck", function (item) {
                var $target = $(item.target);
                var id = $target.attr("id");
                if (id !== "undefined" && id === "all") {
                    var all = $target.is(":checked");
                    $("#FileOnNet table input.fileNetCheck").attr("checked", all);
                } else {
                    var current = $target.is(":checked");
                    if (!current) {
                        $("#FileOnNet table #all").attr("checked", false);
                    }
                }
            });


            // 鼠标点击事件
            $body.on("mousedown", "#FileOnNet table", function (e) {
                var which = e.which;
                console.log(which); // 1 = 鼠标左键 left; 2 = 鼠标中键; 3 = 鼠标右键
                if (which === 1) {
                    // 选中当前行
                    /*var $check = $(e.currentTarget).find("input");
                    var flag = $check.attr("checked");
                    flag = flag === undefined ? true : false
                    $check.attr("checked", flag);*/
                } else if (which === 3) {
                    // 鼠标左键选中操作 右键替换默认菜单
                    context.init({preventDoubleContext: false});
                    var copyCache = $("#copyCache").data("copyCache");
                    var menus = [{header: 'Compressed Menu'},
                        {
                            text: "重命名", action: function (e) {
                                showRenameDialog(e)
                            }
                        },
                        {
                            text: "复制", action: function () {
                                copyPath()
                            }
                        }
                    ];
                    if (copyCache !== undefined && copyCache !== "") {
                        var copy = {
                            text: "粘贴", action: function () {
                                pasteFile()
                            }
                        };
                        menus.push(copy);
                    }
                    context.attach("#FileOnNet #fileList tr td", menus);
                }

                // return false;// 阻止链接跳转
            })
        })();


        // file address bar
        function fileAddressBar(data) {
            var a = "<a path='" + data.parent.filePath + "' onclick='returnParent(this)'>返回上级</a>&nbsp;|&nbsp;";
            var parentModules = data.parentModules;
            var l = parentModules.length;
            var modules = "";
            for (--l; l >= 0; l--) {
                var v = parentModules[l];
                if (l !== 0) {
                    modules += "<a path='" + v.path + "' class='modules' onclick='returnParent(this)'>" + v.name + "</a>&nbsp;>&nbsp;"
                } else {
                    modules += "<span path=" + v.path + " class='modules'>" + v.name + "</span>"
                }
            }
            var $fileBar = $("#fileBar");
            $fileBar.html("");
            $fileBar.append(a);
            $fileBar.append(modules);
        }


        /**
         *网盘功能模块  目录获取
         *
         * @param selectPath 被选中的路径
         */
        function fileNet(selectPath) {
            $.ajax({
                url: "${ctx}/fileNet/getCurrentFile",
                type: "POST",
                dataType: "json",
                data: {
                    "rootPath": selectPath
                },
                success: function (data) {
                    var fileListHTML = template("fileNetList", {"data": data.data});
                    var $bd = $("#bd-data");
                    $bd.html("");
                    $bd.append(fileListHTML);
                    fileAddressBar(data);
                    $("#FileOnNet table #all").attr("checked", false);
                }
            })
        }

        // 测试活动页签
        function c() {
            var random = Math.round(Math.random() * 100);
            // 活动页签的ID 不可重复
            var id = "table_id1" + random;
            // 活动页签的名称
            var name = "table_name" + random;
            // 当前页签是否允许关闭 true：允许关闭
            var closable = true;
            // 模板HTML
            var template = "<p>这是内容 随机数为：" + random + "</p>";
            var item = {'id': id, 'name': name, 'closable': closable, 'template': template};
            // 执行创建页签
            closableTab.addTab(item);
        }

        /**
         * 关闭前确认
         * @param i 被关闭的当前元素
         */
        function remove(i) {
            bootbox.confirm("<span style='font-size: 16px'>确认要关闭此条记录吗?</span>", function () {
                closableTab.closeTab(i)
            })
        }


        /**
         * 返回到指定父级目录
         * @param item
         */
        function returnParent(item) {
            var $a = $(item);
            fileNet($a.attr("path"));
        }


        /**
         * 显示创建目录的弹窗
         * 将当前父路径赋值到指定位置
         */
        function showAddFileTmp() {
            var parentPath = $("#FileOnNet #fileBar span.modules").attr("path");
            $("#parentURI").val(parentPath);
            $("#addSonDirectory").modal("show");
        }


        /**
         * 显示文件上传的弹窗
         * 将当前父路径赋值到指定位置
         */
        function showUploadFileTmp() {
            var parentPath = $("#FileOnNet #fileBar span.modules").attr("path");
            $("#parentURI").val(parentPath);
            $("#addFile").modal("show");
        }


        /**
         * 选中文件
         */
        function selectFile() {
            var $checked = $("#FileOnNet table input:checked");
        }


        /**
         * 下载选择的文件
         * @param selectPath
         */
        function downloadFile(selectPath) {
            selectPath = encodeURIComponent(selectPath);
            var uri = "${ctx}/fileNet/downloadFile?selectPath=" + selectPath;
            window.open(uri);
        }


        /**
         * 显示重命名对话框 并赋值当前文件名称
         */
        function showRenameDialog() {
            var name = $.trim($("#currentName").data("currentName")).split(".")[0];
            $("#newName").val(name);
            $("#renameDialog").modal("show");
        }

        /**
         * 重命名文件
         *
         * @param currentPath
         * @param newName
         */
        function reNameFile() {
            var currentPath = $("#currentPath").data("currentPath");
            var newName = $.trim($("#newName").val());
            if (newName === "") {
                toastr["warning"]("请输入新名称", "警告！");
                return false;
            }

            $.ajax({
                type: "POST",
                url: "${ctx}/fileNet/renameFile",
                dataType: "JSON",
                data: {
                    "currentPath": currentPath,
                    "newName": newName
                },
                success: function (data) {
                    if (data.code === "success") {
                        toastr["success"]("重命名成功", "成功!");
                        fileNet($("#fileBar span").attr("path"));
                        $("#renameDialog").modal("hide");
                    } else {
                        toastr["error"](data.message, "重命名未成功");
                    }
                }

            });
        }


        /**
         * 获取被复制文件路径
         */
        function copyPath() {
            $("#copyCache").data("copyCache", $("#currentPath").data("currentPath"));
        }

        /**
         *将复制的文件粘贴到当前目录下
         */
        function pasteFile() {
            var currentPath = $("#fileBar span").attr("path");
            var copyCache = $("#copyCache").data("copyCache");
            if (typeof copyCache === "undefined" || copyCache === "") {
                toastr["info"]("请选择要粘贴的文件", "提示！");
                return false;
            }
            $.ajax({
                type: "POST",
                url: "${ctx}/fileNet/operationFile",
                data: {
                    "oldFile": copyCache,
                    "newFile": currentPath
                },
                success: function (data) {
                    if (data.code === "error") {
                        toastr["error"](data.message, "错误！");
                    } else {
                        $("#copyCache").data("copyCache", "");
                        toastr["success"](data.message, "成功！");
                        fileNet($("#fileBar span").attr("path"));
                    }
                }
            })
        }
    </script>
</div>

</html>

