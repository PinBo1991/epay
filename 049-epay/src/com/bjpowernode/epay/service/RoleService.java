package com.bjpowernode.epay.service;

import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.vo.PaginationVO;

public interface RoleService {
	
	/**
	 * 保存角色
	 * @param role
	 */
	void save(Role role);
	
	/**
	 * 删除角色
	 * @param ids
	 */
	void delete(String [] ids);
	
	/**
	 * 根据id获取角色
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
	 * 分页查询角色
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	PaginationVO<Role> getByPage(Integer pageNo,Integer pageSize);
}
