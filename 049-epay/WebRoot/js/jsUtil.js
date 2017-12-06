/*
//面向过程的封装方式    	复选框只能选一个
function selectSingleCheckbox(path){
		//获取选中的checkbox
		var checkedElts = $(":checkbox[name='id']:checked");
		if(checkedElts.length==0){
			$("#message").text("请选择要修改记录");
		}else if(checkedElts.length>1){
			$("#message").text("只能选择一条记录");			
		}else{
			window.location.href= path+"?id="+checkedElts.val();
		}
}*/
/*js中定义类的方式
JsUtil = function(){}*/
function JsUtil(){}

//动态的给js中的类添加属性或者方法
JsUtil.prototype.selectSingleCheckbox=function(path){
	//获取选中的checkbox
	var checkedElts = $(":checkbox[name='id']:checked");
	if(checkedElts.length==0){
		$("#message").text("请选择要修改记录");
	}else if(checkedElts.length>1){
		$("#message").text("只能选择一条记录");			
	}else{
		window.location.href= path+"?id="+checkedElts.val();
	}
};

//在该js文件被加载的时候  创建对象
$_ = jsUtil = new JsUtil();
