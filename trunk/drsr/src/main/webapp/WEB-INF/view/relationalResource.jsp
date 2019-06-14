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
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/ComBoSelect/css/combo.select.css" rel="stylesheet" type="text/css"/>
    <style>
        .custom-error{
            color:#a94442!important;
            border-color:#a94442!important;
        }
        .custom-error1{
            color:#a94442!important;
        }
        .custom-error2{
            border-color:#a94442!important;
        }
        .jq22 { width: 400px; margin: 100px auto;}
        .alert-info {
            background-color: #e0e0e0 !important;
            border: none !important;
            border-left: #0e6445 8px solid !important;
        }
        .page-content-wrapper .page-content{
            padding: 0px 0px 0px 0px !important;
        }
        .source-head,.source-table{
            padding:0px 20px !important;
        }
        #dataSourceList th {
            background-color: #f1f1f1;
            color: black;
            font-size: 14px;
            border-left: none !important;
            border-right: none !important;
            font-weight: normal;
        }
        #dataSourceList td {
            border-left: none !important;
            border-right: none !important;
        }
        .purple.btn,.red.btn,.green.btn,.btn-danger {
            border-radius: 6px !important;
        }
        .col-sm-3 {
            width: 25% !important;
        }
        .form-group {
            margin-bottom: 2.6% !important;
        }
        .form-control{
            border-radius:6px !important; ;
        }
        .bg-primary {
            background-color: #1e8753;
        }
        .form-control:focus {
              border-color: #66afe9 !important;
              -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6) !important;
          }
        .combo-select{
            border-radius:3px !important; ;
        }
        .purple.btn,.red.btn {
            color: green !important;
            background-color: #ffffff !important;
            border: 2px solid green;
        }
        .purple.btn:hover,.red.btn:hover{
            background-color: green !important;
            color: white !important;
        }
        .table-bordered > tbody > tr:hover {
            background-color: #f5f5f5;
        }
        .row h4 {
            font-size: 18px;
            color: #1a8651;
            margin: 0px auto ;
        }
        .row a.big-btn {
            right: 0;
            /*position: absolute;*/
            /*top: 48;*/
            padding: 15px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background: #137450;
        }

    </style>
</head>
<body>
<div class="page-content">
    <%--<div class="source-head">--%>
        <%--<h3 style="font-size: 17px !important;">关系数据源</h3>--%>
        <%--&lt;%&ndash;<hr>&ndash;%&gt;--%>
    <%--</div>--%>
    <%--<div class="source-title">
        <span>关系数据源信息管理</span>
    </div>--%>
    <div class="alert alert-info" role="alert" style="padding: 10px 20px !important;margin-left: 20px;margin-right: 20px;margin-top:1%;">
        <!--查询条件 -->
        <div class="row" style="margin: 5px auto;">
            <h4 style="font-weight: 500 !important;float: left;">关系数据信息管理</h4>
            <div style="float: right;margin-right: -19px;">
                <a class="big-btn" id="addSqlSource">添加SQL数据源</a>
            </div>
                <%--<div class="col-md-12">--%>
                <%--<button type="button" class="btn  btn-sm green pull-right" id="addSqlSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;新增关系型数据源</button>--%>
            <%--</div>--%>
            <%--<div class="col-md-2">
                <button type="button" class="btn  btn-sm green pull-right" id="addFileSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加文件型数据源</button>
            </div>--%>
        </div>
    </div>
    <div class="source-table" >
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" id="dataSourceList">
            <thead>
            <tr>
                <th>编号</th>
                <th>数据源名称</th>
                <th>数据库名称</th>
                <th>数据源类型</th>
                <th>创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="relationBody" style="background-color: #ffffff;">
            </tbody>
        </table>
        <div class="page-message" style="float: left">

        </div>
        <div class="page-list" style="float: right"></div>
    </div>
