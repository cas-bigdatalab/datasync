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
    <style type="text/css">
        td {
            text-align: center;
        }

        th {
            text-align: center;
        }

        .error-message {
            color: red;
        }
    </style>
</head>
<body>
    <div class="page-content">
        <h3>欢迎来到专题库注册页面</h3>

        <hr />

        <!--the page to add subject-->
        <a title="添加专题库" id="showAddSubjectDialog" data-target="#addSubjectDialog" data-toggle="modal" >
            <span class="btn green btn-sm">
                <i class="glyphicon glyphicon-plus"></i>
                添加专题库
            </span>
        </a>

        <br />
        <br />

        <div class="table-scrollable">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th style="display:none;">专题库ID</th>
                    <th>编号</th>
                    <th>专题库名称</th>
                    <th>专题库代码</th>
                    <th>管理员账号</th>
                    <th>管理员密码</th>
                    <th>负责人</th>
                    <th>电话</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="subjectList">
                </tbody>
            </table>
        </div>

        <!--分页-->
        <div class="row margin-top-20">
            <div class="col-md-6 margin-top-10">
                当前第<span style="color:blue;" id="pageNum"></span>页,共<span style="color:blue;" id="totalPages"></span>页, 共<span style="color:blue;" id="total"></span>条数据
            </div>
            <div class="col-md-6">
                <div id="pagination" style="float: right"></div>
            </div>
        </div>

    </div>

    <script type="text/html" id="subjectListTable">
        {{each list}}
        <tr>
            <td style="display:none;">{{$value.id}}</td>
            <td style="display:none;">{{$value.serialNo}}</td>
            <td style="text-align: center;" >{{(pageNum-1)*pageSize + $index + 1}}</td>
            <td style="text-align: center">{{$value.subjectName}}</td>
            <td style="text-align: center">{{$value.subjectCode}}</td>
            <td style="text-align: center">{{$value.admin}}</td>
            <td style="text-align: center">{{$value.adminPasswd}}</td>
            <td style="text-align: center">{{$value.contact}}</td>
            <td style="text-align: center">{{$value.phone}}</td>
            <td id="{{$value.id}}">
                <button class="btn default btn-xs red updateSubjectBtn"onclick="updateSubject(this);"><i class="fa fa-edit"></i>&nbsp;修改</button>
                &nbsp;
                <button class="btn default btn-xs green deleteSubjectBtn" onclick="deleteSubject(this);"><i class="fa fa-trash"></i>&nbsp;删除</button>
            </td>
        </tr>
        {{/each}}
    </script>


    <div id="addSubjectDialog" class="modal fade" tabindex="-1" aria-hidden="true" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForAddSubjectDialog" class="modal-title" >添加专题库</h4>
                </div>

                <!--subject info input form-->
                <div class="modal-body">
                    <form id="addSubjectForm" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" accept-charset="utf-8" onfocusout="true">

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
                    </form>
                </div>

                <!--buttons to submit or cancel-->
                <div class="modal-footer">
                    <button id="saveSubjectAddBtn" class="btn green" onclick="agreeAddSubject();">
                        保存
                    </button>
                    <button id="cancelSubjectAddBtn" class="btn default"  data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="updateSubjectDialog" class="modal fade" tabindex="-1" aria-hidden="true" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForUpdateSubjectDialog" class="modal-title" >修改专题库</h4>
                </div>
                <div class="modal-body">
                    <form id="updateSubjectForm" class="form-horizontal" role="form" method="post">
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
                                图片<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="file" id="imageM" name="image" class="form-control file" placeholder="请选择一个本地图片" accept="image/gif, image/jpeg, image/png, image/jpg">
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
                                <input type="text" class="form-control" placeholder="请输入管理员账号" id="adminM" name="admin"  required="required" readonly="readonly"/>
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

                    </form>
                </div>
                <div class="modal-footer">
                    <button id="agreeUpdateSubjectBtn" class="btn green" onclick="agreeUpdateSubject();">
                        保存
                    </button>
                    <button id="cancelUpdateSubjectBtn" class="btn default"  data-dismiss="modal">
                        取消
                    </button>
                </div>
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
    <script type="text/javascript" src="${ctx}/resources/bundles/artTemplate/template.js"></script>


    <script type="text/javascript">

        $(function () {
            getSubject(1);

            var subjectValid = {
                errorElement: 'span',
                errorClass: 'error-message',
                focusInvalid: false,
                rules: {
                    subjectName: "required",
                    subjectCode: "required",
                    image: "required",
                    admin: "required",
                    adminPasswd: "required",
                    contact: "required",
                    phone: "required",
                    email: "required",
                    serialNo: "required"
                },
                messages: {
                    subjectName: "请输入专题库名称",
                    subjectCode: "请输入专题库代码",
                    image: "请选择一个图片",
                    admin: "请输入专题库管理员账号",
                    adminPasswd: "请输入专题库管理密码",
                    contact: "请输入专题库联系人",
                    phone: "请输入专题库联系人电话",
                    email: "请输入专题库联系人email",
                    serialNo: "请输入专题库的序号"
                }
            };

            $("#addSubjectForm").validate(subjectValid);
            $("#updateSubjectForm").validate(subjectValid);
        });

        //获得专题库
        function getSubject(pageNum) {
            $.ajax({
                url: "${ctx}/subjectMgmt/querySubject",
                type: "get",
                data: {
                    "pageNum": pageNum
                },
                dataType: "json",
                success: function (data) {
                    console.log("获得subject成功！");
                    console.log("success - data = " + data);

                    var html = template("subjectListTable", data);
                    $("#subjectList").empty();
                    $("#subjectList").append(html);

                    $("#pageNum").html(data.pageNum);
                    $("#totalPages").html(data.totalPages);
                    $("#total").html(data.total);

                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }

                    $('#pagination').bootpag({
                        total: data.totalPages,
                        page: data.pageNum,
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
                        getSubject(num);
                    });
                },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    console.log("textStatus = " + textStatus);
                    console.log("errorThrown = " + errorThrown);
                }
            });
        }

        //添加专题库
        function agreeAddSubject()
        {
            if (!$("#addSubjectForm").valid()) {
                return;
            }

            var formData = new FormData();

            formData.append("subjectName", $("#subjectCode").val());
            formData.append("subjectCode", $("#subjectCode").val());
            formData.append('image', $('#image').get(0).files[0]);
            formData.append('brief', $("#brief").val());
            formData.append("admin", $("#admin").val());
            formData.append("adminPasswd", $("#adminPasswd").val());
            formData.append("contact", $("#contact").val());
            formData.append("phone", $("#phone").val());
            formData.append("email", $("#email").val());
            formData.append("serialNo", $("#serialNo").val());

            $.ajax({
                url: "${ctx}/subjectMgmt/addSubject",
                type: "post",
                contentType:false,
                processData:false,
                data: formData,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $("#addSubjectDialog").modal("hide");
                    getSubject(1); //没有搜索条件的情况下，显示第一页
                    location.reload();
                },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    console.log("textStatus = " + textStatus);
                    console.log("errorThrown = " + errorThrown);
                }
            });

        }

        //更新专题库
        function updateSubject(updateBtn) {
            $.ajax({
                    type: "GET",
                    async: false,
                    url: '${ctx}/subjectMgmt/querySubjectById',
                    data: {id: $(updateBtn).parent().attr("id")},
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

                        $("#updateSubjectDialog").modal("show");
                    },
                    error: function(data) {
                        console.log(data);
                    }
                });

            $("#agreeUpdateSubjectBtn").click(agreeUpdateSubject());
        }
        function agreeUpdateSubject()
        {
            if (!$("#updateSubjectForm").valid()) {
                return;
            }

            var formData = new FormData();
            formData.append("subjectName", $("#subjectNameM").val());
            formData.append("subjectCode", $("#subjectCodeM").val());


            console.log($('#imageM').get(0).files);

            if ($('#imageM').get(0).files.length == 0)
            {
                console.log("$('#imageM').get(0).files.length == 0 : ");
                formData.append('image', null);
            }
            else
            {
                formData.append('image', $('#imageM').get(0).files[0]);
            }
            formData.append('brief', $("#briefM").val());
            formData.append("admin", $("#adminM").val());
            formData.append("adminPasswd", $("#adminPasswdM").val());
            formData.append("contact", $("#contactM").val());
            formData.append("phone", $("#phoneM").val());
            formData.append("email", $("#emailM").val());
            formData.append("serialNo", $("#serialNoM").val());

            console.log("agreeUpdateSubject - formData = " + formData);

            $.ajax({
                url: "${ctx}/subjectMgmt/updateSubject",
                type: "post",
                contentType:false,
                processData:false,
                data: formData,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $("#updateSubjectDialog").modal("hide");
                    getSubject(1); //没有搜索条件的情况下，显示第一页
                    location.reload();
                },
                error: function(data) {

                }
            });
        }


        //删除专题库
        function deleteSubject(deleteBtn)
        {
            $("#deleteSubjectDialog").modal("show");
            idOfSubjectToBeDeleted = $(deleteBtn).parent().attr("id");

            console.log("idOfSubjectToBeDeleted = " + idOfSubjectToBeDeleted);

            $("#agreeDeleteBtn").click(
                agreeDeleteSubject(idOfSubjectToBeDeleted)
            );
        };
        function agreeDeleteSubject(id)
        {
            $("#deleteUserDialog").modal("hide");

            var deleteUrl = "${ctx}/subjectMgmt/deleteSubject?id=" + id + "&pageNum=" + 1;
            $.ajax({
                type: "GET",
                url: deleteUrl,
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    getSubject(1);
                },
                error: function(data)
                {
                    console.log(data);
                }
            });
        }

        //subjectCode唯一性
        $("#subjectCode").blur(function() {
            $.ajax({
                type: "GET",
                async: false,
                url: '${ctx}/subjectMgmt/querySubjectCode',
                data: {code: $(this).val()},
                dataType: "text",
                success: function (data){
                    var cntOfSubjectCode = parseInt(data);
                    if (cntOfSubjectCode > 0)
                    {
                        alert("subjectCode已经存在，请另外选择一个！")
                    }
                },
                error: function(data) {
                    console.log(data);
                }
            });
        });

        //用户名唯一性
        $("#admin").blur(function() {
            $.ajax({
                type: "GET",
                async: false,
                url: '${ctx}/subjectMgmt/queryAdmin',
                data: {admin: $(this).val()},
                dataType: "text",
                success: function (data){
                    var cntOfAdmin = parseInt(data);
                    if (cntOfAdmin > 0)
                    {
                        alert("admin已经存在，请另外选择一个！")
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
