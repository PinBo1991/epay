package com.bjpowernode.epay.service;

import java.util.List;

import com.bjpowernode.epay.domain.Role;

public interface UserRoleRelationService {

	/**
	 * 根据用户id获取当前用户已经分配的角色
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
	 * 给用户分配角色
	 * @param userId
	 * @param roleIds
	 */
	void assign(String userId, String[] roleIds);

}