</div>
<!-- validation add Mode -->
<div id="relationalSourceModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cancelButton();"></button>
                <h4 class="modal-title" id="relationalSourceModalTitle">新增关系型数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="relationalSourceForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">数据源名称<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceName"
                                                   name="dataSourceName"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label  class="col-sm-3 control-label">数据库类型<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <select name="dataBaseType" id="dataBaseType" class="form-control" onchange="dbSelect();">
                                                <%--<option value="DB2">DB2</option>
                                                <option value="Oracle">Oracle</option>
                                                <option value="SqlServer">SqlServer</option>--%>
                                                <option value="mysql">MySql</option>
                                                <option value="oracle">Oracle</option>
                                                <option value="sqlserver">SqlServer</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="host" class="col-sm-3 control-label">主机<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="host" name="host" placeholder="请输入主机名称">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="port" class="col-sm-3 control-label">端口<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="port" name="port" value="3306" placeholder="请输入端口号">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="userName" class="col-sm-3 control-label">用户名<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入用户名">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="col-sm-3 control-label">密码<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                                        </div>
                                    </div>
                                    <div class="form-group" id="dataBaseNameDiv" >
                                        <label for="databaseName" class="col-sm-3 control-label" id="dataBaseName">数据库名称<span class="required">
													* </span></label></label>
                                        <div class="col-md-9" id="dataBaseNameDiv2">
                                            <%--<input type="text" class="form-control" id="databaseName" name="databaseName" placeholder="请输入数据库名称">--%>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green" id="saveButton" style="display: none;">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" class="btn green" id="checkButton" onclick="loadMysqlDatabaseList()">
                            <i class="glyphicon glyphicon-ok"></i>加载数据库列表</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- validation edit Mode -->
<div id="relationalSourceEditModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cancelButton();"></button>
                <h4 class="modal-title">编辑关系型数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="relationalSourceEditForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">数据源名称<span class="required">
													 </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceNameE"
                                                   name="dataSourceNameE" disabled/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label  class="col-sm-3 control-label">数据库类型<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <select name="dataBaseTypeE" id="dataBaseTypeE" class="form-control" onchange="dbSelectE();">
                                                <%--<option value="DB2">DB2</option>
                                                <option value="Oracle">Oracle</option>
                                                <option value="SqlServer">SqlServer</option>--%>
                                                <option value="mysql">MySql</option>
                                                <option value="oracle">Oracle</option>
                                               <option value="sqlserver">SqlServer</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="databaseNameE" class="col-sm-3 control-label">数据库名称<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="databaseNameE" name="databaseNameE" placeholder="请输入数据库名称">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="hostE" class="col-sm-3 control-label">主机<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="hostE" name="hostE" placeholder="请输入主机名称">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="portE" class="col-sm-3 control-label">端口<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="portE" name="portE" placeholder="请输入端口号">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="userNameE" class="col-sm-3 control-label">用户名<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="userNameE" name="userNameE" placeholder="请输入用户名">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="passwordE" class="col-sm-3 control-label">密码<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="password" class="form-control" id="passwordE" name="passwordE" placeholder="请输入密码">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="idHidden" val=""/>
