package com.bjpowernode.epay.dao;

import java.util.List;

import com.bjpowernode.epay.domain.Role;

public interface RoleDao {
	
	/**
	 * 保存角色
	 * @param role
	 */
	void save(Role role);
	
	/**
	 * 根据角色id删除角色
	 * @param id
	 */
	void deleteById(String id);
	
	/**
	 * 根据角色id获取角色对象
	 * @param id
	 * @return
	 */
	Role getById(String id);
	
	/**
	 * 修改角色
	 * @param role
	 */
	void update(Role role);
	
	/**
	 * 获取分页查询的数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Role> getRolesByPage(Integer pageNo,Integer pageSize);
	
	/**
	 * 获取总记录条数
	 * @return
	 */
	Long getTotal();
}
