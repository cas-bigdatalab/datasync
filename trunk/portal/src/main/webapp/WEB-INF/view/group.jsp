<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/10/31
  Time: 10:42
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx" />

<html>

<head>
    <title>用户管理</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div class="page-content" style="min-height: 650px;">
    <h3>&nbsp;&nbsp;用户管理</h3>
    <hr />

    <div class="col-md-12">
        <div class="tabbable-custom ">
            <!-- tab header --->
            <ul class="nav nav-tabs ">
                <li class="active">
                    <a href="#userContent" data-toggle="tab">
                        用户管理</a>
                </li>
                <li>
                    <a href="#groupContent" data-toggle="tab">
                        用户组管理</a>
                </li>
            </ul>
            <!--tab content-->
            <div class="tab-content">

                <!--用户管理标签页-->
                <div class="tab-pane active" id="userContent" style="min-height: 400px">
                    <div class="row">
                        <div class="col-xs-12 col-md-12 col-lg-12">

                            <!--用户管理标签页: 用户筛选条件-->
                            <div class="alert alert-info" role="alert">
                                <div class="row">
                                    <div class="col-md-12">
                                            <label class="control-label">用户账号:</label>
                                            <input type="text" id="loginIdFilter" name="loginIdFilter" placeholder="用户账号" class="input-small" style="height: 30px;" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;

                                            <label class="control-label">用户名:</label>
                                            <input type="text" id="userNameFilter" name="userNameFilter" placeholder="用户名" class="input-small" style="height: 30px;" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;

                                            <label class="control-label">用户组:</label>

                                            <select name='groupsFilter' id='groupsFilter' multiple="multiple" class="form-control select2me" style="width: 300px; height: 30px;" >
                                                <c:forEach  var="group"  items="${groupList}">
                                                    <option value="${group.groupName}" id="${group.id}" style="width: 150px; height: 30px;">${group.groupName}</option>
                                                </c:forEach>
                                            </select>

                                            &nbsp;&nbsp;&nbsp;&nbsp;

                                            <button id="searchUserBtn" name="searchUserBtn" onclick="searchUser();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <button id="addUserBtn" name="addUserBtn" class="btn info green btn-sm" data-target="#addUserDialog" data-toggle="modal" ><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新建用户</button>
                                     </div>
                                </div>
                            </div>

                            <!--用户管理标签页: 用户列表-->
                            <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">编号</th>
                                            <th style="width: 12%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户名 </th>
                                            <th style="width: 12%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">账号 </th>
                                            <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</th>
                                            <%--<th style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">状态</th>--%>
                                            <th style="width: 30%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户组</th>
                                            <th style="text-align: center;background: #64aed9;color: #FFF;font-weight: bold">操作</th>
                                        </tr>
                                    </thead>

                                    <tbody id="userList">

                                    </tbody>

                                </table>
                            </div>

                            <!--用户管理标签页: 分页-->
                            <div class="row margin-top-20">
                                <div class="col-md-6 margin-top-10">
                                    当前第<span style="color:blue;" id="curUserPageNum"></span>页,共<span style="color:blue;" id="totalUserPages"></span>页, 共<span style="color:blue;" id="totalUsers"></span>条数据
                                </div>
                                <div class="col-md-6">
                                    <div id="paginationForUser" style="float: right"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--group tab-->
                <div class="tab-pane" id="groupContent">
                    <div class="row">
                        <div class="col-xs-12 col-md-12 col-lg-12">
                            <div class="alert alert-info" role="alert">
                                <!--查询条件 -->
                                <div class="row">
                                    <div class="col-md-12">

                                        <label class="control-label">用户组名:</label>
                                        <input type="text" id="groupName" name="groupName" class="input-small search-text">
                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                        <button id="btnSearch" name="btnSearch" onclick="search();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查询</button>
                                        &nbsp;&nbsp;
                                        <button id="btnAdd" name="btnAdd" onclick="" class="btn info green btn-sm"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新建用户组</button>
                                    </div>
                                </div>

                            </div>
                            <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                    <tr>
                                        <th style="width: 5%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">编号</th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">
                                            用户组名
                                        </th>
                                        <th style="width: 25%;text-align: left;background: #64aed9;color: #FFF;font-weight: bold">描述</th>
                                        <th style="width: 10%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</th>
                                        <th style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="groupList"></tbody>
                                </table>
                            </div>
                            <div class="row margin-top-20">
                                <div class="col-md-6 margin-top-10">
                                    当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span style="color:blue;" id="totalPages"></span>页,<span style="color:blue;" id="totalCount"></span>条数据
                                </div>
                                <div class="col-md-6">
                                    <div id="pagination" style="float: right"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--新增用户组Group-->
