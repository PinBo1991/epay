package com.bjpowernode.epay.domain;

import java.util.List;

public class User {
	
	public static final Integer LOCK_CODE = 2; 
	public static final Integer UN_LOCK_CODE = 1;
	public static final String LOCK_TEXT = "锁定";
	public static final String UN_LOCK_TEXT = "启用";
	
	private String id;
	private String accountNo;
	private String name;
	private String email;
	private String password;
	private Integer lockStatus;// 1 启用 2锁定
	private String expireTime;
	private String allowIps;
	private String createTime;
	private String editTime;

	private List<Role> roles;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getLockStatus() {
		return lockStatus;
	}
	
	public String getLockStatusText() {
		return LOCK_CODE.equals(lockStatus)?LOCK_TEXT:UN_LOCK_TEXT;
	}

	public void setLockStatus(Integer lockStatus) {
		this.lockStatus = lockStatus;
	}

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	public String getAllowIps() {
		return allowIps==null?"":allowIps;
	}

	public void setAllowIps(String allowIps) {
		this.allowIps = allowIps;
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

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

}
