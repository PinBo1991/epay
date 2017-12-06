package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.domain.UserCondition;
import com.bjpowernode.epay.service.UserRoleRelationService;
import com.bjpowernode.epay.service.UserService;
import com.bjpowernode.epay.utils.DateUtil;
import com.bjpowernode.epay.utils.MD5Util;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="userRoleRelationService")
	private UserRoleRelationService userRoleRelationService; 
	
	@RequestMapping("/index")
	public String index(){
		return "qx/user/index";
	}
	
	@RequestMapping("/add")
	public String add(){
		return "qx/user/add";
	}
	
	@RequestMapping("/edit")
	public String edit(){
		return "qx/user/edit";
	}
	
	@RequestMapping("/list")
	public String list(){
		return "qx/user/list";
	}
	
	@RequestMapping("/assign")
	public String assign(String id,Model model){
		//获取用户信息
		User user = userService.getById(id);		
		model.addAttribute("user", user);
		
		//获取当前用户已经分配的角色列表
		List<Role> assignedRoles = userRoleRelationService.getAssignedRolesByUserId(id);
		model.addAttribute("assignedRoles", assignedRoles);
		
		//获取当前用户未分配的角色列表
		List<Role> unAssignedRoles = userRoleRelationService.getUnAssignedRolesByUserId(id);
		model.addAttribute("unAssignedRoles", unAssignedRoles);
		
		return "qx/user/assign";
	}
	
	@RequestMapping("/detail")
	public String detail(String id,Model model){
		User user = userService.getById(id);
		model.addAttribute("user", user);
		return "qx/user/detail";
	}
	@RequestMapping("/save")
	@ResponseBody
	public Object save(User user){
		Map<String ,Object> jsonMap = new HashMap<String,Object>(); 
		try{
			user.setCreateTime(DateUtil.getSystemTime());
			user.setPassword(MD5Util.MD5(user.getPassword()));
			userService.save(user);
			jsonMap.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/getByPage")
	@ResponseBody
	public Object getByPage(UserCondition userCondition){
		//{"total":100,"dataList":[{"id":"","accountNo":"","name":"","createTime":"","expireTime":"","allowIps":"","lockStatusText":""},{},{}]}
		return userService.getByPage(userCondition);
	}
}
