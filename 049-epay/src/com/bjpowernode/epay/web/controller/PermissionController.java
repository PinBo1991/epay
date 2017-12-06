package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.domain.Permission;
import com.bjpowernode.epay.service.PermissionService;
import com.bjpowernode.epay.utils.DateUtil;

@Controller
@RequestMapping("/permission")
public class PermissionController{

	@Resource(name="permissionService")
	private PermissionService permissionService;

	@RequestMapping("/index")
	public String index(){
		return "qx/permission/index";
	}
	
	@RequestMapping("/tree")
	public String tree(){
		return "qx/permission/tree";
	}
	
	@RequestMapping("/workarea")
	public String workarea(){
		return "qx/permission/workarea";
	}
	
	@RequestMapping(value="/makePermissionTree",produces="text/json;charset=UTF-8")
	@ResponseBody
	public Object makePermissionTree(){
		//System.out.println(Thread.currentThread().getContextClassLoader());
		//System.out.println(Thread.currentThread().getContextClassLoader().getParent());
		//System.out.println(Thread.currentThread().getContextClassLoader().getParent().getParent());
		//System.out.println(Thread.currentThread().getContextClassLoader().getParent().getParent().getParent());
		//System.out.println(Thread.currentThread().getContextClassLoader().getParent().getParent().getParent().getParent());
		return permissionService.getPermissionTree();
	}
	
	@RequestMapping("/detail")
	public String detail(String id,Model model){
		model.addAttribute("permission", permissionService.getById(id));
		return "qx/permission/detail";
	}
	
	@RequestMapping("/add")
	public String add(){
		return "qx/permission/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Object save(Permission permission){
		//{"success":true,"data":{"id":"","pid":"","name":""}} 成功  {"success":false}失败
		permission.setCreateTime(DateUtil.getSystemTime());
		
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			permissionService.save(permission);
			jsonMap.put("success", true);
			Map<String,Object> permissionMap = new HashMap<String,Object>();
			permissionMap.put("id", permission.getId());
			permissionMap.put("pid", permission.getPid());
			permissionMap.put("name", permission.getName());
			jsonMap.put("data", permissionMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
			
		}
		return jsonMap;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id){
		//{"success":true} 成功  {"success":false} 失败
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			permissionService.deleteById(id);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/edit")
	public String edit(String id,Model model){
		//根据id获取许可对象
		model.addAttribute("permission", permissionService.getById(id));
		return "qx/permission/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Object update(Permission permission){
		//{"success":true} 成功  {"success":false} 失败
		permission.setEditTime(DateUtil.getSystemTime());
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			permissionService.update(permission);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/getByCode")
	@ResponseBody
	public Object getByCode(String code){
		//{"success":true} 不重复  校验通过  {"success":false}重复  校验没通过
		//根据许可代码获取许可对象
		Permission permission = permissionService.getByCode(code);
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		if(permission==null){
			jsonMap.put("success", true);
		}else{
			jsonMap.put("success", false);			
		}
		return jsonMap;
	}
	
	@RequestMapping("/getByNameAndPid")
	@ResponseBody
	public Object getByNameAndPid(String name,String pid){
		//{"success":true} 不重复  校验通过  {"success":false}重复  校验没通过
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		//根据名字和pid获取许可对象
		Permission permission = permissionService.getByNameAndPid(name,pid);
		if(permission==null){
			jsonMap.put("success", true);
		}else{
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/makeCheckboxTree")
	@ResponseBody
	public Object makeCheckboxTree(String roleId){
		// [{id:"000",pId:"0",name:"外汇局业务办公系统",open:true},{id:"7001",pId:"700",name:"公告管理"}]
		List<Map<String,Object>> jsonList = permissionService.getCheckboxTree(roleId);
		return jsonList;
	}
	
	@RequestMapping("/makeDetailTree")
	@ResponseBody
	public Object makeDetailTree(String roleId){
		// [{id:"000",pId:"0",name:"外汇局业务办公系统",open:true},{id:"7001",pId:"700",name:"公告管理"}]
		List<Map<String,Object>> jsonList = permissionService.getDetailTree(roleId);
		return jsonList;
	}
	
	@RequestMapping("/makeFinalTree")
	@ResponseBody
	public Object makeFinalTree(String userId){
		// [{id:"000",pId:"0",name:"外汇局业务办公系统",open:true},{id:"7001",pId:"700",name:"公告管理"}]
		List<Map<String,Object>> jsonList = permissionService.getFinalTree(userId);
		return jsonList;
	}
	
	@RequestMapping("/makeMenuTree")
	@ResponseBody
	public Object makeMenuTree(String userId){
		// [{id:"000",pId:"0",name:"外汇局业务办公系统",open:true},{id:"7001",pId:"700",name:"公告管理"}]
		List<Map<String,Object>> jsonList = permissionService.getMenuTree(userId);
		return jsonList;
	}
}