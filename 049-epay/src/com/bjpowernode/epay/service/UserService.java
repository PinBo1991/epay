package com.bjpowernode.epay.service;

import java.util.Set;

import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.domain.UserCondition;
import com.bjpowernode.epay.vo.PaginationVO;

public interface UserService {
	/**
	 * 保存用户
	 * @param user
	 */
	void save(User user);

	/**
	 * 分页查询用户
	 * @param userCondition
	 * @return
	 */
	PaginationVO<User> getByPage(UserCondition userCondition);

	/**
	 * 根据用户id获取用户对象
	 * @param id
	 * @return
	 */
	User getById(String id);

	/**
	 * 登录认证
	 * @param accountNo
	 * @param password
	 * @param ip
	 * @return
	 */
	User login(String accountNo, String password, String ip);

	/**
	 * 获取当前用户能够操作的所有urls
	 * @param id
	 * @return
	 */
	Set<String> getUrlsByUserId(String userId);
	
}
