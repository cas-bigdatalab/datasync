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
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>用户组管理</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="page-content" style="min-height: 650px;">
    <h3><b>用户组管理</b></h3>
    <div class="col-md-12">
        <div class="tabbable-custom ">
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

            <div class="tab-content">
                <div class="tab-pane active" id="userContent" style="min-height: 400px">
                    <div class="row">
                        <div class="col-xs-12 col-md-12 col-lg-12">

                            <div class="alert alert-info" role="alert">
                                <!--查询条件 -->
                                <div class="row">
                                    <div class="col-md-12">

                                        <label class="control-label">用户账号</label>
                                        <input type="text" id="account" name="account" placeholder="用户账号" class="input-small search-text">
                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                        <label class="control-label">用户名</label>
                                        <input type="text" id="userName" name="userName" placeholder="用户名" class="input-small search-text">
                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                        <label class="control-label">用户组</label>
                                        <input type="text" id="group" name="group" placeholder="用户组" class="input-small search-text">
                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                        <button id="userSearch" name="userSearch" onclick="search();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查询</button>
                                        &nbsp;&nbsp;
                                        <button id="userAdd" name="userAdd" onclick="" class="btn info green btn-sm"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新建用户</button>
                                    </div>
                                </div>
                            </div>
                            <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                    <tr>
                                        <th style="width: 5%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">编号</th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户名 </th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">账号 </th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</th>

                                        <th style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">状态</th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户组</th>
                                        <th style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="userList">
                                        <td style="width: 5%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">编号</td>
                                        <td style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户名 </td>
                                        <td style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">账号 </td>
                                        <td style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</td>

                                        <td style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">状态</td>
                                        <td style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">用户组</td>
                                        <td style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">操作</td>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row margin-top-20">
                                <div class="col-md-6 margin-top-10">
                                    当前第<span style="color:blue;" id="currentPageNum"></span>页,共<span style="color:blue;" id="pageCnt"></span>页, 共<span style="color:blue;" id="totalCnt"></span>条数据
                                </div>
                                <div class="col-md-6">
                                    <div id="pagination1" style="float: right"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

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
                                        <th style="width: 25%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">描述</th>
                                        <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</th>
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


<script type="text/html" id="userListTable">
    {{each list}}
    <tr>
        <td style="text-align: center">{{(currentPage-1)*pageSize+$index+1}}</td>
        <td><a href="javascript:editData('{{$value.id}}');">{{$value.groupName}}</a>
        </td>
        <td style="text-align: center">{{$value.desc}}</td>
        <td style="text-align: center">{{dateFormat($value.createTime)}}</td>
        <td id="{{$value.id}}" style="text-align: center">
            <%--<button class="btn default btn-xs green-stripe" onclick="viewData()">查看</button>&nbsp;&nbsp;--%>
            <button class="btn default btn-xs purple updateButton" onclick="editData('{{$value.id}}')"><i class="fa fa-edit"></i>&nbsp;&nbsp;修改</button>&nbsp;&nbsp;
            <button class="btn default btn-xs red" onclick="deleteData('{{$value.id}}')"><i class="fa fa-trash"></i>&nbsp;&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>


<script type="text/html" id="groupTmpl">
    {{each list}}
    <tr>
        <td style="text-align: center">{{(currentPage-1)*pageSize+$index+1}}</td>
        <td><a href="javascript:editData('{{$value.id}}');">{{$value.groupName}}</a>
        </td>
        <td style="text-align: center">{{$value.desc}}</td>
        <td style="text-align: center">{{dateFormat($value.createTime)}}</td>
        <td id="{{$value.id}}" style="text-align: center">
            <%--<button class="btn default btn-xs green-stripe" onclick="viewData()">查看</button>&nbsp;&nbsp;--%>
            <button class="btn default btn-xs purple updateButton" onclick="editData('{{$value.id}}')"><i class="fa fa-edit"></i>&nbsp;&nbsp;修改</button>&nbsp;&nbsp;
            <button class="btn default btn-xs red" onclick="deleteData('{{$value.id}}')"><i class="fa fa-trash"></i>&nbsp;&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScriptForGroup">
    <script src="${ctx}/resources/bundles/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script src="${ctx}/resources/js/subStrLength.js"></script>
    <script src="${ctx}/resources/js/regex.js"></script>
    <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var currentPageNo = 1;

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
        });

        function search() {
            getData(1);
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
                        url: ctx + "/resource/delete/" + id,
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
    </script>
</div>

</html>
