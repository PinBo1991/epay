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
		//给保存按钮注册一个单击事件
		$("#saveBtn").click(function(){
			//提交表单
			$("#permissionForm").submit();
		});
		
		//给表单绑定相关的操作
		$("#permissionForm").ajaxForm({
			//发送请求之前执行的回调函数  返回true,请求继续提交;返回false,请求不再提交了,比较适合做校验
			beforeSubmit:function(){
				$("#message").text("正在保存许可请稍后...");
				
				//设置ajax同步
				$.ajaxSetup({
					async:false
				});
				
				//触发需要校验项目的失去焦点事件  
				$(".requiredText").blur();
				
				//获取所有提示信息的span
				//alert($(".requiredSpan").length);
				/*
					jquery中遍历数组的方式1
						数组.each(function(i){
							i代表当前遍历的索引
						});
						$(".requiredSpan").each(function(i){
							alert(i+"::::"+this);
						});
					jquery中遍历数组的方式2
						$.each(数组,function(i,n){
							i代表遍历的索引,n和this都代表当前遍历的对象
						});
						$.each($(".requiredSpan"),function(i,n){
							alert(i+":::"+n+"::::"+this);
						});
						返回 'false' 将停止循环 (就像在普通的循环中使用 'break')
						返回 'true' 跳至下一个循环(就像在普通的循环中使用'continue')
				*/
				var flag = true;
				$.each($(".requiredSpan"),function(i,n){
					if(this.innerHTML!=""){
						flag = false;
						return false;
					}
				});
				
				if(!flag){
					$("#message").text("非法数据请检查!");
				}
				return flag;
			},
			//服务器处理成功之后 ,执行的回调函数  该函数会接收服务器响应的数据  具体的数据格式可以取决于response.setContentType(text|html|json|xml...)
			success:function(jsonObject){
				//{"success":true,"data":{"id":"","pid":"","name":""}} 成功  {"success":false} 失败
				if(jsonObject.success){
					$("#message").text("保存成功");
					
					//获取树对象
					var treeObj = window.parent.treeFrame.$.fn.zTree.getZTreeObj("permission_tree");
					var id = jsonObject.data.id;
					var pid = jsonObject.data.pid;
					var name = jsonObject.data.name;
					//向树对象上添加新的节点 
					var parentNode =  treeObj.getNodeByParam("id", pid);
					var newNode = {"id":id,"name":name};
					treeObj.addNodes(parentNode, newNode);
				}else{
					$("#message").text("保存失败");						
				}
				//设置ajax异步
				$.ajaxSetup({
					async:true
				});
			}
		});
		
		//给许可代码的文本框注册失去焦点事件
		$("#code").blur(function(){
			//获取许可代码
			//var code = document.getElementById("code").value; 基于Dom的编程方式  
			//var code = $("#code").val();//基于jquery的编程方式 val()是jquery特有的方法
			var code = this.value;  //基于dom的编程方式 this代表当前对象
			//var code = $(this).val();//基于jquery的编程方式   this是dom元素  但是$(this)是jquery对象
			//去除前后空白
			//code = code.trim();   在js中,String提供了trim()函数,但是在IE浏览器下不兼容
			code = $.trim(code);
			//alert("----"+code+"----");
			//判断是否为空
			//if(code==null){}错误的写法  ,因为在js中,字符串没有null
			//if(code.length==0){}这种写法可以,但是繁琐了
			if(code==""){
				//为空提示用户
				$("#codeRequiredSpan").text("许可代码不能为空");
			}else{
				//不为空  判断是否含有特殊字符  需要用到正则表达式
				/*
					正则表达式对象创建的两种方式
						方式1:  var regExp = /^[A-Za-z0-9]+$/flag;
						方式2:  var regExp = new RegExp("^[A-Za-z0-9]+$",flag);
						flag的取值:g全局匹配    i忽略大小写		m匹配多行  以及他们的任意组合
				*/
				var regExp = /^[A-Za-z0-9]+$/;
				var ok = regExp.test(code);
				if(!ok){
					//含有特殊字符  提示用户
					$("#codeRequiredSpan").text("许可代码只能是字母和数字");
				}else{
					//不含有特殊字符  发送ajax请求判断是否重复
					$.get("${pageContext.request.contextPath}/permission/getByCode.do",
							{"_":new Date().getTime(),"code":code},function(jsonObject){
								//{"success":true} 不重复  校验通过  {"success":false}重复  校验没通过
								if(jsonObject.success){
									//不重复  校验通过  清空提示信息
									$("#codeRequiredSpan").text("");									
								}else{
									//重复 提示用户
									$("#codeRequiredSpan").text("许可代码已经存在");									
								}
							});
				}
			}
		});
		
		//给许可名称文本框注册一个失去焦点事件
		$("#name").blur(function(){
			//获取许可名称
			var name = this.value;
			//去除前后空白
			name = $.trim(name);
			//判断是否为空
			if(name==""){
				//为空提示用户
				$("#nameRequiredSpan").text("许可名称不能为空");
			}else{
				//不为空  发送ajax请求 判断是否重复 (在同一个节点下,不能重复;不同的节点下,可以重复)
				$.get("${pageContext.request.contextPath}/permission/getByNameAndPid.do",
						{"_":new Date().getTime(),"name":name,"pid":"${param.id }"},function(jsonObject){
							//{"successs":true}不重复  校验通过  {"success":false} 重复  校验没通过
							if(jsonObject.success){
								//不重复 校验通过  清空提示信息
								$("#nameRequiredSpan").text("");
							}else{
								//重复   提示用户
								$("#nameRequiredSpan").text("在该节点下名称已经存在!");
							}
						});
			}
		});
	});
</script>

<form action="permission/save.do" method="post" id="permissionForm">
<input type="hidden" name="pid" value="${param.id }">
<table border="0" cellpadding="0" cellspacing="0" class="table_border">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table_right">
				<tr>
					<td><font style="font-size: 12px;"><strong>新增许可</strong></font>
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
									<td class="box_table_odd"><input type="text" id="code" name="code" class="requiredText"/> 
									<span class="star">*</span>
									<span id="codeRequiredSpan" style="color:red;font-size:12px" class="requiredSpan"></span>
									</td>
								</tr>
								<tr>
									<td height="36" class="box_table_even">名称：</td>
									<td class="box_table_odd"><input type="text" id="name" name="name" class="requiredText"/> 
									<span class="star">*</span>
									<span id="nameRequiredSpan" style="color:red;font-size:12px" class="requiredSpan"></span>
									</td>
								</tr>
								<tr>
									<td class="box_table_even">模块URL：</td>
									<td class="box_table_odd"><input type="text" id="moduleUrl" name="moduleUrl"/></td>
								</tr>
								<tr>
									<td class="box_table_even">操作URL：</td>
									<td class="box_table_odd"><input type="text" size="90" id="operationUrl" name="operationUrl"/>
										多个逗号隔开</td>
								</tr>
								<tr>
									<td class="box_table_even">排序号：</td>
									<td class="box_table_odd"><input type="text" id="orderNo" name="orderNo"/></td>
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
								<td width="50px"><a class="button" href="javascript:void(0)"><span id="saveBtn">保存</span></a></td>
								<td width="50px"><a class="button"
									href="javascript:void(window.history.back());"><span>返回</span></a></td>
								<td><span id="message" style="color: red;font-size: 12px"></span> </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>