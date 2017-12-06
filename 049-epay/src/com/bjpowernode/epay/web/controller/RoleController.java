package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.service.RoleService;
import com.bjpowernode.epay.utils.DateUtil;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Resource(name="roleService")
	private RoleService roleService;
	
	@RequestMapping("/index")
	public String index(){
		return "qx/role/index";
	}
	
	@RequestMapping("/list")
	public String list(){
		return "qx/role/list";
	}
	
	@RequestMapping("/add")
	public String add(){
		return "qx/role/add";
	}
	
	@RequestMapping("/edit")
	public String edit(String id,Model model){
		//根据id获取修改对象
		Role role = roleService.getById(id);
		model.addAttribute("role", role);
		return "qx/role/edit";
	}
	
	@RequestMapping("/assign")
	public String assign(String id,Model model){
		Role role = roleService.getById(id);
		model.addAttribute("role", role);
		return "qx/role/assign";
	}
	
	@RequestMapping("/detail")
	public String detail(String id,Model model){
		Role role = roleService.getById(id);
		model.addAttribute("role", role);
		return "qx/role/detail";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Object save(Role role){
		//{"success":true}成功  {"success":false} 失败
		role.setCreateTime(DateUtil.getSystemTime());
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			roleService.save(role);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/getByPage")
	@ResponseBody
	public Object getByPage(Integer pageNo,Integer pageSize){
		//{"total":100,"dataList":[{"id":"","code":"","name":"","remark":""},{},{}]}
		return roleService.getByPage(pageNo, pageSize);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String[] ids){
		//{"success":true} 成功  {"success":false} 失败
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		
		try {
			roleService.delete(ids);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Object update(Role role){
		role.setEditTime(DateUtil.getSystemTime());
		Map<String, Object> jsonMap = new HashMap<String,Object>();
		try {
			roleService.update(role);
			jsonMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("success", false);
		}
		return jsonMap;
	}
}
