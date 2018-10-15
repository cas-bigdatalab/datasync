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
    <title>系统</title>
    <link href="${ctx}/resources/css/projectMessage.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="task-head">
        <span>DataSync / 专题信息</span>
    </div>
    <div class="task-title">
        <span>专题库信息认证管理</span>
    </div>
    <%--<div class="task-table">
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" id="projectList" >
            <thead>
            <tr>
                <th>编号</th>
                <th>专题库名称</th>
                <th>专题库英文名称</th>
                <th>库 | FTP</th>
                <th>创建时间</th>
                <th>URL</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            <tr>
                <td>2</td>
                <td>**专题库FTP</td>
                <td>dataOneFTP</td>
                <td>FTP访问</td>
                <td>2018-09-12 09:12</td>
                <td>https://www.cnblogs.com</td>
            </tr>
            </tbody>
        </table>
        <div class="page-message">

        </div>
        <div class="page-list"></div>
    </div>--%>
    <div class="messageCon" >
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-3 control-label">专题库名称:</label>
                <div class="col-sm-8">烟草库</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">专题库代码 :</label>
                <div class="col-sm-8">tobacco</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">管理员账号:</label>
                <div class="col-sm-8">XXXXXXXXX</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">密码:</label>
                <div class="col-sm-8">XXXXXXXXX</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">联系人:</label>
                <div class="col-sm-8">XXXXXXXXX</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">电话:</label>
                <div class="col-sm-8">XXXXXXXXXX</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">邮箱:</label>
                <div class="col-sm-8">hanfang@cnic.cn
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">FTP用户名:</label>
                <div class="col-sm-8">toftpadmin</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">FTP密码:</label>
                <div class="col-sm-8">
                    ftp123
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">描述:</label>
                <div class="col-sm-8">
                    烟草质量控制数据库烟草质量控制数据库烟草质量控制数据库烟草质量控制数据库烟草质量控制数据库
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>

    <script>
        $(function(){

        });
        function tableConfiguration(num,data) {
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
                    $(".table-message").html("请求失败");
                }
            })
        }
    </script>
</div>

</html>
