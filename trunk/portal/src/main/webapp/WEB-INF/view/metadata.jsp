<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2019/03/14
  Time: 10:42
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx" />

<html>

<head>
    <title>元数据管理</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .error-message {
            color: red;
        }
        .page-content {
            height: 830px;
            min-height: 830px;
        }
        #table_List1 th,#table_List2 th{
            background-color: #64aed9;
            text-align: center;
            font-family: 'Arial Negreta', 'Arial Normal', 'Arial';
            font-weight: 700;
            font-style: normal;
            font-size: 18px;
            color: #FFFFFF;
        }
    </style>
</head>

<body>

<div style="height: 850px;min-height: 850px;" class="page-content" >
    <h3>&nbsp;&nbsp;元数据管理</h3>
    <hr />

    <div class="alert alert-info" role="alert" >
        <!--查询条件 -->
        <div class="row">
            <div class="col-md-12 form-inline">

                <label class="control-label">元数据英文名:</label>
                <input type="text" id="queryExtField" name="extField" class="form-control search-text ">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <label class="control-label">元数据中文名称:</label>
                <input type="text" id="queryExtFieldName" name="extFieldName" class="form-control search-text ">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button id="btnSearch" name="btnSearch" onclick="search();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查询</button>
                &nbsp;&nbsp;
                <button id="btnAdd" name="btnAdd" style="float: right" onclick="" class="btn info green btn-sm"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增</button>
            </div>
        </div>

    </div>
    <div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">

        <div class="table-message-group">列表加载中......</div>
        <div class="table-scrollable">

            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr id="table_List2">
                    <th style="width: 5%;">编号</th>
                    <th style="width: 10%;">
                        元数据英文名
                    </th>
                    <th style="width: 5%;">
                        字段类型
                    </th>
                    <th style="width: 15%;">元数据中文名称</th>
                    <th style="width: 5%;">排序</th>
                    <th style="width: 5%;">是否必填</th>
                    <th style="width: 20%;">枚举值</th>
                    <%--<th style="width: 20%;">备注</th>--%>
                    <th style="width: 15%;">操作</th>
                </tr>
                </thead>
                <tbody id="metadataList">

                </tbody>
            </table>
        </div>

    </div>

</div>

<!--增加元数据-->
<div class="modal fade" tabindex="-1" role="dialog" id="addModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">增加元数据</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="addMetadataForm" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group">
                        <label for="extFieldAdd" class="col-sm-3 control-label">元数据英文名<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="extFieldAdd" name="extField" placeholder="请输入元数据英文名(首字母小字)"  required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isMustAdd" class="col-sm-3 control-label">字段类型<span class="required">*
													</span></label>
                        <div class="col-sm-8">
                            <select style="width: 368px;height: 34px;" id="typeAdd" name="type" placeholder="请输入元数据字段类型">
                                <option  value="String">字符串(String)</option>
                                <option  value="Integer">整型数值(Integer)</option>
                                <option  value="Double">精度型数值(Double)</option>
                                <option  value="DateTime">日期时间(DateTime)</option>
                                <option  value="List">枚举值</option>
                            </select>
                        </div>
                    </div>

                    <div id="divEnumdata" class="form-group" style="display:none;">
                        <label for="enumdataAdd" class="col-sm-3 control-label">枚举项值<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="enumdataAdd" name="enumdata" placeholder="请输入枚举值,各枚举项值以英文逗号(,)隔开">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="extFieldNameAdd" class="col-sm-3 control-label">元数据中文名称<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="extFieldNameAdd" name="extFieldName" placeholder="请输入元数据中文名称"  required="required" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sortOrderAdd" class="col-sm-3 control-label">排序<span class="required">
													</span></label>
                        <div class="col-sm-8">
                            <input  type="text" class="form-control"  id="sortOrderAdd" name="sortOrder" placeholder="请输入元数据排列顺序" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isMustAdd" class="col-sm-3 control-label">是否必填项<span class="required">
													</span></label>
                        <div class="col-sm-8">
                            <select style="width: 368px;height: 34px;" id="isMustAdd" name="isMust" placeholder="请选择元数据字段值是否必填项">
                                <option  value="0">否</option>
                                <option  value="1">是</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sortOrderAdd" class="col-sm-3 control-label">备注<span class="required">
													</span></label>
                        <div class="col-sm-8">
                            <input  type="text" class="form-control"  id="remarkAdd" name="remark" placeholder="请输入备注信息" />
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitAddData();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" onclick="resetData();" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!--修改用户组Group-->
<div class="modal fade" tabindex="-1" role="dialog" id="editModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改用户组</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="editGroupForm" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group">

                        <input type="hidden" class="form-control"
                               id="groupId"
                               name="id" value=""/>

                        <input type="hidden" class="form-control"
                               id="groupUsers"
                               name="users" />

                        <label for="groupNameEdit" class="col-sm-3 control-label">用户组名称<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="groupNameEdit" name="groupName" placeholder="请输入用户组名称" readonly  required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descEdit" class="col-sm-3 control-label">描述<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <textarea  type="text" class="form-control" cols="30" rows="5" id="descEdit" name="desc" placeholder="请输入用户组描述信息" required="required"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitEditData();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!--用户组Group, 添加用户-->
