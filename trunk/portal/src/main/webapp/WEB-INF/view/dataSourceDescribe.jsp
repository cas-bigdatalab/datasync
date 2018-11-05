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
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.css">
    <style>
        .undeslist label{
            font-size: 18px;
        }
        .custom-error{
            color:#a94442!important;
            border-color:#a94442!important;
        }
        .key-word{
            padding:0 8px;
            height: 28px;
            background:#57add9;
            color:#fff;
            font-size: 14px;
            margin-right:10px;
            margin-bottom: 5px;
            float:left;
        }

        .key-word p{
            float:left;
            font-size:14px;
            line-height:28px;
        }
        .key-word span{
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
                                        <h3 class="block">元数据信息描述</h3>




                                        <div class="form-group">
                                            <label class="control-label col-md-3" >数据集名称 <span class="required">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="need_checked"
                                                       id="resTitle" style="border: 1px solid rgb(169, 169, 169)">
                                                <div class="custom-error" name="need_message" style="display: none">请输入数据集名称</div>
                                            </div>

                                        </div>
                                        <%--<div class="form-group">
                                            <label class="control-label col-md-3">图片<span >
													* </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                    <div class="fileinput-preview thumbnail"
                                                         data-trigger="fileinput"
                                                         style="width: 200px; height: 150px;border: 1px solid rgb(169, 169, 169)">
                                                    </div>
                                                    <div>
                                                            <span class="btn default btn-file">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <span class="fileinput-exists">
                                                            换一个</span>
                                                            <input id="imagePath" type="file" name="imageFile">
                                                            </span>
                                                        <a href="#" class="btn red fileinput-exists"
                                                           data-dismiss="fileinput">
                                                            删除 </a>
                                                    </div>
                                                </div>
                                                <div class="clearfix margin-top-10">
												<span class="label label-danger">
												注意! </span>
                                                    图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                    Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。
                                                </div>
                                            </div>
                                        </div>--%>

                                            <div class="form-group">
                                                <label class="control-label col-md-3">图片<span class="required">
													* </span>
                                                </label>
                                                <div class="col-md-9">
                                                    <div class=" margin-top-10">
                                                        <form name="form" id="fileForm" action="" class="form-horizontal" method="post">
                                                            <div style="width: 200px; height: 150px;border: 1px solid rgb(169, 169, 169)">
                                                                <%--<img alt="" src="" id="cutimg" style="height: 150px; width: 200px;"/>--%>
                                                                <input type="hidden" id="x" name="x" />
                                                                <input type="hidden" id="y" name="y" />
                                                                <input type="hidden" id="w" name="w" />
                                                                <input type="hidden" id="h" name="h" />
                                                            </div>
                                                            <span class="btn default btn-file" id="checkPicture">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <input id="fcupload" type="file" name="imgFile" onchange="readURL(this);">
                                                    </span>
                                                            <span id="uploadSpan" class="fileinput-new" hidden>
                                                                <button type="button" onclick="doUpload();">上传</button>
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
                                        <form class="form-horizontal">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">资源目录<span  >
													* </span>
                                                </label>
                                                <div class="col-md-4" id="cemterCatalogDiv" >
                                                    <input type="hidden"  id="centerCatalogId">
                                                    <div id="jstree-demo"></div>
                                                    <div class="custom-error" style="display: none" id="file_dir">请选择目录</div>
                                                </div>
                                            </div>
                                            <div class="form-group dataLicenseInputGroup">
                                                <label class="control-label col-md-3">描述 <span class="required">
													* </span>
                                                </label>
                                                <div class="col-md-6">
                                                    <textarea name="need_checked" id="dataDescribeID" style=" height: 96px; width: 412px;resize: none;"></textarea>
                                                    <div class="custom-error" name="need_message" style="display: none">请输入描述信息</div>
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">关键词<span>
													* </span></label>
                                                <div class="checkbox-list col-md-9">
                                                    <div style="margin-bottom: 3px;line-height: 24px">
                                                        <input type="text" style="font-size: 16px" id="addWorkStr">
                                                        <button class="btn green" type="button" onclick="addKeyWords()">添加关键词</button>
                                                    </div>
                                                    <div style=" width: 412px;border: 1px solid rgb(169, 169, 169);min-height: 40px;padding-top: 5px;overflow: hidden" class="key-wrap">
                                                        <div class='key-word'> <p>aaaaaaa</p> <span class='closeWord'>×</span> </div>
                                                    </div>
                                                    <div class="custom-error" id="key_work" style="display: none">请添加至少一个关键词</div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">来源<span  class="required">
													* </span></label>
                                                <div class="col-md-6" id="dataSourceDes">
                                                    <textarea name="need_checked" id="dataSourceDesID" style=" height: 96px; width: 412px;resize: none;"></textarea>
                                                    <div class="custom-error" name="need_message" style="display: none">请输入来源</div>
                                                </div>

                                            </div>
                                        </form>














                                    </form>
                                </div>
                                <div class="tab-pane" id="tab2">

                                    <h3 class="block">确定数据对象范围，发布数据</h3>
                                    <h3>
                                        <span>数据源:</span>
                                        <label for="aaa" style="font-size: 23px;color: #1CA04C">数据库表</label>
                                        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
                                        <label for="bbb" style="font-size: 23px;color: #1CA04C">文件型数据</label>
                                        <input name="ways" type="radio" value="LH" id="bbb"/>
                                    </h3>
                                    <div style="overflow: hidden" class="select-database" >
                                        <div class="col-md-3" style="font-size: 18px;text-align:right ">
                                            <span>选择表资源</span>
                                        </div>
                                        <div class="col-md-9" >
                                            <div class="row undeslist" >
                                                <div class="col-md-4">
                                                    <label>
                                                        <input type="checkbox">
                                                        <span>dictionay</span>
                                                    </label>
                                                </div>
                                                <div class="col-md-4">
                                                    <label>
                                                        <input type="checkbox">
                                                        <span>dictionay</span>
                                                    </label>
                                                </div>
                                                <div class="col-md-4">
                                                    <label>
                                                        <input type="checkbox">
                                                        <span>dictionay</span>
                                                    </label>
                                                </div>

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

                                    <h3>确定数据对象发布的权限分配范围</h3>
                                    <div style="overflow: hidden">
                                        <div class="col-md-6 col-md-offset-3" style="font-size: 18px">
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-4 control-label">可公开范围</label>
                                                    <div class="col-sm-8">
                                                        <select name="" id="inputEmail3" class="form-control">
                                                            <option value="">请选择公开范围</option>
                                                            <option value="">外网公开用户</option>
                                                            <option value="">内网用户</option>
                                                            <option value="">质量组用户</option>
                                                            <option value="">分析组用户</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label  class="col-sm-4 control-label">已选择</label>
                                                    <div class="col-sm-8">

                                                    </div>
                                                </div>
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
<script type="text/html" id="dataRelationshipList">
    {{each list as value i}}
    <div class="col-md-4">
        <label>
            <input type="checkbox" name="resTable" value="{{value}}">
            <span style="word-break: break-all">{{value}}</span>
        </label>
    </div>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var initNum =1;
        var firstFlag=false;
        var secondFlag=false;
        var thirdFlag=false;
        var resourceId="";
        var publicType="0";
        var tagNames=new Array();
        /*fileSourceFileList();*/
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
            console.log($index)
            if($(this).val() != "" &&$(this).val().trim()!=""){
                $("[name='need_checked']:eq("+$index +")").removeClass("custom-error")
                $("[name='need_message']:eq("+$index +")").removeClass("custom-error")
                $("[name='need_message']:eq("+$index +")").hide()
                $(".required:eq("+$index +")").parent().removeClass("custom-error")
            }
        })
        initCenterResourceCatalogTree($("#jstree-demo"));
        relationalDatabaseTableList();

        function fromAction(flag) {
            if(flag){
                ++initNum;
                if(initNum ==2 ){
                    addResourceFirstStep()
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
                }else {
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
                }else {
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
                    $(".undeslist").empty();

                    var List =JSON.parse(data)
                    console.log(List)
                    var tabCon = template("dataRelationshipList", List);
                    $(".undeslist").append(tabCon);
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function addKeyWords() {
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
        }
        $(".key-wrap").delegate(".closeWord","click",function () {
            var index = $(".closeWord").index($(this))
            $(this).parent().remove()
            tagNames.splice(index,1)
            if(tagNames==0){
                $("#key_work").show();
            }

        })
        function addResourceFirstStep() {
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
            if(tagNames.length ==0){
                $("#key_work").show()
                firstFlag=true
                return
            }
            if($("#centerCatalogId").val() ==""){
                $("#file_dir").show();
                firstFlag=true
                return
            }
            firstFlag=false
            $.ajax({
                url:ctx+"/resource/addResourceFirstStep",
                type:"POST",
                data:{
                    title:"",
                    imagePath:"",
                    introduction:"",
                    keyword:"",
                    catalogId:"",
                    createdByOrganization:""
                },
                success:function (data) {
                    console.log("———————————111111111———————————")
                    console.log(data)
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
            /*$.ajax({
                url:ctx+"/resource/addResourceSecondStep",
                type:"POST",
                data:{
                    resourceId:"5bdc180e095e0423ec2a2597",
                    publicType:publicType,
                    dataList:dataList
                },
                success:function (data) {
                    console.log("——————————222222222————————————")
                    console.log(data)
                    console.log("——————————222222222————————————")
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })*/
        }
        function getResourceById() {
            $.ajax({
                url:ctx+"/resource/getResourceById",
                type:"POST",
                data:{
                    resourceId:"5bdc180e095e0423ec2a2597",
                },
                success:function (data) {
                    console.log("——————————444444————————————")
                    console.log(data)
                    console.log("——————————444444————————————")
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        /*addResourceFirstStep();*/
        /*addResourceSecondStep();*/
        getResourceById();
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

        function validationFirst() {
            
        }

    </script>
</div>

</html>

