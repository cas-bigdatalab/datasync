<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/9/28
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<c:set value="1" var="currentPage" />

<html>
<head>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/default.css"/>
    <style type="text/css">
        td {
            text-align: center;
        }

        th {
            text-align: center;
        }
    </style>
</head>
<body>
    <h3>欢迎来到专题库注册页面</h3>

    <hr />

    <!--the page to add subject-->
    <a title="添加关系数据库" id="showAddSubjectDialog" data-target="#addSubjectDialog" data-toggle="modal" >
        <button>
            添加专题库<span class="glyphicon glyphicon-plus"></span>
        </button>
    </a>

    <br />
    <br />

    <!--the table to list all available subjects-->
    <div class="portlet-body">
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th style="display:none;">专题库ID</th>
                    <th>序号</th>
                    <th>专题库名称</th>
                    <th>专题库代码</th>
                    <th>管理员账号</th>
                    <th>管理员密码</th>
                    <th>专题库负责人</th>
                    <th>负责人电话</th>
                    <th>FTP账号</th>
                    <th>FTP密码</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody
                <c:forEach items="${subjectsOfThisPage}" var="subject" varStatus="vs">
                    <tr>
                        <td style="display:none;">${subject.id}</td>
                        <td>${subject.serialNo}</td>
                        <td>${subject.subjectName}</td>
                        <td>${subject.subjectCode}</td>
                        <td>${subject.admin}</td>
                        <td>${subject.adminPasswd}</td>
                        <td>${subject.contact}</td>
                        <td>${subject.phone}</td>
                        <td>${subject.ftpUser}</td>
                        <td>${subject.ftpPassword}</td>
                        <td id="${subject.id}">
                            <a title="修改" class="updateSubjectBtn" data-target="#updateSubjectDialog" data-toggle="modal">
                                <span class="glyphicon glyphicon-pencil"></span>
                            </a>
                            &nbsp;&nbsp;
                            <a title="删除" class="deleteSubjectBtn" data-target="#deleteSubjectDialog" data-toggle="modal">
                                <span class="glyphicon glyphicon-remove"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!--paging-->
    <div align="center">
        <ul class="pagination">
            <li>
                <a href="${ctx}/subjectMgmt/querySubject?currentPage=1">
                    首页
                </a>
            </li>

            <c:forEach begin="1" end="${totalPages}" step="1" varStatus="vs">
            <li>
                <a href="${ctx}/subjectMgmt/querySubject?currentPage=${vs.count}">${vs.count}</a>
                <c:set value="${vs.count}" var="currentPage" />
            </li>
            </c:forEach>

            <li>
                <a href="${ctx}/subjectMgmt/querySubject?currentPage=${totalPages}">
                    尾页
                </a>
                <c:set value="${totalPages}" var="currentPage" />
            </li>
        </ul>
    </div>

    <div id="addSubjectDialog" class="modal fade" tabindex="-1" aria-hidden="true" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForAddSubjectDialog" class="modal-title" >添加专题库</h4>
                </div>

                <form id="addSubjectForm" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" accept-charset="utf-8"  action="${ctx}/subjectMgmt/addSubject">

                <!--subject info input form-->
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="form-body">

                            <div class="form-group">
                                <label class="col-md-3 control-label" for="subjectName" style="display:none;">
                                    专题库id（不显示）
                                </label>
                                <div style="display:none;">
                                    <input type="text" class="form-control" id="id" name="id" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label" for="subjectName">
                                    专题库名称<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入专题库名称" id="subjectName" name="subjectName" required="required"/>
                                </div>
                            </div>

                            <!--SubjectCode需要保证唯一性，为了保证唯一，需要通过后端数据库交互验证是否已经存在-->
                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    专题库代码<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入专题库代码" id="subjectCode" name="subjectCode"  required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    图片<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="file" id="image" name="image" class="form-control file" placeholder="请选择一个本地图片" accept="image/gif, image/jpeg, image/png, image/jpg" required="required">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    专题库简介
                                </label>
                                <div class="col-md-9">
                                    <textarea class="form-control" placeholder="请输入专题库简介" id="brief" name="brief"></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    管理员账号<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入管理员账号" id="admin" name="admin"  required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    管理员密码<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入管理员密码" id="adminPasswd" name="adminPasswd"  required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    联系人<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入联系人姓名" id="contact" name="contact"  required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    联系电话<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入联系人电话" id="phone" name="phone"   required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    Email
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入联系人Email" id="email" name="email"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    序号<span style="color: red;">*</span>
                                </label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" placeholder="请输入序号" id="serialNo" name="serialNo" required="required" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--buttons to submit or cancel-->
                <div class="modal-footer">
                    <button id="saveSubjectAddBtn" class="btn green" type="submit">
                        保存
                    </button>
                    <button id="cancelSubjectAddBtn" class="btn default"  data-dismiss="modal">
                        取消
                    </button>
                </div>

                </form>
            </div>
        </div>
    </div>

    <div id="updateSubjectDialog" class="modal fade" tabindex="-1" aria-hidden="true" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForModifySubjectDialog" class="modal-title" >修改专题库</h4>
                </div>

                <form id="modifySubjectForm" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" accept-charset="utf-8"  action="${ctx}/subjectMgmt/addSubject">

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="form-body">

                                <div class="form-group">
                                    <label class="col-md-3 control-label" for="subjectName" style="display:none;">
                                        专题库id（不显示）
                                    </label>
                                    <div style="display:none;">
                                        <input type="text" class="form-control" id="idM" name="id" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label" for="subjectName">
                                        专题库名称<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入专题库名称" id="subjectNameM" name="subjectName" required="required"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        专题库代码<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入专题库代码" id="subjectCodeM" name="subjectCode"  required="required" readonly="readonly"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        图片<span>*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="file" id="imagePathM" name="image" class="form-control file" placeholder="请选择一个本地图片" accept="image/gif, image/jpeg, image/png, image/jpg">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        专题库简介
                                    </label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" placeholder="请输入专题库简介" id="briefM" name="brief"></textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        管理员账号<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入管理员账号" id="adminM" name="admin"  required="required" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        管理员密码<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入管理员密码" id="adminPasswdM" name="adminPasswd"  required="required" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        联系人<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入联系人姓名" id="contactM" name="contact"  required="required" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        联系电话<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入联系人电话" id="phoneM" name="phone"   required="required" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        Email
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入联系人Email" id="emailM" name="email"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label">
                                        序号<span style="color: red;">*</span>
                                    </label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="请输入序号" id="serialNoM" name="serialNo" required="required" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button id="saveSubjectModifyBtn" class="btn green" type="submit">
                            保存
                        </button>
                        <button id="cancelSubjectModifyBtn" class="btn default"  data-dismiss="modal">
                            取消
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <div id="deleteSubjectDialog" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>

                    <h5 class="modal-title">
                        删除专题库
                    </h5>
                </div>

                <div class="modal-body">
                    <h5>确认删除该专题库？</h5>
                </div>

                <div class="modal-footer">
                    <span id="idOfSubjectToBeDeleted"></span>
                    <button id="agreeDeleteBtn" class="btn green" data-dismiss="modal">确认</button>
                    <button id="cancelDeleteBtn"  class="btn default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript" src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/form-validation/form-validation.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.js"></script>

    <script type="text/javascript">
        $(".deleteSubjectBtn").click(function (){
            idOfSubjectToBeDeleted = $(this).parent().attr("id");
            console.log("在deleteSubjectBtn的click里, idOfSubjectToBeDeleted = " + idOfSubjectToBeDeleted);

            $("#agreeDeleteBtn").click(function ()
            {
                console.log("在agreeDeleteBtn的click里, idOfSubjectToBeDeleted = " + idOfSubjectToBeDeleted);

                var deleteUrl = "${ctx}/subjectMgmt/deleteSubject?id=" + idOfSubjectToBeDeleted + "&currentPage=" + ${currentPage};
                $.ajax({
                    type: "GET",
                    url: deleteUrl,
                    dataType: "text",
                    success: function (data) {
                    }
                });
            });
        });

        $(".updateSubjectBtn").click(
            function () {
                $.ajax({
                    type: "GET",
                    async: false,
                    url: '${ctx}/subjectMgmt/querySubjectById',
                    data: {id: $(this).parent().attr("id")},
                    dataType: "json",
                    success: function (data){
                        $("#idM").val(data.id);
                        $("#subjectNameM").val(data.subjectName);
                        $("#subjectCodeM").val(data.subjectCode);
                        $("#briefM").val(data.brief);
                        $("#adminM").val(data.admin);
                        $("#adminPasswdM").val(data.adminPasswd);
                        $("#contactM").val(data.contact);
                        $("#phoneM").val(data.phone);
                        $("#emailM").val(data.email);
                        $("#serialNoM").val(data.serialNo);
                    },
                    error: function(data) {
                        console.log(data);
                    }
                });
            }
        );

        $("#subjectCode").blur(function() {
            $.ajax({
                type: "GET",
                async: false,
                url: '${ctx}/subjectMgmt/querySubjectCode',
                data: {code: $(this).val()},
                dataType: "json",
                success: function (data){
                    if (data > 0)
                    {
                        alert("subjectCode必须已经存在，请另外选择一个！")
                    }
                },
                error: function(data) {
                    console.log(data);
                }
            });
        });
    </script>

</body>
</html>
