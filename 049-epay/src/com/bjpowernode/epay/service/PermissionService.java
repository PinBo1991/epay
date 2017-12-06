package com.bjpowernode.epay.service;

import java.util.List;
import java.util.Map;

import com.bjpowernode.epay.domain.Permission;

public interface PermissionService {
	
	/**
	 * 保存许可
	 * @param permission
	 */
	void save(Permission permission);
	
	/**
	 * 根据id删除许可
	 * @param id
	 */
	void deleteById(String id);
	
	/**
	 * 根据许可id获取许可对象
	 * @param id
	 * @return
	 */
	Permission getById(String id);
	
	/**
	 * 修改许可
	 * @param permission
	 */
	void update(Permission permission);
	
	/**
	 * 拼接json格式字符串
	 * @return
	 */
	String getPermissionTree();

	/**
	 * 根据许可代码获取许可对象
	 * @param code
	 * @return
	 */
	Permission getByCode(String code);

	/**
	 * 根据许可名称和pid获取许可对象
	 * @param name
	 * @param pid
	 * @return
	 */
	Permission getByNameAndPid(String name, String pid);

	/**
	 * 生成给角色分配许可功能中带有checkbox的许可树
	 * @param roleId
	 * @return
	 */
	List<Map<String, Object>> getCheckboxTree(String roleId);

	/**
	 * 生成查看角色明细功能中的许可树
	 * @param roleId
	 * @return
	 */
	List<Map<String, Object>> getDetailTree(String roleId);

	/**
	 * 生成查看用户明细功能中的许可树
	 * @param userId
	 * @return
	 */
	List<Map<String, Object>> getFinalTree(String userId);

	/**
	 * 生成菜单树
	 * @param userId
	 * @return
	 */
	List<Map<String, Object>> getMenuTree(String userId);
}
