<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/09/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>系统</title>
    <link href="${ctx}/resources/css/createTask.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="task-head">
        <span>DataSync / 数据范围</span>
    </div>
    <div class="task-title">
        <span>确定数据对象范围，上传数据</span>
    </div>
    <div class="select-way">
        <span>数据源:</span>
        <label for="aaa">数据库</label>
        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
        <label for="bbb">本地上传</label>
        <input name="ways" type="radio" value="LH" id="bbb"/>
    </div>
    <div class="select-ways">
        <div class="select-database">
            <span>选择数据源</span>
            <select  id="DBchange">
                <%--<option value="">-----------</option>
                <option value="aaa">关系数据源DB2</option>
                <option value="bbb">数据源OracleData</option>
                <option value="">关系数据源DB2</option>
                <option value="">数据源OracleData</option>
                <option value="">关系数据源DB2</option>
                <option value="">数据源OracleData</option>--%>
            </select>
            <div class="database-con-rel container-fluid" style="display: none">
                <div class="row">
                    <div class="col-md-3 dataHead1">数据源名称：</div>
                    <div class="col-md-9 dataHead2">关系数据源DB2</div>
                    <div class="col-md-12">
                        <div class="col-md-2">选择表资源</div>
                        <div class="col-md-9" >
                            <div class="row" id="db-table">
                                <%--<div class="col-md-4">
                                    <label>
                                        <input type="checkbox" name="relationCheck" value="aaa"> Remember me
                                    </label>
                                </div>
                                <div class="col-md-4">
                                    <label>
                                        <input type="checkbox" name="relationCheck" value="bbb"> Remember me
                                    </label>
                                </div>
                                <div class="col-md-4">
                                    <label>
                                        <input type="checkbox" name="relationCheck" value="ccc"> Remember me
                                    </label>
                                </div>
                                <div class="col-md-4">
                                    <label>
                                        <input type="checkbox" name="relationCheck" value="sss"> Remember me
                                    </label>
                                </div>
                                <div class="col-md-4">
                                    <label>
                                        <input type="checkbox" name="relationCheck" value="fff"> Remember me
                                    </label>
                                </div>
                                <div class="col-md-4">
                                    <label>
                                        <div class="checker">
                                            <span>
                                                <input type="checkbox" name="relationCheck" value="aaa">
                                            </span>
                                        </div> Remember me
                                    </label>
                                </div>--%>
                            </div>
                        </div>
                    </div>
                    <div id="totalList">
                        <div class="col-md-12" style="margin-bottom: 10px" >
                            <div class="col-md-2" style="text-align: right">sql查询</div>
                            <div class="col-md-4">
                                <input type="text" class="form-control sqlStatements" id="asdf">
                            </div>
                            <div class="col-md-2" style="margin: 0 -15px">
                                <input type="text" class="form-control" placeholder="请输入一个表名" name="sqlTableName">
                            </div>
                            <div class="col-md-4">
                                <button type="button" class="btn blue preview">预览</button>
                                <button type="button" class="btn green" onclick="addSql()"><span class="glyphicon glyphicon-plus"></span>sql查询</button>
                            </div>
                            <div class="col-md-2" style="text-align: left">
                            </div>
                        </div>
                        <div id="sqlList"></div>
                    </div>

                    <div class="col-md-12 ">
                        <button type="button" class="btn green pull-right" onclick="sendRelationTask()">提交</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="select-local" style="display: none;">
            <%--<button type="button" class="btn btn-success" id="upload-directory">上传目录</button>
            <button type="button" class="btn btn-success" id="upload-file">上传文件</button>
            <div style="min-height: 400px;margin-top: 50px">
                <div class="left">
                    <button type="button" class="btn btn-success btn-sm" style="margin-bottom:5px" onclick="editTree();"><i
                            class="glyphicon glyphicon-pencil"></i> 修改
                    </button>
                    <div id="jstree_show" style="height:300px"></div>
                </div>
                <div class="right" id="editRegon">

                </div>
            </div>--%>
            <%--<div style="height: 1000px;background-color: #7ad588"></div>
            <div class="col-md-12 ">
                <button type="button" class="btn green pull-right" onclick="sendFileTask()">提交</button>
            </div>--%>
                <span>选择数据源</span>
                <select  id="DBFilechange">
                    <%--<option value="">-----------</option>
                    <option value="aaa">关系数据源DB2</option>
                    <option value="bbb">数据源OracleData</option>
                    <option value="">关系数据源DB2</option>
                    <option value="">数据源OracleData</option>
                    <option value="">关系数据源DB2</option>
                    <option value="">数据源OracleData</option>--%>
                </select>
                <div class="database-con-file container-fluid" style="display: none;">
                    <div class="row">
                        <div class="col-md-12 dataHead3" style="max-height: 500px;overflow: auto;padding-top: 10px">
                            <div class="col-md-2">选择文件</div>
                            <div class="col-md-9 dataHead4" >
                                <div class="row" id="file-table">
                                    <%--<div class="col-md-4">
                                        <label>
                                            <input type="checkbox" name="relationCheck" value="aaa"> Remember me
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label>
                                            <input type="checkbox" name="relationCheck" value="bbb"> Remember me
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label>
                                            <input type="checkbox" name="relationCheck" value="ccc"> Remember me
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label>
                                            <input type="checkbox" name="relationCheck" value="sss"> Remember me
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label>
                                            <input type="checkbox" name="relationCheck" value="fff"> Remember me
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label>
                                            <div class="checker">
                                                <span>
                                                    <input type="checkbox" name="relationCheck" value="aaa">
                                                </span>
                                            </div> Remember me
                                        </label>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 ">
                            <button type="button" class="btn green pull-right" onclick="sendFileTask()">提交</button>
                        </div>
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
                <%--<div class="form">--%>
                <%--<form class="form-horizontal" role="form" action="addRelationalDatabase" method="post"--%>
                <%--accept-charset="utf-8" id="relationalDatabaseForm">--%>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet box green-haze" style="border:0;">
                                <div class="portlet-title">
                                    <ul class="nav nav-tabs" style="float:left;">
                                        <%--<li class="active">
                                            <a href="#editTableFieldComsId" data-toggle="tab"
                                               id="editTableDataAndComsButtonId" aria-expanded="true">
                                                编辑 </a>
                                        </li>--%>
                                        <li class="active">
                                            <a href="#previewTableDataAndComsId" id="previewTableDataAndComsButtonId"
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
                <%--</form>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="previewTableDataAndComsTmpl">
    <div class="skin skin-minimal">
        <table class="table table-hover table-bordered">
            {{each datas as itemList i}}
            {{if i == 0}}
            <thead>
            <tr style="word-break: keep-all">
                <th>#</th>
                {{each itemList as item j}}
                <th>{{item.columnName}}
                    {{if item.columnComment}}
                    <br/>({{item.columnComment}})
                    {{/if}}
                </th>
                {{/each}}
            </tr>
            </thead>
            {{/if}}
            <tbody>
            {{if i != 0}}
            <tr>
                <td>{{i}}</td>
                {{each itemList as item j}}
                <td>{{item}}</td>
                {{/each}}
            </tr>
            {{/if}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>
<script type="text/html" id="dataRelationshipList">
    <option value="" id="selNone" selected="selected">-----------</option>
    {{each data as value i}}
    <option value="{{value.dataSourceName}}" id="{{value.dataSourceId}}" task-name="value.DataTaskName">{{value.dataSourceName}}</option>
    {{/each}}
</script>
<script type="text/html" id="dataRelationshipList2">
    {{each list as value i}}
    <div class="col-md-6">
        <%--<label>
            <input type="checkbox" name="relationBox" value="{{value}}"> {{value}}
        </label>--%>
        <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="relationBox" value="{{value}}" style="line-height: normal"></div>
        <div style="padding-left: 20px"> {{value}}</div>
    </div>
    <%--<div class="col-md-4">
        <label>
            <div class="checker">
                <span>
                    <input type="checkbox" name="relationCheck" value="{{value}}">
                </span>
            </div> {{value}}
        </label>
    </div>--%>
    {{/each}}
</script>
<script type="text/html" id="addSql">
    <div class="col-md-12" style="margin-bottom: 10px" name="aaaa">
        <div class="col-md-2" style="text-align: right">sql查询</div>
        <div class="col-md-4">
            <input type="text" class="form-control sqlStatements" >
        </div>
        <div class="col-md-2" style="margin: 0 -15px">
            <input type="text" class="form-control" placeholder="请输入一个表名" name="sqlTableName">
        </div>
        <div class="col-md-4">
            <button type="button" class="btn blue preview">预览</button>
            <button type="button" class="btn red removeSql"><span class="glyphicon glyphicon-trash"></span>删除</button>
        </div>
        
    </div>
</script>

<script type="text/html" id="dataFileshipList">
    <option value="" id="selFileNone" selected="selected">-----------</option>
    {{each data as value i}}
    <option value="{{value.dataSourceName}}" Keyid="{{value.dataSourceId}}" task-name="value.DataTaskName">{{value.dataSourceName}}</option>
    {{/each}}
</script>
<script type="text/html" id="dataFileshipList2">
    {{each data as value i}}
    <div class="col-md-6">
        <label>
            <input type="checkbox" name="fileTable" value="{{value.id}}">
            <span style="word-break: break-all">{{value.text}}</span>
        </label>
    </div>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.min.js"></script>
    <%--<script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>--%>

    <script>
        var dataRelSrcId;
        var dataRelTaskName;
        var dataRelTableList;
        var dataRelSqlList;
        var dataRelSqlTableList;
        var dataFileSrcId;
        var dataFilePathList;
        var dataFileTaskName;
        var curSQLStrIndex = 0;
        $("[name='ways']").on("change",function () {
            if(this.value =="DB"){
                $(".select-database").show();
                $(".select-local").hide();

            }else {
                $(".select-database").hide();
                $(".select-local").show();
            }
        })
        $("#DBchange").on("change",function () {
            var id = $("#DBchange option:selected").attr("id");
            var taskNname = $("#DBchange option:selected").attr("task-name");
            dataRelSrcId =id;
            dataRelTaskName = taskNname;
            var name = $(this).val();
            if(name == ""){
                $(".database-con-rel").hide();
                return
            }
            $(".database-con-rel").show();
            $(".dataHead2").html(name);
            $.ajax({
                url:"${ctx}/relationship/relationalDatabaseTableList",
                type:"POST",
                data:{
                    dataSourceId:id
                },
                success:function (data) {
                    $("#db-table").empty();
                    var List =JSON.parse(data);
                    console.log(List)
                    var tabCon = template("dataRelationshipList2", List);
                    $("#db-table").append(tabCon);

                },
                error:function () {
                    console.log("请求失败")
                }
            })
        })
        $("#DBFilechange").on("change",function () {
            var id = $("#DBFilechange option:selected").attr("Keyid");
            var taskname = $("#DBFilechange option:selected").attr("task-name");
            dataFileSrcId =id;
            dataFileTaskName=taskname;
            var name = $(this).val();
            if(name == ""){
                $(".database-con-file").hide();
                return
            }
            $(".database-con-file").show();

            $.ajax({
                url:"${ctx}/fileResource/fileSourceFileList",
                type:"POST",
                data:{
                    dataSourceId:id
                },
                success:function (data) {
                    $("#file-table").empty();
                    var List =JSON.parse(data)
                    console.log(List)
                    var data={
                        data:List
                    }
                    var tabCon = template("dataFileshipList2", data);
                    $("#file-table").append(tabCon);
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        })
        $("#sqlList").delegate(".removeSql","click",function () {
            $(this).parent().parent().remove();
        })
        $("#totalList").delegate(".preview","click",function () {
            var $Str =$(this).parent().parent().find(".sqlStatements").val();
            /*staticSourceTableChoice(2, null, dataRelSrcId, $Str, "dataResource");*/
            $("#staticSourceTableChoiceModal").modal("show");
            previewSqlDataAndComs(dataRelSrcId,$Str);
           /* $.ajax({
                url:"${ctx}/relationship/previewRelationalDatabaseBySQL",
                type:"POST",
                data:{
                    dataSourceId:dataRelSrcId,
                    sqlStr:$Str
                },
                success:function (data) {
                    console.log(data);
                },
                error:function () {
                    console.log("请求失败")
                }
            })*/
        })
        function staticSourceTableChoice(editIsChoiceTableOrSql, obj, dataSourceId, tableNameOrSql, refer) {
            if (refer == "dataService" || !obj || obj.checked) {
                $('#editTableFieldComsId').html("");
                $('#previewTableDataAndComsId').html("");

                $('#editTableDataAndComsButtonId').parent().removeClass("active");
                $('#previewTableDataAndComsButtonId').parent().removeClass("active");

                $('#editTableFieldComsId').removeClass("active");
                $('#previewTableDataAndComsId').removeClass("active");

                $('#editTableDataAndComsButtonId').parent().addClass("active");
                $('#editTableFieldComsId').addClass("active");
                /*var tableInfosList = null;
                if (editIsChoiceTableOrSql == 1) {
                    var tableInfos = getTableFieldComs(dataSourceId, tableNameOrSql);
                    tableInfosList = [];
                    tableInfosList[0] = {tableName: tableNameOrSql, tableInfos: tableInfos};
                } else if (editIsChoiceTableOrSql == 2) {
                    var tableInfosMap = getSqlFieldComs(dataSourceId, tableNameOrSql);
                    var i = 0;
                    tableInfosList = [];
                    for (var key in tableInfosMap) {
                        tableInfosList [i++] = {tableName: key, tableInfos: tableInfosMap[key]};
                    }
                }*/
                /*if (!tableInfosList || tableInfosList.length == 0) {
                    if (editIsChoiceTableOrSql == 2) {
                        toastr["warning"]("提示！", "请先检查填写sql语句");
                    }
                    return;
                }*/
                $("#staticSourceTableChoiceModal").modal("show");
                // var html = template("editTableFieldComsTmpl", {"tableInfosList": tableInfosList});
                // $('#editTableFieldComsId').html(html);
                curSourceTableChoice = obj;
                curDataSourceId = dataSourceId;
                curEditIsChoiceTableOrSql = editIsChoiceTableOrSql;
                curRefer = refer;
                if (editIsChoiceTableOrSql == 1) {
                    curTableName = tableNameOrSql;
                } else if (editIsChoiceTableOrSql == 2) {
                    curSQL = tableNameOrSql;
                }
                // preSaveEditTableFieldComs();// 页面与保存coms信息
            } else {
                $(obj).removeAttr("coms");
            }
            $("#form_wizard_1").find(".button-save").removeAttr("disabled");

        }
        function getTableFieldComs(dataSourceId, tableName) {
            var dataResult = null;
            $.ajax({
                type: "GET",
                url: '${ctx}/getTableFieldComs',
                data: {"dataSourceId": dataSourceId, "tableName": tableName, "timestamp": Date.parse(new Date())},
                dataType: "json",
                async: false,
                success: function (data) {
                    if (!data || !data.tableInfos) {
                        return;
                    }
                    dataResult = data.tableInfos;
                }
            });
            return dataResult;
        }
        function getSqlFieldComs(dataSourceId, sqlStr) {
            var dataResult = null;
            $.ajax({
                type: "GET",
                url: '${ctx}/relationship/previewRelationalDatabaseBySQL',
                data: {"dataSourceId": dataSourceId, "sqlStr": sqlStr},
                dataType: "json",
                async: false,
                success: function (data) {
                    if (!data || !data.tableInfos) {
                        return;
                    }
                    dataResult = data.tableInfos;
                }
            });
            return dataResult;
        }



        function addSql() {
            var tabCon = template("addSql");
            $("#sqlList").append(tabCon);
        }

        <!--create relation task -->
        function sendRelationTask() {
            var $eleChecked = $("[name='relationBox']:checked")
            $("[name='sqlTableName']").each(function () {
                if($(this).val() == ""){
                    toastr["warning"]("提示！", "请为预览sql编辑一个表名");
                    return
                }
                dataRelSqlTableList+=$(this).val()+";"
            })
            var numChecked = $eleChecked.size();

            if (numChecked == 0) {
                toastr["success"]("最少选择一个表资源");
                return
            }
            var relTabStr = "";
            $eleChecked.each(function () {
                relTabStr+=$(this).val()+";"
            });
            var relSqlStr= "";
            $(".sqlStatements").each(function () {
                relSqlStr+=$(this).val()+";"
            })
            dataRelTableList= relTabStr;
            dataRelSqlList =relSqlStr;
            $.ajax({
                url:"${ctx}/datatask/saveRelationDatatask",
                type:"POST",
                data:{
                    dataSourceId:dataRelSrcId,
                    dataRelTableList:dataRelTableList,
                    dataRelSqlList:dataRelSqlList
                },
                success:function (data) {
                    /*window.location.href="${ctx}/dataUpload"*/
                },
                error:function () {
                }
            })

        }
        function sendFileTask(){
            var $eleChecked = $("[name='fileTable']:checked")
            var numChecked = $eleChecked.size();
            if (numChecked == 0) {
                toastr["success"]("最少选择一个文件资源");
                return
            }
            var fileTabStr = "";
            $eleChecked.each(function () {
                fileTabStr+=$(this).val()+";"
            });
            dataFilePathList=fileTabStr;
            $.ajax({
                url:"${ctx}/relationship/saveDatatask",
                type:"POST",
                data:{
                    dataSourceId:dataFileSrcId,
                    souceCheck:dataFileTaskName,
                    sqlStatements:dataFilePathList,
                },
                success:function (data) {
                    /*window.location.href="${ctx}/dataUpload"*/
                },
                error:function () {
                }
            })
        }

        $(function(){
            $.ajax({
                url:"${ctx}/relationship/findAllDBSrc",
                type:"GET",
                success:function (data) {
                    var list =JSON.parse(data)
                    console.log(list)
                    var data={
                        data:list
                    }
                    var tabCon = template("dataRelationshipList", data);
                    $("#DBchange").append(tabCon);
                },
                error:function () {
                    console.log("请求失败")
                }
            })
            $.ajax({
                url:"${ctx}/fileResource/findAllFileSrc",
                type:"GET",
                success:function (data) {
                    var list =JSON.parse(data)
                    var data={
                        data:list
                    }
                    var tabCon = template("dataFileshipList", data);
                    $("#DBFilechange").append(tabCon);
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });




       /* var treeData = {
            'core' : {
                "animation": 0,
                "check_callback":false,
                'data' : [
                    {
                        "text" : "Root node",
                        "state" : { "opened" : true },
                        "children" : [
                            {
                                "text" : "Child node 1",
                                "state" : { "selected" : true },
                                "icon" : "jstree-file"
                            },
                            { "text" : "Child node 2",  }
                        ]
                    }
                ]
            },
            "plugins" : ["dnd","state","types","wholerow"]
        }
        $("#jstree_show").jstree(treeData);
        var jsdata;
        var deleteNodeArray;
        $(".select-local>button").on("click",function () {
            jsdata=null;
            $("#jstree_show").jstree({
                'core' : {
                    'data' :{
                        'url':$.hr_contextUrl()+"menu/list",
                        'data':function(node){
                            return node;
                        }
                    }
                },
                'plugins':['contextmenu','sort'],
                "contextmenu":{
                    "items":{
                        "create":null,
                        "rename":null,
                        "remove":null,
                        "ccp":null,
                        "新建菜单":{
                            "label":"新建菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0])
                                var pid = node.parent;
                                _menu.operation.addMenu(pid,node);
                            }
                        },
                        "删除菜单":{
                            "label":"删除菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                _menu.operation.delMenu(node);
                            }
                        },
                        "修改菜单":{
                            "label":"修改菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]).original;
                                _menu.operation.editMenu(node);
                            }
                        },
                        "上移菜单":{
                            "label":"上移菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var prev_dom = $(data.reference[0]).closest("li").prev();
                                _menu.operation.sortMenu(node,prev_dom);
                            }
                        },
                        "下移菜单":{
                            "label":"下移菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var next_dom = $(data.reference[0]).closest("li").next();
                                _menu.operation.sortMenu(node,next_dom);
                            }
                        },
                        "新建子菜单":{
                            "label":"新建子菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var pid = node.id;
                                _menu.operation.addMenu(pid,node);
                            }
                        }
                    }
                }
            });
            $("#editRegon").empty();
            var url = this.id == "upload-directory"? "upload-directory":"upload-file";
            /!*$.ajax({
                url: ctx + url,
                type: "get",
                dataType: "json",
                data: {editable: false},
                success: function (data) {
                    jsdata =data
                    $('#jstree_show').jstree(data);
                }
            })*!/
        })

        function editTree() {
            if($("#editRegon").html().trim() != ""){
                return false;
            }
            deleteNodeArray = new Array();
            var html = '<div class="row" style="margin-bottom:12px"> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_create();"><i class="glyphicon glyphicon-asterisk"></i> 添加</button> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_rename();"><i class="glyphicon glyphicon-pencil"></i> 重命名</button> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_delete();"><i class="glyphicon glyphicon-remove"></i> 删除</button> ' +
                '</div> ' +
                '<div id="jstree_edit" style="height:300px"></div> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_cancel();" style="margin-left:5px"><i class="glyphicon glyphicon-remove"></i> 取消</button>' +
                '<button type="button" class="btn btn-primary btn-sm" onclick="jstree_submit();" style="margin-left:5px"><i class="glyphicon glyphicon-ok"></i> 提交</button>'
            $("#editRegon").append(html);
            //这有一点需要补充
             var to = false;
             $('#demo_q').keyup(function () {
                 if (to) {
                     clearTimeout(to);
                 }
                 to = setTimeout(function () {
                     var v = $('#demo_q').val();
                     $('#jstree_edit').jstree(true).search(v);
                 }, 250);
             });
            treeData.core.check_callback= true;
            treeData.plugins=["contextmenu", "dnd", "state", "types", "wholerow"]
            $('#jstree_edit').jstree(treeData);
        }

        function jstree_cancel(){
            $("#editRegon").html("");
            treeData.core.check_callback= false;
            treeData.plugins=["dnd","state","types","wholerow"]
        }
        function jstree_create() {
            var ref = $('#jstree_edit').jstree(true),
                sel = ref.get_selected();
            if (!sel.length) {
                return false;
            }
            sel = sel[0];

            sel = ref.create_node(sel);
            ref.set_icon(sel, "glyphicon glyphicon-th-list");

            if (sel) {
                ref.edit(sel);
            }
        }
        function jstree_rename() {
            var ref = $('#jstree_edit').jstree(true),
                sel = ref.get_selected();
            if (!sel.length) {
                return false;
            }
            sel = sel[0];
            ref.edit(sel);
        }
        function jstree_delete() {

            /!* var ref = $('#jstree_edit').jstree(true);
             sel = ref.get_selected();
             if (!sel.length) {
                 return false;
             }*!/
            /!*ref.delete_node(sel);
            if(sel[0].indexOf("_")<0){
                deleteNodeArray.push(sel[0]);
            }*!/
            /!*$("#deleteContent").attr("nodeid",sel[0]);*!/
            $("#deleteNodeModal").modal('show');
            /!*$("#deleteContent").html('<div align="center">确认删除'+ref.get_node(sel).text+'节点？</div>')*!/
            $("#deleteContent").html('<div align="center">确认删除节点？</div>')
        };
        function confirmDeleteNode(){
            if(syncSwitch = "deny"){
                toastr["warning"]("己经开始同步数据，不能再删除记录！", "数据删除");
            }else{
                var ref = $('#jstree_edit').jstree(true);
                sel =$('#jstree_edit').jstree("get_node", $("#deleteContent").attr("nodeid"));
                ref.delete_node(sel);
                if (sel.id.indexOf("_") < 0) {
                    deleteNodeArray.push(sel.id);
                }
            }

        }

        function jstree_submit() {
            var treeData = $.jstree.reference('jstree_edit')._model.data;
            var packageTreeData = new Array();
            $.each(treeData, function (n, value) {
                if (value.parent != null) {
                    var nodeData = {
                        id: value.id,
                        text: value.text,
                        parent: value.parent,
                        level: value.parents.length,
                        order: n
                    };
                    packageTreeData.push(nodeData);
                }
            });
            $.ajax({
                url: ctx + "/resCatalogSubmit",
                type: "get",
                dataType: "json",
                data: {packageTreeData: JSON.stringify(packageTreeData),
                    deleteNodeArray:JSON.stringify(deleteNodeArray)},
                success: function (data) {
                    window.location.href = ctx + "/resCatalog";
//                    toastr["success"]("资源目录添加成功！", "success！");
                }
            })
        }
*/

        /*$("#previewTableDataAndComsButtonId").bind("click", function () {
            if (curEditIsChoiceTableOrSql == 1) {
                var tableInfos = getEditTableOrSqlFieldComs();
                previewTableDataAndComs(curDataSourceId, tableInfos);
            } else if (curEditIsChoiceTableOrSql == 2) {
                // var tableInfos = getEditTableOrSqlFieldComs();
                previewSqlDataAndComs(curDataSourceId);
            }
        });*/

        function previewSqlDataAndComs(dataSourceId,str) {
            /*var sqlStr;
            if (curRefer == "dataService") {
                sqlStr = $("#publicSql").val();
            } else {
                var sqlStrId = "sqlStr";
                if (curSQLStrIndex < 0) {
                    return;
                }
                if (curSQLStrIndex != 0) {
                    sqlStrId += curSQLStrIndex;
                }
                sqlStr = $("#" + sqlStrId).val();
            }*/
            console.log(dataSourceId);
            console.log(str);
            $.ajax({
                type: "GET",
                url:  '${ctx}/relationship/previewRelationalDatabaseBySQL',
                data: {
                    "dataSourceId": dataSourceId,
                    "sqlStr": str
                },
                dataType: "json",
                success: function (data) {
                    console.log(data)
                    if (!data || !data.datas) {
                        return;
                    }
                    var columnTitleList = [];
                    // tableInfosList.forEach(function (tableInfos, index1, array1) {
                    //     tableInfos.tableInfos.forEach(function (value, index2, array2) {
                    //         // var columnTitle = value.columnNameLabel + "<br>(" + value.columnComment + ")";
                    //         // columnTitleList.push(columnTitle);
                    //         columnTitleList.push({columnName:value.columnName,columnComment:value.columnComment});
                    //     });
                    // });
                    data.datas.unshift(columnTitleList);
                    var html = template("previewTableDataAndComsTmpl", {"datas": data.datas});
                    $('#previewTableDataAndComsId').html(html);
                }
            });
        }

        $(function () {
            /*tableConfiguration();*/
        })

    </script>
</div>

</html>
