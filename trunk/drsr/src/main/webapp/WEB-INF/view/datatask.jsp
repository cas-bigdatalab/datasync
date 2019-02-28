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
    <style type="text/css">
        .arrListSty{
            display: inline-block;
            margin-right: 5px;
            background-color: #aaaaaa;
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
    </style>
</head>
<body>
<div class="page-content">
    <div>
        <div class="uplod-head">
            <h3>
                数据任务
            </h3>
            <hr>
        </div>
        <%--<div class="upload-title">
            <span>数据上传任务列表</span>
            &lt;%&ndash;<a href="${ctx}/createTask">新建任务</a>&ndash;%&gt;
        </div>--%>
        <div class="alert alert-info" role="alert" style="margin:0  33px">
            <!--查询条件 -->
            <div class="row">
                <div class="col-md-9">
                    <form class="form-inline" style="margin-bottom: 0px">
                        <div class="form-group" >
                            <label >数据类型</label>
                            <select  id="dataSourceList" class="form-control" style="width: 150px">
                                <option value="">全部</option>
                                <option value="mysql">mysql</option>
                                <option value="file">file</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label  >状态</label>
                            <select  id="dataStatusList" class="form-control" style="width: 150px">
                                <option value="">全部</option>
                                <option value="1">上传/导入完成</option>
                                <option value="0">未上传</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-sm blue" style="margin-left: 49px" id="seachTaskSource"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                    </form>
                </div>
                <div class="col-md-3" style="text-align: right">
                    <button type="button" class="btn btn-sm green" style="margin-left: 49px" onclick="relCreateTask()"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增数据任务</button>
                </div>
            </div>
        </div>
        <div class="upload-table">
            <div class="table-message">列表加载中......</div>
            <table class="table table-bordered data-table" id="upload-list" >
                <thead>
                <tr>
                    <th>编号</th>
                    <th>任务标识</th>
                    <th>数据类型</th>
                    <th>数据源</th>
                    <th>编辑时间</th>
                    <th width="10%">上传进度</th>
                    <th width="7%">状态</th>
                    <th width="29%">操作</th>
                </tr>
                </thead>
                <tbody id="bd-data"></tbody>
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

                <button type="button" data-dismiss="modal" class="btn  default">关闭</button>
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
                        <div class="col-sm-8 modediv" id="file-filePath" style="max-height: 300px;overflow-x: hidden"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8 modediv" id="file-createTime"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">创建者:</label>
                        <div class="col-sm-8 modediv" id="file-creator"></div>
                    </div>--%>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">上传进度:</label>
                        <div class="col-sm-8"></div>
                    </div>--%>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8 modediv" id="file-status"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" data-dismiss="modal" class="btn default">关闭</button>
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
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each dataTasks as value i}}
    <tr keyIdTr="{{value.dataTaskId}}">
        <td>{{i + 1}}</td>
        <td>{{value.dataTaskName}}</td>
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
                <button type="button" class="btn purple btn-xs" onclick="editData('{{value.dataTaskId}}');"><i class="fa fa-edit"></i>&nbsp;编辑</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                {{else if value.logPath  != "" }}
                <button type="button" kkid="{{value.dataTaskId}}Pause" style="display: none;"  class="btn red btn-xs" onclick="pauseUpLoading('{{value.dataTaskId}}',new Date().getTime());"><i class="glyphicon glyphicon-pause"></i>&nbsp;暂停</button>
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" keyDataType="{{value.dataTaskType}}" resupload="one"><i class="glyphicon glyphicon-upload"></i>&nbsp;上传</button>
                <button type="button" class="btn purple btn-xs" onclick="editData('{{value.dataTaskId}}');"><i class="fa fa-edit"></i>&nbsp;编辑</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                <button type="button" class="btn  btn-xs yellow-lemon remove-data" onclick="window.location.href='${ctx}/fileResource/downloadFile?dataTaskId={{value.dataTaskId}}'"><i class="glyphicon glyphicon-book"></i>&nbsp;日志</button>
            {{/if}}
            {{else if value.status  == 1 }}
                <button type="button" kkid="{{value.dataTaskId}}Pause" style="display: none;"  class="btn red btn-xs" onclick="pauseUpLoading('{{value.dataTaskId}}',new Date().getTime());"><i class="glyphicon glyphicon-pause"></i>&nbsp;暂停</button>
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" keyDataType="{{value.dataTaskType}}" resupload="two"><i class="glyphicon glyphicon-upload"></i>&nbsp;上传</button>
                <button type="button" class="btn  edit-data btn-xs blue" onclick="showData('{{value.dataTaskId}}','{{value.dataTaskType}}','{{value.dataSrc.dataSourceName}}')" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
                <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
                <button type="button" class="btn  btn-xs yellow-lemon remove-data" onclick="window.location.href='${ctx}/fileResource/downloadFile?dataTaskId={{value.dataTaskId}}'"><i class="glyphicon glyphicon-book"></i>&nbsp;日志</button>
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
        var dataSourceName=""
        var dataSourceStatus=""
        var uploadListFlag = $("#uploadListFlag")
        function relCreateTask(){
            window.location.href="${ctx}/createTask";
        }
        $(function(){
            tableConfiguration2(1,"","")
        });
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
                        if(keyType =="mysql"){

                            console.log("mysql数据源")
                            $.ajax({
                                url:"${ctx}/datatask/" + souceID,
                                type:"POST",
                                dataType:"JSON",
                                success:function (data) {
                                    console.log("aaaaaaaaaaaaa")
                                    if (data.result == 'true') {

                                        $.ajax({
                                            url:"${ctx}/ftpUpload",
                                            type:"POST",
                                            data:{dataTaskId:souceID,processId:keyID},
                                            success:function (data) {
                                                var data =JSON.parse(data)
                                                $("[name="+keyID+"]").attr("valFlag","true")
                                                if(keyType == "mysql"){
                                                    if(data =="1"){
                                                        toastr["success"]("导入成功！");
                                                        $("."+souceID).text("已导入")
                                                        tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                                        return
                                                    }else {
                                                        $("."+souceID).text("导入失败")
                                                        return
                                                    }
                                                }else {
                                                    if(data =="1"){
                                                        toastr["success"]("上传成功！");
                                                        $("."+souceID).text("已上传")
                                                        tableConfiguration2(1,dataSourceName,dataSourceStatus)
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
                                       // $("."+souceID).text("正在上传");
                                        getProcess(keyID,souceID);

                                    }else {
                                        return
                                    }
                                },
                                error:function () {
                                    console.log("请求失败")
                                }
                            })
                        }else{
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
                                            tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                        }else {
                                            $("."+souceID).text("导入失败")
                                            return
                                        }
                                    }else {
                                        if(data =="1"){
                                            toastr["success"]("上传成功！");
                                            $("."+souceID).text("已上传")
                                            tableConfiguration2(1,dataSourceName,dataSourceStatus)
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
                        }
                    }else {
                        console.log("bbbbbbbbbbbbbbbbbbbb")
                        return
                    }
                })
            }else{
                uploadListFlag.append("<span name="+keyID+" valFlag='false'></span>")
                if(keyType =="mysql"){
                    $.ajax({
                        url:"${ctx}/datatask/" + souceID,
                        type:"POST",
                        dataType:"JSON",
                        success:function (data) {
                            if (data.result == 'true') {
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
                                                tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                                return
                                            }else {
                                                $("."+souceID).text("导入失败")
                                                return
                                            }
                                        }else {
                                            if(data =="1"){
                                                toastr["success"]("上传成功！");
                                                $("."+souceID).text("已上传")
                                                tableConfiguration2(1,dataSourceName,dataSourceStatus)
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
                               // $("."+souceID).text("正在上传");
                                getProcess(keyID,souceID);

                            }else {
                                return
                            }
                        },
                        error:function () {
                            console.log("请求失败")
                        }
                    })
                }else{
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
                                    tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                }else {
                                    $("."+souceID).text("导入失败")
                                    return
                                }
                            }else {
                                if(data =="1"){
                                    toastr["success"]("上传成功！");
                                    $("."+souceID).text("已上传")
                                    // window.location.reload();
                                    tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                }else if(data=="0"){
                                    stopSetOuts();
                                    toastr["error"]("连接FTP出错：请检查网络连接！");
                                    tableConfiguration2(1,dataSourceName,dataSourceStatus)
                                    $("[kkid="+souceID+"Loading]")[0].style.display="none";
                                    $("[kkid="+souceID+"LoadingFail]")[0].style.display="block";
                                    $("."+souceID).text("ftp断开")
                                }else if(data=="4"){
                                    toastr["error"]("文件不存在！");
                                    $("."+souceID).text("上传失败")
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
                   // $("."+souceID).text("正在上传");
                    getProcess(keyID,souceID);
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
                            toastr["success"]("删除成功");
                            tableConfiguration2(1,dataSourceName,dataSourceStatus);
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
                    if(type=="mysql"){
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
                        if(datatask.status == 1){
                            $("#pre-status").html("导入完成")
                        }else {
                            $("#pre-status").html("未导入完成")
                        }
                        $("#relModal").modal('show');
                    }else {
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
                        if(datatask.status == 1){
                            $("#file-status").html("导入完成")
                        }else {
                            $("#file-status").html("未导入完成")
                        }
                        $("#fileModal").modal('show');
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
            setout= setInterval(function () {
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
                            window.location.reload();
                        }

                        if(dataJson.process[0] >= 100 && dataJson.blockList.length==0){
                            $("."+souceID).text("上传成功")
                            stopSetOuts();
                            window.location.reload();
                        }
                       if(dataJson.process[0]==0 && dataJson.process[0]!=99){
                           $("."+souceID).text("正在上传");
                           $("[kkid="+souceID+"Loading]")[0].style.display="block";
                           $("[kkid="+souceID+"Pause]")[0].style.display="inline";
                           $("[keyIdTd="+souceID+"]")[0].style.display="none";
                       }else if(dataJson.process[0]==99){
                           $("."+souceID).text("解压中...");
                           $("[kkid="+souceID+"Unziping]")[0].style.display="block";
                           $("[kkid="+souceID+"Pause]")[0].style.display="none";
                       }else{
                           $("."+souceID).text("正在上传");
                           $("[keyIdTd="+souceID+"]")[0].style.display="none";
                           $("[kkid="+souceID+"Loading]")[0].style.display="none";
                           $("[kkid="+souceID+"Pause]")[0].style.display="inline";
                            $("[kkid="+souceID+"]")[0].style.width=dataJson.process[0]+"%";
                            $("[kkid="+souceID+"Text]")[0].textContent=dataJson.process[0]+"%";
                       }

                    }
                })
            },1000)
            setouts=setout;
        }

        function stopSetOuts(){
            var start = (setouts - 100) > 0 ? setouts -100 : 0;
            for(var i = start; i <= setouts; i++){
                clearInterval(i);
            }
        }

        function tableConfiguration2(num,datataskType,status) {
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
                    $(".page-message").html("当前第<span style='color:blue'>"+DataList.pageNum +"</span>页,共<span style='color:blue'>"+totalpage +"</span>页,共<span style='color:blue'>"+DataList.totalCount+"</span>条数据");
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
           $("."+taskId).text("已暂停");
           $.ajax({
               url:"${ctx}/pauseUpLoading",
               type:"post",
               data:{
                   taskId:taskId,
                   time:time
               },
               success:function (data) {
                  //toastr["success"]("任务"+taskId+":  已暂停");
               },
               error:function () {
                   console.log("请求失败")
               }
           })
       }

    </script>
</div>

</html>
