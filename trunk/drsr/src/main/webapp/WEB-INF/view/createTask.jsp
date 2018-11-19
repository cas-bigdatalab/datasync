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
        <%--<span>确定数据对象范围，上传数据</span>--%>
        <form class="form-inline">
            <div class="form-group">
                <label for="dataTaskName" style="font-size: 18px">创建任务名</label>
                <input type="text" class="form-control" id="dataTaskName" >
            </div>
        </form>
    </div>

    <div class="select-way">
        <span>数据源</span>
        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
        <label for="aaa">数据库上传</label>
        <input name="ways" type="radio" value="LH" id="bbb"/>
        <label for="bbb">本地上传</label>
    </div>
    <div class="select-ways" >
        <div class="select-database ">
            <form class="form-inline">
                <div class="form-group">
                    <label >选择数据源</label>
                    <select  id="DBchange" class="form-control"></select>
                </div>
            </form>
            <div class="database-con-rel container-fluid" style="display: none">
                <div class="row">
                    <div class="col-md-3 dataHead1" style="display: none">数据源名称：</div>
                    <div class="col-md-9 dataHead2" id="resTitle" style="display: none"></div>
                    <div class="col-md-12" style="margin: 0 -15px">
                        <div class="col-md-2" style="margin: 0 -15px">选择表资源</div>
                        <div class="col-md-10" >
                            <div class="row" id="db-table" style="margin-top: 6px"></div>
                        </div>
                    </div>
                    <div id="totalList">
                        <div class="col-md-12" style="margin-bottom: 10px" >
                            <div class="col-md-2" style="text-align: right">sql查询</div>
                            <div class="col-md-4">
                                <input type="text" class="form-control sqlStatements inputVili" >
                            </div>
                            <div class="col-md-2" style="margin: 0 -15px">
                                <input type="text" class="form-control inputVili" placeholder="新表名" name="sqlTableName">
                            </div>
                            <div class="col-md-4">
                                <button type="button" class="btn blue preview">预览</button>
                                <%--<button type="button" class="btn green" onclick="addSql()"><span class="glyphicon glyphicon-plus"></span>sql查询</button>--%>
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
                <form class="form-inline">
                    <div class="form-group">
                        <label>选择数据源</label>
                        <select  id="DBFilechange" class="form-control"></select>
                    </div>
                </form>

                <div class="database-con-file container-fluid" style="display: none;">
                    <div class="row">
                        <div class="col-md-3 dataHead1" style="display: none">数据源名称：</div>
                        <div class="col-md-9 dataHead2" id="fileTitle" style="display: none"></div>
                        <div class="col-md-12" style="margin: 0 -15px">
                            <div class="col-md-2" style="margin: 0 -15px">选择文件</div>
                            <div class="col-md-10" style="margin-top: 6px">
                                <div class="row" id="file-table"></div>
                            </div>
                        </div>
                        <div class="col-md-12 ">
                            <button type="button" class="btn green pull-right" onclick="sendFileTask()">提交</button>
                        </div>


                        <%--<div class="col-md-12 dataHead3" style="max-height: 500px;overflow: auto;padding-top: 10px">
                            <div class="col-md-2">选择文件</div>
                            <div class="col-md-10 dataHead4" >
                                <div class="row" id="file-table">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 ">
                            <button type="button" class="btn green pull-right" onclick="sendFileTask()">提交</button>
                        </div>--%>
                    </div>
                </div>
        </div>
    </div>
    <div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
        <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                            id="editTableFieldComsCloseId"></button>
                    <h4 class="modal-title" id="relationalDatabaseModalTitle">预览数据</h4>
                </div>
                <%--<div class="form">--%>
                <%--<form class="form-horizontal" role="form" action="addRelationalDatabase" method="post"--%>
                <%--accept-charset="utf-8" id="relationalDatabaseForm">--%>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet box green-haze" style="border:0;">
                                <div class="portlet-title" style="display: none">
                                   <%-- <ul class="nav nav-tabs" style="float:left;">
                                       &lt;%&ndash; <li class="active">
                                            <a href="#editTableFieldComsId" data-toggle="tab"
                                               id="editTableDataAndComsButtonId" aria-expanded="true">
                                                编辑 </a>
                                        </li>&ndash;%&gt;
                                        <li class="active">
                                            <a href="#previewTableDataAndComsId" id="previewTableDataAndComsButtonId"
                                               data-toggle="tab" aria-expanded="true">
                                                预览 </a>
                                        </li>
                                    </ul>--%>
                                </div>
                                <div class="tab-content"
                                     style="background-color: white;min-height:300px;max-height:70%;padding-top: 20px ; overflow: scroll;">
                                   <%-- <div class="tab-pane active" id="editTableFieldComsId">
                                    </div>--%>
                                    <div id="previewTableDataAndComsId">
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
                    <button type="button" id="editTableFieldComsSaveId" data-dismiss="modal" class="btn green">确认
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
            {{if i != 0}}
            <tr>
                <td>{{i}}</td>
                {{each itemList as item j}}
                <td>{{item}}</td>
                {{/each}}
            </tr>
            {{/if}}
            {{/each}}
        </table>
    </div>
