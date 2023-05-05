$(function () {
	$("#bookOrder_liveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#bookOrder_leaveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#bookOrder_totalMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入订单总价',
		invalidMessage : '订单总价输入不对',
	});

	$("#bookOrder_orderState").validatebox({
		required : true, 
		missingMessage : '请输入订单状态',
	});

	$("#bookOrder_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#bookOrder_orderTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#bookOrderAddButton").click(function () {
		//验证表单 
		if(!$("#bookOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#bookOrderAddForm").form({
			    url:"/BookOrder/add",
				queryParams: {
			    	"csrfmiddlewaretoken": $('input[name="csrfmiddlewaretoken"]').val()
				},
			    onSubmit: function(){
					if($("#bookOrderAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#bookOrderAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#bookOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#bookOrderClearButton").click(function () { 
		//$("#bookOrderAddForm").form("clear"); 
		location.reload()
	});
});
