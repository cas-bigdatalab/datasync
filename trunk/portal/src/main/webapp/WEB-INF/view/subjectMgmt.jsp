<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <style type="text/css">
        td {
            text-align: center;
        }

        th {
            text-align: center;
            color: #FFF;
            font-weight: bold;
        }

        .error-message {
            color: red;
        }
    </style>
</head>

<body>
    <div class="page-content">
        <h3>数据节点管理</h3>
        <hr />

        <!--数据节点筛选条件-->
        <div class="alert alert-info" role="alert">
            <div class="row">
                <div class="col-md-12 form-inline">
                    <label class="control-label">数据节点名称:</label>
                    <input type="text" id="subjectNameFilter" name="subjectNameFilter" placeholder="数据节点名称" class="form-control search-text" style="width: 300px;" />

                    &nbsp;&nbsp;&nbsp;&nbsp;

                    <button id="searchSubjectBtn" name="searchSubjectBtn" onclick="searchSubject();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <button id="addSubjectBtn" name="addSubjectBtn" class="btn info green btn-sm" onclick="addSubject()"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增数据节点</button>
                </div>
            </div>
        </div>

        <!--数据节点列表页面-->
        <div class="table-scrollable">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                    <tr>
                        <th style="display:none;">数据节点ID</th>
                        <th style="width: 3%;background: #64aed9;">编号</th>
                        <th style="width: 5%;background: #64aed9;">数据节点名称</th>
                        <th style="width: 5%;background: #64aed9;">数据节点代码</th>
                        <th style="width: 5%;background: #64aed9;">管理员账号</th>
                        <th style="width: 5%;background: #64aed9;">负责人</th>
                        <th style="width: 5%;background: #64aed9;">电话</th>
                        <th style="width: 10%;background: #64aed9;">操作</th>
                    </tr>
                </thead>
                <tbody id="subjectList">
                </tbody>
            </table>
        </div>

        <!--数据节点分页插件-->
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
            <td style="text-align: center">{{$value.contact}}</td>
            <td style="text-align: center">{{$value.phone}}</td>
            <td id="{{$value.id}}">
                <button class="btn default btn-xs purple updateSubjectBtn"onclick="updateSubject(this);"><i class="fa fa-edit"></i>&nbsp;修改</button>
                &nbsp;
                <button class="btn default btn-xs red deleteSubjectBtn" onclick="deleteSubject(this);"><i class="fa fa-trash"></i>&nbsp;删除</button>
            </td>
        </tr>
        {{/each}}
    </script>

    <div id="addSubjectDialog" class="modal fade" tabindex="-1" aria-hidden="true" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForAddSubjectDialog" class="modal-title" >新增数据节点</h4>
                </div>

                <!--subject info input form-->
                <div class="modal-body">
                    <form id="addSubjectForm" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" accept-charset="utf-8" onfocusout="true">

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectName">
                                数据节点名称<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入数据节点名称" id="subjectName" name="subjectName" required="required"/>
                            </div>
                        </div>

                        <!--SubjectCode需要保证唯一性，为了保证唯一，需要通过后端数据库交互验证是否已经存在-->
                        <div class="form-group">
                            <label class="col-md-3 control-label">
                                数据节点代码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入数据节点代码" id="subjectCode" name="subjectCode"  required="required" />
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
                                数据节点简介
                            </label>
                            <div class="col-md-9">
                                <textarea class="form-control" placeholder="请输入数据节点简介" id="brief" name="brief"></textarea>
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
                                <input type="text" class="form-control" placeholder="请输入序号，只能输入数字" id="serialNo" name="serialNo" required="required" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
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
                <div class="modal-header bg-primary">
                    <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                    <h4 id="titleForUpdateSubjectDialog" class="modal-title" >修改数据节点</h4>
                </div>
                <div class="modal-body">
                    <form id="updateSubjectForm" class="form-horizontal" role="form" method="post">
                        <div class="form-group">
                                <label class="col-md-3 control-label" for="subjectName" style="display:none;">
                                    数据节点id（不显示）
                                </label>
                                <div style="display:none;">
                                    <input type="text" class="form-control" id="idM" name="id" />
                                </div>
                            </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectName">
                                数据节点名称<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入数据节点名称" id="subjectNameM" name="subjectName" required="required"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">
                                数据节点代码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入数据节点代码" id="subjectCodeM" name="subjectCode"  required="required" readonly="readonly"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">
                                图片
                            </label>
                            <div class="col-md-9">
                                <input type="file" id="imageM" name="image" class="form-control file" placeholder="请选择一个本地图片" accept="image/gif, image/jpeg, image/png, image/jpg">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">
                                数据节点简介
                            </label>
                            <div class="col-md-9">
                                <textarea class="form-control" placeholder="请输入数据节点简介" id="briefM" name="brief"></textarea>
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
                                序号
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入序号，只能输入数字" id="serialNoM" name="serialNo" readonly="readonly" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
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

    <%--<div id="deleteSubjectDialog" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>

                    <h5 class="modal-title">
                        删除数据节点
                    </h5>
                </div>

                <div class="modal-body">
                    <h5>确认删除该数据节点？</h5>
                </div>

                <div class="modal-footer">
                    <span id="idOfSubjectToBeDeleted"></span>
                    <button id="agreeDeleteBtn" class="btn green" data-dismiss="modal">确认</button>
                    <button id="cancelDeleteBtn"  class="btn default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>--%>


    <!--为了加快页面加载速度，请把js文件放到这个div里-->
    <div>
        <script type="text/javascript" src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/form-validation/form-validation.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/artTemplate/template.js"></script>
        <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
        <script type="text/javascript">
            var nextSerialNo = 1;
            var currentPage = 1;

            //初始化
            $(function () {
                console.log("数据节点页面初始化");
                getSubject(1);

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

                //新建、修改数据节点对话框的验证
                var addSubjectValid = {
                    errorElement: "span",
                    errorClass: "error-message",
                    focusInvalid: false,
                    rules: {
                        subjectName: "required",
                        subjectCode: {
                            required: true,
                            remote:
                                {
                                    url: "${ctx}/subjectMgmt/querySubjectCode",
                                    type: "get",
                                    data:
                                        {
                                            'subjectCode': function()
                                            {
                                                return $("#subjectCode").val();
                                            }
                                        },
                                    dataType: "json"
                                }
                        },
                        image: "required",
                        admin: {
                            required: true,
                            remote:
                                {
                                    url: "${ctx}/subjectMgmt/queryAdmin",
                                    type: "get",
                                    data:
                                        {
                                            'admin': function()
                                            {
                                                return $("#admin").val();
                                            }
                                        },
                                    dataType: "json"
                                }
                        },
                        adminPasswd: "required",
                        contact: "required",
                        phone:
                        {
                            required: true,
                            maxlength:11,
                            maxlength:11,
                            isphoneNum:true
                        },
                        email: {
                            required: false,
                            email: true
                        },
                        serialNo: "required"
                    },
                    messages: {
                        subjectName: "请输入数据节点名称",
                        subjectCode: {
                            required: "请输入数据节点代码",
                            remote: "此数据节点代码已经存在！"
                        },
                        image: "请选择一个图片",
                        admin: {
                            required: "请输入数据节点管理员账号",
                            remote: "此数据节点管理员账号已经存在！"
                        },
                        adminPasswd: "请输入数据节点管理密码",
                        contact: "请输入数据节点联系人",
                        phone: {
                            required:"请输入手机号",
                            maxlength:"请填写11位的手机号",
                            minlength:"请填写11位的手机号",
                            isphoneNum:"请填写正确的手机号码"
                        },
                        email: "请输入一个正确的email",
                        serialNo: "请输入数据节点的序号"
                    }
                };

                jQuery.validator.addMethod("isphoneNum", function(value, element) {
                    debugger
                    var length = value.length;
                    var mobile = /^1[0-9]{1}[0-9]{9}$/;
                    return this.optional(element) || (length == 11 && mobile.test(value));
                }, "请填写正确的手机号码");

                var updateSubjectValid = {
                    errorElement: 'span',
                    errorClass: 'error-message',
                    focusInvalid: false,
                    rules: {
                        subjectName: "required",
                        subjectCode: "required",
                        admin: "required",
                        adminPasswd: "required",
                        contact: "required",
                        phone:
                            {
                                required: true,
                                maxlength:11,
                                maxlength:11,
                                isphoneNum:true
                            },
                        email: {
                            required: false,
                            email: true
                        },
                        serialNo: "required"
                    },
                    messages: {
                        subjectName: "请输入数据节点名称",
                        subjectCode: "请输入数据节点代码",
                        admin: "请输入数据节点管理员账号",
                        adminPasswd: "请输入数据节点管理密码",
                        contact: "请输入数据节点联系人",
                        phone: {
                            required:"请输入手机号",
                            maxlength:"请填写11位的手机号",
                            minlength:"请填写11位的手机号",
                            isphoneNum:"请填写正确的手机号码"
                        },
                        email: "请输入一个正确的email",
                        serialNo: "请输入数据节点的序号"
                    }
                };
                $("#addSubjectForm").validate(addSubjectValid);
                $("#updateSubjectForm").validate(updateSubjectValid);
            });

            //数据节点名称的模糊搜索
            function searchSubject()
            {
                getSubject(1);
            }

            //查询数据节点
            function getSubject(pageNum) {
                console.log("getSubject请求已经发送了");
                $.ajax({
                    url: "${ctx}/subjectMgmt/querySubject",
                    type: "get",
                    data: {
                        "subjectNameFilter": $("#subjectNameFilter").val().trim(),
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
                        currentPage = pageNum;
                        $("#totalPages").html(data.totalPages);
                        $("#total").html(data.total);

                        //分页
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
                            currentPage = num;
                        });
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        console.log("textStatus = " + textStatus);
                        console.log("errorThrown = " + errorThrown);
                    }
                });
            }

            function addSubject()
            {
                $.ajax({
                    url: "${ctx}/subjectMgmt/getNextSerialNo",
                    type: "get",
                    data: {},
                    dataType: "json",
                    success: function (data) {
                        $("#serialNo").val(data);
                        $("#addSubjectDialog").modal("show");
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        console.log("textStatus = " + textStatus);
                        console.log("errorThrown = " + errorThrown);
                    }
                });
            }

            //添加数据节点
            function agreeAddSubject()
            {
                if (!$("#addSubjectForm").valid()) {
                    return;
                }

                var formData = new FormData();

                formData.append("subjectName", $("#subjectName").val());
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

            //更新数据节点
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
                        $("#imageM").attr("src", data.imagePath)
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
            }
            function agreeUpdateSubject()
            {
                if (!$("#updateSubjectForm").valid()) {
                    return;
                }

                var formData = new FormData();
                formData.append("id", $("#idM").val());
                formData.append("subjectName", $("#subjectNameM").val());
                formData.append("subjectCode", $("#subjectCodeM").val());
                formData.append('image', $('#imageM').get(0).files[0]);
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

            //删除数据节点
            function deleteSubject(deleteBtn)
            {
                var id = $(deleteBtn).parent().attr("id");

                console.log("idOfSubjectToBeDeleted = " + id);

                bootbox.confirm("确定要删除此条记录吗？",
                    function (result)
                    {
                        if (result) {
                            var deleteUrl = "${ctx}/subjectMgmt/deleteSubject?id=" + id + "&pageNum=" + 1;
                            $.ajax({
                                url: deleteUrl,
                                type: "get",
                                dataType: "text",
                                success: function (data) {
                                    console.log(data);
                                    console.log("typeof data = " + (typeof data));
                                    if (data.trim() == "1") {
                                        toastr["success"]("删除成功！", "数据删除");
                                        getSubject(currentPage);
                                    }
                                    else {
                                        toastr["error"]("删除失败！", "数据删除");
                                    }
                                },
                                error: function(data)
                                {
                                    console.log(data);
                                    toastr["error"]("删除失败！", "数据删除");
                                }
                            });
                        }
                    }
                );
            }

        </script>
    </div>
</body>


</html>
