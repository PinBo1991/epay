<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>互联网支付-后台管理</title>

<script src="jquery/jquery-1.7.2.min.js" type="text/javascript"></script>

<link href="dwz/themes/azure/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
<link href="dwz/themes/css/print.css" rel="stylesheet" type="text/css" media="print" />
<link href="dwz/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" media="screen" />
<script src="dwz/bin/dwz.min.js" type="text/javascript"></script>
<script src="dwz/js/dwz.regional.zh.js" type="text/javascript"></script>

<link rel="stylesheet" href="jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="jquery/ztree/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
	$(function() {
		DWZ.init("dwz/dwz.frag.xml", {
			loginUrl : "login_dialog.html",
			loginTitle : "登录", // 弹出登录对话框
			statusCode : {
				ok : 200,
				error : 300,
				timeout : 301
			}, //【可选】
			pageInfo : {
				pageNum : "pageNum",
				numPerPage : "numPerPage",
				orderField : "orderField",
				orderDirection : "orderDirection"
			}, //【可选】
			keys : {
				statusCode : "statusCode",
				message : "message"
			}, //【可选】
			ui : {
				hideMode : 'offsets'
			}, //【可选】hideMode:navTab组件切换的隐藏方式，支持的值有’display’，’offsets’负数偏移位置的值，默认值为’display’
			debug : false, // 调试模式 【true|false】
			callback : function() {
				initEnv();
				$("#themeList").theme({
					themeBase : "themes"
				}); // themeBase 相对于index页面的主题base路径
			}
		});
	});
</script>
</head>

<body>
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<a class="logo" href="http://www.bjpowernode.com">标志</a>
				<ul class="nav">
					<li><a href="javascript:void(0)">用户信息：${session_user.name}</a></li>
					<li><a href="javascript:void(0)">上次登录时间：2016-06-01 10:10:10</a></li>
					<li><a href="javascript:void(0)">登录次数：888</a></li>
					<li><a href="main/changepwd.do" target="dialog" width="600">修改密码</a></li>
					<li><a href="login.html">退出登录</a></li>
				</ul>
			</div>
		</div>
		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse">
						<div></div>
					</div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse">
					<h2>互联网支付管理</h2>
					<div>收缩</div>
				</div>
				<div class="accordion" fillSpace="sidebar">
					
					<!-- 操作员管理 -->
					<div class="accordionHeader"><h2>&nbsp;&nbsp;操作员管理</h2></div>
					<div class="accordionContent">
						<script type="text/javascript">
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
						   			url: "${pageContext.request.contextPath}/permission/makeMenuTree.do?userId=${session_user.id}"
						   		},
						   		callback:{
						   			onExpand:function(event,treeId,treeNode){
						   				initUI($("#"+treeId));
						   			}
						   		}
							};
							
							$(document).ready(function(){
								$.fn.zTree.init($("#menu_tree"), setting);
							});
						</script>
						<div id="menu_tree" class="ztree"></div>
					</div>
					
					<div class="accordionHeader"><h2>&nbsp;&nbsp;车辆管理管理</h2></div>
						
					<div class="accordionContent">
						老杨二手车!!!
					</div>
					
				</div>
			</div>
		</div>
		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent">
						<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" class="main">
								<a href="javascript:;">
									<span>
										<span class="home_icon">我的主页</span>
									</span>
								</a>
							</li>
						</ul>
					</div>
					<div class="tabsLeft">left</div>
					<!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
					<div class="tabsRight">right</div>
					<!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
					<div class="tabsMore">more</div>
				</div>
				<ul class="tabsMoreList">
					<li><a href="javascript:;">我的主页</a></li>
				</ul>
				<div class="navTab-panel tabsPageContent layoutBox">
					<div style="display: table; width: 100%; height: 500px;">
						<div id="box" style="display: table-cell; vertical-align: middle; text-align: center;">
							<img src="dwz/themes/default/images/bj.jpg" width="100%" height="100%"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<b>互联网支付-后台管理</b>&nbsp;Copyright &copy; <a href="demo_page2.html" target="dialog">北京动力节点教育科技有限公司</a>
	</div>
</body>
</html>