<%--
  Created by IntelliJ IDEA.
  User: Administrator
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
    <title>DataSync专题库门户管理系统</title>

    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jqeury-file-upload/css/jquery.fileupload.css">--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.Jcrop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-datepicker/css/datepicker.css">

    <style>
        .undeslist label{
            font-size: 18px;
        }
        .custom-error{
            color:#a94442!important;
            border-color:#a94442!important;
        }
        .key-word ,.permissions-word{
            padding:0 8px;
            height: 28px;
            background:#57add9;
            color:#fff;
            font-size: 14px;
            margin-right:10px;
            margin-bottom: 5px;
            float:left;
        }

        .key-word p , .permissions-word p{
            float:left;
            font-size:14px;
            line-height:28px;
        }
        .key-word span , .permissions-word span{
            float:left;
            cursor:pointer;
            margin-left:5px;
            font-size:16px;
            margin-top:2px;
        }

    </style>
</head>

<body>

<div class="page-content">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue" id="form_wizard_1">
                <div class="portlet-title" style="background-color:#3fd5c0">
                    <div class="caption">
                        <i class="fa fa-gift"></i> 数据发布 - <span class="step-title">
                                第&nbsp;<span id="staNum">1</span>&nbsp;步,共&nbsp;3&nbsp;步</span>
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-wizard">
                        <div class="form-body">
                            <ul class="nav nav-pills nav-justified steps">
                                <li class="active">
                                    <a href="#tab1"  class="step">
                                                <span class="number">
                                                1 </span>
                                        <span class="desc">
                                                <i class="fa fa-check"></i> 元数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab2"  class="step">
                                                <span class="number">
                                                2 </span>
                                        <span class="desc">
                                                <i class="fa fa-check"></i> 实体数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab3"  class="step">
                                                <span class="number">
                                                3 </span>
                                        <span class="desc">
                                                <i class="fa fa-check"></i> 设置权限 </span>
                                    </a>
                                </li>
                            </ul>
                            <div id="bar" class="progress progress-striped" role="progressbar">
                                <div class="progress-bar progress-bar-success">
                                </div>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab1">
                                    <form class="form-horizontal" id="submit_form"
                                          method="POST">
                                        <div class="form-group">
                                            <label class="control-label col-md-3" >数据集名称 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-4" style="padding-top:14px">
                                                <input type="text" class="form-control" name="need_checked"
                                                       id="task_title" style="border: 1px solid rgb(169, 169, 169)">
                                                <div class="custom-error" name="need_message" style="display: none">请输入数据集名称</div>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" >邮箱号<span >
                                                    * </span>
                                            </label>
                                            <div class="col-md-4" style="padding-top:14px">
                                                <input type="email" class="form-control"
                                                       id="task_email" style="border: 1px solid rgb(169, 169, 169)">
                                                <div class="custom-error" name="data_email" style="display: none">请输入正确的邮箱地址</div>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" >电话号码 <span >
                                                    * </span>
                                            </label>
                                            <div class="col-md-4" style="padding-top:14px">
                                                <input type="text" class="form-control"
                                                       id="task_phone" style="border: 1px solid rgb(169, 169, 169)">
                                                <div class="custom-error" name="data_phone" style="display: none">请输入正确的手机号</div>
                                            </div>

                                        </div>
                                    </form>
                                    <div style="overflow: hidden" class="row">
                                        <div class="form-group">
                                            <label class="control-label col-md-3" style="text-align: right">图片<span >
                                                    * </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class=" margin-top-10">
                                                    <form name="form" id="fileForm" action="" class="form-horizontal" method="post">
                                                        <div id="cutDiv" style="width: 200px; height: 150px;border: 1px solid rgb(169, 169, 169)">
                                                            <%--<img alt="" src="" id="cutimg" style="height: 150px; width: 200px;"/>--%>
                                                            <input type="hidden" id="x" name="x" />
                                                            <input type="hidden" id="y" name="y" />
                                                            <input type="hidden" id="w" name="w" />
                                                            <input type="hidden" id="h" name="h" />
                                                            <input type="hidden" id="tag" name="tag" val=""/>
                                                        </div>
                                                            <span class="btn default btn-file" id="checkPicture">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <input class="photo-file" id="fcupload" type="file" name="imgFile" onchange="readURL(this);">
                                                            </span>
                                                            <span id="uploadSpan" class="btn default btn-file" style="display: none">
                                                                <span class="fileinput-new">
                                                            上传</span>
                                                                <input type="button" onclick="doUpload();"/>
                                                        </span>
                                                    </form>
                                                    <div class="clearfix margin-top-10">
                                                    <span class="label label-danger">
                                                注意! </span>
                                                        图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                        Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">资源目录<span  >
                                                    * </span>
                                            </label>
                                            <div class="col-md-4" id="cemterCatalogDiv" style="padding-top:14px" >
                                                <input type="hidden"  id="centerCatalogId">
                                                <div id="jstree-demo"></div>
                                                <div class="custom-error" style="display: none" id="file_dir">请选择目录</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">选择时间<span >
                                                    * </span></label>
                                            <div class="col-md-6"  style="padding-top:14px">
                                                <div class="input-group input-daterange">
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="起始时间" readonly>
                                                    <div class="input-group-addon">to</div>
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="起始时间" readonly>
                                                </div>
                                                <div class="custom-error" id="data_time" style="display: none">请添正确选择日期</div>
                                            </div>
                                        </div>
                                        <div class="form-group dataLicenseInputGroup">
                                            <label class="control-label col-md-3">描述 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-6" style="padding-top:14px">
                                                <textarea name="need_checked" id="dataDescribeID" style=" height: 96px; width: 412px;resize: none;"></textarea>
                                                <div class="custom-error" name="need_message" style="display: none">请输入描述信息</div>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" id="lab_key">关键词<span class="required">
                                                    * </span></label>
                                            <div class="checkbox-list col-md-5" style="padding-top:14px">
                                                <%--<div style="margin-bottom: 3px;line-height: 24px">
                                                    <input type="text" style="font-size: 16px" id="addWorkStr">
                                                    <button class="btn green" type="button" onclick="addKeyWords()">添加关键词</button>
                                                </div>--%>
                                                    <input type="hidden" class="form-control" id="select2_tags" value="" name="need_checked">

                                                <%--
                                                <div style=" width: 412px;border: 1px solid rgb(169, 169, 169);min-height: 40px;padding-top: 5px;overflow: hidden;padding-left: 3px" class="key-wrap"></div>
