package com.bjpowernode.epay.web;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.bjpowernode.epay.domain.User;

public class SystemInitListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("---系统初始化开始---");
		ServletContext application =  sce.getServletContext();
		application.setAttribute("LOCK_CODE", User.LOCK_CODE);
		application.setAttribute("UN_LOCK_CODE", User.UN_LOCK_CODE);
		application.setAttribute("LOCK_TEXT", User.LOCK_TEXT);
		application.setAttribute("UN_LOCK_TEXT", User.UN_LOCK_TEXT);
		System.out.println("---系统初始化结束---");
	}
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {

	}


}
