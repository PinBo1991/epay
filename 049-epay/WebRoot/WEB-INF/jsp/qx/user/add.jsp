<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
<link href="jquery/ui/css/ui-lightness/jquery-ui-1.8.18.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/ui/js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="jquery/ui/js/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="jquery/ui/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="jquery/form/jquery.form.js"></script>


<script type="text/javascript">
	//页面加载完成之后
	$(function(){
		//集成日历插件
		$("#expireTime").datetimepicker({
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showSecond: true,
			timeFormat: 'hh:mm:ss'
		});
		// 为保存按钮注册一个单击事件
		$("#saveBtn").click(function(){
			// 提交表单
			$("#userForm").submit();
		});
		$("#userForm").ajaxForm({
			beforeSubmit:function(){
				$("#message").text("正在保存请稍后...");
			},
			success:function(jsonObject){
				if(jsonObject.success){
					$("#message").text("保存成功!");
				}else{
					$("#message").text("保存失败!");
				}
			}
		});
	});
</script>

<form action="user/save.do" method="post" id="userForm">
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>新增用户</strong></font>
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
						<table width="100%" border="0" cellspacing="0"
							class="table_padding">
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0"
										class="box_table" id="box_table2">
										<thead>
											<tr>
												<td class="box_table_even">登录帐号：</td>
												<td class="box_table_odd">
													<span class="in"> 
														<input type="text" name="accountNo"/> 
														<span class="star">*</span>
													</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">用户姓名：</td>
												<td class="box_table_odd">
													<span class="in"> 
														<input type="text" name="name"/> 
														<span class="star">*</span>
													</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">电子邮件：</td>
												<td class="box_table_odd">
													<span class="in"> 
														<input type="text" name="email"/> 
														<span class="star">*</span>
													</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">登录密码：</td>
												<td class="box_table_odd">
													<span class="in"> 
														<input type="password" name="password"/> 
														<span class="star">*</span>
													</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">密码确认：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="password" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">是否启用：</td>
												<td class="box_table_odd">
													<input type="radio" name="lockStatus" value="1"/> 启用 
													<input type="radio" name="lockStatus" value="2"/> 锁定 
													<span class="star">*</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">失效时间：</td>
												<td class="box_table_odd">
													<input type="text" id="expireTime" name="expireTime"/> 
													<span class="star">*</span>
												</td>
											</tr>
											<tr>
												<td class="box_table_even">允许访问的IP：</td>
												<td class="box_table_odd">
													<span class="in"> 
														<input type="text" size="120" name="allowIps"/>
													</span>
												</td>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</td>
							</tr>
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
								<td width="50px"><a class="button" href="javascript:void(0);"><span id="saveBtn">保存</span></a></td>
								<td width="50px"><a class="button"
									href="javascript:void(window.history.back());"><span>返回</span></a></td>
								<td><span id="message" style="color: red;font-size: 14px"></span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
