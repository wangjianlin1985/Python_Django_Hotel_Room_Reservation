$(function () {
    //实例化房间描述编辑器
    tinyMCE.init({
        selector: "#room_roomDesc_modify",
        theme: 'advanced',
        language: "zh",
        strict_loading_mode: 1,
    });
    setTimeout(ajaxModifyQuery,"100");
  function ajaxModifyQuery() {	
	$.ajax({
		url : "/Room/update/" + $("#room_roomNo_modify").val(),
		type : "get",
		data : {
			//roomNo : $("#room_roomNo_modify").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (room, response, status) {
			$.messager.progress("close");
			if (room) { 
				$("#room_roomNo_modify").val(room.roomNo);
				$("#room_roomNo_modify").validatebox({
					required : true,
					missingMessage : "请输入房间号",
					editable: false
				});
				$("#room_roomTypeObj_roomTypeId_modify").combobox({
					url:"/RoomType/listAll?csrfmiddlewaretoken=" + $('input[name="csrfmiddlewaretoken"]').val(),
					method: "GET",
					valueField:"roomTypeId",
					textField:"roomTypeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#room_roomTypeObj_roomTypeId_modify").combobox("select", room.roomTypeObjPri);
						//var data = $("#room_roomTypeObj_roomTypeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#room_roomTypeObj_roomTypeId_edit").combobox("select", data[0].roomTypeId);
						//}
					}
				});
				$("#room_roomPhotoImgMod").attr("src", room.roomPhoto);
				$("#room_roomPrice_modify").val(room.roomPrice);
				$("#room_roomPrice_modify").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入价格(每天)",
					invalidMessage : "价格(每天)输入不对",
				});
				$("#room_floorNum_modify").val(room.floorNum);
				$("#room_floorNum_modify").validatebox({
					required : true,
					missingMessage : "请输入楼层",
				});
				$("#room_area_modify").val(room.area);
				$("#room_area_modify").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入面积",
					invalidMessage : "面积输入不对",
				});
				tinyMCE.editors['room_roomDesc_modify'].setContent(room.roomDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#roomModifyButton").click(function(){ 
		if ($("#roomModifyForm").form("validate")) {
			$("#roomModifyForm").form({
			    url:"Room/update/" + $("#room_roomNo_modify").val(),
			    onSubmit: function(){
					if($("#roomEditForm").form("validate"))  {
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
			$("#roomModifyForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