--%>
                                                <div class="custom-error" name="need_message" id="key_work" style="display: none">请添加至少两个关键词</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">来源<span  class="required">
                                                    * </span></label>
                                            <div class="col-md-6" id="dataSourceDes" style="padding-top:14px">
                                                <textarea name="need_checked" id="dataSourceDesID" style=" height: 96px; width: 412px;resize: none;"></textarea>
                                                <div class="custom-error" name="need_message" style="display: none">请输入来源</div>
                                            </div>

                                        </div>
                                    </form>

                                </div>
                                <div class="tab-pane" id="tab2">

                                    <h3>
                                        <span>数据源:</span>
                                        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
                                        <label for="aaa" style="font-size: 18px;color: #1CA04C">数据库表</label>
                                        <input name="ways" type="radio" value="LH" id="bbb"/>
                                        <label for="bbb" style="font-size: 18px;color: #1CA04C">文件型数据</label>
                                    </h3>
                                    <div style="overflow: hidden" class="select-database" >
                                        <div class="col-md-3" style="font-size: 18px;text-align:right ">
                                            <span>选择表资源</span>
                                        </div>
                                        <div class="col-md-9" >
                                            <div class="row undeslist" >
                                            </div>
                                        </div>
                                    </div>
                                    <div style="overflow: hidden;display: none" class="select-local">
                                        <div class="col-md-6 col-md-offset-3" style="font-size: 18px" id="fileContainerTree"></div>
                                        <div id="fileDescribeDiv" style="display: none">

                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab3">

                                    <div style="overflow: hidden">
                                        <div class="col-md-6 col-md-offset-3" style="font-size: 18px">
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label  class="col-sm-4 control-label">选择公开范围</label>
                                                    <div class="col-sm-8">
                                                        <select name="permissions" id="permissions" class="form-control" multiple>
                                                            <option value="外网公开用户">外网公开用户</option>
                                                            <option value="内网用户">内网用户</option>
                                                            <option value="质量组用户">质量组用户</option>
                                                            <option value="分析组用户">分析组用户</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <%--<div class="form-group">
                                                    <label  class="col-sm-4 control-label">已选择</label>
                                                    <div class="col-sm-8">
                                                        <div style=" width: 412px;border: 1px solid rgb(169, 169, 169);min-height: 40px;padding-top: 5px;overflow: hidden" class="permissions-wrap"></div>
                                                    </div>
                                                </div>--%>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <a href="javascript:;" class="btn default button-previous" onclick="fromAction(false)" style="display: none">
                                        <i class="m-icon-swapleft"></i> 上一步 </a>
                                    <a href="javascript:;" class="btn blue button-next" onclick="fromAction(true)" >
                                        下一步 <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                    <a href="javascript:;" class="btn green button-submit" style="display: none">
                                        提交 <i class="m-icon-swapup m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="imgPath" val="">