<div class="modal fade" tabindex="-1" role="dialog" id="addModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增用户组</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="addGroupForm" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group">
                        <label for="groupNameAdd" class="col-sm-3 control-label">用户组名称<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="groupNameAdd" name="groupName" placeholder="请输入用户组名称"  required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descAdd" class="col-sm-3 control-label">描述<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <textarea  type="text" class="form-control" cols="30" rows="5" id="descAdd" name="desc" placeholder="请输入用户组描述信息" required="required"></textarea>
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
                            <input type="text" class="form-control" id="groupNameEdit" name="groupName" placeholder="请输入用户组名称"  required="required" >
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

<!-- 用户组 group -->
<script type="text/html" id="groupTmpl">
    {{each list}}
    <tr>
        <td style="display:table-cell; vertical-align:middle ; text-align: center;" >{{(currentPage-1)*pageSize+$index+1}}</td>
        <td style="display:table-cell; vertical-align:middle" ><a href="javascript:editData('{{$value.id}}');">{{$value.groupName}}</a>
        </td>
        <td style="display:table-cell; vertical-align:middle ;text-align: left">{{$value.desc}}</td>
        <td style="display:table-cell; vertical-align:middle ;text-align: center">{{dateFormat($value.createTime)}}</td>
        <td style="display:table-cell; vertical-align:middle" id="a{{$value.id}}" style="text-align: center">
            <%--<button class="btn default btn-xs green-stripe" onclick="viewData()">查看</button>&nbsp;&nbsp;--%>
            <button class="btn default btn-xs purple updateButton" onclick="editData('{{$value.id}}')"><i class="fa fa-edit"></i>修改</button>&nbsp;&nbsp;
            <button class="btn default btn-xs red" onclick="deleteData('{{$value.id}}')"><i class="fa fa-trash"></i>删除</button>&nbsp;&nbsp;
            <button class="btn default btn-xs green" onclick="addUserData('{{$value.id}}')"><i class="fa fa-user"></i>添加用户</button>
        </td>
    </tr>
    {{/each}}
</script>

<!--用户管理标签页：用户列表表格-->
<script type="text/html" id="userListTable">
    {{each list}}
    <tr>
        <td style="text-align: center">{{(curUserPageNum-1) * pageSize + 1 + $index}}</td>
        <td style="text-align: center">{{$value.userName}}</td>
        <td style="text-align: center">{{$value.loginId}}</td>
        <td style="text-align: center">{{$value.createTime}}</td>
        <%--<td style="text-align: center">{{$value.stat}}</td>--%>
        <td style="text-align: center">{{$value.groups}}</td>
        <td style="text-align: center" id = "{{$value.id}}">
            <button class="btn default btn-xs red updateUserButton" data-target="#updateUserDialog" data-toggle="modal" onclick="updateUser(this);"><i class="fa fa-edit"></i>&nbsp;修改</button>
            &nbsp;
            <button class="btn default btn-xs green updateUserGroupButton" onclick="deleteUser(this);"><i class="fa fa-trash"></i>&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>

