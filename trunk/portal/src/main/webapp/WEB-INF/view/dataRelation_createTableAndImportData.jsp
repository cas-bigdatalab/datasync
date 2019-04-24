<%--
  User: jinbao
  CreateTate: 2019/3/21  9:54
  通过excel创建表以及导入数据
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>Title</title>

    <style>
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }

        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }

        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }

        .inputfile {
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
            position: absolute;
            z-index: -1;
        }

        .qiehuan_div li.active a {
            background: #2a6ebf !important;
            margin-right: 1px !important;
            color: #fff !important;
        }

        .preview {
            height: auto;
            width: auto;
            border: none;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>

<%--弹窗页定义 开始--%>
<div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
    <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
        <div class="modal-content">
            <div class="modal-header bg-primary" style="background-color: #1e8753 !important;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                        id="editTableFieldComsCloseId"></button>
                <h4 class="modal-title" id="relationalDatabaseModalTitle"
                    style="color: white;font-size: 18px;font-weight: 500;">预览数据</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box green-haze" style="border:0;">
                            <div class="portlet-title" style="display: none">
                            </div>
                            <div class="tab-content"
                                 style="background-color: white;min-height:300px;max-height:70%;padding-top: 20px ; overflow: scroll;">
                                <div id="previewTableDataAndComsId" style="max-height: 400px;">
                                    <div class="skin skin-minimal">
                                        <table class="table table-hover table-bordered">
                                            <thead>
                                            <tr style="word-break: keep-all" id="pre-head">
                                                <th>#</th>
                                            </tr>
                                            </thead>
                                            <tbody id="pre-body">

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="editTableFieldComsSaveId" data-dismiss="modal" class="btn red">关闭
                </button>
            </div>
        </div>
    </div>
</div>
<%--弹窗页定义 结束--%>


<%--正文开始--%>
<div class="qiehuan_div">
    <ul class="nav nav-tabs activeTabs" role="tablist">
    </ul>
</div>


<div class="tab-content" style="background-color: white;">
    <%--导入式建表--%>
    <div class="tab-pane active" id="uploadExcel" style="height: 200px;background: #dddddd">
        <form name="form" id="fileForm" method="post" style="text-align: center;">
            <div style="padding-top: 5%;"></div>
            <a href="${ctx}/fileImport/getExcelTemplate" style="font-size: 19px;">点击下载Excel模板</a><br/>
            <div style="margin: 25px;"></div>
            <input type="file" name="file" id="excelFile" class="inputfile"/>
            <label id="fileLabel" for="excelFile" class="btn btn-default">请选择上传文件</label>
            <input id="excelFileUpload" type="button" class="btn btn-default" onclick="uploadExcel();" value="上传"/>
            <input id="resetFile" type="button" class="btn btn-default" onclick="initExcelCreateTable()" value="重置"/>
        </form>

    </div>

    <%--关联创建表--%>
    <div class="tab-pane" id="sql">
        <div style="width: 100%;height: 80%;background: #dddddd">
            <p></p>
            <p>通过联合表A和表B，形成新表</p>
            <div style="border: red solid 2px">
                <form id="selectTable">
                    <div class="row">
                        <div class="col-md-1"> 关联表A</div>
                        <div class="col-md-5">
                            <select id="tableA">

                            </select>
                        </div>
                        <div class="col-md-5">
                            <select id="tableFeild">

                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1">
                            <input type="checkbox"/>
                        </div>
                    </div>
                </form>
            </div>
            <p>通过SQL语句，形成新表</p>
            <div class="col-md-12" style="border: red solid 2px">
                <form id="selectSQL">
                    <div id="totalList">
                        <div class="col-md-12" style="margin-bottom: 10px;padding-top: 50px;">
                            <div class="col-md-1">SQL查询</div>
                            <%--style="text-align: right;margin-left: 35px;"--%>
                            <div class="col-md-7">
                                <input type="text" class="form-control sqlStatements inputVili" name="newSql">
                                <%--<textarea class="form-control sqlStatements inputVili" placeholder="查询语句" name="newSql"></textarea>--%>
                            </div>
                            <div class="col-md-2" style="margin: 0 -15px">
                                <input type="text" class="form-control inputVili" placeholder="新表名" name="newName">
                                <%--<textarea class="form-control sqlStatements inputVili" placeholder="新表名" name="newName"></textarea>--%>
                            </div>
                            <div class="col-md-4" style="display: contents">
                                <button type="button" class="btn blue preview">预览</button>
                                <button type="button" class="btn green" onclick="createTableBySql(this)"><span
                                        class="glyphicon glyphicon-plus"></span>创建表
                                </button>
                            </div>
                            <div class="col-md-2" style="text-align: left;width: 20px;">
                            </div>
                        </div>
                        <div id="sqlList"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--解析excel根据sheet页生成表格--%>
<div id="excelTableList">
    <div class="tap_div">
        <div class="tab-content activeTabs" style="width:100%;">
            <table spellcheck="0" class="table table-hover biaoge" cellspacing="0" border="0">
            </table>
        </div>

    </div>
</div>
<%--正文结束--%>
</div>
</body>

<%--js 开始--%>
<div id="siteMeshJavaScript">
    <script type="text/javascript"
            src="${ctx}/resources/bundles/bootstrap-closable-tab/bootstrap-closable-tab.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/layerJs/layer.js"></script>
    <script>

        var sub = '${sessionScope.SubjectCode}';
        var excelFileName;
        var tagParent = $("div.qiehuan_div ul");
        var li_excel = '<li class="active" value="0"><a id="createTableByExcel" href="#uploadExcel" data-toggle="tab">导入式建表</a></li>';
        var li_sql = '<li class="" value="1"><a id="createTableBySQL" href="#sql" data-toggle="tab">关联创建新表</a></li>';
        (function () {
            initExcelCreateTable();

            closableTab.afterCloseTab = function (item) {
                if (!$(".nav.nav-tabs.activeTabs li")[0]) {
                    $("#uploadExcel").addClass("active");
                    initExcelCreateTable();
                }
            };

            var $inputs = $("#excelFile");
            [].forEach.call($inputs, function (e) {
                var label = $inputs.next();
                $inputs.on("change", function (e) {
                    excelFileName = e.target.value.split("\\").pop();
                    label.text(excelFileName);
                    resetButton(true);
                })
            });

            initSqlCreateTable();
        })();

        function initExcelCreateTable() {
            resetFile();
            tagParent.html("");
            tagParent.append(li_excel);
            tagParent.append(li_sql);
            $("#excelTableList").hide();
        }

        function resetFile() {
            resetButton(false);
            $("#excelFile").val("");
            $("#fileLabel").text("请选择上传文件");
        }

        function resetButton(isSelectFile) {
            if (isSelectFile) {
                $("#excelFileUpload").show();
                $("#resetFile").show();
            } else {
                $("#excelFileUpload").hide();
                $("#resetFile").hide();
            }
        }

        function showExcelTables() {
            $("#uploadExcel").removeClass("active");
            $("#excelTableList").show();
        }

        function uploadExcel() {
            var formData = new FormData($("#fileForm")[0]);
            var fileName = excelFileName;

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
            formData.append("subjectCode", sub);
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
                },
                success: function (result) {
                    var resultJson = JSON.parse(result);
                    if (resultJson["code"] === "error") {
                        toastr["error"]("错误！", resultJson["message"]);
                    } else {
                        var data = resultJson.data;
                        tagParent.html("");
                        $.each(data, function (index, value) {

                            $.each(value, function (sheetName, sheetData) {
                                var id = sheetName;
                                var name = sheetName;
                                var closable = "true";
                                var html = "";
                                var tableStatus = sheetData[0][0];
                                if (tableStatus === "isExist") {
                                    html = template("insertData", {"data": sheetData, "tableName": sheetName});
                                } else {

                                    html = template("createTable", {"data": sheetData, "tableName": sheetName});
                                }
                                var item = {'id': id, 'name': name, 'closable': closable, 'template': html};
                                // 执行创建页签
                                closableTab.addTab(item);
                            })


                        });
                        showExcelTables();
                    }
                },
                complete: function () {
                    $("#layui-layer-shade" + index + "").remove();
                    $("#layui-layer" + index + "").remove();
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
            var tableName = $(_this).attr("tableName");
            var table = $("div[tablename=" + tableName + "] table")[0];
            var tableData = parseTableData2Json(table);
            var size = tableData.data.length;
            if (size) {
                var data = new FormData($("#fileForm")[0]);
                var s = JSON.stringify(tableData.data);
                data.append("tableData", s);
                data.append("subjectCode", sub);
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
                    dataType: "JSON",
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
                        var jsonData = data;
                        if (jsonData.code === "error") {
                            toastr["error"]("错误！", jsonData.message);
                        } else {
                            toastr["success"]("提示！", jsonData.message);
                            var $saveExcelSuccess = $(_this);
                            $saveExcelSuccess.text("保存成功");
                            $saveExcelSuccess.attr('disabled', 'disabled');

                        }
                    },
                    complete: function () {
                        $("#layui-layer-shade" + index + "").remove();
                        $("#layui-layer" + index + "").remove();
                    }
                });
            }
        }

        function parseTableData2Json(table) {
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
                    var b = serializeTableForCreate(cellLength, cells, trl, i);
                    if (b === false) {
                        return b;
                    }
                    result["type"] = "createAndInsert";
                }
                if (cellLength === 5) {
                    serializeTableForInsert(cellLength, cells, trl, i);
                    result["type"] = "insert";
                }
            }
            result["data"] = trl;
            return result;
        }

        function serializeTableForCreate(cellLength, cells, trl, i) {
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

        function serializeTableForInsert(cellLength, cells, trl, i) {
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

        function saveValueAfterDeleteTable() {
            var tableName = $.trim($("div.qiehuan_div ul li.active a").text());
            bootbox.confirm("<span style='font-size: 16px'>确认要删除 “" + tableName + "” 数据表么</span>",
                function (result) {
                    if (result) {
                        $.ajax({
                            url: "${ctx}/fileImport/deleteTable",
                            dataType: "JSON",
                            type: "POST",
                            data: {
                                "tableName": tableName,
                                "subjectCode": sub

                            },
                            success: function (data) {
                                var parse = data;
                                if (parse.code === "success") {
                                    initExcelCreateTable();
                                    toastr["info"]("提示！", parse.message);
                                }
                            }
                        })
                    }
                }
            );
        }

        function initSqlCreateTable() {
            $("#sqlList").on("click", ".removeSql", function () {
                $(this).parent().parent().remove();
            });
            $("#totalList").on("click", ".preview", function () {
                var $Str = $(this).parent().parent().find(".sqlStatements").val();
                previewSqlDataAndComs(this);
            });
            $("#totalList").on("change", ".sqlStatements", function () {
                $(this).css("border-color", "")
            })
        }

        function createTableBySql(_this) {
            var sql = validateSql(_this);
            if (sql.flg !== "true") {
                toastr["error"](sql.flg, "错误！");
                return;
            }

            var tableName = validateTableName(_this);
            if (tableName.flg !== "true") {
                toastr["error"](tableName.flg, "错误！");
                return;
            }
            createTableBySql_real(sql.newSql, tableName.newName)
        }

        function createTableBySql_real(newSql, newName) {
            $.ajax({
                type: "POST",
                url: "${ctx}/fileImport/createTableBySql",
                dataType: "JSON",
                data: {
                    newSql: newSql,
                    newName: newName
                },
                success: function (data) {
                    console.log(data);
                    debugger
                }
            })
        }

        function validateSql(_this) {
            var result = {};
            var selectSql = $.trim($(_this).parent().parent().find('[name="newSql"]').val());
            if (selectSql.length === 0) {
                toastr["error"]("查询语句不能为空", "错误！");
                return;
            }
            result["newSql"] = selectSql;
            $.ajax({
                async: false,
                url: "${ctx}/fileImport/validateSqlString",
                type: "POST",
                dataType: "JSON",
                data: {
                    newSql: selectSql
                },
                success: function (data) {
                    result["flg"] = data;
                }
            });
            return result;
        }

        function validateTableName(_this) {
            var result = {};
            var newName = $.trim($(_this).parent().parent().find('[name="newName"]').val());
            if (newName.length === 0) {
                toastr["error"]("请输入新的表名", "错误！");
                return;
            }
            result["newName"] = newName;
            $.ajax({
                async: false,
                type: "POST",
                url: "${ctx}/fileImport/validateTableName",
                dataType: "JSON",
                data: {
                    newName: newName
                },
                success: function (data) {
                    result["flg"] = data;
                }
            })
            return result;
        }

    </script>
</div>
<%--js 结束--%>

<%--模板定义 开始--%>
<div id="artTemplate">
    <script type="text/html" id="createTable">
        <div tableName="{{tableName}}" class="tab-pane">
            <table class="table table-hover table-bordered">
                <thead>
                <tr style="word-break: keep-all">
                    <th>序号</th>
                    <th>excel字段名称</th>
                    <th>excel字段注释</th>
                    <th>字段类型</th>
                    <th>字段长度</th>
                    <th>
                        是否主键
                        <button class="btn btn-default" id="clearPK" type="button">清除</button>
                    </th>
                </tr>
                </thead>
                <tbody>
                {{each data as v i}}
                {{if i > 0}}
                <tr>
                    <td>{{i}}</td>

                    {{each v as vv ii}}
                    {{if ii > 2}}
                    <td>
                        <input name={{vv}} value={{vv}}>
                    </td>
                    {{/if}}
                    {{/each}}

                    <td>
                        <select fieldType={{v[0]}}>
                            <option selected value="0">请选择字段类型</option>
                            <option value="varchar">varchar</option>
                            <option value="int">int</option>
                            <option value="text">text</option>
                        </select>
                    </td>

                    <td>
                        <input fieldLength={{v[0]}} placeholder="请输入字段长度"/>
                    </td>
                    <td><input fieldPk="{{v[0]}}" name="isPK" type="radio"/></td>
                </tr>
                {{/if}}
                {{/each}}
                </tbody>
            </table>
        </div>
        <button type="button" onclick="createTableAndInsertValue(this)" data-dismiss="modal"
                class="saveExcelSuccess btn bule" tablename="{{tableName}}">创建表并上传数据
        </button>
    </script>

    <script type="text/html" id="insertData">
        <div class="tab-pane" tableName="{{tableName}}">
            <table class="table table-hover table-bordered">
                <thead>
                <tr style="word-break: keep-all">
                    <th>表中字段名称</th>
                    <th>表中字段注释</th>
                    <th>excel字段名称</th>
                    <th>excel字段注释</th>
                    <th>是否主键</th>
                </tr>
                </thead>
                <tbody>
                {{each data as v i}}
                {{if i > 0 && v[0] !="PORTALID"}}
                <tr>
                    {{each v as vv ii}}
                    {{if ii == 0 || ii == 1}}
                    <td>
                        {{vv}}
                    </td>
                    {{/if}}
                    {{/each}}


                    <td>
                        <select>
                            <option value="-1">不匹配任何字段</option>
                            {{each data as vd id}}
                            {{if id > 0 && vd[3] != ""}}
                            {{if id == i}}
                            <option selected="selected" value={{vd[3]}}>{{vd[3]}}</option>
                            {{else}}
                            <option value={{vd[3]}}>{{vd[3]}}</option>
                            {{/if}}
                            {{/if}}
                            {{/each}}
                        </select>
                    </td>


                    {{each v as vv ii}}
                    {{if ii == 4}}
                    <td>{{vv}}</td>
                    {{/if}}
                    {{/each}}

                    {{if v[2] == "PRI"}}
                    <td><input type="radio" name="isPK" fieldPk="{{v[0]}}" checked disabled/></td>
                    {{else }}
                    <td><input type="radio" name="isPK" disabled/></td>
                    {{/if}}
                </tr>
                {{/if}}
                {{/each}}
                </tbody>
            </table>
        </div>
        <button type="button" onclick="createTableAndInsertValue(this)" data-dismiss="modal"
                class="saveExcelSuccess btn bule" tablename="{{tableName}}">增量保存
        </button>
        <button type="button" onclick="saveValueAfterDeleteTable()" data-dismiss="modal"
                class="saveExcelSuccess btn bule" tablename="{{tableName}}">重新上传
        </button>
    </script>

    <%--sql建表新增--%>
    <script type="text/html" id="addSql">
        <div class="col-md-12" style="margin-bottom: 10px;margin-left: 35px;" name="aaaa">
            <div class="col-md-2" style="text-align: right">SQL查询</div>
            <div class="col-md-4">
                <input type="text" class="form-control sqlStatements inputVili">
            </div>
            <div class="col-md-2" style="margin: 0 -15px">
                <input type="text" class="form-control inputVili" placeholder="新表名 " name="sqlTableName">
            </div>
            <div class="col-md-4">
                <button type="button" class="btn blue preview">预览</button>
                <button type="button" class="btn red removeSql"><span class="glyphicon glyphicon-trash"></span>删除
                </button>
            </div>

        </div>
    </script>
</div>
<%--模板定义 结束--%>
</html>
