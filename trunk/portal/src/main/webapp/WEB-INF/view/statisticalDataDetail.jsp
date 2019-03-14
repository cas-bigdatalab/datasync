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
    <style type="text/css">
        .css_chartsleft {
            width: 35%;
            height: 100%;
            float: left;
            margin-left: 10%;
        }

        .css_charts{
            width: 35%;
            height: 100%;
            float: left;
            margin-left: 10%;
            margin-right: 10%;
        }
        #datashowvisitTotal {
            width: 80%;
            height: 45%;
            margin-left: 10%;
            margin-right: 10%;
        }
        #datashowdownTotal{
            width: 80%;
            height: 45%;
            margin-left: 10%;
            margin-right: 10%;
        }
        /*#datacollectionvisit {*/
            /*width: 35%;*/
            /*height: 100%;*/
            /*float: left;*/
            /*margin-left: 10%;*/
        /*}*/

        /*#datacollectiondown {*/
            /*width: 35%;*/
            /*height: 100%;*/
            /*float: left;*/
            /*margin-left: 10%;*/
            /*margin-right: 10%;*/
        /*}*/
    </style>
</head>
<body>
<div class="page-content">
    <div id="div1" style="width: 100%;height:40%;" >
        <div><span style="background-color: #0d957a;color: #FFFFFF;height:2%;">专题库访问量下载量top10统计</span>
            <span style="background-color: #0d957a;height:2%;margin-left: 30%;"><a href="#" style="color: #FFFFFF;" onclick="func_moreDetail()">查看更多详情</a></span>
        </div>
        <div id="datashowvisit" class="css_chartsleft"></div>
        <div id="datashowdown" class="css_charts"></div>
        <div>

        </div>
    </div>
<%-- 专题详情--%>
    <div id="div2" style="width: 100%;height:70%; display: none;">
        <div><span style="background-color: #0d957a;color: #FFFFFF;height:2%;">专题库访问量下载量统计</span>
            <span style="background-color: #0d957a;height:2%;margin-left: 30%;"><a href="#" style="color: #FFFFFF;" onclick="func_toTopTen()"><<<<</a></span>
        </div>
        <div id="datashowvisitTotal"></div>
        <div id="datashowdownTotal"></div>
    </div>
<%--数据集Top10--%>
    <div style="width: 100%;height:40%;margin-top: 1%;" >
        <div><span style="background-color: #0d957a;color: #FFFFFF;height:2%;">数据集访问量下载量top10统计</span></div>
        <div id="datacollectionvisit" class="css_chartsleft"></div>
        <div id="datacollectiondown" class="css_charts"></div>
    </div>
    <%--显示所有专题库--%>
    <div id="themeList" style="width: 100%;height:40%;margin-top: 5%;">
        <div style="background-color: #0d957a;color: #FFFFFF;height:3%;width: 200px;height: 30px;">按专题库查看访问量下载量</div>
        <div id="showAllThemeSpan" style="height-min:300px;width:100%; ">

        </div>
    </div>
    <%--根据专题库查看该专题库内的访问量下载量--%>
    <div id="themeDetail" style="width: 100%;height:70%;margin-top: 5%;display: none;margin-bottom: 3%;">
        <div style="width: 100%;height: 10%;">
        <span style="float: left;background-color: #0d957a;color: #FFFFFF;height:3%;width: 200px;height: 30px;">按专题库查看访问量下载量</span>
        <span style="float: left;margin-left: 30%;"><a><button id="reback_id" style="background-color: #0d957a;color: #FFFFFF;height:3%;width: 200px;height: 30px;" ><<<</button></a></span>
        </div>
        <div id="themeDetail111" style="width: 80%;margin-top:1%;margin-left: 10%;height: 30%;">

        </div>
        <div id="detialCharts"  style="width: 100%; float: none">
            <div id="singlethemeChartsV"  style=" margin-left: 10%;width: 35%;float: left; height:60%;"></div>
            <div id="singlethemeChartsD"   style="margin-left: 10%;margin-right: 10%;width: 35%;float: left;height:60%;"></div>
        </div>
    </div>

</div>


<script type="text/html" id="showAllTheme">
    {{each list as value i}}
    <span style="float: left;width:13%;margin-left: 3%;">
         <a href="javaScript:void(0)" id="{{value.subjectCode}}" onclick="findBySubjectCode(this)">
             <img src="${ctx}/{{value.imagePath}}" />
         </a>
        <br/>
        <p>{{value.subjectName}}</p>
    </span>
    {{/each}}
</script>

<script type="text/html" id="showThemeDetial11">
    {{each subject as value i}}
    <span style="width:13%;margin-left: 3%;float: left">
             <img src="${ctx}/{{value.imagePath}}" />
        <br/>
        <p>{{value.subjectName}}</p>
    </span>
    <span style="float: left;">{{value.contact}}</span>
    {{/each}}
</script>

