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
    <link href="${ctx}/resources/css/createTask.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="task-head">
        <span>DataSync / 数据范围</span>
    </div>
    <div class="task-title">
        <span>确定数据对象范围，上传数据</span>
    </div>
    <div class="select-way">
        <span>数据源:</span>
        <label for="aaa">数据库</label>
        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
        <label for="bbb">本地上传</label>
        <input name="ways" type="radio" value="LH" id="bbb"/>
    </div>
    <div class="select-ways">
        <div class="select-database">
            <span>选择数据源</span>
            <select  id="DBchange">
                <option value="">-----------</option>
                <option value="">关系数据源DB2</option>
                <option value="">数据源OracleData</option>
                <option value="">关系数据源DB2</option>
                <option value="">数据源OracleData</option>
                <option value="">关系数据源DB2</option>
                <option value="">数据源OracleData</option>
            </select>
            <div class="database-con container-fluid" style="display: none">
                <div class="row">
                    <div class="col-md-3 dataHead1">数据源名称：</div>
                    <div class="col-md-9 dataHead2">关系数据源DB2</div>
                    <div class="col-md-2">选择表资源</div>
                    <div class="col-md-9" >
                        <div class="row" id="db-table">
                            <div class="col-md-4">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">sql查询</div>
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-5">
                                <input type="text" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-success">编辑预览</button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>sql查询</button>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-success" onclick="sendTask()">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="select-local" style="display: none">
            <button type="button" class="btn btn-success" id="upload-directory">上传目录</button>
            <button type="button" class="btn btn-success" id="upload-file">上传文件</button>
            <div style="min-height: 400px;margin-top: 50px">
                <div class="left">
                    <button type="button" class="btn btn-success btn-sm" style="margin-bottom:5px" onclick="editTree();"><i
                            class="glyphicon glyphicon-pencil"></i> 修改
                    </button>
                    <div id="jstree_show" style="height:300px"></div>
                </div>
                <div class="right" id="editRegon">

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="dataSouceList">
    <option value="">-----------</option>
    {{each list as value i}}
    <option value="{{name}}">value.name</option>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.min.js"></script>

    <script>





        $(function(){
            $.ajax({
                url:"${ctx}/relationship/findAll",
                type:"GET",
                success:function (data) {
                    console.log(data)
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });
        var treeData = {
            'core' : {
                "animation": 0,
                "check_callback":false,
                'data' : [
                    {
                        "text" : "Root node",
                        "state" : { "opened" : true },
                        "children" : [
                            {
                                "text" : "Child node 1",
                                "state" : { "selected" : true },
                                "icon" : "jstree-file"
                            },
                            { "text" : "Child node 2",  }
                        ]
                    }
                ]
            },
            "plugins" : ["dnd","state","types","wholerow"]
        }
        $("#jstree_show").jstree(treeData);
        var jsdata;
        var deleteNodeArray;
        $(".select-local>button").on("click",function () {
            jsdata=null;
            $("#jstree_show").jstree({
                'core' : {
                    'data' :{
                        'url':$.hr_contextUrl()+"menu/list",
                        'data':function(node){
                            return node;
                        }
                    }
                },
                'plugins':['contextmenu','sort'],
                "contextmenu":{
                    "items":{
                        "create":null,
                        "rename":null,
                        "remove":null,
                        "ccp":null,
                        "新建菜单":{
                            "label":"新建菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0])
                                var pid = node.parent;
                                _menu.operation.addMenu(pid,node);
                            }
                        },
                        "删除菜单":{
                            "label":"删除菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                _menu.operation.delMenu(node);
                            }
                        },
                        "修改菜单":{
                            "label":"修改菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]).original;
                                _menu.operation.editMenu(node);
                            }
                        },
                        "上移菜单":{
                            "label":"上移菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var prev_dom = $(data.reference[0]).closest("li").prev();
                                _menu.operation.sortMenu(node,prev_dom);
                            }
                        },
                        "下移菜单":{
                            "label":"下移菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var next_dom = $(data.reference[0]).closest("li").next();
                                _menu.operation.sortMenu(node,next_dom);
                            }
                        },
                        "新建子菜单":{
                            "label":"新建子菜单",
                            "action":function(data){
                                var node = _menu.data.jsTree.jstree('get_node',data.reference[0]);
                                var pid = node.id;
                                _menu.operation.addMenu(pid,node);
                            }
                        }
                    }
                }
            });
            $("#editRegon").empty();
            var url = this.id == "upload-directory"? "upload-directory":"upload-file";
            /*$.ajax({
                url: ctx + url,
                type: "get",
                dataType: "json",
                data: {editable: false},
                success: function (data) {
                    jsdata =data
                    $('#jstree_show').jstree(data);
                }
            })*/
        })
        function sendTask() {
            $.ajax({
                url:"",
                type:"POST",
            })
            window.location.href="${ctx}/dataUpload"
        }
        function editTree() {
            if($("#editRegon").html().trim() != ""){
                return false;
            }
            deleteNodeArray = new Array();
            var html = '<div class="row" style="margin-bottom:12px"> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_create();"><i class="glyphicon glyphicon-asterisk"></i> 添加</button> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_rename();"><i class="glyphicon glyphicon-pencil"></i> 重命名</button> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_delete();"><i class="glyphicon glyphicon-remove"></i> 删除</button> ' +
                '</div> ' +
                '<div id="jstree_edit" style="height:300px"></div> ' +
                '<button type="button" class="btn btn-default btn-sm" onclick="jstree_cancel();" style="margin-left:5px"><i class="glyphicon glyphicon-remove"></i> 取消</button>' +
                '<button type="button" class="btn btn-primary btn-sm" onclick="jstree_submit();" style="margin-left:5px"><i class="glyphicon glyphicon-ok"></i> 提交</button>'
            $("#editRegon").append(html);
            //这有一点需要补充
             var to = false;
             $('#demo_q').keyup(function () {
                 if (to) {
                     clearTimeout(to);
                 }
                 to = setTimeout(function () {
                     var v = $('#demo_q').val();
                     $('#jstree_edit').jstree(true).search(v);
                 }, 250);
             });
            treeData.core.check_callback= true;
            treeData.plugins=["contextmenu", "dnd", "state", "types", "wholerow"]
            $('#jstree_edit').jstree(treeData);
        }

        function jstree_cancel(){
            $("#editRegon").html("");
            treeData.core.check_callback= false;
            treeData.plugins=["dnd","state","types","wholerow"]
        }
        function jstree_create() {
            var ref = $('#jstree_edit').jstree(true),
                sel = ref.get_selected();
            if (!sel.length) {
                return false;
            }
            sel = sel[0];

            sel = ref.create_node(sel);
            ref.set_icon(sel, "glyphicon glyphicon-th-list");

            if (sel) {
                ref.edit(sel);
            }
        }
        function jstree_rename() {
            var ref = $('#jstree_edit').jstree(true),
                sel = ref.get_selected();
            if (!sel.length) {
                return false;
            }
            sel = sel[0];
            ref.edit(sel);
        }
        function jstree_delete() {

            /* var ref = $('#jstree_edit').jstree(true);
             sel = ref.get_selected();
             if (!sel.length) {
                 return false;
             }*/
            /*ref.delete_node(sel);
            if(sel[0].indexOf("_")<0){
                deleteNodeArray.push(sel[0]);
            }*/
            /*$("#deleteContent").attr("nodeid",sel[0]);*/
            $("#deleteNodeModal").modal('show');
            /*$("#deleteContent").html('<div align="center">确认删除'+ref.get_node(sel).text+'节点？</div>')*/
            $("#deleteContent").html('<div align="center">确认删除节点？</div>')
        };
        function confirmDeleteNode(){
            if(syncSwitch = "deny"){
                toastr["warning"]("己经开始同步数据，不能再删除记录！", "数据删除");
            }else{
                var ref = $('#jstree_edit').jstree(true);
                sel =$('#jstree_edit').jstree("get_node", $("#deleteContent").attr("nodeid"));
                ref.delete_node(sel);
                if (sel.id.indexOf("_") < 0) {
                    deleteNodeArray.push(sel.id);
                }
            }

        }

        function jstree_submit() {
            var treeData = $.jstree.reference('jstree_edit')._model.data;
            var packageTreeData = new Array();
            $.each(treeData, function (n, value) {
                if (value.parent != null) {
                    var nodeData = {
                        id: value.id,
                        text: value.text,
                        parent: value.parent,
                        level: value.parents.length,
                        order: n
                    };
                    packageTreeData.push(nodeData);
                }
            });
            $.ajax({
                url: ctx + "/resCatalogSubmit",
                type: "get",
                dataType: "json",
                data: {packageTreeData: JSON.stringify(packageTreeData),
                    deleteNodeArray:JSON.stringify(deleteNodeArray)},
                success: function (data) {
                    window.location.href = ctx + "/resCatalog";
//                    toastr["success"]("资源目录添加成功！", "success！");
                }
            })
        }
        $("[name='ways']").on("change",function () {
            if(this.value =="DB"){
                $(".select-database").show();
                $(".select-local").hide();
            }else {
                $(".select-database").hide();
                $(".select-local").show();
            }
        })

        $("#DBchange").change(function () {
            var selectName = $("#DBchange option:selected").text();
            $(".dataHead2").html(selectName);

            /*$.ajax({
                url:"",
                type:"GET",
                data:selectName,
                success:function (data) {
                    var html = template("resourceTmp1",data)
                    $("#db-table").empty();
                    $("#db-table").append(html)
                }
            })*/
            $(".database-con").show();
        })

        $(function () {
            /*tableConfiguration();*/
        })

    </script>
</div>

</html>
