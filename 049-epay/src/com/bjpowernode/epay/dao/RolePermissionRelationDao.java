package com.bjpowernode.epay.dao;

import java.util.List;

public interface RolePermissionRelationDao {

	/**
	 * 根据角色id和许可id获取关系表中记录数
	 * @param roleId
	 * @param id
	 * @return
	 */
	Long getCountByRoleIdAndPermissionId(String roleId, String permissionId);

	/**
	 * 根据角色id删除角色许可关系记录
	 * @param roleId
	 */
	void deleteByRoleId(String roleId);

	/**
	 * 保存角色许可关系
	 * @param roleId
	 * @param permissionId
	 */
	void save(String roleId, String permissionId);

	/**
	 * 根据角色id获取当前角色拥有的所有许可ids
	 * @param roleId
	 * @return
	 */
	List<String> getPermissionIdsByRoleId(String roleId);
	
}