<div class="modal fade" tabindex="-1" role="dialog" id="groupModalForAddUser">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户组添加用户</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="groupFormForAdduser" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group" style="margin-bottom:2px;">
                        <input type="hidden" id="spanGroupId">
                        <label class="col-sm-3 control-label">用户组名称:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <span id="spanGroupName"></span>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:2px;">
                        <label  class="col-sm-3 control-label">描述:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <span id="spanDesc"></span>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:2px;">
                        <label  class="col-sm-3 control-label">本组己有用户:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <select class='form-control select2me' name='users' id='users' multiple>
                                <c:forEach  var="item"  items="${list}">
                                    <option value="${item.id}" id="${item.id}" >${item.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitAddUser();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 元数据 -->
<script type="text/html" id="metadataTmpl">
    {{each list}}
    <tr>
        <td style="display:table-cell; vertical-align:middle ; text-align: center;" >{{$index+1}}</td>
        <td style="display:table-cell; vertical-align:middle;text-align: left;" > {{$value.extField}}
        </td>
        <td style="display:table-cell; vertical-align:middle ;text-align: left;">{{$value.type}}</td>

        <td style="display:table-cell; vertical-align:middle ;text-align: left;">{{$value.extFieldName}}</td>
        <td style="display:table-cell; vertical-align:middle ;text-align: center;">{{$value.sortOrder}}</td>
        <td style="display:table-cell; vertical-align:middle ;text-align: center;">
            {{if $value.isMust == 1}}是
            {{else if $value.isMust === 0}}否
            {{/if}}
        </td>
        <td style="display:table-cell; vertical-align:middle ;text-align: left;">{{$value.enumdata}}</td>
        <%--<td style="display:table-cell; vertical-align:middle ;text-align: left;">{{$value.remark}}</td>
--%>
        <td style="display:table-cell; vertical-align:middle;text-align: center;" id="{{$value.id}}" >
            <button class="btn default btn-xs purple updateButton" onclick="editData('{{$value.id}}')"><i class="fa fa-edit"></i>修改</button>&nbsp;
            <button class="btn default btn-xs red" onclick="deleteData('{{$value.id}}')"><i class="fa fa-trash"></i>删除</button>&nbsp;
        </td>
    </tr>
    {{/each}}
</script>



</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script src="${ctx}/resources/js/subStrLength.js"></script>
    <script src="${ctx}/resources/js/regex.js"></script>
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>

    <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>


    <script type="text/javascript">
        var ctx = '${ctx}';
        var validatorAdd;
        var groupUsersSelect2;
        var validAddData;
        var validEditData;

        $(function () {
            //template.helper("dateFormat", formatDate);
            getData();

            $(".search-text").keydown(function (event) {
                if (event.keyCode == 13) {
                    getData();
                }
            });

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "positionClass": "toast-top-right",
                "onclick": null,
                "showDuration": "1000",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };

            validAddData = {
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    groupName: {
                        required: true,
                        remote:
                            {
                                url: "isExist",
                                type: "get",
                                dataType: "json",
                                data:
                                    {
                                        'groupName': function () {
                                            return $("#groupNameAdd").val();
                                        }
                                    }
                            }
                    },
                    desc: {
                        required: true
                    }
                },
                messages: {
                    groupName: {
                        required: "请输入用户组名称",
                        remote: "此用户组名称己存在"
                    },
                    desc: {
                        required: "请输入用户组描述信息"
                    }
                },
                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.parent(".input-group").size() > 0) {
                        error.insertAfter(element.parent(".input-group"));
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                }
            };

            validEditData = {
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    groupName: {
                        required: true
                    },
                    desc: {
                        required: true
                    }
                },
                messages: {
                    groupName: {
                        required: "请输入用户组名称"
                    },
                    desc: {
                        required: "请输入用户组描述信息"
                    }
                },
                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.parent(".input-group").size() > 0) {
                        error.insertAfter(element.parent(".input-group"));
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                }
            };

            $("#addMetadataForm").validate(validAddData);
            $("#editGroupForm").validate(validEditData);

            //getAllUserList();
            groupUsersSelect2 = $('#users').select2({
                placeholder: "请选择用户",
                allowClear: true
            });

        });


        function search() {
            getData();
        }



        function getData() {
            $.ajax({
                url: "${ctx}/admin/metadata/getList",
                type: "get",
                dataType: "json",
                data: {
                    "extField":$.trim($("#queryExtField").val()),
                    "extFieldName":$.trim($("#queryExtFieldName").val())
                },
                success: function (data) {
                    console.log("-----------------");
                    console.log(data);

                    var html = template("metadataTmpl", data);
                    $(".table-message-group").html("");
                    $("#metadataList").empty();
                    $("#metadataList").append(html);
                    if(data.list.length ==0){
                        $(".table-message-group").html("暂时没有数据");
                    }

                }
            });
        }

        function deleteData(id) {

            bootbox.confirm("<span style='font-size:16px;'>确定要删除此条记录吗？</span>", function (r) {
                if (r) {
                    $.ajax({
                        url: ctx + "/group/delete/" + id,
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            if (data.result == 'ok') {
                                toastr["success"]("删除成功！", "数据删除");
                                getData(currentPageNo);
                                //删除用户组的同时,刷新用户列表信息
                                searchUser();
                            }
                            else {
                                toastr["error"]("删除失败！", "数据删除");
                            }
                        },
                        error: function () {
                            toastr["error"]("删除失败！", "数据删除");
                        }
                    });
                }
            });
        }

        $("#btnAdd").click(function () {
            $("#groupNameAdd").val("");
            $("#descAdd").val("");
            resetData();
            $("#addModal").modal('show');
        });

        //重置校验窗体xiajl20181117
        function resetData() {
            $("#addMetadataForm").validate().resetForm();
            $("#addMetadataForm").validate().clean();
            $('.form-group').removeClass('has-error');
        }

        function submitAddData() {
            if (!$("#addMetadataForm").valid()) {
                return;
            }
            $.ajax({
                type: "POST",
                url: '${ctx}/group/add',
                data: $("#addMetadataForm").serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("添加成功！", "添加用户组");
                        $("#addModal").modal("hide");
                        $("#groupNameAdd").val("");
                        $("#descAdd").val("");
                        getData(currentPageNo);
                    } else {
                        toastr["error"]("添加失败！", "添加用户组");
                    }
                }
            });
        }

        <!--编辑用户组-->
        function editData(id) {
            $.ajax({
                type: "GET",
                url: '${ctx}/group/info',
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    $("#editModal").modal("show");
                    $("#groupNameEdit").val(data.group.groupName);
                    $("#descEdit").val(data.group.desc);
                    $("#groupId").val(data.group.id);
                }
            });
        }


        <!--用户组中增加用户界面-->
        function addUserData(id) {
            $.ajax({
                type: "GET",
                url: '${ctx}/group/info',
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $("#groupModalForAddUser").modal("show");
                    $("#spanGroupName").html(data.group.groupName);
                    $("#spanDesc").html(data.group.desc);
                    $("#spanGroupId").val(data.group.id);
                    //编辑显示己增加的用户
                    //编辑显示己增加的用户
                    console.log(data.group.users);
                    console.log(JSON.stringify(data.group.users));

                    $("#users").select2().val(JSON.parse(data.group.users)).trigger("change");

                }
            });
        }

        function submitEditData() {
            if (!$("#editGroupForm").valid()) {
                return;
            }
            $.ajax({
                type: "POST",
                url: '${ctx}/group/update',
                data: $("#editGroupForm").serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("编辑成功！", "用户组编辑");
                        $("#editModal").modal("hide");
                        getData(currentPageNo);
                    } else {
                        toastr["error"]("编辑失败！", "用户组编辑");
                    }
                }
            });
        }

    </script>

</div>

</html>
