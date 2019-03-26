<%--
  User: jinbao
  CreateTate: 2019/3/21  9:54
  通过excel创建表以及导入数据
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%--弹窗页定义 开始--%>
<%--弹窗页定义 结束--%>


<%--正文开始--%>
<div id="excelTableList">
    <div class="qiehuan_div">
        <ul class="nav nav-tabs activeTabs" role="tablist">
        </ul>
    </div>
    <div class="tap_div">
        <div class="tab-content activeTabs" style="width:100%;">
            <table spellcheck="0" class="table table-hover biaoge" cellspacing="0" border="0">
            </table>
        </div>

    </div>
</div>
<div id="uploadExcel" style="height: 200px;background: #dddddd">
    <form name="form" id="fileForm" method="post" style="text-align: center;">
        <a href="${ctx}/fileImport/getExcelTemplate">点击下载Excel模板</a><br/>
        <input id="excelFile" style="display: inline;margin-left: 7%;" type="file" name="file"/><br/>
        <input id="excelFileUpload" type="button" class="btn btn-default" onclick="uploadExcel();"
               value="上传"/>
    </form>
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


        (function () {
            initExcelUpload();

            closableTab.afterCloseTab = function (item) {
                if (!$(".nav.nav-tabs.activeTabs li")[0]) {
                    initExcelUpload();
                }
            }
        })();


        function initExcelUpload() {
            $("#uploadExcel").show();
            $("#excelFile").val("");
            $("#excelTableList").hide();
        }


        function showExcelTables() {
            $("#uploadExcel").hide();
            $("#excelTableList").show();
        }


        function uploadExcel() {
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
                class="saveExcelSuccess btn bule" tablename="{{tableName}}">上传数据
        </button>
    </script>
</div>
<%--模板定义 结束--%>
</html>
