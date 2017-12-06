package com.bjpowernode.epay.service;

public interface InitDataService {
	/**
	 * 解析xml文件中的数据到数据库
	 * @param xmlFile
	 */
	void importFromXml(String xmlFile);
}
