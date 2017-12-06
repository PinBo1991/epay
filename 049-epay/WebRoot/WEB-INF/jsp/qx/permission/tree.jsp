<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">

<link rel="stylesheet" href="jquery/ztree/css/zTreeStyle/zTreeStyle.css" />
<script src="jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="jquery/ztree/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>

<script type="text/javascript">
	var setting = {
		data: {
			simpleData: {
				//使用简单的json格式拼接树节点数据
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
			url: "${pageContext.request.contextPath}/permission/makePermissionTree.do"
		},
		callback:{
			//当单击树节点的时候,在workarea的位置打开详情页面
			onClick:function(){
				//获取当前树对象
				var treeObj = $.fn.zTree.getZTreeObj("permission_tree");
				//获取选中的节点  注意:该方法的返回值是Array(json)   因为我们这里设置了禁止树节点多选 所以数组中只有一个元素 nodes[0]
				var nodes = treeObj.getSelectedNodes();
				//alert(nodes[0].id);
				window.parent.workareaFrame.location = "${pageContext.request.contextPath}/permission/detail.do?id="+nodes[0].id;
			},
			//当删除树节点的时候执行的回调函数
			onRemove:function(event, treeId, treeNode){
				//获取当前树对象
				var treeObj = $.fn.zTree.getZTreeObj("permission_tree");
				//选中父节点 
				treeObj.selectNode(treeNode.getParentNode());
				//显示父节点详情
				window.parent.workareaFrame.location = "${pageContext.request.contextPath}/permission/detail.do?id="+treeNode.getParentNode().id;
			}
		}
	};

	$(document).ready(function(){
		$.fn.zTree.init($("#permission_tree"), setting);
	});
	
		
</script>
<ul id="permission_tree" class="ztree">
</ul>
