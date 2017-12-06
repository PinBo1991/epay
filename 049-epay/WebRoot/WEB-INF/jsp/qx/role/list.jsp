<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">


<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="jquery/pagination/pagination.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/pagination/jquery.pagination.js"></script>
<script type="text/javascript" src="js/jsUtil.js"></script>
<script type="text/javascript">
	//页面加载完成之后
	$(function(){
		displayData(0);
		//给跳转到第几页的文本框注册一个keydown时间  参数event代表刚刚发生的事件
		$("#pageNo").keydown(function(event){
			//alert(event.keyCode);
			if(event.keyCode==13){
				displayData(this.value-1);
			}
		});
		//给全选或者取消全选的checkbox注册一个单击事件
		$("#checkOrCancelAll").click(function(){
			//alert(this.checked);
			//获取所有checkbox
			//var allCheckbox = $(":checkbox");
			//获取页面中所有name='id'的checkbox
			//var allCheckbox = $(":checkbox[name='id']");
			//alert(allCheckbox.length);
			/* if(this.checked){
				$(":checkbox[name='id']").prop("checked",true);
			}else{
				$(":checkbox[name='id']").prop("checked",false);				
			} */
			$(":checkbox[name='id']").prop("checked",this.checked);
		});
	});
	//发送ajax请求获取分页数据
	function displayData(pageNo){
		//将thead中的checkbox设置为取消选中状态
		$("#checkOrCancelAll").prop("checked",false);
		
		var pageSize = $("#pageSize").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/role/getByPage.do",
			type:"get",
			cache:false,//设置浏览器不缓存页面   另一种方式是加时间戳 
			data:{
				"pageNo":pageNo+1,
				"pageSize":pageSize
			},
			beforeSend:function(){
				$("#message").text("正在进行分页查询请稍后...");
				return true;
			},
			success:function(jsonObject){
				//清空tbody
				$("#roleInfoTBody").empty();
				//{"total":100,"dataList":[{"id":"","code":"","name":"","remark":""},{},{}]}
				if(jsonObject.total==0){
					$("#message").text("没有符合条件的记录");
				}else{
					$("#message").text("查询结果如下:");
					var htmlString = "";
					//遍历数组中的元素
					$.each(jsonObject,function(i,n){
						htmlString +="<tr  bgcolor='white'>";
						htmlString +="<td><input type='checkbox' name='id' value='"+n.id+"' onclick='controlFirstCheckbox();'/></td>";
						htmlString +="<td>"+(i+1)+"</td>";
						htmlString +="<td>"+n.code+"</td>";
						htmlString +="<td>"+n.name+"</td>";
						htmlString +="<td>&nbsp;"+n.remark+"</td>";
						htmlString +="</tr>";
					});
					//将拼接好的字符串追加到tbody中
					$("#roleInfoTBody").append(htmlString);
				}
				//集成jquery的翻页插件
				$("#pagination").pagination(jsonObject.total, {//总记录条数
		            callback: displayData,//每次翻页执行的回调函数  会传递页码的索引  比正常的页码小1
		            items_per_page:pageSize,// 每页显示多少条数据
		            current_page:pageNo,//当前页码索引
		            link_to:"javascript:void(0)",//保留超链接的样式,只执行js代码,但是不 跳转到任何资源
		            num_display_entries:8,//页码过多的时候显示的入口个数
		            next_text:"下一页",
		            prev_text:"上一页",
		            next_show_always:false,//如果没有下一页是否显示按钮连接  
		            prev_show_always:false,//如果没有上一页是否显示按钮连接
		            num_edge_entries:2,
		            ellipse_text:"..."
		        });
				//显示总记录条数
				$("#total").text(jsonObject.total);
				//显示总页数
				var pageCount = jsonObject.total%pageSize==0?jsonObject.total/pageSize:parseInt(jsonObject.total/pageSize)+1;
				$("#pageCount").text(pageCount);
			}
		});
	} 
	function controlFirstCheckbox(){
		/* //获取页面中name='id'的checkbox的个数
		var viewSize = $(":checkbox[name='id']").length;
		//获取页面中name='id'并且被选中的checkbox的个数
		var selectedSize = $(":checkbox[name='id']:checked").length;
		if(viewSize==selectedSize){
			$("#checkOrCancelAll").prop("checked",true);
		}else{
		} */
		$("#checkOrCancelAll").prop("checked",$(":checkbox[name='id']").length==$(":checkbox[name='id']:checked").length);			
	}
	
	//删除角色
	function del(){
		//获取要删除的角色
		var checkedElts = $(":checkbox[name='id']:checked");
		if(checkedElts.length==0){
			$("#message").text("请选择要删除的角色!");
		}else{
			if(confirm("您确定要删除选中的角色吗?")){
				//发送ajax请求,完成角色删除   ids=			111&ids=222&ids=333
				/* 拼接要发送的字符串的方式1
				var sendData="";
				$.each(checkedElts,function(i,n){
					sendData +="&ids="+n.value;
				});
				sendData = sendData.substr(1);
				//sendData = sendData.substring(1); */
				/*
					拼接要发送的字符串的方式1
				*/
				var sendData="ids=";
				var idArray = [];
				$.each(checkedElts,function(i,n){
					idArray.push(n.value);
				});
				sendData += idArray.join("&ids=");//用指定的字符串连接数组中的元素,形成一个新的字符串
				//alert(sendData);
				$.ajax({
					url:"${pageContext.request.contextPath}/role/delete.do",
					type:"post",
					data:sendData,
					beforeSend:function(){
						$("#message").text("正在删除角色请稍后...");
						return true;
					},
					success:function(jsonObject){
						//{"success":true} 成功  {"success":false} 失败
						if(jsonObject.success){
							$("#message").text("删除成功");
							//重新加载页面
							//displayData(0);
							window.location.reload();
						}else{							
							$("#message").text("删除失败");
						}
					}
				});
			}
		}
	}
	//修改角色  复选框只能选一个
	function edit(){
		$_.selectSingleCheckbox("${pageContext.request.contextPath}/role/edit.do");
	}
	//给角色分配许可
	function assign(){
		$_.selectSingleCheckbox("${pageContext.request.contextPath}/role/assign.do");
	}
	
	//查看角色明细
	function detail(){
		$_.selectSingleCheckbox("${pageContext.request.contextPath}/role/detail.do");
	}
