<%--
  Created by IntelliJ IDEA.
  User: shiba
  Date: 2018/10/8
  Time: 21:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="${ctx}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/relationalSource.css">
    <%--
        <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    --%>
    <style>
        .error {
            color:red;
            line-height: 34px;
            /*position:relative;min-height:1px;padding-right:15px;padding-left:15px;
            width:33.33333333%*/
        }
    </style>
</head>
<div class="page-content" style="min-height:342px">
    <br/>
    <div>
        <h3 id="forms-inline" class="relationTitle"<%--class="modal-title"--%>>关系数据源模块</h3>
    </div>
    <form class="form-inline">
        <button type="button" class="btn btn-primary" onclick="add();">新增</button>
        <%--<div class="form-group" style="float: right">
            <label>搜索</label>
            <input type="text" class="form-control" v-model="search" v-on:input ="searchFn"  placeholder="请输入搜索关键字">
        </div>--%>
    </form>
    <hr/>
    <table class="table table-bordered">
        <thead>
        <tr>
            <%--
                        <th>数据源编号</th>
            --%>
            <th>数据源名称</th>
            <th>数据源类型</th>
            <th>数据库类型</th>
            <th>数据库名称</th>
            <th>主机地址</th>
            <th>端口</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${relationDataOfThisPage}" var="item" varStatus="status">
            <tr>
                    <%--
                                <td>${item.dataSourceId}</td>
                    --%>
                <td>${item.dataSourceName}</td>
                <td>关系数据源</td>
                <td>${item.databaseType}</td>
                <td>${item.databaseName}</td>
                <td>${item.host}</td>
                <td>${item.port}</td>
                <td>
                    <button type="button" class="btn btn-default"  onclick="editData(${item.dataSourceId});">编辑</button>
                    <button type="button" class="btn btn-danger"  id="delete"  onclick="deleteD(${item.dataSourceId});">删除</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!--新增-->
    <div class="modal fade" tabindex="-1" role="dialog" id="addModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加关系数据库</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="commentForm" method="get" action="" onfocusout="true">
                        <fieldset>
                            <div class="form-group">
                                <label  for="dataSourceName" class="col-sm-3 control-label"><font color='red'>*</font>数据源名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceName" name="dataSourceName" placeholder="请输入数据源名称" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataSourceType" class="col-sm-3 control-label"><font color='red'>*</font>数据源类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceType" name="dataSourceType" value="关系数据源" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataBaseType" class="col-sm-3 control-label"><font color='red'>*</font>数据库类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control"  style="width:50%;float: left " id="dataBaseType" name="dataBaseType" placeholder="请输入数据库类型" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="databaseName" class="col-sm-3 control-label"><font color='red'>*</font>数据库名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="databaseName" name="databaseName" placeholder="请输入数据库名称" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="host" class="col-sm-3 control-label"><font color='red'>*</font>主机地址</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="host" name="host" placeholder="请输入主机地址" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="port" class="col-sm-3 control-label"><font color='red'>*</font>端口</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="port" name="port" placeholder="请输入端口" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="userName" class="col-sm-3 control-label"><font color='red'>*</font>用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="userName" name="userName" placeholder="请输入用户名" required aria-required="true" onfocusout="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-sm-3 control-label"><font color='red'>*</font>密码</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" style="width:50%;float: left " id="password" name="password" placeholder="请输入密码" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9">
                                    <div class="form-horizontal" id="databaseError" style="width:50%;float: left " hidden>
                                        <font color='red'>数据库无法连接</font>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input class="btn btn-primary" id="addSubmit" type="submit" value="确定" onclick="testAddSubmit();">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--编辑-->
    <div class="modal fade" tabindex="-1" role="dialog" id="editModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="commentEditForm" method="get" action="">
                        <fieldset>
                            <div class="form-group">
                                <label  for="dataSourceNameE" class="col-sm-3 control-label"><font color='red'>*</font>数据源名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceNameE" name="dataSourceNameE" placeholder="请输入数据源名称"
                                           required aria-required="true" minlength="2">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataSourceTypeE" class="col-sm-3 control-label"><font color='red'>*</font>数据源类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceTypeE" name="dataSourceTypeE" value="关系数据源" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataBaseTypeE" class="col-sm-3 control-label"><font color='red'>*</font>数据库类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataBaseTypeE" name="dataBaseTypeE" placeholder="请输入数据库类型" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataBaseNameE" class="col-sm-3 control-label"><font color='red'>*</font>数据库名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataBaseNameE" name="dataBaseNameE" placeholder="请输入数据库名称" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="hostE" class="col-sm-3 control-label"><font color='red'>*</font>主机地址</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="hostE" name="hostE" placeholder="请输入主机地址" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="portE" class="col-sm-3 control-label"><font color='red'>*</font>端口</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="portE" name="portE" placeholder="请输入端口" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="userNameE" class="col-sm-3 control-label"><font color='red'>*</font>用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="userNameE" name="userNameE" placeholder="请输入用户名" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="passwordE" class="col-sm-3 control-label"><font color='red'>*</font>密码</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" style="width:50%;float: left " id="passwordE" name="passwordE" placeholder="请输入密码" required aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9">
                                    <div class="form-horizontal" id="databaseErrorE" style="width:50%;float: left " hidden>
                                        <font color='red'>数据库无法连接</font>
                                    </div>
                                </div>
                            </div>
                            <%--
                                                        <input class="submit" type="submit" value="Submit">
                            --%>                    <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">确定</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!--paging-->
    <div align="center">
        <ul class="pagination">
            <!--to the first page-->
            <li>
                <a href="/relationship/indexTest?currentPage=1">
                    首页
                </a>
            </li>

            <c:forEach begin="1" end="${totalPage}" step="1" varStatus="vs">
                <li>
                    <a href="/relationship/indexTest?currentPage=${vs.count}">${vs.count}</a>
                </li>
            </c:forEach>
            <!--to the previous page-->
            <li>
                <c:choose>
                    <c:when test="${currentPage <= 1}">
                        <a>上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/relationship/indexTest?currentPage=${currentPage-1}">
                            上一页
                        </a>
                    </c:otherwise>
                </c:choose>
                <%--<c:if test="${currentPage <= 1 }"></c:if>
                <a href="/relationship/indexTest?currentPage=${currentPage-1}">
                    上一页
                </a>--%>
            </li>
            <!--to the next page-->
            <li>
                <c:choose>
                    <c:when test="${currentPage == totalPage}">
                        <a>下一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/relationship/indexTest?currentPage=${currentPage+1}">
                            下一页
                        </a>
                    </c:otherwise>
                </c:choose>
                <%--<a href="/relationship/indexTest?currentPage=${currentPage+1}">
                    下一页
                </a>--%>
            </li>
            <!--to the last page-->
            <li>
                <a href="/relationship/indexTest?currentPage=${totalPage}">
                    尾页
                </a>
            </li>
        </ul>
    </div>

