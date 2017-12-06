package com.bjpowernode.epay.web.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjpowernode.epay.domain.Constant;
import com.bjpowernode.epay.domain.User;
import com.bjpowernode.epay.exceptions.ApplicationException;
import com.bjpowernode.epay.service.UserService;
import com.bjpowernode.epay.utils.MD5Util;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Resource(name="userService")
	private UserService userService;
	
	@RequestMapping("/main")
	public String main(){
		return "main";
	}
	@RequestMapping("/changepwd")
	public String changepwd(){
		return "changepwd";
	}
	
	@RequestMapping("/login")
	@ResponseBody
	public Object login(String accountNo,String password,HttpServletRequest request){
		//{"success":true}成功  {"success":false,"errMsg":""}失败
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		try {
			//获取客户端ip地址
			String ip = request.getRemoteAddr();
			System.out.println(ip);
			//登录认证
			User user = userService.login(accountNo,MD5Util.MD5(password),ip);
			//将用户信息放到session
			request.getSession().setAttribute(Constant.SESSION_USER, user);
			
			//获取当前用户能够操作的所有urls
			Set<String> urls = userService.getUrlsByUserId(user.getId());
			//将用户能够操作的所有url放到session中
			request.getSession().setAttribute(Constant.URLS, urls);
			jsonMap.put("success", true);
		} catch (ApplicationException e) {
			jsonMap.put("success", false);
			jsonMap.put("errMsg", e.getMessage());
		}
		return jsonMap;
	}
}
