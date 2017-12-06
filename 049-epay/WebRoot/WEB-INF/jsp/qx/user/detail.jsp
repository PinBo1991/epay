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
   			url: "${pageContext.request.contextPath}/permission/makeFinalTree.do?userId=${user.id}"
   		}
	};
	
	$(function() {
		//集成jquery多tab页
		$('#tabs').tabs();
		$.fn.zTree.init($("#final_tree"), setting);
	});
</script>

<table border="0" cellpadding="0" cellspacing="0" class="table_border">
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
                class="table_right">
                <tr>
                    <td>
                        <font style="font-size: 12px"><strong>用户详细信息</strong></font>
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
					<li style="font-size: 12px;">
						<a href="#tabs-1">用户信息</a>
					</li>
					<li style="font-size: 12px;">
						<a href="#tabs-2">许可信息</a>
					</li>
				</ul>
				<div id="tabs-1" style="background: #FFFFFF">
					登录帐号：${user.accountNo }
					<br />
					<br />
					用户姓名：${user.name }
					<br />
					<br />
					电子邮件：${user.email }
					<br />
					<br />
					创建时间：${user.createTime }
					<br />
					<br />
					失效时间：${user.expireTime }
					<br />
					<br />
					允许访问IP：${user.allowIps }
					<br />
					<br />
					状态：<%-- ${user.lockStatusText} --%>
						${user.lockStatus eq LOCK_CODE?LOCK_TEXT:UN_LOCK_TEXT}
					<br />
				</div>
				<div id="tabs-2" style="background: #FFFFFF">
					<table>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>
								<ul id="final_tree" class="ztree">
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
					<td width="50px"><a class="button" href="javascript:void(0)" onclick="window.history.back()"><span>返回</span></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
