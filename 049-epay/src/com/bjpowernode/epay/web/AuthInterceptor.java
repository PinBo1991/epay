package com.bjpowernode.epay.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bjpowernode.epay.domain.Constant;
import com.bjpowernode.epay.domain.User;

public class AuthInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		//非法用户认证  
		//从session中获取用户对象
		User user = (User)request.getSession().getAttribute(Constant.SESSION_USER);
		if(user==null){
			response.sendRedirect(request.getContextPath()+"/login.jsp");
			return false;
		}
		return true;
	}
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}


}