</div>
<div class="mask" style="display:none;"></div>
<input type="hidden" id="idHidden" val=""/>
<input type="hidden" id="markAddHidden" val=""/>
<input type="hidden" id="markEditHidden" val=""/>
<input type="hidden" id="markDeleteHidden" val=""/>

<div class="window addSuccess" hidden style="position: fixed;top: 100px;z-index: 99999; left: 45%;">
    <i id="successClose" class="close" onclick="successClose();"></i>
    <h1><strong>操作成功</strong></h1>
    <div class="img">
        <img src="${ctx}/resources/img/success.png"/>
    </div>
    <p class="line lineOne"></p>
    <p class="line lineOnce"></p>
    <button class="true" id="addTrue" onclick="addTrue();">知道啦！</button>
</div>
<div class="window addFail" hidden style="position: fixed;top: 100px;z-index: 99999; left: 45%;">
    <i id="falseClose" class="close" onclick="falseClose();"></i>
    <h1><strong>操作失败</strong></h1>
    <div class="img">
        <img src="${ctx}/resources/img/fail.png"/>
    </div>
    <p class="lineTwo lineTwice"></p>
    <button class="true" id="addFalse" data-dismiss="modal" onclick="addFalse();">知道啦！</button>
</div>
<div class="window conFail" hidden style="position: fixed;top: 100px;z-index: 99999; left: 45%;">
    <i id="conClose" class="close" onclick="conFalse();"></i>
    <h1><strong>操作失败</strong></h1>
    <div class="img">
        <img src="${ctx}/resources/img/fail.png"/>
    </div>
    <p class="lineTwo lineTwice">数据库无法连接！</p>
    <button class="true" id="conFalse" onclick="conFalse();">知道啦！</button>
</div>
<div class="window deleteAlert" hidden style="position: fixed;top: 100px;z-index: 99999; left: 45%;">
    <i id="validAlert" class="close" onclick="conFalseClose();"></i>
    <h1><strong>请注意!</strong></h1>
    <div class="img">
        <img src="${ctx}/resources/img/fail.png"/>
    </div>
    <p class="lineTwo lineTwice">删除后数据将无法恢复！</p>
    <p class="lineTwo lineSec">您确定要删除吗？</p>
    <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="validTrue" onclick="validAlertTrue();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" id="validFalse" onclick="validAlertClose();">取消</button>
    </div>
</div>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
    <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.js"></script>
    E:\CNIC Project\datasync\trunk\drsr\src\main\webapp\resources\bundles\jquery-bootpag\jquery.bootpag.js
</div>
</html>
