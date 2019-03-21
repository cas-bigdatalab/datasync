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
    <link href="${ctx}/resources/bundles/zTree_v3/css/demo.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/layerJs/theme/default/layer.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .col-md-5 {
            width: 36.666667% !important;
        }
        .col-md-2 {
            width: 12.666667% !important;
        }
        .ztree{
            width: 100% !important;
        }
        div#rMenu {position:absolute; visibility:hidden; top:0; background-color: #555;text-align: left;padding: 2px;}
        div#rMenu ul li{
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }

    </style>
</head>
<body>
<div class="page-content">
    <div class="task-head">
       <h3>设置任务</h3>
        <hr>
    </div>
    <div class="task-title">
        <%--<span>确定数据对象范围，上传数据</span>--%>
        <form class="form-inline">
            <div class="form-group">
                <label for="dataTaskName" style="font-size: 18px">创建任务名</label>
                <input type="text" class="form-control" id="dataTaskName" style="width: 250px;font-size: 16px" disabled>
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
                    <select  id="DBchange" class="form-control" style="font-size: 16px"></select>
                </div>
            </form>
            <div class="database-con-rel container-fluid" style="display: none">
                <div class="row">
                    <div class="col-md-3 dataHead1" style="display: none">数据源名称：</div>
                    <div class="col-md-9 dataHead2" id="resTitle" style="display: none"></div>
                    <div class="col-md-12" style="margin: 0 -15px">
                        <div class="col-md-2" style="margin: 0 -15px">选择表资源</div>
                        <div class="col-md-10" >
                            <div style="text-align: center" id="dataUp">数据加载中......</div>
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
                <form class="form-inline">
                    <div class="form-group">
                        <label>选择数据源</label>
                        <select  id="DBFilechange" class="form-control" style="font-size: 16px"></select>
                    </div>
                </form>

                <div class="database-con-file container-fluid" style="display: none;">
                    <div class="row">
                        <div class="col-md-3 dataHead1" style="display: none">数据源名称：</div>
                        <div class="col-md-9 dataHead2" id="fileTitle" style="display: none"></div>
                        <div class="col-md-12" style="margin: 0 -15px">
                            <div class="col-md-2" style="margin: 0 -15px">选择文件</div>
                            <div class="col-md-5" style="margin-top: 6px">
                                <div id="jstree_show_edit">
                                    <ul id="LocalTreeDemo" class="ztree" ></ul>
                                </div>
                            <%--
                                <div class="row" id="file-table"></div>
--%>
                            </div>
                            <div class="col-md-5" style="margin: 6px 0px 0px 100px">
                                <div id="remoteTreeDiv">
                                    <ul  class="ztree" id="remoteTree"></ul>
                                </div>
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
                    <button type="button" id="editTableFieldComsSaveId" data-dismiss="modal" class="btn red">关闭
                    </button>
                    <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
                </div>
                <%--</form>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>

<div id="rMenu">
    <ul>
        <li id="m_add" onclick="addTreeNode(this);">增加节点</li>
        <li id="m_del" onclick="removeTreeNode();">删除节点</li>
        <%--<li id="m_check" onclick="checkTreeNode(true);">Check节点</li>--%>
        <%--<li id="m_unCheck" onclick="checkTreeNode(false);">unCheck节点</li>--%>
        <li id="m_reset" onclick="resetTree();">恢复初始目录</li>
    </ul>
