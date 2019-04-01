<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/09/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>数据资源汇聚传输工具</title>
    <link href="${ctx}/resources/css/projectMessage.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .form-group div{
            font-size: 18px;
        }
        div.form {
            background: #fff;
            padding: 25px !important;
        }
        .table {
            max-width: 100%;
            margin-bottom: 20px !important;
        }
        table {
            border-spacing: 0;
            border-collapse: collapse;
        }
        table.list td, table.list th {
            padding: 14px !important;
            border-bottom: #edefee 1px solid;
            border-top: none !important;
        }

        table.list th {
            width: 160px;
        }
        div.form th {
            text-align: right;
            /*width: 120px;*/
        }
        div.form td, div.form th {
            font-size: 14px !important;
            color: #282828;
            font-weight: normal;
            padding: 12px;
        }
        .row h4 {
            font-size: 18px;
            color: #1a8651;
            margin: 0px auto ;
        }
        .alert-info {
            background-color: #e0e0e0 !important;
            border: none !important;
            border-left: #0e6445 8px solid !important;
        }

    </style>
</head>

<body>

<div class="page-content">

    <%--<div class="source-head">--%>
        <%--<h3 style="font-size: 17px !important;">数据节点信息</h3>--%>
        <%--&lt;%&ndash;<hr>&ndash;%&gt;--%>
    <%--</div>--%>
    <div class="alert alert-info" role="alert" style="padding: 12px 20px !important;margin-top: 12px;">
        <!--查询条件 -->
        <div class="row" style="margin: 5px auto;">
            <h4 style="font-weight: 500 !important;">数据节点信息认证管理</h4>
        </div>
    </div>

    <%--<div class="task-title" style="margin-top: 4% !important;">--%>
        <%--<span>数据节点信息认证管理</span>--%>
    <%--</div>--%>
    <div class="form">
        <table class="table list">
            <tbody><tr>
                <th>数据节点名称：</th>
                <td>${subject.subjectName}</td>
            </tr><tr>
                <th>数据节点代码：</th>
                <td>${subject.subjectCode}</td></tr>
            <tr>
                <th>管理员账号：</th>
                <td>${subject.admin}</td>
            </tr>
            <tr>
                <th>密码：</th>
                <td>${subject.adminPasswd}</td>
            </tr>
            <tr>
                <th>联系人：</th>
                <td>${subject.contact}</td>
            </tr>
            <tr>
                <th>电话：</th>
                <td>${subject.phone}</td>
            </tr>
            <tr>
                <th>邮箱：</th>
                <td>${subject.email}</td>
            </tr>
            <tr>
                <th>FTP用户名：</th>
                <td>${subject.ftpUser}</td>
            </tr>
            <tr>
                <th>FTP密码：</th>
                <td>${subject.ftpPassword}</td>
            </tr>
            <tr>
                <th>描述：</th>
                <td>${subject.brief}</td></tr>

            </tbody></table>
    </div>

    <%--<div class="messageCon" style="top: 20% !important;" >--%>

        <%--<form class="form-horizontal">--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">数据节点名称:</label>--%>
                <%--<div class="col-sm-8">${subject.subjectName}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">数据节点代码 :</label>--%>
                <%--<div class="col-sm-8">${subject.subjectCode}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">管理员账号:</label>--%>
                <%--<div class="col-sm-8">${subject.admin}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">密码:</label>--%>
                <%--<div class="col-sm-8">${subject.adminPasswd}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">联系人:</label>--%>
                <%--<div class="col-sm-8">${subject.contact}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">电话:</label>--%>
                <%--<div class="col-sm-8">${subject.phone}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">邮箱:</label>--%>
                <%--<div class="col-sm-8">${subject.email}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">FTP用户名:</label>--%>
                <%--<div class="col-sm-8">${subject.ftpUser}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">FTP密码:</label>--%>
                <%--<div class="col-sm-8">${subject.ftpPassword}</div>--%>
            <%--</div>--%>

            <%--<div class="form-group">--%>
                <%--<label  class="col-sm-3 control-label">描述:</label>--%>
                <%--<div class="col-sm-8">${subject.brief}</div>--%>
            <%--</div>--%>
        <%--</form>--%>
    <%--</div>--%>
</div>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script>
        $(function(){
        });

        function tableConfiguration(num, data) {
            data.pageNum=num;
            var conData = data;
            $.ajax({
                url:"",
                type:"GET",
                data:conData,
                success:function (data) {
                    $(".data-table").html("");
                    var DataList = JSON.parse(data);
                    if(DataList=="{}"){
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
                    $(".page-message").html("当前第"+dataFile.pageNum +"页,共"+dataFile.totalPage +"页,共"+dataFile.totalNum+"条数据");
                    $('#page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.pageNum,
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
                        tableConfiguration(num,conData);
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
    </script>
</div>

</html>
