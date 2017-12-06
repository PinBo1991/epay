<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<style type="text/css">
    #roleListFrame{
        border:0px;
        position: absolute;
        left : 0px;
        top : 0px;
        width: 100%;
        height: 100%;
    }
</style>

<iframe src="role/list.do" id="roleListFrame" name="roleListFrame"></iframe>