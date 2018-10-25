<%--
  Created by IntelliJ IDEA.
  User: shibaoping
  Date: 2018/10/24
  Time: 14:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>系统</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/jstree/dist/themes/default/style.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="source-head">
        <span>DataSync / 数据源</span>
    </div>
    <div class="source-title">
        <span>文件数据源信息管理</span>
    </div>
    <div class="alert alert-info" role="alert" style="margin:0  33px">
        <!--查询条件 -->
        <div class="row">
            <%--<div class="col-md-9">
                <button type="button" class="btn  btn-sm green pull-right" id="addSqlSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加SQL数据源</button>
            </div>--%>
            <div class="col-md-12">
                <button type="button" class="btn  btn-sm green pull-right" id="addFileSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加文件型数据源</button>
            </div>
        </div>
    </div>
    <div class="source-table">
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" id="dataSourceList">
            <thead>
            <tr>
                <th>编号</th>
                <th>数据源名称</th>
                <th>文件类型</th>
                <th width="30%">文件地址</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="fileBody">
            </tbody>
        </table>
        <div class="page-message" style="float: left">

        </div>
        <div class="page-list" style="float: right"></div>
    </div>
</div>
<!-- validation add Mode -->
<div id="fileSourceModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title" id="fileSourceModalTitle">添加文件数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="fileSourceForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label for="dataSourceName" class="col-md-3 control-label"><span class="required">
													* </span>数据源名称</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceName"
                                                   name="dataSourceName"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">文件类型</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="fileType"  value="本地文件" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div id="jstree_show"></div>
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
<!-- validation edit Mode -->
<div id="fileSourceEditModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑文件数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="fileSourceEditForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label for = "dataSourceNameE" class="col-md-3 control-label"><span class="required">
													* </span>数据源名称</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control"
                                                   id="dataSourceNameE"
                                                   name="dataSourceNameE"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">文件类型</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="fileType"  value="本地文件" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label  class="col-sm-3 control-label"><font color='red'>*</font>文件地址</label>
                                        <div class="col-sm-9">
                                            <div id="tags_tagsinput" class="tagsinput" style="border: 1px solid black" ></div>
                                            <div id="jstree_show_edit"></div>
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
        <td>{{value.fileType}}</td>
        <td>{{value.filePath}}</td>
        <td>{{value.createTime}}</td>
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
        <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
        <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.js"></script>
        <script src="${ctx}/resources/bundles/jstree/dist/jstree.js" type="text/javascript"></script>
    <script>
        $(function(){
            tableConfiguration();
        });
        /*get data table*/
        function tableConfiguration(num) {
            $.ajax({
                url:"/fileResource/indexPages",
                type:"GET",
                data:{"num":num},
                success:function (data) {
                    var DataList = JSON.parse(data)
                    var fileData = {
                        list:DataList.fileDataOfThisPage
                    }
                    console.log(DataList.list)
                    var tabCon = template("resourceTmp1", fileData);
                    $("#fileBody").html("");
                    $("#fileBody").append(tabCon);
                    if(DataList.fileDataOfThisPage=="{}"||DataList.fileDataOfThisPage==null){
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $(".page-list").html("");
                        return
                    }
                    $(".table-message").hide();
                    /*
                     * 创建table
                     * */
                    if ($(".page-list .bootpag").length != 0) {
                        $(".page-list").off();
                        $('.page-list').empty();
                    }
                    $(".page-message").html("当前第"+DataList.currentPage +"页,共"+DataList.totalPage +"页,共"+DataList.totalNum+"条数据");
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
                    $(".table-message").html("请求失败");
                }
            })
        }

        $("#addFileSource").click(function () {
            $("#fileSourceModal").modal('show');
            $('#jstree_show').jstree({
                "core": {
                    "themes": {
                        "responsive": false,
                    },
                    // so that create works
                    "check_callback": true,
                    'data': function (obj, callback) {
                        var jsonstr = "[]";
                        var jsonarray = eval('(' + jsonstr + ')');
                        var children;
                        if (obj != '#') {
                            var str = obj.id;
                            var str1 = str.replace(/%_%/g, "/");
                        }
                        $.ajax({
                            type: "GET",
                            url: "/fileResource/resCatalogTest",
                            dataType: "json",
                            data: {"data": str1},
                            async: false,
                            success: function (result) {
                                var arrays = result;
                                for (var i = 0; i < arrays.length; i++) {
                                    console.log(arrays[i])
                                    var arr = {
                                        "id": arrays[i].id,
                                        "parent": arrays[i].parentId == "root" ? "#" : arrays[i].parentId,
                                        "text": arrays[i].name,
                                        "type": arrays[i].type,
                                        "children":arrays[i].children
                                    }
                                    jsonarray.push(arr);
                                    children = jsonarray;
                                }
                            }

                        });
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
                "plugins": ["dnd"/*, "state"*/, "types", "checkbox", "wholerow"]
            })
            var $sqlFrom =$('#fileSourceForm')
            handleValidation($sqlFrom);
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

        //编辑文件数据源
       function editData(dataId) {
           $('#jstree_show_edit').jstree({
           "core": {
               "themes": {
                   "responsive": false,
               },
               // so that create works
               "check_callback": true,
               'data': function (obj, callback) {
                   var jsonstr = "[]";
                   var jsonarray = eval('(' + jsonstr + ')');
                   var children;
                   if (obj != '#') {
                       var str = obj.id;
                       var str1 = str.replace(/%_%/g, "/");
                   }
                   $.ajax({
                       type: "GET",
                       url: "/fileResource/resCatalogTest",
                       dataType: "json",
                       data: {"data": str1},
                       async: false,
                       success: function (result) {
                           var arrays = result;
                           for (var i = 0; i < arrays.length; i++) {
                               console.log(arrays[i])
                               var arr = {
                                   "id": arrays[i].id,
                                   "parent": arrays[i].parentId == "root" ? "#" : arrays[i].parentId,
                                   "text": arrays[i].name,
                                   "type": arrays[i].type,
                                   "children":arrays[i].children
                               }
                               jsonarray.push(arr);
                               children = jsonarray;
                           }
                       }

                   });
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
           "plugins": ["dnd"/*, "state"*/, "types", "checkbox", "wholerow"]
       })
           $.ajax({
               type: 'post',
               url: "/fileResource/queryData",
               data: {"dataId": dataId},
               success: function (result) {
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
                               $("#dataBaseNameE").val(jsonData[index][key]);
                           }
                           if (key == 'databaseType') {
                               $("#dataBaseTypeE").val(jsonData[index][key]);
                           }
                           if (key == 'filePath') {
                               var filepath = (jsonData[index][key]).replace(/%_%/g, "/").split(";");
                               var path = "";
                               for(var i = 0;i<filepath.length-1;i++){
                                   path += '<span class="tag" style="display: inline-block">' +
                                           '<span class="filePathClass">'+filepath[i]+'</span>'+'&nbsp;&nbsp;<a href="#" title="Removing tag" onclick="tagClick(this)">x</a> </span>'
                               }
                               $("#tags_tagsinput").html(path);
                               /*
                                $("#filePathE").val(jsonData[index][key]);
                                */
                           }
                           if (key == 'dataSourceId') {
                               $("#idHidden").val(jsonData[index][key]);
                           }
                       }
                   }
               }
           })
            $("#fileSourceEditModal").modal('show');
            var $fileFrom =$('#fileSourceEditForm')
            handleValidation($fileFrom);
        }

        //删除文件数据源
        function deleteData(dataId) {
            bootbox.confirm("确认删除",function (r) {
                if(r){
                    $.ajax({
                        type: 'post',
                        url: "/fileResource/deleteData",
                        data: {"dataId": dataId},
                        success: function (result) {
                            var res = JSON.parse(result);
                            if (res == '1') {
                                toastr["success"]("删除成功");
                                tableConfiguration();
                            } else {
                                toastr["error"]("删除失败");
                            }
                        }
                    })
                }else{

                }
            })
        }

        function tagClick(obj){
            $(obj).parent().hide();
            $(obj).parent().text("");
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
                    dataSourceNameE: {
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
                    if (formName == 'fileSourceEditForm') {
                        var dataSourceId = $("#idHidden").val();
                        var dataSourceName = $("#dataSourceNameE").val();
                        var dataSourceType = 'file';
                        var fileType = '本地文件';
                        var nodes = $('#jstree_show_edit').jstree("get_checked");
                        var attr = [];
                        $("#tags_tagsinput span").each(function (i) {
                            if($(this).attr('class')=='filePathClass'){
                                attr.push($(this).text());
                            }
                        })
                        $.ajax({
                            type: 'post',
                            url: "/fileResource/edit",
                            async: true,
                            traditional: true,
                            data: {
                                "dataSourceId": dataSourceId,
                                "dataSourceName": dataSourceName,
                                "dataSourceType": dataSourceType,
                                "fileType": fileType,
                                "attr": attr,
                                "nodes":nodes
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("编辑成功");
                                    $('#fileSourceEditModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                } else {
                                    toastr["error"]("编辑失败");
                                }
                            }
                        })
                    } else {
                        var nodes = $('#jstree_show').jstree("get_checked");
                        var dataSourceName = $("#dataSourceName").val();
                        var dataSourceType = 'file';
                        var fileType = "本地文件";
                        $.ajax({
                            type: 'post',
                            url: "/fileResource/add",
                            async: true,
                            traditional: true,
                            data: {
                                "dataSourceName": dataSourceName,
                                "dataSourceType": dataSourceType,
                                "fileType": fileType,
                                "data": nodes
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("新增成功");
                                    $('#fileSourceModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                } else {
                                    toastr["error"]("新增失败");
                                }
                            }
                        })
                    }
                }

            });

            function cancelButton() {
                formValid.resetForm();
            }


        };
    </script>
</div>

</html>
