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
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-fileinput/css/fileinput.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jqeury-file-upload/css/jquery.fileupload.css">
    <style>
        .bar {
            height: 18px;
            background: green;
        }
    </style>
</head>

<body>

<div class="page-content">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue" id="form_wizard_1">
                <div class="portlet-title" style="background-color:#3fd5c0">
                    <div class="caption">
                        <i class="fa fa-gift"></i> 数据发布 - <span class="step-title">
								第&nbsp;1&nbsp;步,共&nbsp;3&nbsp;步</span>
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-wizard">
                        <div class="form-body">
                            <ul class="nav nav-pills nav-justified steps">
                                <li class="active">
                                    <a href="#tab1" data-toggle="tab" class="step">
												<span class="number">
												1 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 元数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab2" data-toggle="tab" class="step">
												<span class="number">
												2 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 实体数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab3" data-toggle="tab" class="step">
												<span class="number">
												3 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 设置权限 </span>
                                    </a>
                                </li>
                            </ul>
                            <div id="bar" class="progress progress-striped" role="progressbar">
                                <div class="progress-bar progress-bar-success">
                                </div>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab1">
                                    <form class="form-horizontal" id="submit_form" enctype="multipart/form-data"
                                          method="POST">
                                        <div class="alert alert-danger display-hide">
                                            <button class="close" data-close="alert"></button>
                                            表单填写有误，请检查
                                        </div>
                                        <div class="alert alert-success display-hide">
                                            <button class="close" data-close="alert"></button>
                                            表单保存成功!
                                        </div>

                                        <input type="hidden" name="resourceId" id="resourceId">
                                        <input type="hidden" name="resState" id="resState" value="未完成">
                                        <h3 class="block">静态数据描述信息</h3>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">静态数据名称 <span class="required">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="resTitle"
                                                       id="resTitle" onchange="setResTitle(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">数据图片<span >
													* </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                    <div class="fileinput-preview thumbnail"
                                                         data-trigger="fileinput"
                                                         style="width: 200px; height: 150px;">
                                                    </div>
                                                    <div>
                                                            <span class="btn default btn-file">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <span class="fileinput-exists">
                                                            换一个</span>
                                                            <input id="imagePath" type="file" name="imageFile">
                                                            </span>
                                                        <a href="#" class="btn red fileinput-exists"
                                                           data-dismiss="fileinput">
                                                            删除 </a>
                                                    </div>
                                                </div>
                                                <div class="clearfix margin-top-10">
												<span class="label label-danger">
												注意! </span>
                                                    图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                    Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group dataLicenseInputGroup">
                                            <label class="control-label col-md-3">许可协议 <span class="required">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <select class="form-control dataLicense" name="license" id="dataLicenseID">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">发布到<span class="required">
													* </span></label>
                                            <div class="checkbox-list col-md-6">
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" id="centerCheckbox" name="catalogCheckbox" value="center"> 中心门户</label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" id="localCheckbox" name="catalogCheckbox" value="local"> 本地门户 </label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">分类选择
                                            </label>
                                            <div class="col-md-4" id="cemterCatalogDiv" style="display:none">
                                                <input type="hidden" name="centerCatalogId" id="centerCatalogId">
                                                <div id="jstree-demo"></div>
                                            </div>
                                            <div class="col-md-4" id="localCatalogDiv" style="display:none">
                                                <input type="hidden" name="localCatalogId" id="localCatalogId">
                                                <div id="localjstree-demo"></div>
                                            </div>
                                        </div>
                                        <%--<div class="form-group"  style="display:none">
                                            <label class="control-label col-md-3">本地分类选择
                                            </label>

                                        </div>--%>
                                        <!--       20181102 wzj          <div class="form-group">
                                                             <label class="control-label col-md-3">下载使用说明 <span class="required">
                                                                     * </span>
                                                             </label>
                                                             <div class="col-md-4">
                                                                 <textarea type="text" class="form-control" name="description"
                                                                           rows="3"></textarea>
                                                             </div>
                                                         </div>
                                                         -->
                                        <div class="form-group" style="display: none">
                                            <label class="control-label col-md-3">数据源id <span class="required">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="dataSourceId"
                                                       id="dataSourceId">
                                            </div>
                                        </div>
                                        <div id="onlineDiv">
                                        </div>

                                        <div id="resourceChooseDiv">
                                        </div>

                                        <div id="generateRelationalDatabase">
                                        </div>

                                        <div id="showSqlStr">
                                        </div>

                                        <div id="offlineDiv">
                                        </div>


                                    </form>
                                </div>
                                <div class="tab-pane" id="tab2">
                                    <form action="#" id="coreMetaForm">
                                        <div class="form-body">

                                            <div class="note note-success">
                                                <h4 class="block">核心元数据</h4>
                                                <p id="rootDescription"></a>
                                                </p>
                                            </div>
                                            <div id="coreMetaTree" class="tree-demo" style="min-height: 300px">

                                            </div>


                                        </div>
                                    </form>
                                </div>
                                <div class="tab-pane" id="tab3"></div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <a href="javascript:;" class="btn default button-previous">
                                        <i class="m-icon-swapleft"></i> 上一步 </a>
                                    <a href="javascript:;" class="btn blue button-next">
                                        bia <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                    <a href="javascript:;" class="btn green button-submit">
                                        提交 <i class="m-icon-swapup m-icon-white"></i>
                                    </a>
                                    <div class="col-md-offset-3 col-md-3 " style="float: right">
                                        <button class="btn green button-save">
                                            保存当前页数据
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>

    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</div>

</html>