</script>

<table border="0" cellpadding="0" cellspacing="0" class="table_border">
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
                   class="table_padding">
                <tr>
                    <td>
                        <table align="left">
                            <tr>
                                <td width="75px"><a class="button" href="javascript:void(0);" onclick="detail();"><span>查看明细</span></a>
                                </td>
                                <td width="50px"><a class="button" href="role/add.do"><span>新增</span></a>
                                </td>
                                <td width="50px"><a class="button" href="javascript:void(0);" onclick="del();"><span>删除</span></a></td>
                                <td width="50px"><a class="button" href="javascript:void(0);" onclick="edit();"><span>修改</span></a>
                                </td>
                                <td width="80px"><a class="button" href="javascript:void(0);" onclick="assign();"><span>分配许可</span></a>
                                </td>
                                <td><span id="message" style="color: red;font-size: 14px"></span> </td>
                            </tr>
                        </table>
                    </td>
                    <td width="25" height="26" align="right"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">
            <table border="0" cellpadding="0" cellspacing="0" id="box_num_table2"
                   class="box_num_table">
                <thead>
                <tr  bgcolor="white">
                    <td><input type="checkbox" id="checkOrCancelAll"/></td>
                    <td>序号</td>
                    <td>代码</td>
                    <td>名称</td>
                    <td>描述</td>
                </tr>
                </thead>
                <tbody id="roleInfoTBody">
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table border="0" cellpadding="0" cellspacing="0"
                   class="table_border">
                <tr>
                    <td>
                        <%@ include file="/WEB-INF/jsp/common/pageFoot.jsp" %>
                    </td>
                </tr>
            </table>

        </td>
    </tr>
</table>
