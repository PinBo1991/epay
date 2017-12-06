<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/form/jquery.form.js"></script>
<script type="text/javascript">
	//页面加载完成之后
	$(function(){
		//给更新的按钮注册一个单击事件
		$("#updateBtn").click(function(){
			$("#permissionForm").submit();
		});
		//给form表单绑定相关的操作
		$("#permissionForm").ajaxForm({
			beforeSubmit:function(){
				$("#message").text("正在更新许可请稍后...");
				return true;
			},
			success:function(jsonObject){
				//{"success":true} 成功  {"success":false} 失败
				if(jsonObject.success){
					$("#message").text("更新成功");		
					//获取树对象
					var treeObj = window.parent.treeFrame.$.fn.zTree.getZTreeObj("permission_tree");
					//获取选中的节点
					var nodes = treeObj.getSelectedNodes();
					nodes[0].name=$("#name").val(); 
					treeObj.updateNode(nodes[0]);
				}else{
					$("#message").text("更新失败");										
				}
			}
		});
	});
</script>
<form action="permission/update.do" method="post" id="permissionForm">
<input type="hidden" name="id" value="${permission.id}">
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>修改许可</strong></font>
					</td>
					<td width="25" height="26" align="left"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" class="table_right">
				<tr>
					<td align="center">



						<table border="0" cellpadding="0" cellspacing="0"
							class="box_table" id="box_table2">
							<thead>
								<tr>
									<td height="36" class="box_table_even">代码：</td>
									<td class="box_table_odd"><input type="text" value="${permission.code }" name="code"/> 
										<span class="star">*</span>
									</td>
								</tr>
								<tr>
									<td height="36" class="box_table_even">名称：</td>
									<td class="box_table_odd"><input type="text" value="${permission.name }" name="name" id="name"/> <span
										class="star">*</span></td>
								</tr>
								<tr>
									<td class="box_table_even">模块URL：</td>
									<td class="box_table_odd"><input type="text" value="${permission.moduleUrl }" name="moduleUrl"/></td>
								</tr>
								<tr>
									<td class="box_table_even">操作URL：</td>
									<td class="box_table_odd"><input type="text" size="90" value="${permission.operationUrl }" name="operationUrl"/>
										多个逗号隔开</td>
								</tr>
								<tr>
									<td class="box_table_even">排序号：</td>
									<td class="box_table_odd"><input type="text" value="${permission.orderNo }" name="orderNo"/> </td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>

						<table border="0" cellpadding="0" cellspacing="0"
							class="operation">
							<thead>
								<tr>
									<td height="24">&nbsp;</td>
								</tr>
							</thead>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_padding">
				<tr>
					<td height="21" align="right">
						<table align="left">
							<tr>
								<td width="50px"><a class="button" href="javascript:void(0);"><span id="updateBtn">更新</span></a></td>
								<td width="50px"><a class="button"
									href="javascript:void(window.history.back());"><span>返回</span></a></td>
								<td><span id="message" style="color: fuchsia;font-size: 12px"></span> </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>