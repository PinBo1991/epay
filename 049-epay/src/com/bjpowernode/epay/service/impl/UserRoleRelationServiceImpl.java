package com.bjpowernode.epay.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.UserRoleRelationDao;
import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.service.UserRoleRelationService;

@Service("userRoleRelationService")
public class UserRoleRelationServiceImpl implements UserRoleRelationService {

	@Resource(name="userRoleRelationDao")
	private UserRoleRelationDao userRoleRelationDao; 
	
	
	@Override
	public List<Role> getAssignedRolesByUserId(String userId) {
		return userRoleRelationDao.getAssignedRolesByUserId(userId);
	}


	@Override
	public List<Role> getUnAssignedRolesByUserId(String userId) {
		return userRoleRelationDao.getUnAssignedRolesByUserId(userId);
	}


	@Override
	public void assign(String userId, String[] roleIds) {
		for (String roleId : roleIds) {
			//根据用户id和角色id判断当前关系表中是否有记录
			Long count = userRoleRelationDao.getCountByUserIdAndRoleId(userId,roleId);
			if(count==0){
				//正向授权  insert
				userRoleRelationDao.save(userId,roleId);
			}else{
				//负向授权  delete
				userRoleRelationDao.delete(userId,roleId);
			}
		}
	}

}
