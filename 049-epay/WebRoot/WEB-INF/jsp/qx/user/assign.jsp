<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	function move(srcId,destId){
		//发送ajax请求完成给用户分配角色的功能  userId=123&roleIds=		111&roleIds=222&roleIds=333
		//获取当前选中option
		var selectedOptions = $("option:selected","#"+srcId);
		if(selectedOptions.length==0){
			$("#message").text("请选择角色");
		}else{
			var sendData = "userId=${user.id}&roleIds=";
			var idArray = [];
			//遍历选中的option
			$.each(selectedOptions,function(i,n){
				idArray.push(n.value);
			});
			sendData += idArray.join("&roleIds=");
			//alert(sendData);
			$.ajax({
				url:"${pageContext.request.contextPath}/userRoleRelation/assign.do",
				type:"post",
				data:sendData,
				beforeSend:function(){
					$("#message").text("正在给用户分配角色请稍后...");
					return true;
				},
				success:function(jsonObject){
					//{"success":true}成功  {"success":false}失败
					if(jsonObject.success){
						$("#message").text("分配成功");
						$("option:selected","#"+srcId).appendTo("#"+destId);
					}else{
						$("#message").text("分配失败");					
					}
				}
			});
		}
	}
</script>
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>为用户分配角色</strong></font>
					</td>
					<td width="25" height="26" align="left"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" class="table_padding">
				<tr>
					<td>
						<table style="font-size:12px;" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="42%">
									<div class="list_tit">${user.name }，未分配角色列表</div>
								</td>
								<td width="15%">&nbsp;</td>
								<td width="43%">
									<div class="list_tit">${user.name }，已分配角色列表</div>
								</td>
							</tr>
							<tr>
								<td><select size="20" id="unAssignedRoleList" ondblclick="move('unAssignedRoleList','assignedRoleList')"
									style="width: 100%;height:370px;font-size: 12px;" multiple="multiple">
										<c:forEach items="${unAssignedRoles}" var="unAssignedRole">
											<option value="${unAssignedRole.id}">${unAssignedRole.name }</option>
										</c:forEach>
								</select></td>
								<td>
									<p align="center">
										<img style="cursor:pointer;" onmouseout="this.width=30;this.height=30;" 
											onmouseover="this.width=35;this.height=35;" 
											width="30px;" height="30px;"  alt="分配角色" onclick="move('unAssignedRoleList','assignedRoleList')"
											src="images/youjt.png" title="分配角色">
									</p>
									<br><br><br><br>
									<p align="center">
										<img style="cursor:pointer;" onmouseout="this.width=30;this.height=30;" 
											onmouseover="this.width=35;this.height=35;" 
											width="30px;" height="30px;" width="30px;" onclick="move('assignedRoleList','unAssignedRoleList')"
											height="30px;" alt="撤销角色" src="images/zuojt.png" 
											title="撤销角色">
									</p>
								</td>
								<td>
									<select size="20" multiple="multiple" ondblclick="move('assignedRoleList','unAssignedRoleList')"
										id="assignedRoleList" style="width: 100%;height:370px; font-size: 12px;">
											<c:forEach items="${assignedRoles}" var="assignedRole">
												<option value="${assignedRole.id}">${assignedRole.name}</option>
											</c:forEach>
									</select>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="table_padding">
							<tr>
								<td height="21" align="right">
									<table align="right">
										<tr>
											<td><span id="message" style="color: red;font-size: 12px"></span> </td>
											<td width="50px"><a class="button"
												href="javascript:void(window.history.back());"><span>返回</span></a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