<script type="text/html" id="dataRelationshipList">
    {{each list as value i}}
    <div class="col-md-4">
        <label>
            <input type="checkbox checkRelShow" name="resTable" value="{{value}}">
            <span style="word-break: break-all">{{value}}</span>
        </label>
    </div>
    {{/each}}
</script>
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
        </div>
    </div>
</div>
<%@ include file="./tableFieldComsTmpl.jsp" %>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/jquery.Jcrop.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-form/jquery.form.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/js/metaTemplate.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2_locale_zh-CN.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var sub = '${sessionScope.SubjectCode}'
        var initNum =1;
        var firstFlag=false;
        var secondFlag=false;
        var resourceId="";
        var publicType="0";
        var firstTime = 0;
        var lastTime = 0;
        var testEmail =/^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/
        /*var tagNames=new Array();*/
        //将图片截图并上传功能
        $('.selectData').datepicker({
            language:'zh-CN'
        });
        $('.selectData').each(function() {
            $(this).datepicker('clearDates');
        });
        $('.selectData:eq(0)').datepicker().on("changeDate",function (ev) {
            firstTime = new Date(ev.date).getTime()
            $("#data_time").hide()
        })
        $('.selectData:eq(1)').datepicker().on("changeDate",function (ev) {
            lastTime =new Date(ev.date).getTime()
            $("#data_time").hide()
        })

        var api = null;
        $("#select2_tags").select2({
            tags: true,
            multiple: true,
            tags:[""],
        });
        $('#permissions').select2({
            placeholder: "请选择用户",
            allowClear: true
        });
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                reader.onload = function(event) {
                    var tag = $("#tag").val();
                    if(tag=="") {
                        $("#cutDiv").append('<img src="" id="cutimg" style="height:100%; width: 100%;display: block"/>');
                        $("#tag").val("1");
                    }
                    $('#cutimg').removeAttr('src');
                    $('#cutimg').attr('src', event.target.result);
                    $("#checkPicture").hide();
                    $("#uploadSpan").show();
                    console.log(event.target.result)
                    api = $.Jcrop('#cutimg', {
                        setSelect: [ 10, 10, 100, 100 ],
                        aspectRatio: 4/3,
                        allowSelect:true,
/*
                        allowSelect:false,
*/
/*
                        allowResize:false,
*/
                        onSelect: updateCoords,
                        onChange:updateCoords
                    });
                };
                if (api != undefined) {
                    api.destroy();
                }
            }
            function updateCoords(obj) {
                $("#x").val(obj.x);
                $("#y").val(obj.y);
                $("#w").val(obj.w);
                $("#h").val(obj.h);
            };
        }
        function doUpload(){
            $(".jcrop-holder").hide();
            var formData = new FormData($( "#fileForm" )[0]);
            $.ajax({
                url: '${ctx}/resource/uploadHeadImage' ,
                type: 'post',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (result) {
                    var resultJson = JSON.parse(result);
                    var filePath = 'resources/img/images/'+resultJson.saveName;
                    $("#imgPath").val('resources/img/images/'+resultJson.saveName);
                    $('.jcrop-tracker').hide();
                    $("#checkPicture").show();
                    $("#uploadSpan").hide();
                    $('#cutimg').attr('src',filePath+'_cut.jpg');
                    $('#cutimg').show();
                },
                error: function (returndata) {
                    alert(returndata);
                }
            });
        }
        $(".progress-bar-success").width(initNum*33+"%");
        $("[name='ways']").on("change",function () {
            if(this.value =="DB"){
                $(".select-database").show();
                $(".select-local").hide();
                publicType ="0"
            }else {
                $(".select-database").hide();
                $(".select-local").show();
                publicType ="1"
            }
        })
        $("[name='need_checked']").on("change",function () {
            var $index = $("[name='need_checked']").index($(this))
            if($(this).val() != "" &&$(this).val().trim()!=""){
                $("[name='need_checked']:eq("+$index +")").removeClass("custom-error")
                $("[name='need_message']:eq("+$index +")").hide()
                $(".required:eq("+$index +")").parent().removeClass("custom-error")
            }
        })
        $("#task_email").on("change",function () {
            $("[name='data_email']").hide()
        })
        $("#task_phone").on("change",function () {
            $("[name='data_phone']").hide()
        })
        $(".undeslist").delegate(".checkRelShow","click",function () {
            staticSourceTableChoice(1,this,sub,$(this).val(),"dataResource")
        })
        /*$("#permissions").on("change",function () {
            var $selEle=$("#permissions option:selected")
            var valStr = $selEle.val();
            if(valStr ==""){
                return
            }
            $selEle.remove()
            $(".permissions-wrap").append("<div class='permissions-word'> <p class='tagname'>"+valStr+"</p> <span class='closeWord'>×</span> </div>");

        })*/
        $(".button-submit").click(function () {
            addResourceThirdStep()
        })
        /*$(".key-wrap").delegate(".closeWord","click",function () {
            var index = $(".closeWord").index($(this))
            $(this).parent().remove()
            tagNames.splice(index,1)
            if(tagNames==0){
                $("#key_work").show();
            }

        })*/
       /* $(".permissions-wrap").delegate(".closeWord","click",function () {
            $(this).parent().remove()
            var str =$(this).parent().find(".tagname").text()
            $("#permissions").append("<option value="+str +">"+ str+"</option>")

        })*/
        initCenterResourceCatalogTree($("#jstree-demo"));
        relationalDatabaseTableList();

        function fromAction(flag) {
            if(flag){
                ++initNum;
                if(initNum ==2 ){
                    if(resourceId == ""){
                        addResourceFirstStep()
                    }else {
                        editResourceFirstStep()
                    }
                    if(firstFlag){
                        initNum--
                        toastr["error"]("请填写必须项目");
                        return
                    }
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab1").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(1)").addClass("active")
                    $(".button-previous").show();
                }else if(initNum ==3) {
                    addResourceSecondStep()
                    if(secondFlag){
                        initNum--
                        toastr["error"]("请选择至少一项");
                        return
                    }
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab2").removeClass("active")
                    $("#tab3").addClass("active")
                    $(".steps li:eq(2)").addClass("active")
                    $(".button-submit").show()
                    $(".button-next").hide()
                }
            }else {
                --initNum
                if(initNum == 1){
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab2").removeClass("active")
                    $("#tab1").addClass("active")
                    $(".steps li:eq(1)").removeClass("active")
                    $(".button-previous").hide();
                }else if(initNum == 2){
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab3").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(2)").removeClass("active")
                    $(".button-next").show()
                    $(".button-submit").hide()
                }
            }
        }
        function initCenterResourceCatalogTree(container) {
            $.ajax({
                url: ctx + "/getLocalResCatalog",
                type: "get",
                dataType: "json",
                data: {editable: false},
                success: function (data) {
                    console.log(data)
                    $(container).jstree(data).bind("select_node.jstree", function (event, selected) {
                        /*$(".button-save").removeAttr("disabled");*/
                        $("#centerCatalogId").val(selected.node.id);
                        $("#file_dir").hide();
                    })
                }
            })
        }
        function relationalDatabaseTableList() {
            $.ajax({
                url:ctx+"/resource/relationalDatabaseTableList",
                type:"GET",
                success:function (data) {
                    console.log(data)
                    $(".undeslist").empty();
                    var List =JSON.parse(data)
                    var tabCon = template("dataRelationshipList", List);
                    $(".undeslist").append(tabCon);
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
       /* function addKeyWords() {
            var newStr = $("#addWorkStr").val()
            if(newStr =="" ||newStr.trim() == ""){
                return
            }
            for(var i=0;i<tagNames.length;i++){
                if(newStr ==tagNames[i]){
                    toastr["error"]("不可添加重复标签");
                    return
                }
            }
            tagNames.push(newStr)
            $(".key-wrap").append("<div class='key-word'> <p class='tagname'>"+newStr+"</p> <span class='closeWord'>×</span> </div>");
            $("#addWorkStr").val("")
            $("#key_work").hide();
        }*/

        function addResourceFirstStep() {
            firstFlag=false
            $("[name='need_checked']").each(function () {
                var $index = $("[name='need_checked']").index($(this))
                if($(this).val() == "" ||$(this).val().trim()==""){
                    $("[name='need_checked']:eq("+$index +")").addClass("custom-error")
                    $("[name='need_message']:eq("+$index +")").show()
                    $(".required:eq("+$index +")").parent().addClass("custom-error")
                    firstFlag=true
                    return
                }
            })

            if($("#select2_tags").val().split(",").length <2){
                $("#lab_key").addClass("custom-error")
                $("#key_work").show()
                firstFlag=true
            }
            if($("#centerCatalogId").val() ==""){
                $("#file_dir").show();
                firstFlag=true
            }
            if(firstTime ==0 || lastTime ==0|| firstTime>lastTime){
                $("#data_time").show();
                firstFlag=true
            }
            if(!(/^1[34578]\d{9}$/.test($("#task_phone").val()))){
                $("[name='data_phone']").show()
                firstFlag=true
            }
            if(!testEmail.test($("#task_email").val())){
                $("[name='data_email']").show()
                firstFlag=true
            }
            if(firstFlag){
                return
            }
            var keywordStr = $("#select2_tags").val()
            $.ajax({
                url:ctx+"/resource/addResourceFirstStep",
                type:"POST",
                data:{
                    title:$("#task_title").val(),
                    imagePath:$("#imgPath").val(),
                    introduction:$("#dataDescribeID").val(),
                    keyword:keywordStr,
                    catalogId:$("#centerCatalogId").val(),
                    createdByOrganization:$("#dataSourceDesID").val(),
                    startTime:firstTime,
                    endTime:lastTime,
                    email:$("#task_email").val(),
                    phoneNum:$("#task_phone").val()
                },
                success:function (data) {
                    var data = JSON.parse(data)
                    console.log(data)
                    resourceId = data.resourceId
                    console.log(resourceId)
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function addResourceSecondStep() {

            var dataList=""
            if(publicType =="0"){
                var $ele = $("[name='resTable']:checked")

                $ele.each(function () {
                    dataList+=$(this).val()+";"
                })
            }else {
                var $ele = $("#fileDescribeDiv span")
                $ele.each(function () {
                    dataList+=$(this).text()+";"
                })
            }
            if($ele.size() ==0 ){
                secondFlag = true
            }else {
                secondFlag = false
            }
            dataList = dataList.substr(0, dataList.length - 1);
            $.ajax({
                url:ctx+"/resource/addResourceSecondStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    publicType:publicType=="0"?"mysql":"file",
                    dataList:dataList
                },
                success:function (data) {
                    console.log(data)
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function addResourceThirdStep() {
            var $preEle= $("#permissions").val();
            if($preEle == null){
                toastr["error"]("请选择用户组");
                return
            }
            $.ajax({
                url:ctx+"/resource/addResourceThirdStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    userGroupIdList:$preEle.toString()
                },
                success:function (data) {
                    window.location.href = "${ctx}/dataRelease"
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function editResourceFirstStep() {
            firstFlag=false
            $("[name='need_checked']").each(function () {
                var $index = $("[name='need_checked']").index($(this))
                if($(this).val() == "" ||$(this).val().trim()==""){
                    $("[name='need_checked']:eq("+$index +")").addClass("custom-error")
                    $("[name='need_message']:eq("+$index +")").addClass("custom-error")
                    $("[name='need_message']:eq("+$index +")").show()
                    $(".required:eq("+$index +")").parent().addClass("custom-error")
                    firstFlag=true
                    return
                }
            })
            if($("#select2_tags").val() ==""){
                $("#key_work").show()
                firstFlag=true
            }
            if($("#centerCatalogId").val() ==""){
                $("#file_dir").show();
                firstFlag=true
            }
            if(firstTime ==0 || lastTime ==0|| firstTime>lastTime){
                $("#data_time").show();
                firstFlag=true
            }
            if(!(/^1[34578]\d{9}$/.test($("#task_phone").val()))){
                $("[name='data_phone']").show()
                firstFlag=true
            }
            if(!testEmail.test($("#task_email").val())){
                $("[name='data_email']").show()
                firstFlag=true
            }
            if(firstFlag){
                return
            }
            var keywordStr = $("#select2_tags").val()
            /*for(var i=0;i<tagNames.length;i++){
                keywordStr+=tagNames[i]+";"
            }*/
            $.ajax({
                url:ctx+"/resource/editResourceFirstStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    title:$("#task_title").val(),
                    imagePath:$("#imgPath").val(),
                    introduction:$("#dataDescribeID").val(),
                    keyword:keywordStr,
                    catalogId:$("#centerCatalogId").val(),
                    createdByOrganization:$("#dataSourceDesID").val(),
                    startTime:firstTime,
                    endTime:lastTime,
                    email:$("#task_email").val(),
                    phoneNum:$("#task_phone").val()
                },
                success:function (data) {
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }

        $('#fileContainerTree').jstree({
            'core': {
                'data': function (node, cb) {
                    var children;
                    if (node.id == '#') {
                        children = initFileTree();
                    } else {
                        children = getFileList(node.id);
                    }
                    generateChildJson(children);
                    cb.call(this, children);
                }
            },
            "plugins": [
                "checkbox", "wholerow"
            ]
        }).bind('select_node.jstree', function (e, data) {
            var fileId = data.node.id;
            var str = fileId.replace(/%_%/g, "/");
            /*var isContain = false;*/
            $("#fileDescribeDiv").append("<div name="+ fileId+"><span>"+str +"</span></div>")
            /*$("#form_wizard_1").find(".button-save").removeAttr("disabled");*/
        }).bind("deselect_node.jstree", function (e, data) {
            var fileId = data.node.id;
            var fileName = data.node.text;
            $("div[name='" + fileId + "']").remove();
            /*$("#form_wizard_1").find(".button-save").removeAttr("disabled");*/
        });
        function initFileTree() {
            var root;
            $.ajax({
                type: "GET",
                url: '${ctx}/resource/fileSourceFileList',
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data)
                    root = data;
                }
            });
            return root;
        }
        function getFileList(folderPath) {
            var children;
            $.ajax({
                url: "${ctx}/resource/treeNode",
                type: "get",
                data: {'filePath': folderPath},
                dataType: "json",
                async: false,
                success: function (data) {
                    children = data;
                }
            });
            return children;
        }
        function generateChildJson(childArray) {
            console.log(childArray)
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
    </script>
</div>

</html>

