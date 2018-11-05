<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/30
  Time: 13:28
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
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div class="page-content">
    <div>
        <div class="uplod-head">
            <span>DataSync / 传输信息</span>
        </div>
        <div class="alert alert-info" role="alert">
            <!--查询条件 -->
            <div class="row">
                <form class="form-inline" style="margin-bottom: 0px">
                    <div class="form-group">
                        <label>数据类型</label>
                        <select id="dataSourceList" class="form-control" style="width: 150px">
                            <option value="">全部</option>
                            <option value="db">关系数据库</option>
                            <option value="file">文件数据库</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select id="dataStatusList" class="form-control" style="width: 150px">
                            <option value="">全部</option>
                            <option value="1">上传完成</option>
                            <option value="0">未上传</option>
                        </select>
                    </div>
                    <button type="button" class="btn blue" style="margin-left: 49px" id="seachDataSource">查询</button>
                    <button type="button" class="btn green" style="margin-left: 49px" onclick="newRelease()">新建发布
                    </button>
                </form>
            </div>
        </div>
        <div class="upload-table">
            <h2 class="table-message">列表加载中......</h2>
            <table class="table table-bordered data-table" id="upload-list">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>数据集名称</th>
                    <th>类型</th>
                    <th>来源位置</th>
                    <th>发布时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="bd-data">
                <tr>
                    <td>1</td>
                    <td>DB2Data</td>
                    <td>关系数据库</td>
                    <td>/dataOneDB</td>
                    <td>2018-04-02 10:14</td>
                    <td>成功</td>
                    <td>
                        <button type="button" class="btn green btn-xs " onclick="resSend()">重新发布</button>
                        <button type="button" class="btn blue btn-xs">查看</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="page-message" style="float: left;line-height: 56px"></div>
            <div class="page-list" style="float: right"></div>
        </div>
    </div>
</div>
<div id="EModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">任务标识:</label>
                        <div class="col-sm-8 modediv" id="pre-dataTaskName"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">数据源ID:</label>
                        <div class="col-sm-8 modediv" id="pre-dataSourceId"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">表名:</label>
                        <div class="col-sm-8 modediv" id="pre-tableName"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">SQL语句:</label>
                        <div class="col-sm-8 modediv" id="pre-sqlString"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">逻辑表名:</label>
                        <div class="col-sm-8 modediv" id="pre-sqlTableNameEn"></div>
                    </div>
                    <div class="form-group" style="word-break: break-all">
                        <label class="col-sm-3 control-label">文件路径:</label>
                        <div class="col-sm-8 modediv" id="pre-filePath"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8 modediv" id="pre-createTime"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">创建者:</label>
                        <div class="col-sm-8 modediv" id="pre-creator"></div>
                    </div>
                    <%--<div class="form-group">
                        <label  class="col-sm-3 control-label">上传进度:</label>
                        <div class="col-sm-8"></div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8 modediv" id="pre-status"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal"><i
                        class="glyphicon glyphicon-ok"></i>确认
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each resourceList as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.title}}</td>
        <td>{{value.publicType}}</td>
        <td>{{value.createdByOrganization}}</td>
        <td>{{dateFormat(value.creationDate)}}</td>
        <td id="{{value.dataTaskId}}">{{value.resState}}</td>
        <%--<td class="{{value.id}}">{{upStatusName(value.status)}}</td>--%>
        <td>
            <%--<button type="button" class="btn green btn-xs exportSql" keyIdTd="{{value.id}}"
                    value="{{value.id}}">&nbsp;&nbsp;&nbsp;导出&nbsp;&nbsp;&nbsp;
            </button>
            {{if value.status == 1}}
            <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" disabled
                    style="background-color: dimgrey">重新上传
            </button>
            {{else if value.status == 0}}
            <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}">&nbsp;&nbsp;&nbsp;上传&nbsp;&nbsp;&nbsp;</button>
            {{/if}}
            <button type="button" class="btn  edit-data btn-xs blue" keyIdTd="{{value.dataTaskId}}"><i
                    class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
            </button>
            <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataTaskId}}');"><i
                    class="glyphicon glyphicon-trash"></i>&nbsp;删除
            </button>--%>
                {{if value.resState == '待审核'}}
                <button type="button" class="btn green btn-xs exportSql" keyIdTd="{{value.id}}"
                        value="{{value.id}}">审核
                </button>
                {{/if}}
                <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.id}}"
                        style="background-color: dimgrey">编辑
                </button>
                <button type="button" class="btn  edit-data btn-xs blue" keyIdTd="{{value.id}}"><i
                        class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
                </button>
                <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.id}}');"><i
                        class="glyphicon glyphicon-trash"></i>&nbsp;删除
                </button>
        </td>
    </tr>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var dataSourceName = ""
        var dataSourceStatus = ""
        $(function(){
            tableConfiguration2(1,"","")
        });
        $("#dataSourceList").on("change", function () {
            dataSourceName = $("#dataSourceList option:selected").val();
        });
        $("#dataStatusList").on("change", function () {
            dataSourceStatus = $("#dataStatusList option:selected").val();
        });
        $("#seachDataSource").click(function () {
            tableConfiguration2(1);
        })
        $("#bd-data").delegate(".upload-data","click",function () {
            var id = $(this).attr("keyIdTd");
            console.log(id)
            window.location.href="${ctx}/resource/editResource?resourceId="+id;
        })

        function resSend() {
            window.location.href = "${ctx}/dataSourceDescribeEdit"
        }

        function newRelease() {
            window.location.href = "${ctx}/dataSourceDescribe"
        }

        function tableConfiguration2(num) {
            $.ajax({
                url: "${ctx}/resource/getPageData",
                type: "GET",
                data: {
                    pageNo: num,
                    title: "",
                    publicType: "",
                    pageSize: 10,
                    status: status
                },
                success: function (data) {
                    $(".table-message").hide();
                    $("#bd-data").html("");
                    var DataList = JSON.parse(data);
                    console.log(DataList)
                    var tabCon = template("resourceTmp1", DataList);
                    $("#bd-data").append(tabCon);

                    if (DataList == "{}") {
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
                    $(".page-message").html("当前第" + DataList.pageNum + "页,共" + DataList.pageSize + "页,共" + DataList.totalCount + "条数据");
                    $('.page-list').bootpag({
                        total: DataList.pageSize,
                        page: DataList.pageNo,
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
                        tableConfiguration2(num);
                    });
                },
                error: function () {
                    $(".table-message").html("请求失败");
                }
            })
        }
    </script>
</div>

</html>

