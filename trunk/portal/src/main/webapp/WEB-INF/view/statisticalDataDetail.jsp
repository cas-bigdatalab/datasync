<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2019/3/6
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>
<head>
    <title>统计管理detail</title>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/resources/bundles/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctx}/resources/bundles/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.css">
    <link href="${ctx}/resources/css/home.css" type="text/css"/>
    <style type="text/css">
        .css_chartsleft {
            width: 35%;
            height: 100%;
            float: left;
            margin-left: 2%;
        }

        .css_charts {
            width: 35%;
            height: 100%;
            float: left;
            margin-left: 18%;
            margin-right: 10%;
        }

        #datashowvisitTotal {
            width: 80%;
            height: 50%;
            margin-left: 4%;
            /*margin-right: 10%;*/
        }

        #datashowdownTotal {
            width: 80%;
            height: 50%;
            margin-left: 4%;
            /*margin-right: 10%;*/
        }
        .report-title{border-bottom: #ccc 1px solid; height: 20px;}
        .report-title h4{background-color: #fff; float:left; font-size: 18px; color:#296ebf; padding-right: 5px;}
        .report-title div{float: left; width: 25px; height: 20px; border-bottom: #296ebf 1px solid;}
        .report-title a.more{float: right; background: #fff; padding-left: 5px; padding-top:8px;}

    </style>
</head>
<body>
        <div class="tap_div" style="margin-top:15px;">
        <div id="div1" style="width: 100%;height:400px;">
            <div class="report-title">
                <h4><i class="fa fa-caret-right"></i>专题库访问量下载TOP10统计</h4>
                <div></div>
                <a href="#" class="more" onclick="func_moreDetail()">查看更多</a>
            </div>
            <div style="width: 100%;height:100%;margin-top: 2%" class="report-content row">
            <div id="datashowvisit" class="css_chartsleft"></div>
            <div id="datashowdown" class="css_charts"></div>
            </div>
        </div>

        <%-- 专题详情--%>
        <div id="div2" style="width: 100%;height:700px; display: none;">
                <div class="report-title">
                    <h4><i class="fa fa-caret-right"></i>专题库访问量下载量统计</h4>
                    <div></div>
                    <a href="#" class="more" onclick="func_toTopTen()">返回</a>
                </div>
            <div id="datashowvisitTotal"></div>
            <div id="datashowdownTotal" style="margin-top: 30px;"></div>
        </div>

        <%--数据集Top10--%>
        <div style="width: 100%;height:400px;margin-top: 100px;">
            <div class="report-title">
                <h4><i class="fa fa-caret-right"></i>数据集访问量下载量TOP10统计</h4>
                <a href="#" class="more"></a>
            </div>
            <div style="width: 100%;height:100%;margin-top: 2%;" class="report-content row">
                <div id="datacollectionvisit" class="css_chartsleft"></div>
                <div id="datacollectiondown" class="css_charts"></div>
            </div>
        </div>


        <%--显示所有专题库--%>
        <div id="themeList" style="width: 100%;height:40%;margin-top: 100px;">
            <%--<div style="background-color: #0d957a;color: #FFFFFF;height:3%;width: 200px;height: 30px;">按专题库查看访问量下载量--%>
            <%--</div>--%>
                <div class="report-title">
                    <h4><i class="fa fa-caret-right"></i>按专题库查看访问量下载量</h4>
                    <div></div>
                    <a href="#" class="more"></a>
                </div>
                <div class="clearfix"></div>
            <div  class="report-content row"  style="height-min:300px;width:100%; ">
                <div id="showAllThemeSpan" class="pic-items">

                </div>
            </div>
        </div>
        <%--根据专题库查看该专题库内的访问量下载量--%>
        <div id="themeDetail" style="width: 100%;height:70%;margin-top: 100px;display: none;margin-bottom: 3%;">
            <%--<div style="width: 100%;height: 10%;">--%>
                <%--<span style="float: left;background-color: #0d957a;color: #FFFFFF;height:3%;width: 200px;height: 30px;">按专题库查看访问量下载量</span>--%>
                <%--<span style="float: left;margin-left: 30%;"><a>
                <button id="reback_id"  style="background-color: #0d957a;color: #FFFFFF;height:3%;width: 100px;height: 30px;"><<<</button></a></span>--%>
            <%--</div>--%>
                <div class="report-title">
                    <h4><i class="fa fa-caret-right"></i>按专题库查看访问量下载量</h4>
                    <div></div>
                    <a id="reback_id" href="#" class="more">返回</a>
                </div>
            <div id="themeDetail111" style="width: 80%;margin-top:1%;margin-left: 10%;height: 25%;">

            </div>
            <div id="detialCharts" style="width: 100%; float: none">
                <%--<div id="singlethemeChartsV"  style=" margin-left: 10%;width: 35%;float: left; height:60%;"></div>--%>
                <%--<div id="singlethemeChartsD"   style="margin-left: 10%;margin-right: 10%;width: 35%;float: left;height:60%;"></div>--%>
                <table id="singleThemeTable" class="table table-bordered data-table">
                    <thead>
                    <tr>
                        <th width="60%">数据集名</th>
                        <th width="20%">访问量<i id="vcount_desc" class="fa fa-sort-desc" aria-hidden="true"
                                              onclick="func_asc()"></i>
                            <i id="vcount_asc" class="fa fa-sort-asc" aria-hidden="true" style="display: none;"
                               onclick="func_desc()"></i></th>
                        <th width="20%">下载量<i id="dcount_desc" class="fa fa-sort-desc" aria-hidden="true"
                                              onclick="func_ascDown()"></i>
                            <i id="dcount_asc" class="fa fa-sort-asc" aria-hidden="true" style="display: none;"
                               onclick="func_descDown()"></i>
                        </th>
                    </tr>
                    </thead>
                    <tbody id="single_tbody"></tbody>
                </table>

                <div class="review-item clearfix">

                    <div id="page_div" style="padding-top: 25px; float: left; display: none;">
                        当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span
                            style="color:blue;"
                            id="totalPages"></span>页,<span
                            style="color:blue;" id="totalCount"></span>条数据
                    </div>
                    <div style="float: right;">
                        <div id="pagination"></div>
                    </div>

                </div>
            </div>
        </div>
        </div>


<script type="text/html" id="showAllTheme">
    {{each list as value i}}
    <%--<span style="float: left;width:13%;margin-left: 3%;">--%>
         <%--<a href="javaScript:void(0)" id="{{value.subjectCode}}" onclick="findBySubjectCode(this)">--%>
             <%--<img src="${ctx}/{{value.imagePath}}"/>--%>
         <%--</a>--%>
        <%--<br/>--%>
        <%--<p>{{value.subjectName}}</p>--%>
    <%--</span>--%>

    <div class="pic-item" style=" width: 20%; float: left; padding: 5px;height: 250px;">
        <a href="javaScript:void(0)" id="{{value.subjectCode}}" onclick="findBySubjectCode(this)">
            <img src="${ctx}/IoReadImage?filePath={{value.imagePath}}" width="100%;"/>
            <h5 style="text-align: center;" >{{value.subjectName}}</h5>
        </a>
   </div>
   {{/each}}
</script>

<script type="text/html" id="showThemeDetial11">
   {{each subject as value i}}
   <%--<span style="width:13%;margin-left: 3%;float: left">--%>
            <%--<img src="${ctx}/{{value.imagePath}}"/>--%>
       <%--<br/>--%>
       <%--<p>{{value.subjectName}}</p>--%>
   <%--</span>--%>
   <%--<span style="float: left;">简介：{{value.contact}}</span>--%>
   <div class="pic-item" style=" width: 16%; float: left; padding: 5px;height: 150px;margin-bottom: 50px;">
           <img src="${ctx}/IoReadImage?filePath={{value.imagePath}}"  width="100%;height:80%;"/>
       <h5 style="text-align: center;">{{value.subjectName}}</h5>
   </div>
   <div class="pic-item" style=" width: 40%; float: left; padding: 5px;height:150px;">
       简介：{{value.contact}}
   </div>

   {{/each}}
</script>

<script type="text/html" id="single_tbodyTemplent">
   {{each vCount as value i}}
   <tr>
       <td><a href="http://10.0.86.85/DataExplore/sdo/detail&id={{value.id}}">{{value.title}}</a></td>
       <td>{{value.vCount}}</td>
       <td>{{value.dCount}}</td>
   </tr>
   {{/each}}
</script>

</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
   <script src="${ctx}/resources/js/jquery.json.min.js"></script>
   <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
   <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
   <script src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script src="${ctx}/resources/bundles/layerJs/layer.js"></script>
   <script src="${ctx}/resources/bundles/echarts/echarts.min.js"></script>
   <%--<script src="${ctx}/resources/bundles/jquery.svg3dtagcloud/jquery.svg3dtagcloud.min.js"></script>--%>

    <script type="text/javascript">
        var s_subjectCode = "";
        var colors=['#4a8cd6','#da6663', '#7e64a1', '#a987d6',
            '#58bae5', '#54d7b3', '#51c061', '#89c154', '#e2e061',
            '#e2b65f'];
        $.ajax({
            url: "${ctx}/ThemeStatisticVisit",
            type: "post",
            dataType: "json",
            success: function (data) {
                var chart = echarts.init(document.getElementById('datashowvisit'));
                var option = {
                    title: {
                        text: '专题库TOP10访问量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow',
                            label: {
                                show: true
                            }
                        }
                    },
                    legend: {
                        data: data.name,
                        x: 'center',
                        top: 'bottom'
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                        }
                    },
                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine: {
                            show: false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '访问量',
                        type: 'bar',
                        barWidth: 25,
                        data: data.visitCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = colors;
                                    return colorList[params.dataIndex];
                                }
                            }
                        }
                    }]
                };
                chart.setOption(option);
            }
        });

        $.ajax({
            url: "${ctx}/ThemeStatisticDown",
            type: "post",
            dataType: "json",
            success: function (data) {
                var chart = echarts.init(document.getElementById('datashowdown'));
                var option = {
                    // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
                    title: {
                        text: '专题库TOP10下载量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow',
                            label: {
                                show: true
                            }
                        }
                    },
                    legend: {
                        data: data.name,
                        x: 'center',
                        top: 'bottom'
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                        }
                    },
                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine: {
                            show: false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '下载量',
                        type: 'bar',
                        //设置柱子的宽度
                        barWidth: 25,
                        data: data.downCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = colors;
                                    return colorList[params.dataIndex];
                                }
                            }
                        }
                    }]
                };
                chart.setOption(option);
            }
        });

        $.ajax({
            url: "${ctx}/dataCollentionVisit",
            type: "post",
            dataType: "json",
            success: function (data) {
                var chart = echarts.init(document.getElementById('datacollectionvisit'));
                var option = {
                    // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
                    title: {
                        text: '数据集TOP10访问量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow',
                            label: {
                                show: true
                            }
                        }
                    },
                    legend: {
                        data: data.name,
                        x: 'center',
                        top: 'bottom'
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                        }
                    },
                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2,
                            textStyle: {
                                // fontWeight: "bolder",
                                // color: "#000000"
                            }
                        },
                        splitLine: {
                            show: false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '访问量',
                        type: 'bar',
                        barWidth: 25,
                        data: data.visitCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = colors;
                                    return colorList[params.dataIndex];
                                }
                            }
                        }
                    }]
                };
                chart.setOption(option);
            }
        });

        $.ajax({
            url: "${ctx}/dataCollentionDown",
            type: "post",
            dataType: "json",
            success: function (data) {
                var chart = echarts.init(document.getElementById('datacollectiondown'));
                var option = {
                    // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
                    title: {
                        text: '数据集TOP10下载量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow',
                            label: {
                                show: true
                            }
                        }
                    },
                    legend: {
                        data: data.name,
                        x: 'center',
                        top: 'bottom'
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                        }
                    },

                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {     //横坐标字体倾斜展示
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine: {     //去掉网格线
                            show: false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '下载量',
                        type: 'bar',
                        //设置柱子的宽度
                        barWidth: 25,
                        data: data.downCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = colors;
                                    return colorList[params.dataIndex];
                                }
                            }
                        }
                    }]
                };
                chart.setOption(option);
            }
        });

        $.ajax({
            url: "${ctx}/showAllTheme",
            type: "post",
            dataType: "json",
            success: function (data) {
                var html = template("showAllTheme", data);
                $("#showAllThemeSpan").append(html);
            }
        })

        function findBySubjectCode(i) {
            var subjectCode = $(i).attr("id");
            $.ajax({
                url: "${ctx}/findBySubjectCode",
                type: "post",
                dataType: "json",
                data: {"subjectCode": subjectCode},
                success: function (data) {
                    $("#themeDetail111").html(" ");
                    $("#themeList").hide();
                    $("#themeDetail").show();
                    var html = template("showThemeDetial11", data);
                    var subject = data.subject;
                    $("#themeDetail111").append(html);
                    var page = 1;
                    singcharts(subjectCode, page);
                }
            });
        }

        $("#reback_id").click(function () {
            $("#themeList").show();
            $("#themeDetail").hide();
        });

        function fun_limit(subjectCode, data) {
            if (data !== null) {
                $("#page_div").show();
            }

            $("#currentPageNo").html(data.currentPage);
            $("#totalPages").html(data.totalPages);
            $("#totalCount").html(data.totalCount);
            if ($("#pagination .bootpag").length != 0) {
                $("#pagination").off();
                $('#pagination').empty();
            }
            $('#pagination').bootpag({
                total: data.totalPages,
                page: data.currentPage,
                maxVisible: 5,
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
                singcharts(subjectCode, num);
            });
        }


        function singcharts(subjectCode, page) {
            $("#single_tbody").html(" ");
            s_subjectCode = subjectCode;
            $.ajax({
                url: "${ctx}/SingleSortTable",
                type: "post",
                dataType: "json",
                data: {"subjectCode": subjectCode, "pageNo": page},
                success: function (data) {
                    var html = template("single_tbodyTemplent", data);
                    $("#single_tbody").append(html);
                    fun_limit(subjectCode, data);
                }
            });
        }

        function func_asc() {
            var subjectCode = subjectCode;
            var pageNo = 1;
            var sortMethod = "asc";
            $("#vcount_desc").hide();
            $("#vcount_asc").show();
            $("#single_tbody").html(" ");
            sortByvisit(subjectCode, pageNo, sortMethod);
        }

        function func_desc() {
            var subjectCode = subjectCode;
            var pageNo = 1;
            var sortMethod = "desc";
            $("#vcount_asc").hide();
            $("#vcount_desc").show();
            $("#single_tbody").html(" ");
            sortByvisit(subjectCode, pageNo, sortMethod);
        }

        function sortByvisit(subjectCode, pageNo, sortMethod) {
            $.ajax({
                url: "${ctx}/SortByVcount",
                type: "post",
                dataType: "json",
                data: {"subjectCode": s_subjectCode, "pageNo": pageNo, "sortMethod": sortMethod},
                success: function (data) {
                    $("#single_tbody").html(" ");
                    var html = template("single_tbodyTemplent", data);
                    $("#single_tbody").append(html);
                    if (data !== null) {
                        $("#page_div").show();
                    }
                    $("#currentPageNo").html(data.currentPage);
                    $("#totalPages").html(data.totalPages);
                    $("#totalCount").html(data.totalCount);
                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }
                    $('#pagination').bootpag({
                        total: data.totalPages,
                        page: data.currentPage,
                        maxVisible: 5,
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
                        sortByvisit(subjectCode, num, sortMethod);
                    });
                }
            });
        }

        function func_ascDown() {
            var subjectCode = subjectCode;
            var pageNo = 1;
            var sortMethod = "asc";
            $("#dcount_desc").hide();
            $("#dcount_asc").show();
            $("#single_tbody").html(" ");
            sortByDown(subjectCode, pageNo, sortMethod);
        }

        function func_descDown() {
            var subjectCode = subjectCode;
            var pageNo = 1;
            var sortMethod = "desc";
            $("#dcount_asc").hide();
            $("#dcount_desc").show();
            $("#single_tbody").html(" ");
            sortByDown(subjectCode, pageNo, sortMethod);
        }

        function sortByDown(subjectCode, pageNo, sortMethod) {
            $.ajax({
                url: "${ctx}/SortByDcount",
                type: "post",
                dataType: "json",
                data: {"subjectCode": s_subjectCode, "pageNo": pageNo, "sortMethod": sortMethod},
                success: function (data) {
                    $("#single_tbody").html(" ");
                    var html = template("single_tbodyTemplent", data);
                    $("#single_tbody").append(html);
                    if (data !== null) {
                        $("#page_div").show();
                    }
                    $("#currentPageNo").html(data.currentPage);
                    $("#totalPages").html(data.totalPages);
                    $("#totalCount").html(data.totalCount);
                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }
                    $('#pagination').bootpag({
                        total: data.totalPages,
                        page: data.currentPage,
                        maxVisible: 5,
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
                        sortByDown(subjectCode, num, sortMethod);
                    });
                }
            });
        }

        function func_moreDetail() {
            $("#div1").hide();
            $.ajax({
                url: "${ctx}/ThemeStatisticVisitTotal",
                type: "post",
                dataType: "json",
                success: function (data) {
                    var chart = echarts.init(document.getElementById('datashowvisitTotal'));
                    var option = {
                        title: {
                            text: '专题库访问量统计',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'shadow',
                                label: {
                                    show: true
                                }
                            }
                        },
                        legend: {
                            data: data.name,
                            x: 'center',
                            top: 'bottom'
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                dataView : {show: true, readOnly: false},
                                magicType: {show: true, type: ['line', 'bar']},
                            }
                        },
                        xAxis: [{
                            type: 'category',
                            data: data.name,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2
                            },
                            splitLine: {
                                show: false
                            }
                        }],
                        yAxis: [
                            {
                                type: 'value'
                            }],
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            barWidth: 22,
                            data: data.visitCount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = colors;
                                        return colorList[params.dataIndex];
                                    }
                                }
                            }
                        }]
                    };
                    chart.setOption(option);
                }
            });

            $.ajax({
                url: "${ctx}/ThemeStatisticDownTotal",
                type: "post",
                dataType: "json",
                success: function (data) {
                    var chart = echarts.init(document.getElementById('datashowdownTotal'));
                    var option = {
                        title: {
                            text: '专题库下载量统计',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'shadow',
                                label: {
                                    show: true
                                }
                            }
                        },
                        legend: {
                            data: data.name,
                            x: 'center',
                            top: 'bottom'
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                dataView : {show: true, readOnly: false},
                                magicType: {show: true, type: ['line', 'bar']},
                            }
                        },
                        xAxis: [{
                            type: 'category',
                            data: data.name,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2
                            },
                            splitLine: {
                                show: false
                            }
                        }],
                        yAxis: [
                            {
                                type: 'value'
                            }],
                        series: [{
                            name: '下载量',
                            type: 'bar',
                            barWidth: 22,
                            data: data.downCount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = colors;
                                        return colorList[params.dataIndex];
                                    }
                                }
                            }
                        }]
                    };
                    chart.setOption(option);
                }
            });
            $("#div2").show();
        }

        function func_toTopTen() {
            $("#div1").show();
            $("#div2").hide();
        }
    </script>
</div>
</html>
