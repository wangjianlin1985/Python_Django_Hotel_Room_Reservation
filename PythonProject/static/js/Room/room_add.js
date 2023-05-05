$(function () {
	//实例化房间描述编辑器
    tinyMCE.init({
        selector: "#room_roomDesc",
        theme: 'advanced',
        language: "zh",
        strict_loading_mode: 1,
    });
	$("#room_roomNo").validatebox({
		required : true, 
		missingMessage : '请输入房间号',
	});

	$("#room_roomPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入价格(每天)',
		invalidMessage : '价格(每天)输入不对',
	});

	$("#room_floorNum").validatebox({
		required : true, 
		missingMessage : '请输入楼层',
	});

	$("#room_area").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入面积',
		invalidMessage : '面积输入不对',
	});

	//单击添加按钮
	$("#roomAddButton").click(function () {
		if(tinyMCE.editors['room_roomDesc'].getContent() == "") {
			alert("请输入房间描述");
			return;
		}
		//验证表单 
		if(!$("#roomAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomAddForm").form({
			    url:"/Room/add",
				queryParams: {
			    	"csrfmiddlewaretoken": $('input[name="csrfmiddlewaretoken"]').val()
				},
			    onSubmit: function(){
					if($("#roomAddForm").form("validate"))  { 
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
                        $("#roomAddForm").form("clear");
                        tinyMCE.editors['room_roomDesc'].setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomClearButton").click(function () { 
		//$("#roomAddForm").form("clear"); 
		location.reload()
	});
});
