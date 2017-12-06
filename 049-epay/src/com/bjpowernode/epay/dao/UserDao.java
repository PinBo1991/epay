package com.bjpowernode.epay.dao;

import java.util.List;

import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.domain.UserCondition;

public interface UserDao {
	/**
	 * 保存用户
	 * @param user
	 */
	void save(User user);

	/**
	 * 获取总记录条数
	 * @param userCondition
	 * @return
	 */
	Long getTotal(UserCondition userCondition);

	/**
	 * 获取分页查询的数据
	 * @param userCondition
	 * @return
	 */
	List<User> getUsersByPage(UserCondition userCondition);

	/**
	 * 根据用户id获取用户对象
	 * @param id
	 * @return
	 */
	User getById(String id);

	/**
	 * 根据账号和密码获取用户对象
	 * @param accountNo
	 * @param password
	 * @return
	 */
	User getByAccountNoAndPassword(String accountNo, String password);

}
