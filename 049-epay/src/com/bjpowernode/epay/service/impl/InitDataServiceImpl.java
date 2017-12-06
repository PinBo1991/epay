package com.bjpowernode.epay.service.impl;

import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.PermissionDao;
import com.bjpowernode.epay.dao.RoleDao;
import com.bjpowernode.epay.dao.RolePermissionRelationDao;
import com.bjpowernode.epay.dao.UserDao;
import com.bjpowernode.epay.dao.UserRoleRelationDao;
import com.bjpowernode.epay.domain.Permission;
import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.service.InitDataService;
import com.bjpowernode.epay.utils.DateUtil;

@Service("initDataService")
public class InitDataServiceImpl implements InitDataService {
	
	@Resource(name="userDao")
	private UserDao userDao;
	
	@Resource(name="roleDao")
	private RoleDao roleDao;
	
	@Resource(name="userRoleRelationDao")
	private UserRoleRelationDao userRoleRelationDao;
	
	@Resource(name="permissionDao")
	private PermissionDao permissionDao;
	
	@Resource(name="rolePermissionRelationDao")
	private RolePermissionRelationDao rolePermissionRelationDao; 

	@Override
	public void importFromXml(String xmlFile) {
		try {
			//创建解析器SAXReader  注意:虽然是SAXReader,但是底层是dom的解析方式
			SAXReader reader = new SAXReader();
			//获取当前线程的类加载器
			ClassLoader loader = Thread.currentThread().getContextClassLoader();
			//获取指向某一个文件的字节输入流
			InputStream in = loader.getResourceAsStream(xmlFile);
			//将指向某一个文件的字节输入流读到内存中,生成一棵dom树
			Document document =  reader.read(in);
			
			//保存用户信息
			String userId = saveUser((Element) document.selectSingleNode("/sys-data/user-info/user"));
			
			//保存角色信息
			String roleId = saveRole((Element) document.selectSingleNode("/sys-data/role-info/role"));
			
			//保存许可信息
			savePermission((Element) document.selectSingleNode("/sys-data/permission-info/permission"),null);
			
			//保存用户角色关系
			saveUserRoleRelation(userId,roleId);
			
			//保存角色许可关系
			saveRolePermissionRelation(roleId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void saveRolePermissionRelation(String roleId) {
		//获取所有许可对象
		List<Permission> permissions = permissionDao.getAll();
		for (Permission permission : permissions) {
			rolePermissionRelationDao.save(roleId, permission.getId());
		}
	}

	private void savePermission(Element permissionElt,String pid) {
		Permission permission = new Permission();
		permission.setCode(permissionElt.attributeValue("code"));
		permission.setName(permissionElt.attributeValue("name"));
		permission.setOrderNo(Integer.valueOf(permissionElt.attributeValue("order-no")));
		permission.setOperationUrl(permissionElt.attributeValue("operation-url"));
		permission.setModuleUrl(permissionElt.attributeValue("module-url"));
		permission.setCreateTime(DateUtil.getSystemTime());
		permission.setPid(pid);
		permissionDao.save(permission);
		
		List<Element> elementElts =permissionElt.elements();
		for (Element elementElt : elementElts) {
			savePermission(elementElt,permission.getId());
		}
	}

	private void saveUserRoleRelation(String userId, String roleId) {
		userRoleRelationDao.save(userId, roleId);
	}

	private String saveRole(Element roleElt) {
		Role role = new Role();
		role.setCode(roleElt.attributeValue("code"));
		role.setName(roleElt.attributeValue("name"));
		role.setCreateTime(DateUtil.getSystemTime());
		roleDao.save(role);
		return role.getId();
	}

	//保存用户信息
	private String saveUser(Element userElt) {
		User user = new User();
		user.setAccountNo(userElt.attributeValue("login-account"));
		user.setLockStatus(Integer.valueOf(userElt.attributeValue("lockStatus")));
		user.setName(userElt.attributeValue("name"));
		user.setPassword(userElt.attributeValue("password"));
		user.setCreateTime(DateUtil.getSystemTime());
		userDao.save(user);
		return user.getId();
	}

}
