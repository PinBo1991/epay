package com.bjpowernode.epay.dao;

import java.util.List;

import com.bjpowernode.epay.domain.Permission;

public interface PermissionDao {
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
	 * 获取所有许可对象
	 * @return
	 */
	List<Permission> getAll();

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
	 * 根据用户id获取当前用户拥有的所有许可
	 * @param userId
	 * @return
	 */
	List<Permission> getPermissionsByUserId(String userId);
	
}
