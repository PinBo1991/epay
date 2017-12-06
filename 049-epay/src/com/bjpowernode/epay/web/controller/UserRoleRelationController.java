package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.service.UserRoleRelationService;

@Controller
@RequestMapping("/userRoleRelation")
public class UserRoleRelationController {
	
	@Resource(name="userRoleRelationService")
	private UserRoleRelationService userRoleRelationService;
	
	@RequestMapping("/assign")
	@ResponseBody
	public Object assign(String userId,String[] roleIds){
		//{"success":true}成功  {"success":false}失败
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			userRoleRelationService.assign(userId,roleIds);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
}
