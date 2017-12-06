package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.service.RolePermissionRelationService;

@Controller
@RequestMapping("/rolePermissionRelation")
public class RolePermissionRelationController {
	
	@Resource(name="rolePermissionRelationService")
	private RolePermissionRelationService rolePermissionRelationService; 
	
	@RequestMapping("/assign")
	@ResponseBody
	public Object assign(String roleId,String [] permissionIds){
		//{"success":true} 成功  {"success":false} 失败
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			rolePermissionRelationService.assign(roleId,permissionIds);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
}
