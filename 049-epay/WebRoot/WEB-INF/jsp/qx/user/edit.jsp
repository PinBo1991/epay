<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/table.css" rel="stylesheet" type="text/css" />
<link href="dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />

<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>修改用户</strong></font>
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
												<td class="box_table_odd"><span class="in"> <input
														type="text" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">用户姓名：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="text" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">电子邮件：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="text" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">登录密码：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="password" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">密码确认：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="password" /> <span class="star">*</span>
												</span></td>
											</tr>
											<tr>
												<td class="box_table_even">是否启用：</td>
												<td class="box_table_odd"><input type="radio" /> 启用 <input
													type="radio" /> 锁定 <span class="star">*</span></td>
											</tr>
											<tr>
												<td class="box_table_even">失效时间：</td>
												<td class="box_table_odd"><input type="text" /> <span
													class="star">*</span></td>
											</tr>
											<tr>
												<td class="box_table_even">允许访问的IP：</td>
												<td class="box_table_odd"><span class="in"> <input
														type="text" size="120" />
												</span></td>
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
								<td width="50px"><a class="button" href="list.html"><span>更新</span></a></td>
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

