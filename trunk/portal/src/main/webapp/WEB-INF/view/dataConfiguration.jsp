<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/30
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>DataSync专题库门户管理系统</title>
    <link rel="stylesheet" href="${ctx}/resources/css/dataConfig.css">
    <style type="text/css">
        .nav-tabs li a{
            font-size: 22px;
            background-color: gainsboro;
        }
        .nav-tabs>li.active>a{
            background-color: #28a4a4!important;
            border: 1px solid black!important;
            border-bottom-color:transparent!important;
        }
        .nav-tabs>li.active>a:hover{
            background-color: #28a4a4!important;
        }
        .undeslist label{
            font-size: 18px;
            word-break: break-all;
        }
    </style>
</head>

<body>

<div class="page-content">
    <h3><b>数据配置</b></h3>
    <div class="config-head">
        <span>DataSync / 传输信息</span>
    </div>
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#undescribe" aria-controls="undescribe" role="tab" data-toggle="tab">待描述数据表</a></li>
            <li role="presentation"><a href="#isdescribe" aria-controls="isdescribe" role="tab" data-toggle="tab">已描述数据表</a></li>
            <li role="presentation"><a href="#filedata" aria-controls="filedata" role="tab" data-toggle="tab">文件数据</a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="undescribe">
                <div class="col-md-3" style="font-size: 18px">
                    <span>选择表资源进行描述</span>
                </div>
                <div class="col-md-9" >
                    <div class="row undeslist" >
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>

                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="isdescribe">
                <div class="col-md-3" style="font-size: 18px">
                    <span>选择表资源查看/修改描述</span>
                </div>
                <div class="col-md-9" >
                    <div class="row undeslist" >
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label>
                                <input type="radio">
                                <span>dictionay</span>
                            </label>
                        </div>

                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="filedata">cccccccc</div>
        </div>

    </div>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</div>

</html>

