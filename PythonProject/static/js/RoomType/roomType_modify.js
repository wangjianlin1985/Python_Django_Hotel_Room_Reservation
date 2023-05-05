$(function () {
    //实例化类型介绍编辑器
    tinyMCE.init({
        selector: "#roomType_roomTypeDesc_modify",
        theme: 'advanced',
        language: "zh",
        strict_loading_mode: 1,
    });
    setTimeout(ajaxModifyQuery,"100");
  function ajaxModifyQuery() {	
	$.ajax({
		url : "/RoomType/update/" + $("#roomType_roomTypeId_modify").val(),
		type : "get",
		data : {
			//roomTypeId : $("#roomType_roomTypeId_modify").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (roomType, response, status) {
			$.messager.progress("close");
			if (roomType) { 
				$("#roomType_roomTypeId_modify").val(roomType.roomTypeId);
				$("#roomType_roomTypeId_modify").validatebox({
					required : true,
					missingMessage : "请输入类型id",
					editable: false
				});
				$("#roomType_roomTypeName_modify").val(roomType.roomTypeName);
				$("#roomType_roomTypeName_modify").validatebox({
					required : true,
					missingMessage : "请输入房间类型",
				});
				tinyMCE.editors['roomType_roomTypeDesc_modify'].setContent(roomType.roomTypeDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#roomTypeModifyButton").click(function(){ 
		if ($("#roomTypeModifyForm").form("validate")) {
			$("#roomTypeModifyForm").form({
			    url:"RoomType/update/" + $("#roomType_roomTypeId_modify").val(),
			    onSubmit: function(){
					if($("#roomTypeEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#roomTypeModifyForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