</script>
<script type="text/html" id="dataRelationshipList">
    <option value="" id="selNone" selected="selected">请选择数据源</option>
    {{each data as value i}}
    <option value="{{value.dataSourceName}}" id="{{value.dataSourceId}}">{{value.dataSourceName}}</option>
    {{/each}}
</script>
<script type="text/html" id="dataRelationshipList2">
    {{each list as value i}}
    <div class="col-md-4">
        <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="relationBox" value="{{value}}" style="line-height: normal"></div>
        <div style="padding-left: 20px;word-break: break-all ;"> {{value}}</div>
    </div>
    {{/each}}
</script>
<script type="text/html" id="addSql">
    <div class="col-md-12" style="margin-bottom: 10px" name="aaaa">
        <div class="col-md-2" style="text-align: right">sql查询</div>
        <div class="col-md-4">
            <input type="text" class="form-control sqlStatements inputVili" >
        </div>
        <div class="col-md-2" style="margin: 0 -15px">
            <input type="text" class="form-control inputVili" placeholder="新表名 " name="sqlTableName">
        </div>
        <div class="col-md-4">
            <button type="button" class="btn blue preview">预览</button>
            <button type="button" class="btn red removeSql"><span class="glyphicon glyphicon-trash"></span>删除</button>
        </div>
        
    </div>
</script>

<script type="text/html" id="dataFileshipList">
    <option value="" id="selFileNone" selected="selected">请选择数据源</option>
    {{each data as value i}}
    <option value="{{value.dataSourceName}}" Keyid="{{value.dataSourceId}}">{{value.dataSourceName}}</option>
    {{/each}}
