/**
 * Created by shibaoping on 2018/10/9.
 */
var flag;

function add() {
    $('#addModal').modal('show');
}
function editData(dataId) {
    $.ajax({
        type:'post',
        url: "/fileResource/queryData",
        data:{"dataId":dataId},
        success: function(result) {
            var jsonData = JSON.parse(result);
            //var Data = jsonData.substring(1,jsonData.length-1);
            var dataSourceName = jsonData.dataSourceName;
            for (var index in jsonData) {
                for (var key in jsonData[index]) {
                    if (key == 'dataSourceName') {
                        $("#dataSourceNameE").val(jsonData[index][key]);
                    }
                    if (key == 'dataSourceType') {
                        $("#dataSourceTypeE").val(jsonData[index][key]);
                    }
                    if (key == 'databaseName') {
                        $("#dataBaseNameE").val(jsonData[index][key]);
                    }
                    if (key == 'databaseType') {
                        $("#dataBaseTypeE").val(jsonData[index][key]);
                    }
                    if (key == 'filePath') {
                        $("#filePathE").val(jsonData[index][key]);
                    }
                    if (key == 'dataSourceId'){
                        $("#idHidden").val(jsonData[index][key]);
                    }
                }
            }
        }
    })
    $('#editModal').modal('show');
}
function deleteD(dataId) {
   $("#markDeleteHidden").val(dataId);
    $(".modal-backdrop").hide();
    $(".modal-content").hide();
    $(".mask").show();
    $(".deleteAlert").show();
}

function addTrue(){
    $(".addSuccess").hide();
    $(".mask").hide();
    window.location.href = "/fileResource/index";
}

function addFalse(){
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function successClose(){
    $(".addSuccess").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function falseClose(){
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function validAlertClose(){
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function validAlertTrue(){
var dataId = $("#markDeleteHidden").val();
        $.ajax({
            type:'post',
            url: "/fileResource/deleteData",
            data:{"dataId":dataId},
            success: function(result){
                if(result=='1'){
                    $(".mask").show();
                    $(".addSuccess").show();
                    window.location.href = "/fileResource/index";
                }else{
                    $(".mask").show();
                    $(".addFail").show();
                    window.location.href = "/fileResource/index";
                }
            }
        })

}

function conFalse(){
    $(".conFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

    $("#commentForm").validate({
        debug: true,//只验证不提交表单
        submitHandler: function () {
            if ($("#markAddHidden").val() != "") {

            } else {
                var dataSourceName = $("#dataSourceName").val();
                var dataSourceType = '文件数据源';
                var fileType = "本地文件";
                var filePath = $("#filePath").val();
                $.ajax({
                    type: 'post',
                    url: "/fileResource/add",
                    async: true,
                    data: {
                        "dataSourceName": dataSourceName,
                        "dataSourceType": dataSourceType,
                        "fileType":fileType,
                        "filePath":filePath
                    },
                    success: function (result) {
                        var jsonData = JSON.parse(result);
                        if (jsonData == '1') {
                            $("#markAddHidden").val("1");
                            $(".modal-backdrop").hide();
                            $(".modal-content").hide();
                            $(".addSuccess").show();
                            $(".mask").show();
                        } else if (jsonData == '2') {
                            $("#fileError").show();
                        } else {
                            $(".modal-backdrop").hide();
                            $(".modal-content").hide();
                            $(".addFail").show();
                            $(".mask").show();
                        }
                    }
                })
            }
        }
    });


$("#commentEditForm").validate({
        submitHandler: function () {
            if ($("#markEditHidden").val() != "") {

            } else {
                var dataSourceId = $("#idHidden").val();
                var dataSourceName = $("#dataSourceNameE").val();
                var dataSourceType = '文件数据源';
                var fileType = $("#selectedFileTypeE option:selected").val();
                var filePath = $("#filePathE").val();
                $.ajax({
                    type: 'post',
                    url: "/fileResource/edit",
                    data: {
                        "dataSourceId" : dataSourceId,
                        "dataSourceName": dataSourceName,
                        "dataSourceType" : dataSourceType,
                        "fileType" : fileType,
                        "filePath" : filePath
                    },
                    success: function (result) {
                        var jsonData = JSON.parse(result);
                        if (jsonData == '1') {
                            $("#markEditHidden").val("1");
                            $("#editModal").hide();
                            $(".addSuccess").show();
                            $(".mask").show();
                        }else if(jsonData == '2'){
                            $("#fileErrorE").show();
                        }else {
                            $("#editModal").hide();
                            $(".addFail").show();
                            $(".mask").show();
                        }
                    }
                })
            }
        }
    });

function conFalseClose(){
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function uploadFilesClick(){
    $(".fileIsNullAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function fileAlertClose(){
    $(".fileIsNullAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}
