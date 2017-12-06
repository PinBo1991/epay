<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	function del(){
		//获取树对象
		var treeObj = window.parent.treeFrame.$.fn.zTree.getZTreeObj("permission_tree");
		//获取当前选中的节点
		var nodes = treeObj.getSelectedNodes();
		//判断当前选中的节点是不是根
		if(nodes[0].level==0){
			//根许可不能删除
			$("#message").text("根许可不能删除");			
		}else{
			//如果该许可下有子许可 不能删除
			if(nodes[0].isParent){
				$("#message").text("该许可下有子许可不能删除");							
			}else{
				//删除提示用户
				if(confirm("您确定要删除选中的许可吗?")){
					//发送ajax请求完成删除操作
					$.ajax({
						url:"${pageContext.request.contextPath}/permission/delete.do",
						type:"post",
						data:{
							"id":nodes[0].id
						},
						beforeSend:function(){
							$("#message").text("正在删除许可请稍后...");
							return true;
						},
						success:function(jsonObject){
							if(jsonObject.success){
								$("#message").text("删除成功");
								//从树对象上删除节点  第二个参数如果为true ,表示删除的节点的时候,会触发onRemove的回调函数
								treeObj.removeNode(nodes[0],true);
							}else{
								$("#message").text("删除失败");								
							}
						}
					});
				}
			}
		}
		
		
	}
</script>
${urls}
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_padding">
				<tr>
					<td><font style="font-size: 12px; color: red;"><strong>提示：点击左边树上的节点查看许可详情</strong></font>
					</td>
					<td width="25" height="26" align="right"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>许可详细信息</strong></font>
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
									<td width="30%">代码：</td>
									<td width="70%">${permission.code}</td>
								</tr>
								<tr>
									<td>名称：</td>
									<td>${permission.name }</td>
								</tr>
								<tr>
									<td>模块URL：</td>
									<td>${permission.moduleUrl }</td>
								</tr>
								<tr>
									<td>操作URL：</td>
									<td>${permission.operationUrl }</td>
								</tr>
								<tr>
									<td>排序号：</td>
									<td>${permission.orderNo }</td>
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
								<c:if test="${fn:contains(urls, 'permission/add.do')}">
									<td width="50px">
										<a class="button" href="${pageContext.request.contextPath }/permission/add.do?id=${permission.id}"><span>新增</span></a>
									</td>
								</c:if>
								<c:if test="${fn:contains(urls, 'permission/delete.do')}">
									<td width="50px">
										<a class="button" href="javascript:void(0);"><span onclick="del();">删除</span></a>
									</td>
								</c:if>
								<c:if test="${fn:contains(urls, 'permission/edit.do')}">
									<td width="50px"><a class="button" href="${pageContext.request.contextPath }/permission/edit.do?id=${permission.id}"><span>修改</span></a></td>
									<td><span id="message" style="color: blue;font-size: 14px"></span> </td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
