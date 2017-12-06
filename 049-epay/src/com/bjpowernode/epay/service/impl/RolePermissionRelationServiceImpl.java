package com.bjpowernode.epay.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.RolePermissionRelationDao;
import com.bjpowernode.epay.service.RolePermissionRelationService;

@Service("rolePermissionRelationService")
public class RolePermissionRelationServiceImpl implements RolePermissionRelationService {

	
	@Resource(name="rolePermissionRelationDao")
	private RolePermissionRelationDao rolePermissionRelationDao; 
	
	@Override
	public void assign(String roleId, String[] permissionIds) {
		//先将当前这个角色拥有许可记录从关系表中删除
		rolePermissionRelationDao.deleteByRoleId(roleId);
		//在将角色id和许可id封装为一条关系记录 插入到关系表中
		for (String permissionId : permissionIds) {
			if(!"".equals(permissionId)){
				rolePermissionRelationDao.save(roleId,permissionId);				
			}
		}
	}

}
