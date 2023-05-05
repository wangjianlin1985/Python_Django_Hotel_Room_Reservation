$(function () {
    setTimeout(ajaxModifyQuery,"100");
  function ajaxModifyQuery() {	
	$.ajax({
		url : "/BookOrder/update/" + $("#bookOrder_orderId_modify").val(),
		type : "get",
		data : {
			//orderId : $("#bookOrder_orderId_modify").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookOrder, response, status) {
			$.messager.progress("close");
			if (bookOrder) { 
				$("#bookOrder_orderId_modify").val(bookOrder.orderId);
				$("#bookOrder_orderId_modify").validatebox({
					required : true,
					missingMessage : "请输入订单id",
					editable: false
				});
				$("#bookOrder_roomObj_roomNo_modify").combobox({
					url:"/Room/listAll?csrfmiddlewaretoken=" + $('input[name="csrfmiddlewaretoken"]').val(),
					method: "GET",
					valueField:"roomNo",
					textField:"roomNo",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#bookOrder_roomObj_roomNo_modify").combobox("select", bookOrder.roomObjPri);
						//var data = $("#bookOrder_roomObj_roomNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#bookOrder_roomObj_roomNo_edit").combobox("select", data[0].roomNo);
						//}
					}
				});
				$("#bookOrder_liveDate_modify").datebox({
					value: bookOrder.liveDate,
					required: true,
					showSeconds: true,
				});
				$("#bookOrder_leaveDate_modify").datebox({
					value: bookOrder.leaveDate,
					required: true,
					showSeconds: true,
				});
				$("#bookOrder_totalMoney_modify").val(bookOrder.totalMoney);
				$("#bookOrder_totalMoney_modify").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入订单总价",
					invalidMessage : "订单总价输入不对",
				});
				$("#bookOrder_orderState_modify").val(bookOrder.orderState);
				$("#bookOrder_orderState_modify").validatebox({
					required : true,
					missingMessage : "请输入订单状态",
				});
				$("#bookOrder_orderMemo_modify").val(bookOrder.orderMemo);
				$("#bookOrder_userObj_user_name_modify").combobox({
					url:"/UserInfo/listAll?csrfmiddlewaretoken=" + $('input[name="csrfmiddlewaretoken"]').val(),
					method: "GET",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#bookOrder_userObj_user_name_modify").combobox("select", bookOrder.userObjPri);
						//var data = $("#bookOrder_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#bookOrder_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#bookOrder_telephone_modify").val(bookOrder.telephone);
				$("#bookOrder_telephone_modify").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#bookOrder_orderTime_modify").datetimebox({
					value: bookOrder.orderTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#bookOrderModifyButton").click(function(){ 
		if ($("#bookOrderModifyForm").form("validate")) {
			$("#bookOrderModifyForm").form({
			    url:"BookOrder/update/" + $("#bookOrder_orderId_modify").val(),
			    onSubmit: function(){
					if($("#bookOrderEditForm").form("validate"))  {
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
			$("#bookOrderModifyForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
