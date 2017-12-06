<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<style type="text/css">
	#treeFrame{
		border:1px #a2bac0 solid;
		position: absolute;
		left : 2px;
		top : 2px;
		width: 300x;
		height: 485px;
	}
	#workareaFrame{
		border:0px;
		position: absolute;
		left : 310px;
		width : 830px;
		top : 2px;
		height: 485px;
	}
</style>

<iframe src="permission/tree.do" name="treeFrame" id="treeFrame"></iframe>
<iframe src="permission/workarea.do" name="workareaFrame" id="workareaFrame"></iframe>