</script>
<script type="text/html" id="dataFileshipList2">
    {{each data as value i}}
    <div class="col-md-4">
        <label>
            <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="fileTable" value="{{value.id}}" style="line-height: normal"></div>
            <div style="padding-left: 20px;word-break: break-all;"> {{value.text}}</div>
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
        var dataRelTableList;
        var dataRelSqlList;

        var dataFileSrcId;
        var dataFilePathList;

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
            dataRelSrcId =id;
            var name = $(this).val();
            if(name == ""){
                $(".database-con-rel").hide();
                return
            }
            $(".database-con-rel").show();
            $("#resTitle").html(name);
            $.ajax({
                url:"${ctx}/relationship/relationalDatabaseTableList",
                type:"POST",
                data:{
                    dataSourceId:id
                },
                success:function (data) {
                    $("#db-table").empty();
                    var List =JSON.parse(data);
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
            dataFileSrcId =id;
            var name = $(this).val();
            if(name == ""){
                $(".database-con-file").hide();
                return
            }
            $(".database-con-file").show();
            $("#fileTitle").html(name);
            $.ajax({
                url:"${ctx}/fileResource/fileSourceFileList",
                type:"POST",
                data:{
                    dataSourceId:id
                },
                success:function (data) {
                    $("#file-table").empty();
                    var List =JSON.parse(data)
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
            var $Str =$(this).parent().parent().find(".sqlStatements").val();;
            $("#staticSourceTableChoiceModal").modal("show");
            previewSqlDataAndComs(dataRelSrcId,$Str)
        })
        function addSql() {
            var result = true;
            $(".sqlStatements").each(function () {
                if (!$(this).val() || !$(this).val().trim()) {
                    toastr["error"]("错误！", "请先完成当前编辑");
                    result = false;
                    return;
                }
            });
            if (!result) {
                return;
            }
            /*if (!validSqlStrResult) {
                toastr["error"]("错误！", "请先通过当前sql校验");
                return;
            }*/
            <!-- 第一个校验完成才能添加-->
            var tabCon = template("addSql");
            $("#sqlList").append(tabCon);
        }
        <!--create relation task -->
        function sendRelationTask() {
            var dataRelSqlTableList="";
            var $eleChecked = $("[name='relationBox']:checked")
            var numChecked = $eleChecked.size();

            var sqlNum =0;
            $(".inputVili").each(function () {
                if(!$(this).val()=="" &&!$(this).val().trim()==""){
                    sqlNum++
                }
            })

            if($("#dataTaskName").val() =="" || $("#dataTaskName").val().trim() == ""){
                toastr["error"]("提示！", "请创建任务名");
                return
            }
            if(numChecked ==0){
                if(sqlNum >=2 && sqlNum%2 ==0){

                }else {
                    if(sqlNum ==0){
                        toastr["error"]("表资源与sql查询至少选择添加一个");
                        return
                    }
                    toastr["error"]("sql语句和新建表名不能为空");
                    return
                }
            }else {
                if((sqlNum<2 ||sqlNum%2 !=0) && sqlNum!=0 ){
                    toastr["error"]("sql语句和新建表名不能为空");
                    return
                }
            }



            $("[name='sqlTableName']").each(function () {
                dataRelSqlTableList+=$(this).val()+";"
            })

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
                    dataRelSqlList:dataRelSqlList,
                    datataskName:$("#dataTaskName").val(),
                    sqlTableNameEnList:dataRelSqlTableList
                },
                success:function (data) {
                    window.location.href="${ctx}/dataUpload"
                },
                error:function () {
                }
            })

        }
        function sendFileTask(){
            var $eleChecked = $("[name='fileTable']:checked")
            var numChecked = $eleChecked.size();
            if($("#dataTaskName").val() ==""){
                toastr["error"]("提示！", "请创建任务名");
                return
            }
            if (numChecked == 0) {
                toastr["error"]("最少选择一个文件资源");
                return
            }
            var fileTabStr = "";
            $eleChecked.each(function () {
                fileTabStr+=$(this).val()+";"
            });
            dataFilePathList=fileTabStr;
            $.ajax({
                url:"${ctx}/datatask/saveFileDatatask",
                type:"POST",
                data:{
                    dataSourceId:dataFileSrcId,
                    datataskName:$("#dataTaskName").val(),
                    filePathList:dataFilePathList,
                },
                success:function (data) {
                    window.location.href="${ctx}/dataUpload"
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


        function previewSqlDataAndComs(dataSourceId,str) {



           /* var sqlName = splistLastStr(str);*/
            $.ajax({
                type: "GET",
                url:  '${ctx}/relationship/previewRelationalDatabaseBySQL',
                data: {
                    "dataSourceId": dataSourceId,
                    "sqlStr": str
                },
                dataType: "json",
                success: function (data) {
                    for(var key in data.maps){
                        var sqlName = key
                    }
                    var tabHead=data.maps[sqlName];
                    var tabBody=data.datas;
                    $("#pre-head").empty();
                    $("#pre-body").empty();
                    var preHeadStr="<th>#</th>";
                    var preBodyStr="";
                    if (!data || !data.datas) {
                        return;
                    }
                    for(var i=0;i<tabHead.length;i++){
                        preHeadStr+="<th>"+tabHead[i].columnName +"</th>"
                    }
                    $("#pre-head").append(preHeadStr);
                    var columnTitleList = [];
                    data.datas.unshift(columnTitleList);

                    var html = template("previewTableDataAndComsTmpl", {"datas": data.datas});
                    $('#pre-body').html(html);
                }
            });
        }
        function splistLastStr(str) {

            var arr =str.split(" ");
            var lastStr = arr[arr.length - 1];
            return lastStr;
        }

    </script>
</div>

</html>
