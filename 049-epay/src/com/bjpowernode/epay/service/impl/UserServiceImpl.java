package com.bjpowernode.epay.service.impl;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.PermissionDao;
import com.bjpowernode.epay.dao.UserDao;
import com.bjpowernode.epay.domain.Permission;
import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.domain.UserCondition;
import com.bjpowernode.epay.exceptions.ApplicationException;
import com.bjpowernode.epay.service.UserService;
import com.bjpowernode.epay.utils.DateUtil;
import com.bjpowernode.epay.vo.PaginationVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource(name="userDao")
	private UserDao userDao;
	
	@Resource(name="permissionDao")
	private PermissionDao permissionDao;
	
	@Override
	public void save(User user) {
		userDao.save(user);
	}

	@Override
	public PaginationVO<User> getByPage(UserCondition userCondition) {
		PaginationVO<User> paginationVO = new PaginationVO<User>();
		Long total = userDao.getTotal(userCondition);
		List<User> dataList = userDao.getUsersByPage(userCondition);
		paginationVO.setTotal(total);
		paginationVO.setDataList(dataList);
		return paginationVO;
	}

	@Override
	public User getById(String id) {
		return userDao.getById(id);
	}

	@Override
	public User login(String accountNo, String password, String ip) {
		User user = userDao.getByAccountNoAndPassword(accountNo,password);
		//账号和密码是否正确
		if(user==null){
			throw new ApplicationException("账号或者密码错误!");
		}
		//是否锁定
		if(User.LOCK_CODE.equals(user.getLockStatus())){
			throw new ApplicationException("账号已被锁定请联系管理员!");			
		}
		//是否失效
		if(user.getExpireTime()!=null&&user.getExpireTime()!=""&&DateUtil.getSystemTime().compareTo(user.getExpireTime())>0){
			throw new ApplicationException("账号已失效请联系管理员!");						
		}
		//是否ip受限
		if(user.getAllowIps()!=null&&user.getAllowIps()!=""&&!user.getAllowIps().contains(ip)){
			throw new ApplicationException("ip受限请联系管理员!");									
		}
		return user;
	}

	@Override
	public Set<String> getUrlsByUserId(String userId) {
		Set<String> urls = new HashSet<String>();
		//获取用户拥有的所有许可
		List<Permission> permissions = permissionDao.getPermissionsByUserId(userId);
		for (Permission permission : permissions) {
			if(permission.getModuleUrl()!=null){
				urls.add(permission.getModuleUrl());
			}
			if(permission.getOperationUrl()!=null){
				//将数组放到集合中
				Collections.addAll(urls, permission.getOperationUrl().split(","));
			}
		}
		return urls;
	}

}
