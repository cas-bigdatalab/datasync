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
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div>
        <div class="uplod-head">
            <span>DataSync / 传输信息</span>
        </div>
        <div class="upload-title">
            <span>数据上传任务列表</span>
            <a href="${ctx}/createTask">新建任务</a>
        </div>
        <div class="upload-search">
            <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="名称">
            <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="数据类型">
            <input type="text" class="form-control" style="width: 200px;display: inline-block" placeholder="状态">
            <button type="button" class="btn btn-success" style="margin-left: 166px">查询</button>
            <button type="button" class="btn btn-success">全部上传</button>
        </div>
        <div class="upload-table">
            <div class="table-message">列表加载中......</div>
            <table class="table table-bordered data-table" id="upload-list" >
                <thead>
                <tr>
                    <th>任务编号</th>
                    <th>任务标识</th>
                    <th>数据来源类型</th>
                    <th>数据源</th>
                    <th>创建时间</th>
                    <th>上传进度</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="bd-data">
                <%--<tr>
                    <td>1</td>
                    <td>aaaa</td>
                    <td>aaaaaa</td>
                    <td>aaaaaa</td>
                    <td>aaaaaa</td>
                    <td>aaaaaa</td>
                    <td><button type="button" class="btn btn-success upload">上传</button></td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>高能物理主题数据库</td>
                    <td>关系数据库</td>
                    <td>dataOneDB</td>
                    <td>2018-04-12 09:12</td>
                    <td>成功</td>
                    <td><button type="button" class="btn btn-success">重新上传</button></td>
                </tr>--%>
                </tbody>
            </table>
            <div class="page-message" style="background-color: silver;height: 40px">

            </div>
            <div class="page-list" style="background-color: yellow;height: 20px"></div>
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
            <td  id="{{value.id}}">--</td>
            <td  class="{{value.id}}">--</td>
            <td>
                <button type="button" class="btn btn-success btn-sm exportSql" keyIdTd="{{value.id}}"  value="{{value.id}}" >导出SQL文件</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-success upload-data btn-sm" keyIdTd="{{value.id}}"  {{value.isdis}}>{{btnName(value.num)}}</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-success edit-data btn-sm" keyIdTd="{{value.id}}" >查看</button>
            </td>
        </tr>
        {{/each}}
    </script>
</div>
<div id="EModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body" style="min-height: 100px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务标识:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">数据源ID:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">表名:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">SQL语句:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">逻辑表名:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">文件路径:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建者:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">上传进度:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8"></div>
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
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>

    <script>
        $(function(){

        });
        var uploadList=[];
        template.helper("btnName",function (num) {
            var name=""
            if(num ==0){
                name="&nbsp;&nbsp;&nbsp;上传&nbsp;&nbsp;&nbsp;"
            }else {
                name="重新上传"
            }
            return name
        })
        $("#upload-list").delegate(".upload-data","click",function () {
            /*init();*/
            /*send request*/
            $(this).css("background-color","dimgrey");
            $(this).attr("disabled","disabled");

            var souceID = $(this).attr("keyIdTd");
            var keyID = souceID + new Date().getTime();
            $.ajax({
                url:"${ctx}/ftpUpload",
                type:"POST",
                data:{dataTaskId:souceID,processId:keyID},
                success:function (data) {

                    /*send request get Process */

                },
                error:function () {
                    console.log("请求失败")
                }
            })
            $("."+souceID).text("正在导入")
            getProcess(keyID,souceID);
        })
        $("#upload-list").delegate(".edit-data","click",function () {
            /*send request*/
            var souceID = $(this).attr("keyIdTd");

            /*$.ajax({
                url:"${ctx}/getDataContent",
                type:"POST",
                data:{processId:souceID},
                success:function (data) {
                    console.log(data)

                },
                error:function () {
                    console.log("请求失败")
                }
            })*/
            $("#EModal").modal('show');
        })
        var List ={
            list:[
                {
                    id:"1",
                    name:"aaa",
                    data:"关系数据库",
                    source:"a数据库",
                    time:"2018-04-12 09:12",
                    num:0,
                    isdis:""
                },
                {
                    id:"222222",
                    name:"aaa",
                    data:"关系数据库",
                    source:"a数据库",
                    time:"2018-04-12 09:12",
                    num:1,
                    isdis:""
                },
                {
                    id:"3333333",
                    name:"aaa",
                    data:"关系数据库",
                    source:"a数据库",
                    time:"2018-04-12 09:12",
                    num:2,
                    isdis:true
                },
                {
                    id:"4444444",
                    name:"aaa",
                    data:"关系数据库",
                    source:"a数据库",
                    time:"2018-04-12 09:12",
                    num:1
                }
            ]
        }
        var aaa = template("resourceTmp1", List);
        init();
        function init() {
            $("#bd-data").empty();
            $("#bd-data").append(aaa);
        }


        function getProcess(keyID,souceID) {
           var setout= setInterval(function () {
                $.ajax({
                    url:"${ctx}/ftpUploadProcess",
                    type:"POST",
                    data:{
                        processId:keyID
                    },
                    success:function (data) {
                        if(data == "100"){
                            $("."+souceID).text("导入完成")
                            clearInterval(setout)
                        }
                        $("#"+souceID).text(data+"%");
                    }
                })
            },1000)

        }
        function getPrecent(id) {
            setInterval(function () {
                console.log(id)
            },1100)
        }
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


        //导出SQL文件
        $("#upload-list").delegate(".exportSql","click",function () {
            var souceID = $(this).attr("keyIdTd");
            //var keyID = souceID + new Date().getTime();
            $.ajax({
                url:"${ctx}/task/" + souceID,
                type:"POST",
                dataType:"JSON",
                success:function (data) {
                    console.log(data.result);
                    if (data.result == 'true') {
                        alert("导出SQL文件成功!");
                    }
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });
    </script>
</div>

</html>