<script type="text/html" id="resourceTmp1">
    {{each list as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.dataSourceName}}</td>
        <td>{{value.databaseName}}</td>
        <td>{{value.databaseType}}</td>
        <td>{{value.createTime}}</td>
        {{if value.stat == 1}}
        <td>正常</td>
        {{else if value.stat == 2}}
        <td>异常</td>
        {{else}}
        <td>异常</td>
        {{/if}}
        <td>
            <button type="button" class="btn btn-success btn-xs purple " onclick="editData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-edit"></i>&nbsp;编辑</button>
            <button type="button" class="btn btn-success btn-xs red" onclick="deleteData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>
        <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
        <script src="${ctx}/resources/bundles/ComBoSelect/js/jquery.combo.select.js"></script>
    <script>
        $(function(){
            $("#databaseName").comboSelect();//加载combox
            $("#dataBaseNameDiv")[0].style.display="none";//显示数据库输入框
            tableConfiguration();
        });
        /*get data table*/
        function tableConfiguration(num) {
/*
            data.pageNum=num;
*/
        /*    var conData = data;*/
            $.ajax({
                url:"${ctx}/relationship/indexPages",
                type:"GET",
                data:{"num":num},
                success:function (data) {
                    var DataList = JSON.parse(data)
                    var relationData = {
                        list:DataList.relationDataOfThisPage
                    }
                    console.log(DataList.list)
                    var tabCon = template("resourceTmp1", relationData);
                    $("#relationBody").html("");
                    $("#relationBody").append(tabCon);
                    if(DataList.relationDataOfThisPage=="{}"||DataList.relationDataOfThisPage==null){
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $(".page-list").html("");
                        return
                    }
                    $(".table-message").html("");
                    /*
                     * 创建table
                     * */
                    if ($(".page-list .bootpag").length != 0) {
                        $(".page-list").off();
                        $('.page-list').empty();
                    }
                    $(".page-message").html("当前第&nbsp;<span style='color:blue'>" + DataList.currentPage + "</span>&nbsp;页,&nbsp;共&nbsp;<span style='color:blue'>" + DataList.totalPage + "</span>&nbsp;页,&nbsp;&nbsp;共&nbsp;<span style='color:blue'>" + DataList.totalNum + "</span>&nbsp;条数据");
                    $('.page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.currentPage,
                        maxVisible: 6,
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
                        tableConfiguration(num);
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
        function confirmDeleteNode(){
            $(".form-horizontal [type='text']").val("")
            alert("ok")
        }
        function confirmAddNode(){

        }
        $("#addSqlSource").click(function () {
            $("#databaseName").empty();//初始化select
            $("#port").val("3306");
            $("#dataBaseNameDiv")[0].style.display="none";//隐藏数据库输入框
            $("#saveButton")[0].style.display="none";//隐藏保存按钮
            $("#checkButton")[0].style.display="inline";//显示检查按钮
            $("#dataBaseName")[0].innerHTML="数据库名称<span style='color: red;'>\t\t\t\t\t\t\t\t\t\t\t\t\t* </span>";
            $("#dataSourceName")[0].className="form-control";
            $("#relationalSourceModal").modal('show');
            var $sqlFrom =$('#relationalSourceForm')
            handleValidation($sqlFrom);
        })

        //编辑关系数据源
       function editData(dataId) {
            $.ajax({
                type:'post',
                url: "${ctx}/relationship/queryData",
                data:{"dataId":dataId},
                success: function(result) {
                    var jsonData = JSON.parse(result);
                    //var Data = jsonData.substring(1,jsonData.length-1);
                    var dataSourceName = jsonData.dataSourceName;
                    for (var index in jsonData) {
                        for (var key in jsonData[index]) {
                            if (key == 'dataSourceName') {
                                $("#dataSourceNameE").val(jsonData[index][key]);
                            }
                            if (key == 'dataSourceType') {
                                $("#dataSourceTypeE").val(jsonData[index][key]);
                            }
                            if (key == 'databaseName') {
                                $("#databaseNameE").val(jsonData[index][key]);
                            }
                            if (key == 'databaseType') {
                                $("#dataBaseTypeE").val(jsonData[index][key]);
                            }
                            if (key == 'host') {
                                $("#hostE").val(jsonData[index][key]);
                            }
                            if (key == 'port') {
                                $("#portE").val(jsonData[index][key]);
                            }
                            if (key == 'userName') {
                                $("#userNameE").val(jsonData[index][key]);
                            }
                            if (key == 'password') {
                                $("#passwordE").val(jsonData[index][key]);
                            }
                            if (key == 'dataSourceId'){
                                $("#idHidden").val(jsonData[index][key]);
                            }
                        }
                    }
                }
            })
            $("#relationalSourceEditModal").modal('show');
            var $fileFrom =$('#relationalSourceEditForm')
            handleValidation($fileFrom);
        }

        //删除关系数据源
        function deleteData(dataId) {
            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>",function (r) {
                if(r){
                    $.ajax({
                        type:'post',
                        url: "${ctx}/relationship/deleteData",
                        data:{"dataId":dataId},
                        success: function(result){
                            var res = JSON.parse(result);
                            if(res=='1'){
                                toastr["success"]("删除成功");
                                tableConfiguration();
                            }else if(res=='2'){
                                toastr["warning"]("此数据源下有关联任务!");
                            }else{
                                toastr["error"]("删除失败");
                            }
                        }
                    })
                }else{

                }
            })
        }


        function handleValidation(element) {
            // for more info visit the official plugin documentation:
            // http://docs.jquery.com/Plugins/Validation
            var formValid;
            formValid = element.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    dataSourceName: {
                        required: true
                    },
                    dataSourceType: {
                        required: true
                    },
                    databaseName: {
                        required: true
                    },
                    host: {
                        required: true
                    },
                    port: {
                        required: true
                    },
                    userName: {
                        required: true
                    },
                    password: {
                        required: true
                    },
                    dataSourceNameE: {
                        required: true
                    },
                    dataSourceTypeE: {
                        required: true
                    },
                    databaseNameE: {
                        required: true
                    },
                    hostE: {
                        required: true
                    },
                    portE: {
                        required: true
                    },
                    userNameE: {
                        required: true
                    },
                    passwordE: {
                        required: true
                    }
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                            .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },

                success: function (label) {
                    label
                            .closest('.form-group').removeClass('has-error'); // set success class to the control group
                },

                submitHandler: function (form) {
                    var formName = $(form).attr('id');
                    if (formName == 'relationalSourceEditForm') {
                        var dataSourceName = $("#dataSourceNameE").val();
                        var dataBaseName = $("#databaseNameE").val();
                        var dataBaseType = $("#dataBaseTypeE").val();
                        var host = $("#hostE").val();
                        var port = $("#portE").val();
                        var userName = $("#userNameE").val();
                        var password = $("#passwordE").val();
                        var dataSourceId = $("#idHidden").val();

                        $.ajax({
                            type: 'post',
                            async: false,
                            url: "${ctx}/relationship/edit",
                            data: {
                                "dataSourceName": dataSourceName,
                                "dataSourceType" : 'db',
                                "dataBaseName": dataBaseName,
                                "dataBaseType": dataBaseType,
                                "host": host,
                                "port": port,
                                "userName": userName,
                                "password": password,
                                "dataSourceId": dataSourceId,
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("编辑成功");
                                    $('#relationalSourceEditModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                }else if(jsonData == '2') {
                                    toastr["error"]("数据库连接失败");
                                }else {
                                    toastr["error"]("编辑失败");
                                }
                            }
                        })
                    } else {
                        var dataSourceName = $("#dataSourceName").val();
                        var dataSourceType = 'db';
                        var dataBaseName = $("#databaseName").val();
                        var dataBaseType = $("#dataBaseType option:selected").val();
                        var host = $("#host").val();
                        var port = $("#port").val();
                        var userName = $("#userName").val();
                        var password = $("#password").val();
                        if(dataBaseName==null || dataBaseName==""){
                            $("#databaseName").style.border="red";
                            return;
                        }
                        $.ajax({
                            type: 'post',
                            url: "${ctx}/relationship/add",
                            async: false,
                            data: {
                                "dataSourceName": dataSourceName,
                                "dataSourceType": dataSourceType,
                                "dataBaseName": dataBaseName,
                                "dataBaseType": dataBaseType,
                                "host": host,
                                "port": port,
                                "userName": userName,
                                "password": password
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("新增成功");
                                    $('#relationalSourceModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                }else if(jsonData == '2') {
                                    toastr["error"]("数据库连接失败");
                                }else if(jsonData=="3"){
                                    $("#dataSourceName").addClass("custom-error");
                                    toastr["error"]("数据源名称已存在！");
                                }else {
                                    toastr["error"]("新增失败");
                                }
                            }
                        })
                    }
                }

            });
        };
        function dbSelect(){
            var db = $("#dataBaseType option:selected").val();
            if(db=='DB2'){
                $("#port").val("5000");
            }else if(db=='oracle'){
                $("#port").val("1521");
                $("#dataBaseNameDiv2").empty();//清空div中的html

                $("#dataBaseNameDiv2").append(" <input type=\"text\" class=\"form-control\" id=\"databaseName\" name=\"databaseName\" placeholder=\"请输入数据库名称\">");
                $("#dataBaseNameDiv")[0].style.display="block";//显示数据库输入框
                $("#saveButton")[0].style.display="inline";//显示保存按钮
                $("#checkButton")[0].style.display="none";//隐藏检查按钮
                $("#dataBaseName")[0].innerHTML="服务名<span style='color: red;'>\t\t\t\t\t\t\t\t\t\t\t\t\t* </span>";
            }else if(db=='sqlserver'){
                $("#databaseName").empty();//初始化select
                $("#port").val("1433");
                $("#dataBaseNameDiv")[0].style.display="none";//隐藏数据库输入框
                $("#saveButton")[0].style.display="none";//隐藏保存按钮
                $("#checkButton")[0].style.display="inline";//显示检查按钮
                $("#dataBaseName")[0].innerHTML="数据库名称<span style='color: red;'>\t\t\t\t\t\t\t\t\t\t\t\t\t* </span>";
            }else if(db=='mysql'){
                $("#databaseName").empty();//初始化select
                $("#port").val("3306");
                $("#dataBaseNameDiv")[0].style.display="none";//隐藏数据库输入框
                $("#saveButton")[0].style.display="none";//隐藏保存按钮
                $("#checkButton")[0].style.display="inline";//显示检查按钮
                $("#dataBaseName")[0].innerHTML="数据库名称<span style='color: red;'>\t\t\t\t\t\t\t\t\t\t\t\t\t* </span>";
            }
        }
        function dbSelectE(){
            var db = $("#dataBaseTypeE option:selected").val();
            if(db=='DB2'){
                $("#portE").val("5000");

            }else if(db=='oracle'){
                $("#portE").val("1521");
            }else if(db=='SqlServer'){
                $("#portE").val("1433");
            }else{
                $("#portE").val("3306");
            }
        }
        function cancelButton() {
            $("#relationalSourceForm").validate().resetForm();
            $("#relationalSourceForm").validate().clean();
            $('.form-group').removeClass('has-error');
        }
        /*jQuery.validator.addMethod("isFilePath", function (value, element) {
         var winPath = /^[a-zA-Z]:(((\/(?! )[^/:*?<>\""|\/]+)+\/?)|(\/)?)\s*$/g;
         var lnxPath = /^([\/][\w-]+)*$/;
         return this.optional(element) || winPath.test(value) || lnxPath.test(value);
         }, "请正确填写路径");*/

        //加载MySQL数据库列表
        function loadMysqlDatabaseList() {
            var dataBaseType = $("#dataBaseType").val();
            var host = $("#host").val();
            var port = $("#port").val();
            var userName = $("#userName").val();
            var password = $("#password").val();
            if(host=="" || host==null){
                toastr["warning"]("请输入正确主机地址！");
                return;
            }
            if(port=="" || port==null){
                toastr["warning"]("请输入正确端口号！");
                return;
            }
            if(userName=="" || userName==null){
                toastr["warning"]("请输入正确用户名！");
                return;
            }
            if(password=="" || password==null){
                toastr["warning"]("请输入正确密码！");
                return;
            }

            $.ajax({
                type: 'post',
                url: "${ctx}/relationship/loadDatabaseList",
                async: false,
                data: {
                    "dataBaseType": dataBaseType,
                    "host": host,
                    "port": port,
                    "userName": userName,
                    "password": password
                },
                success: function (result) {
                    var jsonData = JSON.parse(result);
                    if(jsonData.result==0){
                        toastr["error"]("数据库连接失败，请检查连接信息！");
                        return;
                    }else{
                        $("#dataBaseNameDiv2").empty();//初始化div
                        $("#dataBaseNameDiv2").append(" <select name=\"databaseName\" id=\"databaseName\" > </select>");
                        for(var i=0;i<jsonData.databaseList.length;i++){
                            $("#databaseName").append("<option value='"+jsonData.databaseList[i]+"'>"+jsonData.databaseList[i]+"</option>");
                        }
                        $("#databaseName").comboSelect();//加载combox
                        $("#dataBaseNameDiv")[0].style.display="block";//显示数据库输入框
                        $("#saveButton")[0].style.display="inline";//显示保存按钮
                        $("#checkButton")[0].style.display="none";//隐藏检查按钮
                    }

                }
            })

        }
    </script>
</div>

</html>