<!--用户管理标签页：新建用户对话框-->
<div id="addUserDialog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h4 id="titleForAddUserDialog" class="modal-title" >添加用户</h4>
            </div>

            <div class="modal-body">
                <form id="addUserForm" class="form-horizontal" role="form" method="post" accept-charset="utf-8"  onfocusout="true">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="userName">
                                用&nbsp;户&nbsp;名<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户名称" id="userName" name="userName" required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="loginId">
                                用户账号<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户账号,只可输入数字和字母的组合" id="loginId" name="loginId"  required="required" onkeyup="this.value=this.value.replace(/[^\w_]/g,'');" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="password">
                                密&nbsp;&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入密码"  id="password" name="password" required="required">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectCode">
                                专题库代码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入专题库代码"  id="subjectCode" name="subjectCode" required="required">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="groupsForAddUserDialog">
                                角&nbsp;&nbsp;&nbsp;&nbsp;色<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <select class='form-control select2me' name='groupsForAddUserDialog' id='groupsForAddUserDialog' multiple="multiple">
                                    <c:forEach  var="group"  items="${groupList}">
                                        <option value="${group.groupName}" id="${group.id}" >${group.groupName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button id="saveUserAddBtn" class="btn green" onclick="addUser();">
                    保存
                </button>
                <button id="cancelUserAddBtn" class="btn default"  data-dismiss="modal">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>

<!--用户管理标签页：修改用户对话框-->
<div id="updateUserDialog" class="modal fade" tabindex="-1"  role="dialog" aria-hidden="true" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 id="titleForUpdateUserDialog" class="modal-title" >修改用户</h4>
            </div>

            <div class="modal-body">
                <form id="updateUserForm" class="form-horizontal" role="form" method="post" accept-charset="utf-8"  onfocusout="true">
                    <div class="form-body">
                        <span id="idForUpdate" hidden="hidden"></span>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="userNameForUpdate">
                                用&nbsp;户&nbsp;名<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户名称" id="userNameForUpdate" name="userNameForUpdate" required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="loginIdForUpdate">
                                用户账号<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户账号" id="loginIdForUpdate" name="loginIdForUpdate"  required="required" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="passwordForUpdate">
                                密&nbsp;&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入密码"  id="passwordForUpdate" name="passwordForUpdate" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectCodeForUpdate">
                                专题库代码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入专题库代码"  id="subjectCodeForUpdate" name="subjectCodeForUpdate" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="groupsForUpdateUserDialog">
                                角&nbsp;&nbsp;&nbsp;&nbsp;色<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <select class='form-control select2me' name='groupsForUpdateUserDialog' id='groupsForUpdateUserDialog' multiple="multiple">
                                    <c:forEach  var="group"  items="${groupList}">
                                        <option value="${group.groupName}" id="${group.id}" >${group.groupName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button id="saveUserUpdateBtn" class="btn green" onclick="agreeUpdateUser();">
                    保存
                </button>
                <button id="cancelUserUpdateBtn" class="btn default"  data-dismiss="modal">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>

<!--用户管理标签页：删除用户对话框-->
<div id="deleteUserDialog" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    删除用户
                </h5>
            </div>
            <div class="modal-body">
                <h5>确认删除该用户？</h5>
            </div>

            <div class="modal-footer">
                <span id="idOfUserToBeDeleted" hidden="hidden"></span>
                <button id="agreeDeleteUserBtn" class="btn green" onclick="agreeDeleteUser();">确认</button>
                <button id="cancelDeleteUserBtn"  class="btn default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

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
        var currentPageNo = 1;
        var validatorAdd;
        var groupUsersSelect2;
        $(function () {
            template.helper("dateFormat", formatDate);
            getData(1);

            $(".search-text").keydown(function (event) {
                if (event.keyCode == 13){
                    getData(1);
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

            var validData = {
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
            $("#addGroupForm").validate(validData);
            $("#editGroupForm").validate(validData);

            //getAllUserList();
            groupUsersSelect2 = $('#users').select2({
                placeholder: "请选择用户",
                allowClear: true
            });


            //////////////////////////////////////////////////////////////////////////////////////////////////
            //
            // 用户管理标签页：jquery初始化代码
            //
            //////////////////////////////////////////////////////////////////////////////////////////////////
            queryUser(null, null, null, 1); //用户管理标签页：获得用户列表
            //选择用户组筛选用户
            groupsFilterSelect2 = $("#groupsFilter").select2(
                {
                    placeholder: "请选择用户组",
                    allowClear: true
                }
            );
            //添加用户对话框中，选择用户组
            userGroupForAddUserGroupDialogSelect2 = $("#groupsForAddUserDialog").select2({
                placeholder: "请选择用户组",
                allowClear: true
            });
            //添加更新用户组对话框中，选择用户组
            groupsForUpdateUserDialogSelect2 = $('#groupsForUpdateUserDialog').select2({
                placeholder: "请选择用户组",
                allowClear: true
            });
        });

        function search() {
            getData(1);
        }

        //获取所有的用户信息
        function getAllUserList() {
            $.ajax({
                url: "${ctx}/group/getUserList",
                type: "get",
                dataType: "json",
                success: function (data) {

                }
            });
        }

        function getData(pageNo) {
            $.ajax({
                url: "${ctx}/group/getPageData",
                type: "get",
                dataType: "json",
                data: {
                    "groupName":$.trim($("#groupName").val()),
                    "pageNo": pageNo,
                    "pageSize": 10
                },
                success: function (data) {

                    var html = template("groupTmpl", data);
                    $("#groupList").empty();
                    $("#groupList").append(html);
                    $("#currentPageNo").html(data.currentPage);
                    currentPageNo = data.currentPage;
                    $("#totalPages").html(data.totalPages);
                    $("#totalCount").html(data.totalCount);

                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }

                    $('#pagination').bootpag({
                        total: data.totalPages,
                        page: data.currentPage,
                        maxVisible: 5,
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
                        getData(num);
                        currentPageNo = num;
                    });
                }
            });
        }

        function deleteData(id) {
            bootbox.confirm("确定要删除此条记录吗？", function (r) {
                if (r) {
                    $.ajax({
                        url: ctx + "/group/delete/" + id,
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            if (data.result == 'ok') {
                                toastr["success"]("删除成功！", "数据删除");
                                getData(currentPageNo);
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
            $("#addModal").modal('show');
        });

        function resetData() {
            validatorAdd.resetForm();
        }

        function submitAddData() {
            if (!$("#addGroupForm").valid()) {
                return;
            }
            $.ajax({
                type: "POST",
                url: '${ctx}/group/add',
                data: $("#addGroupForm").serialize(),
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
                    $("#groupModalForAddUser").modal("show");
                    $("#spanGroupName").html(data.group.groupName);
                    $("#spanDesc").html(data.group.desc);
                    $("#spanGroupId").val(data.group.id);
                    //编辑显示己增加的用户
                    //编辑显示己增加的用户
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

        <!--用户组中增加用户信息确认 -->
        function submitAddUser() {
            console.log("id=" +$("#spanGroupId").val());
            $.ajax({
                type: "POST",
                url: '${ctx}/group/updateUsers',
                data: {"id": $("#spanGroupId").val(),
                    "users":JSON.stringify($("#users").val())
                },
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("用户组增加用户成功！", "用户组编辑");
                        $("#groupModalForAddUser").modal("hide");
                    } else {
                        toastr["error"]("用户组增加用户失败！", "用户组编辑");
                    }
                }
            });
        }
    </script>


    <%--//////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 用户管理标签页：javascript代码
    //
    //////////////////////////////////////////////////////////////////////////////////////////////////--%>
    <script type="text/javascript">

        //添加用户 对话框的保存
        function addUser()
        {
            console.log("adduser\n" + (typeof $("#groupsForAddUserDialog").val()) + "\nadduser");

            $.ajax({
                url: "${ctx}/user/addUser",
                type: "get",
                data: {
                    "userName": $("#userName").val(),
                    "loginId": $("#loginId").val(),
                    "password": $("#password").val(),
                    "subjectCode": $("#subjectCode").val(),
                    "groups": $("#groupsForAddUserDialog").val().toString(),
                },
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    $("#addUserDialog").modal("hide");
                    setTimeout(function(){}, 100);
                    queryUser(null, null, null, 1); //没有搜索条件的情况下，显示第一页
                    location.reload();
                },
                error: function(data) {

                }
            });
        }

        //查询 按钮
        function searchUser()
        {
            var loginId = $("#loginIdFilter").val();
            var userName = $("#userNameFilter").val();
            var groups = $("#groupsFilter").val().toString();
            queryUser(loginId, userName, groups, 1);
        }

        function queryUser(loginId, userName, groups, curUserPageNum)
        {
            $.ajax({
                url: "${ctx}/user/queryUser",
                type: "get",
                data: {
                    "loginId": loginId,
                    "userName": userName,
                    "groups": groups,
                    "curUserPageNum": curUserPageNum,
                    "pageSize": 10
                },
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    var html = template("userListTable", data);

                    $("#userList").empty();
                    $("#userList").append(html);

                    $("#curUserPageNum").html(data.curUserPageNum);
                    $("#totalUserPages").html(data.totalUserPages);
                    $("#totalUsers").html(data.totalUsers);

                    if ($("#paginationForUser .bootpag").length != 0) {
                        $("#paginationForUser").off();
                        $('#paginationForUser').empty();
                    }

                    $('#paginationForUser').bootpag({
                        total: data.totalUserPages,
                        page: data.curUserPageNum,
                        maxVisible: 5,
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
                    }).on('page', function (event, toNum) {
                        queryUser(loginId, userName, groups, toNum);
                    });
                }
            });
        }

        //删除按钮
        function deleteUser(deleteBtn)
        {
            var idOfUser = $(deleteBtn).parent().attr("id");

            $("#deleteUserDialog").modal("show");
            $("#idOfUserToBeDeleted").html(idOfUser);
        }

        function agreeDeleteUser(agreeDeleteBtn)
        {
            $("#deleteUserDialog").modal("hide");
            var idOfUser = $("#idOfUserToBeDeleted").html();
            $.ajax({
                url: "${ctx}/user/deleteUser",
                type: "get",
                data:
                    {"id": idOfUser},
                dataType: "json",
                success: function (data) {
                    queryUser(null, null, null, 1);
                },
                error: function(data) {

                }
            });
        }

        function updateUser(updateBtn)
        {
            var idOfUser = $(updateBtn).parent().attr("id");

            $.ajax(
                {
                    url: "${ctx}/user/getUserById",
                    type: "get",
                    data: {
                        "id": idOfUser
                    },
                    dataType: "json",
                    success: function (data) {
                        console.log("updateUser - getUserById user = " + data.toString());
                        console.log("udpateUser - idForUpdate = " + data.id);
                        $("#idForUpdate").html(data.id);
                        $("#userNameForUpdate").val(data.userName);
                        $("#loginIdForUpdate").val(data.loginId);
                        $("#passwordForUpdate").val(data.password);
                        $("#subjectCodeForUpdate").val(data.subjectCode);

                        var groupArr = data.groups.split(",");
                        console.log("getUserById - groupArr - " + groupArr);
/*
                        for (var i = 0; i < groupArr.length; i++) {
*/
                            /*$("#groupsForUpdateUserDialog").val(groupArr[i]);*/
                        //$("#users").select2().val(JSON.parse(data.group.users)).trigger("change");
                        $("#groupsForUpdateUserDialog").select2().val(groupArr).trigger("change");
                        /*}*/

                        $("#updateUserDialog").modal("show");

                    },
                    error: function(data) {

                    }
                }

            );
        }

        function agreeUpdateUser()
        {
            $.ajax({
                url: "${ctx}/user/updateUser",
                type: "get",
                data: {
                    "id": $("#idForUpdate").html(),
                    "userName": $("#userNameForUpdate").val(),
                    "loginId": $("#loginIdForUpdate").val(),
                    "password": $("#passwordForUpdate").val(),
                    "subjectCode": $("#subjectCodeForUpdate").val(),
                    "groups": $("#groupsForUpdateUserDialog").val().toString()
                },
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    $("#updateUserDialog").modal("hide");
                    queryUser(null, null, null, 1); //没有搜索条件的情况下，显示第一页
                    location.reload();
                },
                error: function(data) {

                }
            });
        }

        //subjectCode唯一性
        $("#loginId").change(
            function()
            {
                var loginId = $(this).val();

            }
        )
        $("#loginId").blur(
            function() {
                $.ajax({
                    type: "GET",
                    async: false,
                    url: '${ctx}/user/queryLoginId',
                    data: {loginId: $(this).val()},
                    dataType: "text",
                    success: function (data){
                        var cntOfLoginId = parseInt(data);
                        if (cntOfLoginId > 0)
                        {
                            alert("loginId已经存在，请另外选择一个！")
                        }
                    },
                    error: function(data) {
                        console.log(data);
                    }
            });
        });
    </script>
</div>

</html>
