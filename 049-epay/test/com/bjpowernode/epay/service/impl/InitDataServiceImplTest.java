package com.bjpowernode.epay.service.impl;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bjpowernode.epay.service.InitDataService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/resources/spring-base.xml"})
public class InitDataServiceImplTest {
	
	@Resource(name="initDataService")
	private InitDataService initDataService;  
	
	@Test
	public void testImportFromXml() {
		initDataService.importFromXml("init-data.xml");
	}

}
