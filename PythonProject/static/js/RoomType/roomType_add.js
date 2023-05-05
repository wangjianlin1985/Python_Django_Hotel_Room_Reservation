$(function () {
	//实例化类型介绍编辑器
    tinyMCE.init({
        selector: "#roomType_roomTypeDesc",
        theme: 'advanced',
        language: "zh",
        strict_loading_mode: 1,
    });
	$("#roomType_roomTypeName").validatebox({
		required : true, 
		missingMessage : '请输入房间类型',
	});

	//单击添加按钮
	$("#roomTypeAddButton").click(function () {
		if(tinyMCE.editors['roomType_roomTypeDesc'].getContent() == "") {
			alert("请输入类型介绍");
			return;
		}
		//验证表单 
		if(!$("#roomTypeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomTypeAddForm").form({
			    url:"/RoomType/add",
				queryParams: {
			    	"csrfmiddlewaretoken": $('input[name="csrfmiddlewaretoken"]').val()
				},
			    onSubmit: function(){
					if($("#roomTypeAddForm").form("validate"))  { 
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
                        $("#roomTypeAddForm").form("clear");
                        tinyMCE.editors['roomType_roomTypeDesc'].setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomTypeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomTypeClearButton").click(function () { 
		//$("#roomTypeAddForm").form("clear"); 
		location.reload()
	});
});
