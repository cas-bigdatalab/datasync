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
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="source-head">
        <span>DataSync / 数据源</span>
    </div>
    <div class="source-title">
        <span>数据源信息管理</span>
        <a href="javascript:void(0)" id="addDB">添加</a>
    </div>
    <div class="source-table">
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" >
            <thead>
            <tr>
                <th>任务编号</th>
                <th>名称</th>
                <th>数据来源</th>
                <th>上传位置</th>
                <th>创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td class="source-name">高能物理主题数据库</td>
                <td class="source-DB">关系数据库</td>
                <td class="source-local">dataOneDB</td>
                <td>2018-04-12 09:12</td>
                <td>成功</td>
                <td><button type="button" class="btn btn-success btn-sm" keyID="aaa">编辑</button></td>
            </tr>
            <tr>
                <td>2</td>
                <td class="source-name">高能物理主题数据库</td>
                <td class="source-DB">关系数据库</td>
                <td class="source-local">dataOneDB</td>
                <td>2018-04-12 09:12</td>
                <td>成功</td>
                <td><button type="button" class="btn btn-success btn-sm" keyID="bbb">编辑</button></td>
            </tr>
            </tbody>
        </table>
        <div class="page-message">

        </div>
        <div class="page-list"></div>
    </div>
</div>
<div id="addModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加数据源信息</h4>
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
                                <option value="">------------</option>
                                <option value="">------------</option>
                                <option value="">------------</option>
                            </select>
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
<div id="EModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加数据源信息</h4>
            </div>
            <div class="modal-body" style="min-height: 100px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="chinaName2" class="col-sm-3 control-label">数据源名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="chinaName2" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="englishName2" class="col-sm-3 control-label">数据来源</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="englishName2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">上传位置</label>
                        <div class="col-sm-8">
                            <select name="" id="selDB" class="form-control">
                                <option value="" selected="selected">------------</option>
                                <option value="">dataOneDB</option>
                                <option value="">dataTwoDB</option>
                                <option value="">dataThreeDB</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal" onclick="confirmEditNode();" ><i
                        class="glyphicon glyphicon-ok"></i>完成
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each list as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.name}}</td>
        <td>{{value.data}}</td>
        <td>{{value.source}}</td>
        <td>{{value.time}}</td>
        <td class="upload-percent">--</td>
        <td><button type="button" class="btn btn-success" keyIdTd="{{value.id}}" >{{btnName(value.num)}}</button></td>
    </tr>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>

    <script>
        $(function(){

        });
        var editSouceID ="";
        var documentTr = null;
        /*get edit data*/
        $(".source-table").delegate("button","click",function () {
            editSouceID = $(this).attr("keyID");
            documentTr = $(this).parent().parent();
            /*$.ajax({
                type: "GET",
                url: '${ctx}/license/info',
            data: {"id": id},
            dataType: "json",
            success: function (data) {
                $("#id_edit").val(data.license.id);
                $("#name_edit").val(data.license.name);
                $("#org_edit").val(data.license.org);
                $("#content_edit").val(data.license.content);
                $('#image-edit-preview-id').attr('src', ctx + data.license.icon);
            }
        });*/
            $("#EModal").modal('show');
        })
        /*get data table*/
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
        function confirmDeleteNode(){
            $(".form-horizontal [type='text']").val("")
            alert("ok")
        }
        function confirmEditNode(){
            documentTr.find(".source-name").text($("#chinaName2").val())
            documentTr.find(".source-DB").text($("#englishName2").val())
            documentTr.find(".source-local").text($("#selDB option:selected").text())
            $("#chinaName2").val("");
            $("#englishName2").val("")
            $("#selDB option:first").prop("selected", 'selected');
            $.ajax({
                url:"",
                type:"POST",
                data:{
                    id:editSouceID
                },
                success:function () {

                }
            })
        };
        function confirmAddNode(){
            $.ajax({

            })
        }
        $("#addDB").click(function () {
            $("#addModal").modal('show');
        })
    </script>
</div>

</html>
