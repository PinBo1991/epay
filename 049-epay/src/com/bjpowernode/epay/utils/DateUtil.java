package com.bjpowernode.epay.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 
 * @author Administrator
 *	获取系统时间字符串的工具类
 */
public class DateUtil {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	//工具类的构造方法一般都是私有的
	private DateUtil() {
	}
	
	public static String getSystemTime(){
		return sdf.format(new Date());
	}
}
