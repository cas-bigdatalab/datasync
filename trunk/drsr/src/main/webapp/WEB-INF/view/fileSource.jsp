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
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/jstree/dist/themes/default/style.css" rel="stylesheet" type="text/css">
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
    <h3 id="forms-inline" class="relationTitle"<%--class="modal-title"--%>>文件数据源模块</h3>
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
            <th>文件类型</th>
            <th>文件地址</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${fileDataOfThisPage}" var="item" varStatus="status">
        <tr>
<%--
            <td>${item.dataSourceId}</td>
--%>
            <td>${item.dataSourceName}</td>
            <td>文件数据源</td>
            <td>${item.fileType}</td>
            <td>${item.filePath}</td>
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
                    <h4 class="modal-title">添加文件数据源</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="commentForm" method="get" action="">
                        <fieldset>
                            <div class="modal-footer">
                                <input class="btn btn-primary" id="addSubmit" type="submit" value="确定">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            </div>
                            <div class="form-group">
                            <label  for="dataSourceName" class="col-sm-3 control-label"><font color='red'>*</font>数据源名称</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceName" name="dataSourceName" placeholder="请输入数据源名称" required aria-required="true">
                            </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataSourceName" class="col-sm-3 control-label"><font color='red'>*</font>数据源类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " value="文件数据源" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><font color='red'>*</font>文件类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left "
                                           name="fileType"  value="本地文件" disabled>
                                </div>
                            </div>
                            <%--<div class="form-group">
                                <label  for="filePath" class="col-sm-3 control-label"><font color='red'>*</font>文件地址</label>
                                <div class="col-sm-9">
                                    <input type="file" class="form-control" style="width:50%;float: left " id="filePath" name="dataSourceType" placeholder="请输入文件地址" required aria-required="true" checkFileFormat="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9">
                                    <div class="form-horizontal" id="fileError" style="width:50%;float: left " hidden>
                                        <font color='red'>文件为空，请检查您选取的文件地址是否正确</font>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="form-group">
                            <div id="jstree_show" style="height:300px"></div>
                                </div>
                            <%--<div class="modal-footer">
                                <input class="btn btn-primary" id="addSubmit" type="submit" value="确定">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            </div>--%>
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
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">确定</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            </div>
                            <div class="form-group">
                                <label  for="dataSourceName" class="col-sm-3 control-label"><font color='red'>*</font>数据源名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceNameE"
                                           name="dataSourceName" placeholder="请输入数据源名称"  required  aria-required="true" onblur="fileFormatCheck();">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  for="dataSourceType" class="col-sm-3 control-label"><font color='red'>*</font>数据源类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left " id="dataSourceType"
                                           name="dataSourceType" value="文件数据源" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><font color='red'>*</font>文件类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width:50%;float: left "
                                            name="fileType"  value="本地文件" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-3 control-label"><font color='red'>*</font>文件地址</label>
                                <div class="col-sm-9">
                                        <div id="tags_tagsinput" class="tagsinput" style="border: 1px solid black" ></div>
                                        <div id="jstree_show_edit" style="height:300px"></div>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div id="addSqlSourcetable" class="modal fade" tabindex="-1" data-width="400">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加SQL数据源信息</h4>
                </div>
                <div class="modal-body" style="min-height: 100px">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="chinaName" class="col-sm-3 control-label">数据源名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="chinaName" required="required" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="englishName" class="col-sm-3 control-label">英文名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="englishName" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">类型</label>
                            <div class="col-sm-8">
                                <select name="" id="" class="form-control">
                                    <option value="">DB2</option>
                                    <option value="">Oracle</option>
                                    <option value="">SqlServer</option>
                                    <option value="">MySql</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="HostNum" class="col-sm-3 control-label">主机</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="HostNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="portNum" class="col-sm-3 control-label">端口</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="portNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="userName" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="userName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="possword" class="col-sm-3 control-label">密码</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="possword">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn green" data-dismiss="modal" onclick="confirmAddNode();" ><i
                            class="glyphicon glyphicon-ok"></i>添加
                    </button>
                    <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
                </div>
            </div>
        </div>
    </div>

    <!--paging-->
    <div align="center">
        <ul class="pagination">
            <!--to the first page-->
            <li>
                <a href="/fileResource/index?currentPage=1">
                    首页
                </a>
            </li>

            <c:forEach begin="1" end="${totalPage}" step="1" varStatus="vs">
                <li>
                    <a href="/fileResource/index?currentPage=${vs.count}">${vs.count}</a>
                </li>
            </c:forEach>
            <!--to the previous page-->
            <li>
                <c:choose>
                    <c:when test="${currentPage <= 1}">
                        <a>上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/fileResource/index?currentPage=${currentPage-1}">
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
                        <a href="/fileResource/index?currentPage=${currentPage+1}">
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
                <a href="/fileResource/index?currentPage=${totalPage}">
                    尾页
                </a>
            </li>
        </ul>
    </div>

</div>
<div class="mask" style="display:none;"></div>
<input type="hidden" id="idHidden"/>
<input type="hidden" id="markAddHidden"/>
<input type="hidden" id="markEditHidden"/>
<input type="hidden" id="markDeleteHidden"/>
<input type="hidden" id="markOsNameHidden" value ="${osName}"/>

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
    <i id="conClose" class="close" onclick="conFalseClose();"></i>
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
<div class="window fileIsNullAlert" hidden style="position: fixed;top: 100px;z-index: 99999; left: 45%;">
    <i id="validFileAlert" class="close" onclick="fileAlertClose();"></i>
    <h1><strong>操作失败</strong></h1>
    <div class="img">
        <img src="${ctx}/resources/img/fail.png"/>
    </div>
    <p class="lineTwo lineTwice">您要上传的文件为空</p>
    <p class="lineTwo lineSec">请检查您填写的文件路径是否正确</p>
    <button class="true" id="uploadFiles" onclick="uploadFilesClick();">知道啦！</button>
</div>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
    <script src="${ctx}/resources/bundles/relationModule/messages_zh.js"></script>
    <script src="${ctx}/resources/bundles/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script src="${ctx}/resources/js/subStrLength.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/relationModule/vue.min.js"></script>
    <script src="${ctx}/resources/bundles/relationModule/fileResource.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var deleteNodeArray;
    </script>

</div>
</html>
