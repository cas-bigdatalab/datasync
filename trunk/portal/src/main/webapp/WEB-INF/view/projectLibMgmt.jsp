<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/9/28
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>
<head>
    <title>Title</title>

    <link id="style_color" href="${ctx}/resources/css/default.css" rel="stylesheet" type="text/css"/>
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

    <!--添加专题库页面-->
    <a id="showAddProjectLibDialog" data-target="#addProjectLib" data-toggle="modal" title="添加关系数据库">
        <button>
            添加专题库
            <i class="glyphicon glyphicon-plus"></i>
        </button>
    </a>

    <br />
    <br />

    <!--专题库列表主体-->
    <div class="portlet-body">
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <td>编号</td>
                    <td>专题库名称</td>
                    <td>专题库代码</td>
                    <td>专题库简介</td>
                    <td>专题库负责人</td>
                    <td>负责人电话</td>
                    <td>负责人地址</td>
                    <td>管理员账号</td>
                    <td>FTP账号</td>
                    <td>FTP密码</td>
                    <td>操作</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>projectLib1</td>
                    <td>projectLibCode</td>
                    <td>projectLibIntro</td>
                    <td>projectLibAdmin</td>
                    <td>adminPhone</td>
                    <td>adminAddress</td>
                    <td>adminAccount</td>
                    <td>ftpAccount</td>
                    <td>ftpPassword</td>
                    <td id="${ds.dataSourceId}">
                        <a title="修改" href="#modifyProjectLib" class="updateButton">
                            <i class="glyphicon glyphicon-pencil"></i>
                        </a>
                        &nbsp;&nbsp;
                        <a title="删除" class="deleteButton" data-target="#deleteProjectLib" data-toggle="modal">
                            <i class="glyphicon glyphicon-remove"></i>
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!--专题库分页按钮-->
    <div align="center">
        <ul class="pagination">
            <!--到首页-->
            <li>
                <a href="${ctx}/projectLib/projectLibMgmt?currentPage=1">
                    首页
                </a>
            </li>

            <c:forEach begin="1" end="${totalPages}" step="1" varStatus="vs">
                <li>
                    <a href="${ctx}/projectLib/projectLibMgmt?currentPage=${vs.count}">${vs.count}</a>
                </li>
            </c:forEach>

            <!--到尾页-->
            <li>
                <a href="${ctx}/projectLib/projectLibMgmt?currentPage=${totalPages}">
                    尾页
                </a>
            </li>
        </ul>
    </div>

    <!--添加专题库的弹出对话框-->
    <div id="addProjectLib" class="modal fade" tabindex="-1" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <!--添加专题库对话框的标题，包括标题文字和一个右上角的关闭按钮-->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="false"> </button>

                    <h4 class="modal-title" id="titleForAddProjectLibDialog">添加专题库</h4>
                </div>
                <!--专题库信息输入表单-->
                <div class="form">
                    <form class="form-horizontal" role="form" action="addProjectLib" method="post" accept-charset="utf-8" id="projectLibInfoForm">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-body">
                                        <!--专题库名称-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                专题库名称
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                       id="projectLibName" name="projectLibName"/>
                                            </div>
                                        </div>

                                        <!--专题库代码-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                专题库代码
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="请输入专题库代码"
                                                       id="projectLibCode" name="projectLibCode"/>
                                            </div>
                                        </div>

                                        <!--专题库简介-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                专题库简介
                                            </label>
                                            <div class="col-md-9">
                                                <textarea class="form-control" placeholder="请输入专题库简介"
                                                    id="projectLibIntro" name="projectLibIntro">
                                                </textarea>
                                            </div>
                                        </div>

                                        <!--专题库负责人-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                专题库负责人
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="请输入专题库负责人姓名"
                                                       id="projectLibAdmin"
                                                       name="projectLibAdmin"/>
                                            </div>
                                        </div>

                                        <!--专题库负责人电话-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                负责人电话
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="请输入负责人电话"
                                                       id="adminPhone"
                                                       name="adminPhone" />
                                            </div>
                                        </div>

                                        <!--专题库负责人地址-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">负责人地址</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="请输入专题库负责人地址"
                                                       id="adminAddress"
                                                       name="adminAddress"/>
                                            </div>
                                        </div>

                                        <!--专题库管理员账号-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                管理员账号
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="Password"
                                                           id="adminAccount"
                                                           name="adminAccount" />
                                                </div>
                                            </div>
                                        </div>

                                        <!--专题库ftp账号-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                FTP账号
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="请输入FTP账号"
                                                           id="ftpAccount"
                                                           name="ftpAccount" />
                                                </div>
                                            </div>
                                        </div>

                                        <!--专题库ftp密码-->
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">
                                                FTP账号
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="请输入FTP密码"
                                                           id="ftpPassword"
                                                           name="ftpPassword" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--信息提交按钮-->
                        <div class="modal-footer">
                            <button type="submit" class="btn green" id="saveButton" disabled=true>
                                保存
                            </button>
                            <button type="button" data-dismiss="modal" class="btn default">
                                取消
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--删除数据源-->
    <div class="modal fade" id="deleteProjectLib" tabindex="-1" role="basic" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title" align="center">确认删除该专题库？</h4><br>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn default" data-dismiss="modal"><a id="confirmDelete" href="">确认</a></button>
                    <button type="button" class="btn default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/form-validation/form-validation.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/regex.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/metaForm.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/metaFormCheck.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/wizardInit.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/resources/js/dataResourceRegister.js"></script>

    <script type="text/javascript">
        var ctx = '${ctx}';

        $("#showRelationalDatabaseForm").click(function () {
                $("#dataSourceId").val("0");
                $("#dataSourceName").val("");
                $("#databaseName").val("");
                $("#databaseType").val("");
                $("#host").val("");
                $("#port").val("");
                $("#userName").val("");
                $("#password").val("");
                $("#databaseInfo").show();
                $("#xmlInfo").hide();
                $("#unsavedValidateButton").show();
                $("#saveButton").attr("disabled", true);
                $("#relationalDatabaseForm").attr("action", "addRelationalDatabase");
                $("#relationalDatabaseModalTitle").html("添加关系数据库");
            }
        );

        $("#databaseType").change(function () {
            if ($("#databaseType").val() == 'xml') {
                $("#databaseInfo").hide();
                $("#xmlInfo").show();
//                $("#unsavedValidateButton").hide();
//                $("#saveButton").removeAttr("disabled");
            } else {
                $("#databaseInfo").show();
                $("#xmlInfo").hide();
//                $("#unsavedValidateButton").show();
//                $("#saveButton").attr("disabled", true);
            }
        });

        $("#displayRelationalDatabaseForm").click(function () {
                $("#addRelationalDatabaseForm").attr("style", "display:none");
            }
        );

        $(".updateButton").click(function () {
                $("#addRelationalDatabaseForm").attr("style", "display:");
                $.ajax({
                    type: "GET",
                    url: '${ctx}/findRelationalDatabaseById',
                    data: {dataSourceId: $(this).parent().attr("id")},
                    dataType: "json",
                    success: function (data) {
                        $("#showRelationalDatabaseForm").click();
                        $("#dataSourceId").val(data.dataSourceId);
                        $("#dataSourceName").val(data.dataSourceName);
                        $("#databaseName").val(data.databaseName);
                        $("#databaseType").val(data.databaseType);
                        $("#host").val(data.host);
                        $("#port").val(data.port);
                        $("#userName").val(data.userName);
                        $("#password").val(data.password);
                        $("#filePath").val(data.filePath);
                        $("#databaseType").trigger('change');
                        $("#relationalDatabaseForm").attr("action", "updateRelationalDatabase");
                        $("#relationalDatabaseModalTitle").html("修改关系数据库");

                    },
                });
            }
        );

        $(".deleteButton").click(function () {
            $("#confirmDelete").attr("href", "${ctx}/deleteRelationalDatabase?dataSourceId=" + $(this).parent().attr("id"));
        });

        $("#password,#userName,#port,#host").bind('input propertychange', function () {
            $("#saveButton").attr("disabled", true);
        });

        var FormValidation = function () {

            var handleValidation3 = function () {
                // for more info visit the official plugin documentation:
                // http://docs.jquery.com/Plugins/Validation

                var form3 = $('#relationalDatabaseForm');
                var error3 = $('.alert-danger', form3);
                var success3 = $('.alert-success', form3);

                form3.validate({
                    errorElement: 'span', //default input error message container
                    errorClass: 'help-block help-block-error', // default input error message class
                    focusInvalid: false, // do not focus the last invalid input
                    ignore: "", // validate all fields including form hidden input
                    rules: {
                        dataSourceName: {
                            required: true
                        },
                        databaseName: {
                            required: true
                        },
                        databaseType: {
                            required: true,
                        },
                        host: {
                            required: true,
                        },
                        port: {
                            required: true,
                        }
                    },

                    messages: { // custom messages for radio buttons and checkboxes
                        resourceType: {
                            required: "选择数据资源类型"
                        },
                        packType: {
                            required: "选择封装类型"
                        },
                        generateType: {
                            required: "选择生成关系数据表方式"
                        }
                    },

                    errorPlacement: function (error, element) { // render error placement for each input type
                        if (element.parent(".input-group").size() > 0) {
                            error.insertAfter(element.parent(".input-group"));
                        } else if (element.attr("data-error-container")) {
                            error.appendTo(element.attr("data-error-container"));
                        } else if (element.parents('.radio-list').size() > 0) {
                            error.appendTo(element.parents('.radio-list').attr("data-error-container"));
                        } else if (element.parents('.radio-inline').size() > 0) {
                            error.appendTo(element.parents('.radio-inline').attr("data-error-container"));
                        } else if (element.parents('.checkbox-list').size() > 0) {
                            error.appendTo(element.parents('.checkbox-list').attr("data-error-container"));
                        } else if (element.parents('.checkbox-inline').size() > 0) {
                            error.appendTo(element.parents('.checkbox-inline').attr("data-error-container"));
                        } else {
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        }
                    },

                    invalidHandler: function (event, validator) { //display error alert on form submit
                        success3.hide();
                        error3.show();
                        Metronic.scrollTo(error3, -200);
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
                        success3.show();
                        error3.hide();
                        form[0].submit(); // submit the form
                    }

                });

                //apply validation on select2 dropdown value change, this only needed for chosen dropdown integration.
                $('.select2me', form3).change(function () {
                    form3.validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
                });

                // initialize select2 tags
                $("#select2_tags").change(function () {
                    form3.validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
                }).select2({
                    tags: ["red", "green", "blue", "yellow", "pink"]
                });

                //initialize datepicker
                $('.date-picker').datepicker({
                    rtl: Metronic.isRTL(),
                    autoclose: true
                });
                $('.date-picker .form-control').change(function () {
                    form3.validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
                })
            }


            return {
                //main function to initiate the module
                init: function () {
                    handleValidation3();
                }
            };
        }();
    </script>
</div>

</html>
