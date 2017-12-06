package com.bjpowernode.epay.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bjpowernode.epay.domain.Permission;
import com.bjpowernode.epay.service.PermissionService;

@RunWith(SpringJUnit4ClassRunner.class)//指定spring测试环境
@ContextConfiguration({"/resources/spring-base.xml","/resources/spring-service.xml"})//指定spring配置文件的路径   '/'代表classpath
public class PermissionServiceImplTest{

	@Resource(name="permissionService")
	private PermissionService permissionService;
	
	@Before
	public void init(){
		System.out.println("---start----");
	}
	@After
	public void destroy(){
		System.out.println("---end----");
	}
	/*
	单元测试的断言机制
	@Test
	public void testM1(){
		String actual = m1();
		String expected = "java";
		Assert.assertEquals(expected, actual);
	}
	
	public String m1(){
		return "java";
	}*/
	
	@Test
	public void testSave() {
		Permission permission = new Permission();
		permission.setCode("001");
		permission.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		permission.setModuleUrl("aaaa");
		permission.setOperationUrl("bbbb");
		permission.setName("车辆维护");
		permission.setOrderNo(1);
		permission.setPid(null);
		permissionService.save(permission);
		
		Permission permission1 = new Permission();
		permission1.setCode("001001");
		permission1.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		permission1.setModuleUrl("aaaa");
		permission1.setOperationUrl("bbbb");
		permission1.setName("新增车辆");
		permission1.setOrderNo(1);
		permission1.setPid(permission.getId());
		permissionService.save(permission1);
		
		Permission permission2 = new Permission();
		permission2.setCode("001002");
		permission2.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		permission2.setModuleUrl("aaaa");
		permission2.setOperationUrl("bbbb");
		permission2.setName("删除车辆");
		permission2.setOrderNo(1);
		permission2.setPid(permission.getId());
		permissionService.save(permission2);
	}

	@Test
	public void testDeleteById() {
		permissionService.deleteById("24DB8308497D45018C760C45EEB052E8");
	}

	@Test
	public void testGetById() {
		Permission permission = permissionService.getById("81F211615DCD4E2AA7CEAFEBA6BDC8B6");
		System.out.println(permission.getName());
	}

	@Test
	public void testUpdate() {
		Permission permission = permissionService.getById("81F211615DCD4E2AA7CEAFEBA6BDC8B6");
		permission.setName("新增车辆111");
		permissionService.update(permission);
	}

	@Test
	public void testGetPermissionTree() {
		String jsonString = permissionService.getPermissionTree();
		System.out.println(jsonString);
	}

}
