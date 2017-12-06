<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" href="jquery/ztree/css/zTreeStyle/zTreeStyle.css" />
<link type="text/css" href="jquery/ui/css/ui-lightness/jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/ui/js/jquery-ui-1.8.18.custom.min.js"></script>
<script src="jquery/ztree/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script type="text/javascript">
	//集成jquery ztree插件
	var setting = {
		check: {
			//显示带有checkbox的树
			enable: true
		},
		data: {
			//使用简单的json格式拼接树节点数据
			simpleData: {
				enable: true
			}
		},
		view: {
			//禁止树节点数据多选
			selectedMulti: false
		},
		async: {
			//开启异步加载模式
			enable: true,
			url: "${pageContext.request.contextPath}/permission/makeCheckboxTree.do?roleId=${role.id}"
		}
	};
	
	$(function() {
		//集成jquery多tab页
		$('#tabs').tabs();
		$.fn.zTree.init($("#checkbox_tree"), setting);
	});
	
	//给角色分配许可
	function assign(){
		//roleId=123&permissionIds=		111&permissionIds=222&permissionIds=333
		var sendData = "roleId=${role.id}&permissionIds=";
		var treeObj = $.fn.zTree.getZTreeObj("checkbox_tree");
		//获取被勾选的节点  如果想获取未被勾选的节点   设置参数为false
		var nodes = treeObj.getCheckedNodes(true);
		var idArray = [];
		$.each(nodes,function(i,n){
			idArray.push(nodes[i].id);
		});
		sendData += idArray.join("&permissionIds=");
		//alert(sendData);
		$.ajax({
			url:"${pageContext.request.contextPath}/rolePermissionRelation/assign.do",
			type:"post",
			data:sendData,
			beforeSend:function(){
				$("#message").text("正在给角色分配许可请稍后...");
				return true;
			},
			success:function(jsonObject){
				//{"success":true} 成功  {"success":false} 失败
				if(jsonObject.success){
					$("#message").text("分配成功");					
				}else{
					$("#message").text("分配失败");										
				}
			}
		});
	}
</script>
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
                class="table_right">
                <tr>
                    <td>
                        <font style="font-size: 12px"><strong>为角色分配许可</strong></font>
                    </td>
                    <td width="25" height="26" align="right">
                    </td>
                </tr>
            </table>
		</td>
	</tr>
	<tr height="50">
		<td>
			<div id="tabs">
				<ul>
					<li><a href="#tabs-1">角色信息</a></li>
					<li><a href="#tabs-2">许可信息</a></li>
				</ul>
				<div id="tabs-1" style="background: #FFFFFF">
					代码：${role.code } <br /> <br /> 
					名称：${role.name }<br /> <br /> 
					描述：${role.remark }
				</div>
				<div id="tabs-2" style="background: #FFFFFF">
					<table>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>
								<ul id="checkbox_tree" class="ztree">
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="table_padding">
	<tr>
		<td height="21" align="right">
			<table align="left">
				<tr>
					<td width="70px">
						<a class="button" href="javascript:void(0)" onclick="assign();"><span>分配许可</span>
						</a>
					</td>
					<td width="50px">
						<a class="button" href="javascript:void(0)" onclick="window.history.back()">
							<span>返回</span>
						</a>
					</td>
					<td><span id="message" style="color:maroon;font-size: 14px"></span> </td>
				</tr>
			</table>
		</td>
	</tr>
</table>

