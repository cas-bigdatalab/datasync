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
        #datashowvisit {
            width: 500px;
            height: 100%;
            float: left;
            margin-left: 10%;
        }

        #datashowdown {
            width: 500px;
            height: 100%;
            float: left;
            margin-left: 10%;
            margin-right: 10%;
        }
        #datacollectionvisit {
            width: 500px;
            height: 100%;
            float: left;
            margin-left: 10%;
        }

        #datacollectiondown {
            width: 500px;
            height: 100%;
            float: left;
            margin-left: 10%;
            margin-right: 10%;
        }
    </style>
</head>
<body>
<div class="page-content">
    <div style="width: 100%;height:40%;" >
        <div><span style="background-color: #0d957a;color: #FFFFFF;height:30px;">专题库访问量下载量top10统计</span></div>
        <div id="datashowvisit"></div>
        <div id="datashowdown"></div>
    </div>
    <div style="width: 100%;height:40%;" >
        <div><span style="background-color: #0d957a;color: #FFFFFF;height:30px;">数据集访问量下载量top10统计</span></div>
        <div id="datacollectionvisit"></div>
        <div id="datacollectiondown"></div>
    </div>
</div>
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
        $.ajax({
            url: "${ctx}/ThemeStatisticVisit",
            type: "post",
            dataType: "json",
            success: function (data) {
                var chart = echarts.init(document.getElementById('datashowvisit'));
                var option = {
                    // color: ['#5182bb', '#be4f4f', '#9bbb5e', '#8064a1', '#4facc5', '#2d4d74'],
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
    </script>
</div>
</html>
