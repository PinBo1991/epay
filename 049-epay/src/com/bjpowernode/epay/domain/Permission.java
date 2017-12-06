package com.bjpowernode.epay.domain;

import java.util.List;

public class Permission {
	
	private String id;
	private String code;
	private String name;
	private String moduleUrl;// 当点击许可节点,跳转的资源路径 ;并不是所有许可都有模块url
	private String operationUrl;// 当执行某一个操作的时候,需要跳转的资源路径
	private Integer orderNo;// 让用户自己指定排序
	private String createTime;
	private String editTime;
	private String pid;
	private List<Permission> childNodes;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModuleUrl() {
		return moduleUrl;
	}

	public void setModuleUrl(String moduleUrl) {
		this.moduleUrl = moduleUrl;
	}

	public String getOperationUrl() {
		return operationUrl;
	}

	public void setOperationUrl(String operationUrl) {
		this.operationUrl = operationUrl;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getEditTime() {
		return editTime;
	}

	public void setEditTime(String editTime) {
		this.editTime = editTime;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public List<Permission> getChildNodes() {
		return childNodes;
	}

	public void setChildNodes(List<Permission> childNodes) {
		this.childNodes = childNodes;
	}

}
