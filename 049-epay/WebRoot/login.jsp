<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<style>
.bjf {
	background: url(images/bjf.jpg) repeat-x;
}

.dlf_03 {
	background: url(images/dlf_03.jpg) no-repeat;
	width: 636px;
	height: 283px;
}

.dlk {
	width: 300px;
	height: 150px;
	margin-left: 290px;
	margin-top: 2px;
}

.wenzi {
	font-size: 12px;
	font-family: "宋体";
}

.shurukuang {
	width: 180px;
	height: 20px;
	line-height: 20px;
	font-size: 12px;
	font-family: "宋体";
}

.shurukuang1 {
	width: 50px;
	height: 20px;
	line-height: 20px;
	font-size: 12px;
	font-family: "宋体";
	border: 1px solid #7F9DB9
}

.cuowu {
	width: 300px;
	height: 30px;
	font: "宋体";
	font-size: 12px;
	text-align: center;
	color: #FF4A4A;
	line-height: 30px;
}

.dlk a.test {
	display: block;
	width: 44px;
	height: 26px;
	background-image: url(images/dlf.jpg);
	background-repeat: no-repeat;
}

.dlk a.test:hover {
	background-image: url(images/dlfh.jpg);
}

.dlk a.test1 {
	display: block;
	width: 44px;
	height: 26px;
	background-image: url(images/czf.jpg);
	background-repeat: no-repeat;
}

.dlk a.test1:hover {
	background-image: url(images/czf.jpg);
}

.dlk .dla {
	border: none;
	background: transparent;
}

.ocx_style {
	border: 1px solid #7F9DB9;
	width: 155px;
	height: 20px;
}

.login_gerlyous {
	width: 178px;
	height: 20px;
	background: #FFFFFF;
	border: 1px solid #dddddd;
	color: #000000;
	line-height: 25px;
	padding-left: 0px
}
</style>
<title>互联网支付系统</title>
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	$(function(){
		//让登陆账号文本框获取焦点
		$("#accountNo").focus();
		//给整个登陆窗口注册keydown事件
		$(window).keydown(function(event){
			if(event.keyCode==13){
				login();
			}
		});
		
	});
	function login(){
		//发送ajax请求完成登录认证的功能
		$.ajax({
			url:"${pageContext.request.contextPath}/main/login.do",
			type:"post",
			data:{
				"accountNo":$("#accountNo").val(),
				"password":$("#password").val()
			},
			beforeSend:function(){
				$("#message").text("正在进行登录认证请稍后...");
				return true;
			},
			success:function(jsonObject){
				//{"success":true}成功  {"success":false,"errMsg":""}失败
				if(jsonObject.success){
					window.location.href="${pageContext.request.contextPath}/main/main.do";
				}else{
					$("#message").text(jsonObject.errMsg);
				}
			}
		});
	}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	class="bjf">
	<span id="message" style="color: red;font-size: 12px"></span>
	<form action="main/main.do" id="myform" name="myform" method="post">
		<table style="margin: 0 auto; padding: 0;" id="__01" width="1265"
			height="626" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td colspan="3" width="1265" height="181"></td>
			</tr>
			<tr>
				<td width="315" height="283"></td>
				<td class="dlf_03">
					<div class="dlk">
						<table width="100%" border="0" cellpadding="2">
							<tr>
								<td width="71" align="right" class="wenzi">用户名：</td>
								<td colspan="3"><label> <input type="text"
										id="accountNo" tabindex="1" maxlength='20'
										class="ocx_style" />
								</label></td>
							</tr>
							<tr>
								<td align="right" class="wenzi">密&nbsp;码：</td>
								<td colspan="3"><label> <input type="password"
										id="password" tabindex="1" maxlength='20'
										class="ocx_style" />
								</label></td>
							</tr>
							<tr>
								<td align="right" class="wenzi">验证码：</td>
								<td width="59"><input id="rand" tabindex="3" name="rand"
									maxlength='4' type="text" value="" class="shurukuang1"></td>
								<td width="56"><img name="randImage" id="randImage" src="images/yzm.png"
									width="64" height="20" border="1" align="top"
									onclick="javascript:void(0);"></td>
								<td width="88">&nbsp;</td>
							</tr>
							<tr>
								<td></td>
								<td style="padding-top: 10px;"><a style="text-decoration: none;" href="javascript:void(0)"
									class="test"> 
									<input onclick="login();" class="dla" style="cursor: pointer;height: 27px; width: 45px;" name="dd" value="" />
								</a></td>
								<td>&nbsp;</td>
								<td style="padding-top: 10px;"><a href="javascript:void(0)"
									class="test1"> <input type="reset" class="dla" name="dd"
										onclick="qc();" style="height: 27px; width: 45px;" value="" />
								</a></td>
							</tr>
						</table>
					</div>

				</td>
				<td width="314" height="283"></td>
			</tr>
			<tr>
				<td colspan="3" width="1265" height="162"></td>
			</tr>

		</table>
	</form>
</body>
</html>
