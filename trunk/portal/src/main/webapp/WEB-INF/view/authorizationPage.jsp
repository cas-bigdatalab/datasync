<%--
  Created by IntelliJ IDEA.
  User: caohq
  Date: 2019/4/24
  Time: 16:32
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-fileinput/css/fileinput.min.css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
    <style>
        div.form td, div.form th {
            font-size: 16px;
            color: #282828;
            font-weight: normal;
        }

        table.list td, table.list th {
            padding: 14px !important;
            border-bottom: #edefee 1px solid;
            border-top: none !important;
        }

        div.form {
            padding: 25px !important;
        }
        .select2-search-choice{
            margin: 5px 0 3px 5px !important;
        }

        .table > tbody > tr > th{
            vertical-align: middle !important;
        }
    </style>

</head>
<body>

<shiro:hasRole name="admin">
    <div class="form">
        <table class="table list">
            <tbody>
            <tr>
                <th>主题库名称:</th>
                <td>${subject.subjectName}</td>
            </tr>
            <tr>
                <th>已有用户</th>
                <td>
                    <div class="col-sm-8" style="padding-top: 7px;" >
                        <select class='form-control select2me' name='users' id='users' multiple>
                            <c:forEach  var="item"  items="${list}">
                                <option value="${item.id}" id="${item.id}" >${item.userName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th>主题库代码:</th>--%>
                <%--<td>${subject.subjectCode}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>管理员账号:</th>--%>
                <%--<td>${subject.admin}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>联系人:</th>--%>
                <%--<td>${subject.contact}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>电话:</th>--%>
                <%--<td>${subject.phone}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>邮箱:</th>--%>
                <%--<td>${subject.email}</td>--%>
            <%--</tr>--%>
            <tr>
                <th>描述:</th>
                <td>${subject.brief}</td>
            </tr>
            <tr style="display: none">
                <th>描述:</th>
                <td id="">${subject.id}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <span id="subjectId" hidden>${subject.id}</span>
    <input type="hidden" id="spanGroupId">
</shiro:hasRole>
<script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/context/context.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-fileinput/js/locals/zh.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/layerJs/layer.js"></script>
<script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
<script type="text/javascript">
    addUserData("5cb926cec2257c76cf585954")//($("#subjectId")[0].textContent);
    var groupUsersSelect2;
    groupUsersSelect2 = $('#users').select2({
        placeholder: "请选择用户",
        allowClear: true
    });


    <!--用户组中增加用户界面-->
    function addUserData(id) {
        $.ajax({
            type: "GET",
            url: '${ctx}/group/info',
            data: {"id": id},
            dataType: "json",
            success: function (data) {
                console.log(data);
                $("#spanGroupId").val(data.group.id);
                 console.log(JSON.stringify(data.group.users));
                $("#users").val(data.group.users).select2();
            }
        });
    }

    <!--用户组中增加用户信息确认 -->
    function submitAddUser() {
        console.log("id=" +$("#spanGroupId").val());
        $.ajax({
            type: "POST",
            url: '${ctx}/group/updateUsers',
            traditional: true,
            data: {
                "id": $("#spanGroupId").val(),
                "users": $("#users").val()
            },
            dataType: "json",
            success: function (data) {
                if (data.result == 'ok') {
                    if(userNmu> $("#users option:selected").length){
                        toastr["success"]("删除成功！");
                    }else if(userNmu< $("#users option:selected").length){
                        toastr["success"]("添加成功！");
                    }

                } else {
                    toastr["error"]("操作失败！");
                }
                userNmu= $("#users option:selected").length;
            }
        });
    }

    var userNmu= $("#users option:selected").length;

     $("select#users").click(function(){
         submitAddUser();
     });
</script>

</body>

<%--js 开始--%>




<%--js结束--%>


</html>