</div>
<div class="modal fade" id="createFileMModal" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 66%;top: 156px;margin: 0 auto;">
            <div class="modal-header" style="height: 48px;">
                <h5 class="modal-title" id="createFileTitle" style="float: left;">创建文件夹</h5>
                <button type="button" class="close" onclick="hidenFileNameModal()">
                    <span >&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="fileName" class="col-form-label">文件夹名称</label>
                        <input type="text" autofocus class="form-control" id="fileName">
                        <span id="promptInf" style="color: red;"></span>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="createFileSureBut" onclick="addFilePath()">确定</button>
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
        <label>
            <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="relationBox" value="{{value}}" style="line-height: normal"></div>
            <div style="padding-left: 20px;word-break: break-all ;"> {{value}}</div>
        </label>
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
    <script src="${ctx}/resources/bundles/layerJs/layer.js"></script>
    <script src="${ctx}/resources/bundles/zTree_v3/js/jquery.ztree.all.js"></script>
    <script src="${ctx}/resources/bundles/zTree_v3/js/rightClick.js"></script>

    <script>
        var dataRelSrcId;
        var dataRelTableList;
        var dataRelSqlList;

        var dataFileSrcId;
        var dataFilePathList;
        var dateDef = new Date();
        var taskNameFlag=false
        var validSql = true;
        var remoteZTree, rMenu;
        var jsonObjectStr;
        dateDef = dateDef.Format("yyyyMMddhhmmss");
        $("#dataTaskName").val(dateDef)
        $("#dataTaskName").change(function () {
            var taskName = $(this).val();
            if(taskName =="" || taskName.trim() == ""){
                toastr["error"]("提示！", "任务名不能为空");
                return
            }
            $.ajax({
                url:"${ctx}/datatask/hasDatataskName",
                type:"POST",
                data:{
                    datataskName:$(this).val()
                },
                success:function (data) {
                    console.log(data)
                    if(data === "true"){
                        toastr["error"]("提示！", "任务名已存在");
                        taskNameFlag=true
                    }else {
                        taskNameFlag=false
                    }
                }
            })
        })
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
            console.log("设置数据任务->关系型数据库列表加载！")
            $.ajax({
                url:"${ctx}/relationship/relationalDatabaseTableList",
                type:"POST",
                data:{
                    dataSourceId:id
                },
                success:function (data) {
                    var List =JSON.parse(data);
                    if(List.length !=0){
                        $("#dataUp").html("")
                    }else{
                        $("#dataUp").html("暂时没有数据")
                    }
                    $("#db-table").empty();
                    console.log(data)
                    var tabCon = template("dataRelationshipList2", List);
                    $("#db-table").append(tabCon);

                },
                error:function () {
                    console.log("请求失败")
                }
            })
        })
        $("#DBFilechange").on("change",function () {
            var jsonData;
            var id = $("#DBFilechange option:selected").attr("Keyid");
            dataFileSrcId =id;
            var name = $(this).val();
            if(name == ""){
                $(".database-con-file").hide();
                return
            }
            $(".database-con-file").show();
            $("#fileTitle").html(name);
            var data ="";

            $.ajax({
                type:"POST",
                url: "${ctx}/fileResource/newResCatalog",
                dataType: "json",
                data: {
                    "data": "",
                    "dataSourceId":id
                },
                async: true,
                beforeSend:function(data){
                    index = layer.load(1, {
                        shade: [0.5,'#fff'] //0.1透明度的白色背景
                    });
                },
                success: function (data) {
                    $("#bdTableLabel").css("display", "block");//显示“选择资源”标签
                    $("#bdDirDiv").css("display", "block");//显示“选择资源”标签
                    $("#bdSubmitButton").css("display", "block"); //显示“提交”按钮
                    jsonObjectStr=eval(data.jsonObjectStr);
                    var ztreeObjRemote=$.fn.zTree.init($("#remoteTree"),remoteSetting,jsonObjectStr);
                    var zTreeObj = $.fn.zTree.init($("#LocalTreeDemo"),setting, data.nodeList);

                    remoteZTree = $.fn.zTree.getZTreeObj("remoteTree");
                    rMenu = $("#rMenu");
                    //让第一个父节点展开
                    var rootNode_0 = zTreeObj.getNodeByParam('pid',0,null);
                    zTreeObj.expandNode(rootNode_0, true, false, false, false);



                    // var coreData = eval("["+data.list.toString().replace(/\\/g,"/")+"]");
                    // debugger
                    // var zTreeObj = $.fn.zTree.getZTreeObj("LocalTreeDemo");
                    // if(zTreeObj!=null){
                    //     zTreeObj.destroy();//用之前先销毁tree
                    // }
                    // $.fn.zTree.init($("#LocalTreeDemo"), setting, coreData);
                    // //让第一个父节点展开
                    // var rootNode_0 = zTreeObj.getNodeByParam('pid',0,null);
                    // zTreeObj.expandNode(rootNode_0, true, false, false, false);

                    $("#layui-layer-shade"+index+"").remove();
                    $("#layui-layer"+index+"").remove();
                },
                error: function (data) {
                    toastr["error"]("获得本地目录中的文件树失败,请检查文件上路径及数据源！");
                    console.log("获得本地目录中的文件树失败")
                }
            })

        })
        function generateChildJson(childArray) {
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.type == 'directory') {
                    /*
                     child.children = true;
                     */
                    child.icon = "jstree-folder";
                } else {
                    child.icon = "jstree-file";
                }
            }
        }
        $("#sqlList").delegate(".removeSql","click",function () {
            $(this).parent().parent().remove();
        })
        $("#totalList").delegate(".preview","click",function () {
            var $Str =$(this).parent().parent().find(".sqlStatements").val();
            previewSqlDataAndComs(dataRelSrcId,$Str)
        })
        $("#totalList").delegate(".sqlStatements","change",function () {
            console.log("aaaa")
            $(this).css("border-color","")
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
            if(taskNameFlag){
                toastr["error"]("提示！", "任务名出错，请填写任务名");
                return
            }

            if(numChecked ==0){
                if(sqlNum >=2 && sqlNum%2 ==0){
                    $(".sqlStatements").each(function (i) {
                        validSql = true;
                        if(validSql){
                            allSqlvalidata(dataRelSrcId,$(this).val(),i)
                        }else {
                            return
                        }

                    })
                }else {
                    if(sqlNum ==0){
                        toastr["error"]("表资源与sql查询至少选择添加一个");
                        return
                    }else {
                        toastr["error"]("sql语句和新建表名不能为空");
                        return
                    }

                }
            }else {
                if((sqlNum<2 ||sqlNum%2 !=0) && sqlNum!=0 ){
                    toastr["error"]("sql语句和新建表名不能为空");
                    return
                }else if(sqlNum ==0){

                }else {
                    $(".sqlStatements").each(function (i) {
                        validSql = true;
                        if(validSql){
                            allSqlvalidata(dataRelSrcId,$(this).val(),i)
                        }else {
                            return
                        }

                    })
                }
            }

            /*$(".sqlStatements").each(function (i) {
                 validSql = true;
                if(validSql){
                    allSqlvalidata(dataRelSrcId,$(this).val(),i)
                }else {
                    return
                }

            })*/
            if(!validSql){
                toastr["error"]("sql语句存在错误");
                return
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
            var Bwrap = document.querySelector(".tabWrap");
            Bwrap.style.display="block";
            Bwrap.style.width=Math.max(document.body.offsetWidth,document.documentElement.clientWidth)+"px";
            Bwrap.style.height=Math.max(document.body.offsetHeight,document.documentElement.clientHeight)+"px";
            $.ajax({
                url:"${ctx}/datatask/saveRelationDatatask",
                type:"POST",
                aysnc:true,
                timeout:600000,
                data:{
                    dataSourceId:dataRelSrcId,
                    dataRelTableList:dataRelTableList,
                    dataRelSqlList:dataRelSqlList,
                    datataskName:$("#dataTaskName").val(),
                    sqlTableNameEnList:dataRelSqlTableList
                },
                complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
                    if(status=='timeout'){//超时,status还有success,error等值的情况
                        toastr["error"]("提示！", "请求超时");
                        Bwrap.style.display="none";
                    }
                },
                success:function (data) {
                    window.location.href="${ctx}/dataUpload"
                },
                error:function () {
                    console.log("请求失败")
                }
            })

        }
        function sendFileTask(){
             var $eleChecked = $("[name='fileTable']:checked")
            // var getCheckedFile = getChecedValueInLocalTree();//获取选中的文件
            var nodes = getChecedValueInLocalTree();//获取选中的文件
            var remotePath=getChecedValueInRemoteTree();//获取上传路径
             var numChecked = $eleChecked.size();
             if(remotePath.length==0){
                 toastr["error"]( "请选择上传路径！","提示！");
                 return
             }
            if($("#dataTaskName").val() ==""){
                toastr["error"]("提示！", "请创建任务名");
                return
            }
            /*if (numChecked == 0) {
                toastr["error"]("最少选择一个文件资源");
                return
            }*/
            if(nodes.length==0){
                toastr["error"]("您尚未选取文件");
                return
            }else{
            var fileTabStr = "";
            $eleChecked.each(function () {
                fileTabStr+=$(this).val()+";"
            });
            dataFilePathList=fileTabStr;

            var Bwrap = document.querySelector(".tabWrap");
            Bwrap.style.display="block";
            Bwrap.style.width=Math.max(document.body.offsetWidth,document.documentElement.clientWidth)+"px";
            Bwrap.style.height=Math.max(document.body.offsetHeight,document.documentElement.clientHeight)+"px";
            $.ajax({
                url:"${ctx}/datatask/saveFileDatatask",
                type:"POST",
                aysnc:true,
                timeout:600000,
                traditional: true,
                data:{
                    "dataSourceId":dataFileSrcId,
                    "datataskName":$("#dataTaskName").val(),
                    "nodes":nodes,
                    "remotePath":remotePath
                },
                success:function (data) {
                    var jsonlist=JSON.parse(data);
                    if(jsonlist.result==2){
                        toastr["warning"]("所选文件夹不能全部为空！");
                        Bwrap.style.display="none";
                        // $("#layui-layer-shade"+index+"").remove();
                        // $("#layui-layer"+index+"").remove();
                        return;
                    }
                    window.location.href="${ctx}/dataUpload"
                },
                complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
                    if(status=='timeout'){//超时,status还有success,error等值的情况
                        /*ajaxTimeoutTest.abort();*/
                        toastr["error"]("提示！", "请求超时");
                        Bwrap.style.display="none";
                    }
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
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

            $.ajax({
                url:"${ctx}/datatask/sqlValidation",
                type:"GET",
                data:{
                    sqlStr:str,
                    dataSourceId:dataSourceId
                },
                success:function (data) {
                    var sqlFlag = JSON.parse(data).result
                    if(sqlFlag){
                        $("#staticSourceTableChoiceModal").modal("show");
                        var sqlName = splistLastStr(str);
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
                    }else {
                        toastr["error"]("提示！", "请正确输入sql语句");
                    }
                }
            })


        }
        function splistLastStr(str) {

            var arr =str.split(" ");
            var lastStr = arr[arr.length - 1];
            return lastStr;
        }
        function allSqlvalidata(dataSourceId,str,index) {
            $.ajax({
                url:"${ctx}/datatask/sqlValidation",
                type:"GET",
                async: false,
                data:{
                    sqlStr:str,
                    dataSourceId:dataSourceId
                },
                success:function (data) {
                    var flag = JSON.parse(data).result
                    if(!flag){
                        validSql = flag
                        $(".sqlStatements:eq("+ index+")").css("border-color","red")
                    }
                }
            })
        }

        var setting = {
            async: {
                enable: true,
                url:"${ctx}/fileResource/asyncGetNodes",
                autoParam:["id", "pid", "name"],
                dataFilter: filter
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey:'id',
                    pIdKey:'pid',
                    rootPId: 0
                }
            },
            check: {
                enable: true
            },
            callback : {
                beforeAsync: beforeAsync,
                onAsyncSuccess: onAsyncSuccess,
                onAsyncError: onAsyncError,
                onCheck : asyncAll
            }
        };

        function filter(treeId, parentNode, childNodes) {
            if(parentNode.checked==true){
                for(var num=0;num<childNodes.length;num++){
                    childNodes[num].open=true;
                    childNodes[num].checked=true;
                }
            }
            return childNodes;
        }

        //获取界面中所有被选中的radio
        function getChecedValueInLocalTree() {
            var pathsOfCheckedFiles = new Array();
            var treeObj=$.fn.zTree.getZTreeObj("LocalTreeDemo"),
                nodes=treeObj.getCheckedNodes(true),v="";
            for(var i=0;i<nodes.length;i++){
                pathsOfCheckedFiles.push(nodes[i].id);
            }
            return pathsOfCheckedFiles;
        }

        //获取界面中所有被选中的radio
        function getChecedValueInRemoteTree() {
            var pathsOfCheckedFiles = new Array();
            var treeObj=$.fn.zTree.getZTreeObj("remoteTree"),
                nodes=treeObj.getCheckedNodes(true),v="";
            for(var i=0;i<nodes.length;i++){
                debugger
                pathsOfCheckedFiles.push(nodes[i].pid+"/"+nodes[i].name);
            }
            return pathsOfCheckedFiles;
        }


        function addFilePath(){
            var inputFileName = $("#fileName").val().trim();
            if(inputFileName==null || inputFileName==""){
                $("#promptInf")[0].textContent="文件夹名称不能为空！";
                $("#fileName")[0].style.borderColor="red";
                return;
            }
            var newNode = { name:""+inputFileName+""};
            if (remoteZTree.getSelectedNodes()[0]) {
                newNode.checked = false;
                newNode.isParent=true;
                newNode.id=remoteZTree.getSelectedNodes()[0].id+"/"+newNode.name;
                remoteZTree.addNodes(remoteZTree.getSelectedNodes()[0], newNode);
            } else {
                newNode.isParent=true;
                newNode.id=remoteZTree.getSelectedNodes()[0].id+"/"+newNode.name;
                remoteZTree.addNodes(null, newNode);
            }
            $("#createFileMModal").modal("hide");
        }

        function addTreeNode(e) {
            hideRMenu();
            ShowCreateModal();
        }
        // 修改弹出框的title, 显示弹框
        function ShowCreateModal(title){
            if(remoteZTree.getSelectedNodes()<=0){
                toastr["error"]("请选择父节点！");
                return;
            }
            $("#createFileTitle").text(title);
            $("#promptInf")[0].textContent="";
            $("#fileName")[0].style.borderColor="#d2c3c3";
            $('#createFileMModal').modal('show');
        }

        function hidenFileNameModal() {
            $("#createFileMModal").modal("hide");
        }

        var curStatus = "init", curAsyncCount = 0, asyncForAll = false,
            goAsync = false;

        function asyncAll(event, treeId, treeNode) {
            if (!check()) {
                return;
            }
            var zTree = $.fn.zTree.getZTreeObj("LocalTreeDemo");
            if (false) {
            } else {
                var nodes=new Array([treeNode]);
                asyncNodes(nodes[0]);
            }
        };

        function asyncNodes(nodes) {
            if (!nodes) return;
            curStatus = "async";
            var zTree = $.fn.zTree.getZTreeObj("LocalTreeDemo");
            for (var i=0, l=nodes.length; i<l; i++) {
                if (nodes[i].isParent && nodes[i].zAsync) {
                    asyncNodes(nodes[i].children);
                    // whetherChecked=false;
                } else {
                    goAsync = true;
                    zTree.reAsyncChildNodes(nodes[i], "refresh", true);
                }
            }
        };

        function beforeAsync() {
            curAsyncCount++;
        }
        function onAsyncSuccess(event, treeId, treeNode, msg) {
            curAsyncCount--;
            if (curStatus == "expand") {
                expandNodes(treeNode.children);
            } else if (curStatus == "async") {
                asyncNodes(treeNode.children);
            }

            if (curAsyncCount <= 0) {
                if (curStatus != "init" && curStatus != "") {
                    asyncForAll = true;
                }
                curStatus = "";
            }
        }
        function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
            curAsyncCount--;

            if (curAsyncCount <= 0) {
                curStatus = "";
                if (treeNode!=null) asyncForAll = true;
            }
        }
        var curStatus = "init", curAsyncCount = 0, asyncForAll = false,
            goAsync = false;

        function expandNodes(nodes) {
            if (!nodes) return;
            curStatus = "expand";
            var zTree = $.fn.zTree.getZTreeObj("LocalTreeDemo");
            for (var i=0, l=nodes.length; i<l; i++) {
                zTree.expandNode(nodes[i], true, false, false);
                if (nodes[i].isParent && nodes[i].zAsync) {
                    expandNodes(nodes[i].children);
                } else {
                    goAsync = true;
                }
            }
        }

        function check() {
            if (curAsyncCount > 0) {
                return false;
            }
            return true;
        }

    </script>
</div>

</html>
