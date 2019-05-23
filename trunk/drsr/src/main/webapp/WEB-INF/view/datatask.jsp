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
    <title>DataSync</title>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.css " rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <script src="${ctx}/resources/bundles/zTree_v3/js/rightClick.js"></script>
    <style type="text/css">
        .arrListSty{
            display: inline-block;
            margin-right: 5px;
            /*background-color: #aaaaaa;*/
            padding: 3px 6px;
            margin-bottom: 5px;
        }
        #relModal .form-group div,#fileModal .form-group div{
            word-break: break-all;
        }
        .progress {
            height: 18px !important;
            margin-bottom: 0px !important;
        }
        .sr-only {
            position: relative !important;
        }
        .progress > .progress-bar-success {
            background-color: #5cb85c !important;
        }
        #upload-list th {
            background-color: #f1f1f1;
            color: black;
            font-size: 14px;
            border-left: none !important;
            border-right: none !important;
            font-weight: normal;
        }
        #upload-list td {
            border-left: none !important;
            border-right: none !important;
        }
        .form-control{
            border-radius: 6px !important;
        }
        .alert-info {
            background-color: #e0e0e0 !important;
            border: none !important;
            border-left: #0e6445 8px solid !important;
        }
        .alert {
            padding: 11px;
        }
        .page-content-wrapper .page-content{
            padding: 0px 0px 0px 0px !important;
        }
        .uplod-head,.alert alert-info,.upload-table{
            padding:0px 20px !important;
        }
        #ser_div a {
            font-size: 16px;
            height: 40px;
            padding-left: 10px;
            padding-right: 10px;
            display: block;
            background: #70c24c;
            line-height: 40px;
            color: #FFF;
            border-radius: 6px;
        }
        .btn-xs {
            border-radius: 6px !important;
        }
        .bg-primary {
            background-color: #1e8753 !important;
        }
        .col-sm-3 {
            width: 25% !important;
        }
        .btn-xs {
            padding: 3px 5px !important;
        }
        .table-bordered > tbody > tr:hover {
            background-color: #f5f5f5;
        }

        .spin{ -webkit-transform-origin: 50% 50%; transform-origin:50% 50%;
            -ms-transform-origin:50% 50%; /* IE 9 */ -webkit-animation: spin .8s
        infinite linear; -moz-animation: spin .8s infinite linear; -o-animation:
            spin .8s infinite linear; animation: spin .8s infinite linear; }
        @-webkit-keyframes spin { 0% { -webkit-transform: rotate(0deg);
            transform: rotate(0deg); } 100% { -webkit-transform: rotate(359deg);
            transform: rotate(359deg); } } @keyframes spin { 0% { -webkit-transform:
            rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform:
            rotate(359deg); transform: rotate(359deg); } }
        .shade{
            width:100%;
            height: 100%;
            position: absolute;
            top: 0px;
            left: 0px;
            display: none;

        }
        .wrap-ms-right{
            list-style: none;
            position: absolute;
            top: 0;
            left: 0;
            padding: 5px 0;
            min-width: 80px;
            margin: 0;
            display: none;
            font-family: "微软雅黑";
            font-size: 14px;
            background-color: #fff;
            border: 1px solid rgba(0, 0, 0, .15);
            box-sizing: border-box;
            border-radius: 4px;
            -webkit-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            -moz-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            -ms-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            -o-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .ms-item{
            height: 30px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
        }
        .ms-item:hover{
            background-color: #343a40;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
<div class="page-content">
    <div>
        <%--<div class="uplod-head">--%>
            <%--<h3 style="font-size: 17px !important;">--%>
                <%--数据任务--%>
            <%--</h3>--%>
            <%--&lt;%&ndash;<hr>&ndash;%&gt;--%>
        <%--</div>--%>
        <%--<div class="upload-title">
            <span>数据上传任务列表</span>
            &lt;%&ndash;<a href="${ctx}/createTask">新建任务</a>&ndash;%&gt;
        </div>--%>
        <div class="alert alert-info" role="alert" style="margin:1% 20px 0px 20px">
            <!--查询条件 -->
            <div class="row">
                <div class="col-md-9">
                    <form class="form-inline" style="margin-bottom: 0px">
                        <div class="form-group" >
                            <label style="color: black">数据类型</label>
                            <select  id="dataSourceList" class="form-control" style="width: 150px">
                                <option value="">全部</option>
                                <option value="mysql">mysql</option>
                                <option value="oracle">oracle</option>
                                <option value="file">file</option>
                            </select>
                        </div>
                        <div class="form-group" style="margin-left: 8px;">
                            <label  style="color: black;">状态</label>
                            <select  id="dataStatusList" class="form-control" style="width: 150px">
                                <option value="">全部</option>
                                <option value="1">上传/导入完成</option>
                                <option value="0">未上传</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-sm blue" style="margin-left: 49px;border-radius: 6px !important;background-color: #5cac39;" id="seachTaskSource"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                    </form>
                </div>
                <div class="col-md-3" style="text-align: right;padding-top: 3px;">
                    <button type="button" class="btn btn-sm green" style="margin-left: 49px;border-radius: 6px !important;background-color: #3774b6;padding: 5px 10px !important;" onclick="relCreateTask()"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增数据任务</button>
                </div>
            </div>
        </div>
        <div class="upload-table">
            <div class="table-message">列表加载中......</div>
            <table class="table table-bordered data-table" id="upload-list" >
                <thead>
                <tr>
                    <th>编号</th>
                    <th>
                        <a href="#" title="蓝色“同步图标”表示此任务启动定时同步！
红色“同步图标”表示此同步任务关闭定时同步！
图标为蓝色时单击图标立刻同步任务，双击图标关闭定时任务！
图标为红色时单击图标启动定时同步并立刻同步任务！
右击“同步图标”提供“周期修改”及“日志下载”功能！
">
                            <span class="glyphicon glyphicon-info-sign"></span>
                        </a>
                        任务标识</th>
                    <th>数据类型</th>
                    <th>数据源</th>
                    <th>编辑时间</th>
                    <th width="10%">上传进度</th>
                    <th width="7%">状态</th>
                    <th width="29%">操作</th>
                </tr>
                </thead>
                <tbody id="bd-data" style="background-color: #ffffff;"></tbody>
            </table>

           <%-- <div class="page-message" style="float: left;line-height: 56px" ></div>
            <div id="pagination" style="float: right"></div>--%>
            <div class="row margin-top-20 ">
                <div class="page-message" style="float: left;padding-left: 20px; line-height: 56px"></div>
                <div id="pagination" style="float: right; padding-right: 15px;"></div>
            </div>
        </div>

        <div style="display: none" id="uploadListFlag">
            <span name="" valFlag="false"></span>
        </div>
    </div>
</div>
<div id="relModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务标识:</label>
                        <div class="col-sm-8 modediv" id="pre-dataTaskName"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">数据源:</label>
                        <div class="col-sm-8 modediv" id="pre-dataSourceId"></div>
                    </div>--%>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">表名:</label>
                        <div class="col-sm-8 modediv" id="pre-tableName"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">SQL语句:</label>
                        <div class="col-sm-8 modediv" id="pre-sqlString"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">逻辑表名:</label>
                        <div class="col-sm-8 modediv" id="pre-sqlTableNameEn"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">文件路径:</label>
                        <div class="col-sm-8 modediv" id="pre-filePath"></div>
                    </div>--%>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8 modediv" id="pre-createTime"></div>
                    </div>
                    <div id="periodDiv" class="form-group" style="display: none;">
                        <label  class="col-sm-3 control-label">同步周期:</label>
                        <div class="col-sm-8 modediv" id="pre-period"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">创建者:</label>
                        <div class="col-sm-8 modediv" id="pre-creator"></div>
                    </div>--%>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">上传进度:</label>
                        <div class="col-sm-8"></div>
                    </div>--%>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8 modediv" id="pre-status"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" data-dismiss="modal" class="btn  default" style="color: #267d24 !important;background-color: #fff; border: 1.6px solid; border-radius: 6px !important; ">关闭</button>
            </div>
        </div>
    </div>
</div>
<div id="fileModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务标识:</label>
                        <div class="col-sm-8 modediv" id="file-dataTaskName"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">数据源:</label>
                        <div class="col-sm-8 modediv" id="file-dataSourceId"></div>
                    </div>--%>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">表名:</label>
                        <div class="col-sm-8 modediv" id="file-tableName"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">SQL语句:</label>
                        <div class="col-sm-8 modediv" id="file-sqlString"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">逻辑表名:</label>
                        <div class="col-sm-8 modediv" id="file-sqlTableNameEn"></div>
                    </div>--%>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">文件路径:</label>
                        <div class="col-sm-8 modediv" id="file-filePath" style="max-height: 300px;overflow-x: hidden;border: 1px solid #e5e5e5;margin-top: 18px;"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">文件大小:</label>
                        <div class="col-sm-8 modediv" id="file-size"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8 modediv" id="file-createTime"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">上传路径:</label>
                        <div class="col-sm-8 modediv" id="file-uploadpath"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8 modediv" id="file-status"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" data-dismiss="modal" class="btn default" style="color: #267d24 !important;background-color: #fff; border: 1.6px solid; border-radius: 6px !important; ">关闭</button>
            </div>
       </div>
    </div>
</div>

<div id="logModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content ">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body">
                <h1>日志</h1>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal" ><i
                        class="glyphicon glyphicon-ok"></i>确认
                </button>
                <button type="button" data-dismiss="modal" class="btn  default">取消</button>
            </div>
        </div>
    </div>
</div>

<div id="rMenu" class="wrap-ms-right" style="display: none; top: 26px; left: 100px;width: 100px;">
    <li class="ms-item" data-item="1" onclick="showEditSyncModel()"><i class="fa fa-files-o" data-item="1" ></i>&nbsp; 周期修改</li>
    <li class="ms-item" data-item="3" onclick="fileLogDownload()"><i class="fa fa-download" data-item="3"></i>&nbsp; 日志下载</li>
</div>

<div class="modal fade" id="editSyncModal" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 66%;top: 156px;margin: 0 auto;">
            <div class="modal-header" style="height: 48px;">
                <h5 class="modal-title" id="createFileTitle" style="float: left;font-size: 17px !important;font-weight:bold;">同步周期修改</h5>
                <button type="button" class="close" onclick="hidenFileNameModal()">
                    <span >&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <select id="syncSelect" class="form-control" style="font-size: 14px;">
                            <option value="" disabled selected hidden>周期</option>
                            <option value="3">3小时</option>
                            <option value="6">6小时</option>
                            <option value="24">天</option>
                            <option value="168">周</option>
                            <option value="720">月</option>
                        </select>
                        <span id="promptInf" style="color: red;"></span>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" style="border-radius: 6px !important;" id="createFileSureBut" onclick="saveSyncPeriod()">确定</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each dataTasks as value i}}
    <tr keyIdTr="{{value.dataTaskId}}">
        <td>{{i + 1}}</td>
        <td>
            {{if value.sync=="true" && value.status  == "1"}}
                <a id="{{value.dataTaskId}}Refresh" class="refresh" oncontextmenu="rightClick('{{value.dataTaskId}}','{{value.period}}')" ondblclick="cancelSync(this,'{{value.dataTaskId}}','{{value.sync}}');" onclick="startSync(this,'{{value.dataTaskId}}','{{value.sync}}')" title="单击立刻同步，双击暂停“定时同步”！">
                  <span class="glyphicon glyphicon-refresh"></span>
                </a>
            {{else if value.sync=="false" && value.status  == "1"}}
            <a id="{{value.dataTaskId}}Refresh" class="refresh" oncontextmenu="rightClick('{{value.dataTaskId}}','{{value.period}}')"  ondblclick="cancelSync(this,'{{value.dataTaskId}}','{{value.sync}}');" onclick="startSync(this,'{{value.dataTaskId}}','{{value.sync}}')" style="color: red;" title="单击启动“定时同步”，并立刻同步任务！">
                <span class="glyphicon glyphicon-refresh"></span>
            </a>
            {{/if}}

            {{value.dataTaskName}}
        </td>
        <td>{{value.dataTaskType}}</td>
        <td>{{value.dataSrc.dataSourceName}}</td>
        <td>{{dateTimeFormat(value.createTime)}}</td>
        {{if value.status  == "1"}}
        <td>
            <div class="progress progress-striped active"  >
                <div kkid="{{value.dataTaskId}}Loading" style="color:red;display:none;height:100%;line-height: 1.7;">连接中..</div>
                <div kkid="{{value.dataTaskId}}LoadingFail" style="color:red;display:none;height:100%;line-height: 1.7;">上传失败</div>
                <div kkid="{{value.dataTaskId}}Unziping" style="color:red;display:none;height:100%;line-height: 1.7;">解压中...</div>
                <div  kkid="{{value.dataTaskId}}" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin=\"0\" aria-valuemax="100" style="width: 100%;height: 18px; -webkit-border-radius: 5px !important;">
                    <span kkid='{{value.dataTaskId}}Text' class="sr-only" style="color:#f9f7ef;" >100%</span>
                </div>
            </div>
        </td>
        {{else if value.status  == "0"}}
        <td>
            <div class="progress progress-striped active">
                 <div kkid="{{value.dataTaskId}}Loading" style="color:red;display:none;height:100%;line-height: 1.7;">连接中..</div>
                 <div kkid="{{value.dataTaskId}}LoadingFail" style="color:red;display:none;height:100%;line-height: 1.7;">上传失败</div>
                 <div kkid="{{value.dataTaskId}}Unziping" style="color:red;display:none;height:100%;line-height: 1.7;">解压中...</div>
                 <div kkid="{{value.dataTaskId}}" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin=\"0\" aria-valuemax="100" style="width: 0%;height: 18px; -webkit-border-radius: 5px !important;">
                     <span kkid='{{value.dataTaskId}}Text' class="sr-only" style="color:#f9170a;" ></span>
                 </div>
            </div>
        </td>
        {{/if}}
        <td  class="{{value.dataTaskId}}">{{upStatusName(value.status,value.dataTaskType)}}</td>
        <td style="text-align: center">

            {{if value.status  == 0}}
                {{if value.logPath  == ""}}
                <button type="button" kkid="{{value.dataTaskId}}Pause" style="display: none;" class="btn red btn-xs" onclick="pauseUpLoading('{{value.dataTaskId}}',new Date().getTime());"><i class="glyphicon glyphicon-pause"></i>&nbsp;暂停</button>
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" keyDataType="{{value.dataTaskType}}" resupload="one"><i class="glyphicon glyphicon-upload"></i>&nbsp;上传</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" kkid="{{value.dataTaskId}}Delete" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                <button type="button" kkid="{{value.dataTaskId}}Edit" class="btn purple btn-xs" onclick="editData('{{value.dataTaskId}}');"><i class="fa fa-edit"></i>&nbsp;编辑</button>
                {{else if value.logPath  != "" }}
                <button type="button" kkid="{{value.dataTaskId}}Pause" style="display: none;"  class="btn red btn-xs" onclick="pauseUpLoading('{{value.dataTaskId}}',new Date().getTime());"><i class="glyphicon glyphicon-pause"></i>&nbsp;暂停</button>
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" keyDataType="{{value.dataTaskType}}" resupload="one"><i class="glyphicon glyphicon-upload"></i>&nbsp;上传</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" kkid="{{value.dataTaskId}}Delete" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                <button type="button" kkid="{{value.dataTaskId}}Edit" class="btn purple btn-xs" onclick="editData('{{value.dataTaskId}}');"><i class="fa fa-edit"></i>&nbsp;编辑</button>
                <button type="button" class="btn  btn-xs yellow-lemon remove-data" onclick="window.location.href='${ctx}/fileResource/downloadFile?fileName={{value.dataTaskId}}log.txt'"><i class="glyphicon glyphicon-book"></i>&nbsp;日志</button>
            {{/if}}
            {{else if value.status  == 1 }}
                <button type="button" kkid="{{value.dataTaskId}}Pause" style="display: none;"  class="btn red btn-xs" onclick="pauseUpLoading('{{value.dataTaskId}}',new Date().getTime());"><i class="glyphicon glyphicon-pause"></i>&nbsp;暂停</button>
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" keyDataType="{{value.dataTaskType}}" resupload="two"><i class="glyphicon glyphicon-upload"></i>&nbsp;上传</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" kkid="{{value.dataTaskId}}Delete" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                <button type="button" class="btn  btn-xs yellow-lemon remove-data" onclick="window.location.href='${ctx}/fileResource/downloadFile?fileName={{value.dataTaskId}}log.txt'"><i class="glyphicon glyphicon-book"></i>&nbsp;日志</button>
            {{/if}}

        </td>
    </tr>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var taskProcessStr="";
        var requestStr="";
        var dataSourceName="";
        var pageNum=1;
        var dataSourceStatus="";
        var  rMenu=$("#rMenu");
        var datataskId="";
        var oldPeriod="";
        var uploadListFlag = $("#uploadListFlag");
        $(function(){
            tableConfiguration2(1,"","");
            $(".upload-table").bind("contextmenu", function(){
                return false;
            })
        });

        function relCreateTask(){
            window.location.href="${ctx}/createTask";
        }

        $("#dataSourceList").on("change",function () {
            dataSourceName= $("#dataSourceList option:selected").val();

        });
        $("#dataStatusList").on("change",function () {
            dataSourceStatus = $("#dataStatusList option:selected").val();


        });
        $("#seachTaskSource").click(function () {
            tableConfiguration2(1,dataSourceName,dataSourceStatus)
        })
        //导出SQL文件
        $("#upload-list").delegate(".exportSql","click",function () {
            var souceID = $(this).attr("keyIdTd");
            $.ajax({
                url:"${ctx}/datatask/" + souceID,
                type:"POST",
                dataType:"JSON",
                success:function (data) {
                    if (data.result == 'true') {
                        toastr.success("导出SQL文件成功!");
                    }else {
                        toastr.error("导出SQL文件失败!");
                    }

                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });
        template.helper("upStatusName",function (num,type) {
            console.log(type == "file")
            var name=""
            if(num ==0){
                name="未上传"
            }else if(num == 1 ) {
                if(type =="file"){
                    name="上传完成"
                }else {
                    name="导入完成"
                }

            }
            return name
        })
        $("#upload-list").delegate(".upload-data","click",function () {
            var isres = $(this).attr("resupload")
            var $this = $(this)

            var souceID = $this.attr("keyIdTd");
            var keyID = souceID + new Date().getTime();
            var keyType=$this.attr("keyDataType");
            if(isres == "two"){
                bootbox.confirm("<span style='font-size: 16px'>确认要重新上传吗?</span>",function (r) {
                    if(r){
                        $this.css("background-color","dimgrey");
                        $this.attr("disabled","disabled");
                        $("[kkid="+souceID+"Loading]")[0].style.display="block";
                        $("[kkid="+souceID+"]")[0].style.width="0%";
                        $("[kkid="+souceID+"Text]")[0].textContent="0%";
                        uploadListFlag.append("<span name="+keyID+" valFlag='false'></span>")
                        if(keyType =="file" ){
                            console.log("文件数据源")
                            $.ajax({
                                url:"${ctx}/ftpUpload",
                                type:"POST",
                                timeout:600000,
                                data:{dataTaskId:souceID,processId:keyID},
                                success:function (data) {
                                    console.log("return="+data)
                                    var data =JSON.parse(data)
                                    $("[name="+keyID+"]").attr("valFlag","true")
                                    if(keyType == "mysql"){
                                        if(data =="1"){
                                            toastr["success"]("导入成功！");
                                            $("."+souceID).text("已导入")
                                            tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                        }else {
                                            $("."+souceID).text("导入失败")
                                            return
                                        }
                                    }else {
                                        if(data =="1"){
                                            toastr["success"]("上传成功！");
                                            $("."+souceID).text("已上传")
                                            tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                        }else if(data =="3"){
                                            // toastr["error"]("暂停成功！");
                                        }else if(data=="0"){
                                            stopSetOuts();
                                            toastr["error"]("连接FTP出错：请检查网络连接！");
                                            //tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                            $("[kkid="+souceID+"Loading]")[0].style.display="none";
                                            $("[kkid="+souceID+"LoadingFail]")[0].style.display="block";
                                            $("."+souceID).text("ftp断开")
                                        }else {
                                            $("[kkid="+souceID+"Loading]")[0].style.display="none";
                                            $("[kkid="+souceID+"LoadingFail]")[0].style.display="block";
                                            $("."+souceID).text("上传失败")
                                            return
                                        }
                                    }
                                },
                                error:function () {
                                    console.log("请求失败")
                                }
                            })
                            //$("."+souceID).text("正在上传");
                            getProcess(keyID,souceID);



                        }else{
                            console.log("关系数据源")
                            $.ajax({
                                url:"${ctx}/ftpUpload",
                                type:"POST",
                                data:{dataTaskId:souceID,processId:keyID},
                                success:function (data) {
                                    var data =JSON.parse(data)
                                    $("[name="+keyID+"]").attr("valFlag","true")
                                    if(keyType != "file"){
                                        if(data =="1"){
                                            toastr["success"]("导入成功！");
                                            $("."+souceID).text("已导入")
                                            tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                            return
                                        }else {
                                            $("."+souceID).text("导入失败")
                                            return
                                        }
                                    }else {
                                        if(data =="1"){
                                            toastr["success"]("上传成功！");
                                            $("."+souceID).text("已上传")
                                            tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                            return
                                        }else {
                                            $("."+souceID).text("上传失败")
                                            return
                                        }
                                    }
                                },
                                error:function () {
                                    console.log("请求失败")
                                }
                            })
                        }
                    }else {
                        console.log("bbbbbbbbbbbbbbbbbbbb")
                        return
                    }
                })
            }else{
                uploadListFlag.append("<span name="+keyID+" valFlag='false'></span>")
                if(keyType =="file" ){
                    $.ajax({
                        url:"${ctx}/ftpUpload",
                        type:"POST",
                        timeout:600000,
                        data:{dataTaskId:souceID,processId:keyID},
                        success:function (data) {
                            var data =JSON.parse(data)
                            $("[name="+keyID+"]").attr("valFlag","true")
                            if(keyType == "mysql"){
                                if(data =="1"){
                                    toastr["success"]("导入成功！");
                                    $("."+souceID).text("已导入")
                                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                }else {
                                    $("."+souceID).text("导入失败")
                                    // return
                                }
                            }else {
                                if(data =="1"){
                                    toastr["success"]("上传成功！");
                                    $("."+souceID).text("已上传")
                                    // window.location.reload();
                                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                }else if(data=="0"){
                                    stopSetOuts();
                                    toastr["error"]("连接FTP出错：请检查网络连接！");
                                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                    $("[kkid="+souceID+"Loading]")[0].style.display="none";
                                    $("[kkid="+souceID+"LoadingFail]")[0].style.display="block";
                                    $("."+souceID).text("ftp断开")
                                }else if(data=="4"){
                                    toastr["error"]("文件不存在！");
                                    $("."+souceID).text("上传失败")
                                }else {
                                    $("."+souceID).text("上传失败")
                                    //   return
                                }
                            }


                        },
                        error:function () {
                            console.log("请求失败")
                        }
                    })
                    // $("."+souceID).text("正在上传");
                    getProcess(keyID,souceID);

                }else{
                    $.ajax({
                        url:"${ctx}/ftpUpload",
                        type:"POST",
                        timeout:600000,
                        data:{dataTaskId:souceID,processId:keyID},
                        success:function (data) {
                            var data =JSON.parse(data)
                            $("[name="+keyID+"]").attr("valFlag","true")
                            if(keyType != "file"){
                                if(data =="1"){
                                    toastr["success"]("导入成功！");
                                    $("."+souceID).text("已导入")
                                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                    //  return
                                }else {
                                    $("."+souceID).text("导入失败")
                                    //   return
                                }
                            }else {
                                if(data =="1"){
                                    toastr["success"]("上传成功！");
                                    $("."+souceID).text("已上传")
                                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus)
                                    // return
                                }else {
                                    $("."+souceID).text("上传失败")
                                    //   return
                                }
                            }
                        },
                        error:function () {
                            console.log("请求失败")
                        }
                    })
                }
            }



        })
        <!-- remove dataTask-->
        function removeData(id){
            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>",function (r) {
                if(r){
                    $.ajax({
                        url:"${ctx}/datatask/delete",
                        type:"POST",
                        data:{
                            datataskId:id
                        },
                        success:function (data) {
                            if(data=="1"){
                                toastr["success"]("删除成功");
                                tableConfiguration2(1,dataSourceName,dataSourceStatus);
                            }else if(data=="2"){
                                toastr["warning"]("处于“定期同步”状态下的任务需要先关闭“定时同步”才能删除！");
                            }
                        },
                        error:function () {
                            console.log("请求失败");
                        }
                    })
                }else {

                }
            })


        }
        function showData(id,type,name) {
            $.ajax({
                url:"${ctx}/datatask/detail",
                type:"POST",
                data:{datataskId:id},
                success:function (data) {
                    var datatask = JSON.parse(data).datatask
                    console.log(datatask)
                    if(type=="file"){
                        $("#file-dataTaskName").html(datatask.dataTaskName)
                        $("#file-dataSourceId").html(name)
                        /*$("#file-tableName").html(datatask.tableName)
                        $("#file-sqlString").html(datatask.sqlString)
                        $("#file-sqlTableNameEn").html(datatask.sqlTableNameEn)*/
                        var $filePath=$("#file-filePath")
                        var str = datatask.filePath.replace(/%_%/g, "/");
                        listSpan(str,";",$filePath)
                        /*$("#file-filePath").html(datatask.filePath)*/
                        $("#file-createTime").html(convertMilsToDateTimeString(datatask.createTime))
                        $("#file-creator").html(datatask.creator)
                        $("#file-size").html(datatask.fileSize)
                        $("#file-uploadpath").html(datatask.remoteuploadpath)
                        if(datatask.status == 1){
                            $("#file-status").html("导入完成")
                        }else {
                            $("#file-status").html("未导入完成")
                        }
                        $("#fileModal").modal('show');
                    }else {
                        $("#pre-dataTaskName").html(datatask.dataTaskName)
                        $("#pre-dataSourceId").html(name)
                        var $tableName=$("#pre-tableName")
                        listSpan(datatask.tableName,";",$tableName)
                        /*$("#pre-tableName").html(datatask.tableName)*/
                        var $sqlString=$("#pre-sqlString")
                        listSpan(datatask.sqlString,";",$sqlString)
                        /*$("#pre-sqlString").html(datatask.sqlString)*/
                        var $sqlTableNameEn=$("#pre-sqlTableNameEn")
                        listSpan(datatask.sqlTableNameEn,";",$sqlTableNameEn)
                        /*$("#pre-sqlTableNameEn").html(datatask.sqlTableNameEn)*/
                        /* $("#pre-filePath").html(datatask.filePath)*/
                        $("#pre-createTime").html(convertMilsToDateTimeString(datatask.createTime))
                        $("#pre-creator").html(datatask.creator)
                        if(datatask.period!="" && datatask.period!=null){
                            $("#periodDiv")[0].style.display="block";
                            var str="";
                            if(datatask.period=="3"){
                                str="3小时";
                            }else if(datatask.period=="6"){
                                str="6小时";
                            }else if(datatask.period=="24"){
                                str="天";
                            }else if(datatask.period=="168"){
                                str="周";
                            }else if(datatask.period=="720"){
                                str="月";
                            }
                            $("#pre-period").html(str);
                        }else{
                            $("#periodDiv")[0].style.display="none";
                        }
                        if(datatask.status == 1){
                            $("#pre-status").html("导入完成")
                        }else {
                            $("#pre-status").html("未导入完成")
                        }
                        $("#relModal").modal('show');
                    }
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }

        function editData(id) {
            window.location.href="${ctx}/datatask/editDatatask?datataskId="+id;
        }

        function showLog() {
            $("#logModal").modal('show');
        }

        var arr = []
       function ObjStory(keyid,souceid){
           this.keyID=keyid;
           this.souceID=souceid
       }
        arr.push(new ObjStory("1","2"))
        arr.push(new ObjStory("3","4"))

        if(localStorage.getItem("uploadList") == null){
            var uploadTasks = [];
        }else {
            var uploadTasks=JSON.parse(localStorage.getItem("uploadList"));
        }

        var setouts;
        var blockListSize=0;
        function getProcess(keyID,souceID) {
            setouts= setInterval(function () {
                $.ajax({
                    url:"${ctx}/ftpUploadProcess",
                    type:"POST",
                    async:true,
                    data:{
                        processId:souceID
                    },
                    success:function (data) {
                        data=data.replace(/[\r\n]/g,"");
                        var dataJson=JSON.parse(data);
                        if(dataJson.blockList.length>=blockListSize){
                            blockListSize=dataJson.blockList.length;
                        }else if(dataJson.blockList.length<blockListSize){
                            // tableConfiguration2(2)
                            // stopSetOuts();
                            // window.location.reload();
                          //  tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                        }

                        if(dataJson.process[0] >= 100 && dataJson.blockList.length==0){
                            $("."+souceID).text("上传成功")
                            stopSetOuts();
                            // window.location.reload();
                            tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                        }

                        try{
                            if(dataJson.process[0]==0 && dataJson.process[0]!=99){
                                $("."+souceID).text("正在上传");
                                $("[kkid="+souceID+"Loading]")[0].style.display="block";
                                $("[kkid="+souceID+"Pause]")[0].style.display="inline";
                                $("[kkid="+souceID+"Delete]")[0].style.display="none";//隐藏删除按钮
                              //  $("[kkid="+souceID+"Edit]")[0].style.display="none";//隐藏编辑按钮
                                $("[keyIdTd="+souceID+"]")[0].style.display="none";
                            }else if(dataJson.process[0]==99){
                                $("."+souceID).text("解压中...");
                                $("[kkid="+souceID+"Unziping]")[0].style.display="block";
                                $("[kkid="+souceID+"Pause]")[0].style.display="none";
                                $("[kkid="+souceID+"Delete]")[0].style.display="none";//隐藏删除按钮
                                $("[kkid="+souceID+"Edit]")[0].style.display="none";//隐藏编辑按钮
                            }else{
                                $("."+souceID).text("正在上传");
                                $("[keyIdTd="+souceID+"]")[0].style.display="none";
                                $("[kkid="+souceID+"Loading]")[0].style.display="none";
                                $("[kkid="+souceID+"Pause]")[0].style.display="inline";
                                $("[kkid="+souceID+"Delete]")[0].style.display="none";//隐藏删除按钮
                                if($("[kkid="+souceID+"Edit]").length!=0){//第二次上传不需要隐藏
                                    $("[kkid="+souceID+"Edit]")[0].style.display="none";//隐藏编辑按钮
                                }
                                $("[kkid="+souceID+"]")[0].style.width=dataJson.process[0]+"%";
                                $("[kkid="+souceID+"Text]")[0].textContent=dataJson.process[0]+"%";
                            }
                        }catch (e) {
                            requestStr="";
                            stopSetOuts();
                            console.log(e);
                        }

                    }
                })
            },1000)
           // setouts=setout;
        }

        function stopSetOuts(){
            var start = (setouts - 100) > 0 ? setouts -100 : 0;
            for(var i = start; i <= setouts; i++){
                clearInterval(i);
            }
        }

        function tableConfiguration2(num,datataskType,status) {
            stopSetOuts();
            pageNum=num;
            $.ajax({
                url:"${ctx}/datatask/list",
                type:"GET",
                data:{
                    pageNo:num,
                    datataskType:datataskType,
                    status:status
                },
                success:function (data) {
                   /* $(".table-message").hide();*/
                    $("#bd-data").html("");
                    var DataList = JSON.parse(data);
                    taskProcessStr=DataList.taskProcessList[0];//刷新页面后，获取上传进度
                    requestStr=DataList.requestList[0];//刷新页面后，获取正在上傳的任務
                    console.log(DataList)

                    var tabCon = template("resourceTmp1", DataList);
                    $("#bd-data").append(tabCon);

                    if(DataList.dataTasks.length == 0){
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $("#pagination").html("");
                        return
                    }
                    $(".table-message").html("");
                    //循环设置进度条
                    for(var taskId in taskProcessStr){//用javascript的for/in循环遍历对象的属性
                        if(taskProcessStr[taskId]!=0 && taskProcessStr[taskId]!=100){
                            $("[kkid="+taskId+"]")[0].style.width=taskProcessStr[taskId]+"%";
                            $("[kkid="+taskId+"Text]")[0].textContent=taskProcessStr[taskId]+"%";
                        }
                    }
                    //循環設置定時器
                    for(var request in requestStr){
                        var souceID = request.substr(0,request.indexOf("Block"));
                        var keyID = souceID + new Date().getTime();
                        getProcess(keyID,souceID);
                    }
                    /*
                    * 创建table
                    * */
                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }
                    var totalpage = Math.ceil(DataList.totalCount/DataList.pageSize)
                    $(".page-message").html("当前第&nbsp;<span style='color:blue'>" + pageNum + "</span>&nbsp;页,&nbsp;共&nbsp;<span style='color:blue'>" + totalpage + "</span>&nbsp;页,&nbsp;&nbsp;共&nbsp;<span style='color:blue'>" + DataList.totalCount + "</span>&nbsp;条数据");
                    $('#pagination').bootpag({
                        total: totalpage,
                        page:DataList.pageNo,
                        maxVisible: DataList.pageSize,
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
                        tableConfiguration2(num,datataskType,status);
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }

        function listSpan(arrStr,spl,ele){
            var newStr = arrStr.substr(0, arrStr.length - 1);
            var arrList =  newStr.split(spl);
            if(arrList[0] ==""){
                ele.empty()
                return
            }
            var arrListStr = ""
            for(var i=0;i<arrList.length;i++){
                arrListStr+="<span class='arrListSty'>"+arrList[i]+"</span>"
            }
            ele.empty()
            ele.append(arrListStr)
        };

        //暂停
       function pauseUpLoading(taskId,time){
           // clearInterval();
           stopSetOuts();
           $("."+taskId).text("已暂停");
           $.ajax({
               url:"${ctx}/pauseUpLoading",
               type:"post",
               data:{
                   taskId:taskId,
                   time:time
               },
               success:function (data) {
                  toastr["success"]("任务"+taskId+":  已暂停");
                  tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
               },
               error:function () {
                   console.log("请求失败")
               }
           })
       }

        var timer = null;

       //双击取消同步
        function cancelSync(e,taskId,syncData){
            clearTimeout(timer);
            if(syncData=="false"){
                toastr["warning"]("此任务已暂停同步！");
                e.children[0].className="glyphicon glyphicon-refresh";
                return;
            }
            $.ajax({
                url:"${ctx}/changeSyncStatus",
                type:"POST",
                async:true,
                data:{
                    taskId:taskId,
                    sync:"false"
                },
                success:function (data) {
                    if(data=="1"){
                        toastr["success"]("暂停同步！");
                        // e.children[0].style.color="red";
                    }else {
                        toastr["error"]("暂停失敗！");
                    }
                    // e.children[0].className="glyphicon glyphicon-refresh";
                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);

                },
                error:function () {
                    toastr["error"]("暂停失败！");
                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                }
            });

        };

        //开始同步
        function startSync(e,taskId,syncStatus){
            e.children[0].className="glyphicon glyphicon-refresh loading spin";
            clearTimeout(timer);
            timer = setTimeout(function() { //在单击事件中添加一个setTimeout()函数，设置单击事件触发的时间间隔
                $.ajax({
                    url:"${ctx}/changeSyncStatus",
                    type:"POST",
                    async:true,
                    data:{
                        taskId:taskId,
                        sync:"true"
                    },
                    success:function (data) {
                        if(data=="1" && syncStatus=="true"){
                            toastr["success"]("同步成功！");
                        }else if(data=="1" && syncStatus=="false"){
                            toastr["success"]("本次同步成功！");
                            toastr["success"]("开启定时同步！");
                            // e.children[0].style.color="#5f9cd2";
                        }else {
                            toastr["error"]("开启/同步失敗！");
                        }
                        tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                        // e.children[0].className="glyphicon glyphicon-refresh";

                    },
                    error:function () {
                        toastr["error"]("开启失败！");
                        tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                    }
                });
            }, 300);


        };

        function rightClick(taskId,period){
            datataskId=taskId;
            $("#syncSelect option[value='"+period+"']").attr("selected","selected");
            showRMenu("root", event.clientX, event.clientY);
        }
        function showRMenu(type, x, y) {
            $("#rMenu")[0].style.display="block"

            y += document.body.scrollTop;
            x += document.body.scrollLeft;
            $("#rMenu").css({"top":y-50+"px", "left":x+"px", "visibility":"visible"});
            $("body").bind("mousedown", onBodyMouseDown);
        }

        function showEditSyncModel() {
            $('#editSyncModal').modal('show');
        }

        function hidenFileNameModal() {
            $("#editSyncModal").modal("hide");
        }
        
        function saveSyncPeriod() {
            var period=$("#syncSelect").val();
            if(period=="" || period==null){
                toastr["error"]("请选择同步周期！");
                return;
            }
            $.ajax({
                url:"${ctx}/datatask/updateSyncPeriod",
                type:"POST",
                aysnc:true,
                timeout:30000,
                data:{
                    datataskId:datataskId,
                    period:period
                },
                complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
                    if(status=='timeout'){//超时,status还有success,error等值的情况
                        toastr["error"]("提示！", "请求超时");
                        Bwrap.style.display="none";
                    }
                },
                success:function (data) {
                    hidenFileNameModal();
                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                    toastr["success"]("同步周期修改成功！");
                },
                error:function () {
                    console.log("请求失败")
                    tableConfiguration2(pageNum,dataSourceName,dataSourceStatus);
                }
            })
        }


        function fileLogDownload(){
          window.location.href='${ctx}/fileResource/downloadFile?fileName=Sync'+datataskId+'log.txt';
        }

    </script>
</div>

</html>
