package com.bjpowernode.epay.service;

public interface RolePermissionRelationService {

	/**
	 * 给角色分配许可
	 * @param roleId
	 * @param permissionIds
	 */
	void assign(String roleId, String[] permissionIds);

}