</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script src="${ctx}/resources/js/jquery.json.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/bundles/layerJs/layer.js"></script>
    <script src="${ctx}/resources/bundles/echarts/echarts.min.js"></script>
    <%--<script src="${ctx}/resources/bundles/jquery.svg3dtagcloud/jquery.svg3dtagcloud.min.js"></script>--%>

    <script type="text/javascript">
        // var s_subjectCode="";
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

                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine:{
                            show:false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '访问量',
                        type: 'bar',
                        barWidth : 25,
                        data: data.visitCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                        'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                        'rgb(25,46,94)'];
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

                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine:{
                            show:false
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
                        barWidth : 25,
                        data: data.downCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                        'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                        'rgb(25,46,94)'];
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
                        splitLine:{
                            show:false
                        }
                    }],
                    yAxis: [
                        {
                            type: 'value'
                        }],
                    series: [{
                        name: '访问量',
                        type: 'bar',
                        barWidth : 25,
                        data: data.visitCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                                     'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                                     'rgb(25,46,94)'];
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
                    xAxis: [{
                        type: 'category',
                        data: data.name,
                        axisLabel: {     //横坐标字体倾斜展示
                            interval: 0,
                            rotate: 45,//倾斜度 -90 至 90 默认为0
                            margin: 2
                        },
                        splitLine:{     //去掉网格线
                            show:false
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
                        barWidth : 25,
                        data: data.downCount,
                        //配置样式
                        itemStyle: {
                            //通常情况下：
                            normal: {
                                //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                color: function (params) {
                                    var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                        'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)',
                                        'rgb(20,20,200)','rgb(42,46,150)','rgb(25,46,94)'];
                                        // ['rgb(42,46,150)','rgb(20,20,200)','rgb(42,75,227)','rgb(42,100,227)','rgb(42,130,227)',
                                        // 'rgb(42,150,227)','rgb(80,170,227)','rgb(120,190,238)','rgb(164,205,238)','rgb(195,200,235)'];
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
            url:"${ctx}/showAllTheme",
            type:"post",
            dataType:"json",
            success:function (data) {
                var html=template("showAllTheme",data);
                $("#showAllThemeSpan").append(html);
            }
        })
        function findBySubjectCode(i) {
            var subjectCode=$(i).attr("id");
            $.ajax({
                url:"${ctx}/findBySubjectCode",
                type:"post",
                dataType:"json",
                data:{"subjectCode":subjectCode},
                success:function (data) {
                    $("#themeDetail111").html(" ");
                    $("#themeList").hide();
                    $("#themeDetail").show();
                    var html=template("showThemeDetial11",data);
                    var subject=data.subject;
                    $("#themeDetail111").append(html);
                    singcharts(subjectCode);
                }
            });
        }
        $("#reback_id").click(function () {
            $("#themeList").show();
            $("#themeDetail").hide();
        })

        function singcharts(subjectCode){
            $.ajax({

                url: "${ctx}/singlethemeChartsVisit",
                type: "post",
                dataType: "json",
                data:{"subjectCode":subjectCode},
                success: function (data) {
                    var chart = echarts.init(document.getElementById('singlethemeChartsV'));
                    var option = {
                        // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
                        title: {
                            text: '该专题内的访问量',
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

                        xAxis: [{
                            type: 'category',
                            data: data.title,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2,
                                textStyle: {
                                    // fontWeight: "bolder",
                                    // color: "#000000"
                                }
                            },
                            splitLine:{
                                show:false
                            }
                        }],
                        yAxis: [
                            {
                                type: 'value'
                            }],
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            barWidth : 25,
                            data: data.vcount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                            'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                            'rgb(25,46,94)'];
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
                url: "${ctx}/singlethemeChartsDown",
                type: "post",
                dataType: "json",
                data:{"subjectCode":subjectCode},
                success: function (data) {
                    var chart = echarts.init(document.getElementById('singlethemeChartsD'));
                    var option = {
                        // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
                        title: {
                            text: '该专题内的下载量',
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
                        xAxis: [{
                            type: 'category',
                            data: data.title,
                            axisLabel: {     //横坐标字体倾斜展示
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2
                            },
                            splitLine:{     //去掉网格线
                                show:false
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
                            barWidth : 25,
                            data: data.dcount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                            'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)',
                                            'rgb(20,20,200)','rgb(42,46,150)','rgb(25,46,94)'];
                                        // ['rgb(42,46,150)','rgb(20,20,200)','rgb(42,75,227)','rgb(42,100,227)','rgb(42,130,227)',
                                        // 'rgb(42,150,227)','rgb(80,170,227)','rgb(120,190,238)','rgb(164,205,238)','rgb(195,200,235)'];
                                        return colorList[params.dataIndex];
                                    }
                                }
                            }
                        }]
                    };
                    chart.setOption(option);
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

                        xAxis: [{
                            type: 'category',
                            data: data.name,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2
                            },
                            splitLine:{
                                show:false
                            }
                        }],
                        yAxis: [
                            {
                                type: 'value'
                            }],
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            barWidth : 25,
                            data: data.visitCount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                            'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                            'rgb(25,46,94)'];
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

                        xAxis: [{
                            type: 'category',
                            data: data.name,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2
                            },
                            splitLine:{
                                show:false
                            }
                        }],
                        yAxis: [
                            {
                                type: 'value'
                            }],
                        series: [{
                            name: '下载量',
                            type: 'bar',
                            barWidth : 25,
                            data: data.downCount,
                            //配置样式
                            itemStyle: {
                                //通常情况下：
                                normal: {
                                    //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                                    color: function (params) {
                                        var colorList = ['rgb(164,205,238)','rgb(120,190,238)','rgb(80,170,227)', 'rgb(42,150,227)',
                                            'rgb(42,130,227)','rgb(42,100,227)','rgb(42,75,227)','rgb(20,20,200)','rgb(42,46,150)',
                                            'rgb(25,46,94)'];
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
