package com.bjpowernode.epay.dao;

import java.util.List;

import com.bjpowernode.epay.domain.Role;

public interface UserRoleRelationDao {

	/**
	 * 根据用户id获取当前用户已经分配的角色列表
	 * @param userId
	 * @return
	 */
	List<Role> getAssignedRolesByUserId(String userId);

	/**
	 * 根据用户id获取当前用户未分配角色列表  
	 * @param userId
	 * @return
	 */
	List<Role> getUnAssignedRolesByUserId(String userId);

	/**
	 * 根据用户id和角色id获取关系表中记录数
	 * @param userId
	 * @param roleId
	 * @return
	 */
	Long getCountByUserIdAndRoleId(String userId, String roleId);

	/**
	 * 保存用户角色关系
	 * @param userId
	 * @param roleId
	 */
	void save(String userId, String roleId);

	/**
	 * 删除用户角色关系
	 * @param userId
	 * @param roleId
	 */
	void delete(String userId, String roleId);

}
