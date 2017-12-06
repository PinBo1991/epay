package com.bjpowernode.epay.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.PermissionDao;
import com.bjpowernode.epay.dao.RolePermissionRelationDao;
import com.bjpowernode.epay.domain.Permission;
import com.bjpowernode.epay.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

	@Resource(name="permissionDao")
	private PermissionDao permissionDao;
	
	@Resource(name="rolePermissionRelationDao")
	private RolePermissionRelationDao rolePermissionRelationDao;
	
	@Override
	public void save(Permission permission) {
		permissionDao.save(permission);
	}

	@Override
	public void deleteById(String id) {
		permissionDao.deleteById(id);
	}

	@Override
	public Permission getById(String id) {
		return permissionDao.getById(id);
	}

	@Override
	public void update(Permission permission) {
		permissionDao.update(permission);
	}

	@Override
	public String getPermissionTree() {
		StringBuilder jsonString = new StringBuilder(200);
		jsonString.append("[");
		//获取所有许可对象
		List<Permission> permissions = permissionDao.getAll();
		for (Permission permission : permissions) {
			String pId = permission.getPid()==null?"0":permission.getPid();
			jsonString.append("{\"id\":\""+permission.getId()+"\",\"pId\":\""+pId+"\",\"name\":\""+permission.getName()+"\",\"open\":true},");
		}
		return jsonString.append("]").toString().replace(",]", "]");   //,]-->]
	}

	@Override
	public Permission getByCode(String code) {
		return permissionDao.getByCode(code);
	}

	@Override
	public Permission getByNameAndPid(String name, String pid) {
		return permissionDao.getByNameAndPid(name,pid);
	}

	@Override
	public List<Map<String, Object>> getCheckboxTree(String roleId) {
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		//获取当前角色拥有的所有许可ids
		List<String> permissionIds = rolePermissionRelationDao.getPermissionIdsByRoleId(roleId);
		//获取所有许可
		List<Permission> permissions =  permissionDao.getAll();
		for (Permission permission : permissions) {
			Map<String,Object> jsonMap = new HashMap<String,Object>();
			jsonMap.put("id", permission.getId());
			jsonMap.put("pId", permission.getPid()==null?"0":permission.getPid() );
			jsonMap.put("name", permission.getName());
			jsonMap.put("open", true);
			//判断当前角色是否有这个许可
			if(permissionIds.contains(permission.getId())){
				jsonMap.put("checked", true);
			}
			jsonList.add(jsonMap);
		}
		return jsonList;
	}

	@Override
	public List<Map<String, Object>> getDetailTree(String roleId) {
		List<Map<String, Object>> jsonList = new ArrayList<Map<String,Object>>();
		
		//获取当前角色拥有的所有许可ids
		List<String> permissionIds = rolePermissionRelationDao.getPermissionIdsByRoleId(roleId);
		
		//获取所有许可
		List<Permission> permissions =  permissionDao.getAll();
		for (Permission permission : permissions) {
			//如果当前这个角色有这个许可,那么封装为一个map
			if(permissionIds.contains(permission.getId())){
				Map<String,Object> jsonMap = new HashMap<String,Object>();
				jsonMap.put("id", permission.getId());
				jsonMap.put("pId", permission.getPid()==null?"0":permission.getPid());
				jsonMap.put("name", permission.getName());
				jsonMap.put("open", true);
				jsonList.add(jsonMap);
			}
		}
		return jsonList;
	}

	@Override
	public List<Map<String, Object>> getFinalTree(String userId) {
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		//根据用户id获取当前用户拥有的所有许可
		List<Permission> permissions = permissionDao.getPermissionsByUserId(userId);
		for (Permission permission : permissions) {
			Map<String,Object> jsonMap = new HashMap<String,Object>();
			jsonMap.put("id", permission.getId());
			jsonMap.put("pId", permission.getPid()==null?"0":permission.getPid());
			jsonMap.put("name", permission.getName());
			jsonMap.put("open", true);
			jsonList.add(jsonMap);
		}
		return jsonList;
	}

	@Override
	public List<Map<String, Object>> getMenuTree(String userId) {
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		//根据用户id获取当前用户拥有的所有许可
		List<Permission> permissions = permissionDao.getPermissionsByUserId(userId);
		for (Permission permission : permissions) {
			//如果当前许可不是叶子节点    
			if(permission.getChildNodes().size()>0){
				Map<String,Object> jsonMap = new HashMap<String,Object>();
				jsonMap.put("id", permission.getId());
				jsonMap.put("pId", permission.getPid()==null?"0":permission.getPid());
				jsonMap.put("name", permission.getName());
				//根展开  其它关闭
				if(permission.getPid()==null){
					jsonMap.put("open", true);					
				}
				if(permission.getModuleUrl()!=null){
					jsonMap.put("url", permission.getModuleUrl());
					jsonMap.put("target","navTab");
				}
				jsonList.add(jsonMap);				
			}
		}
		return jsonList;
	}

}
