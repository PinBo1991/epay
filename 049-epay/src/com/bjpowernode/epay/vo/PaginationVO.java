package com.bjpowernode.epay.vo;

import java.util.List;

public class PaginationVO<T> {
	private Long total;// 总记录条数

	private List<T> dataList;// 分页查询出来的数据

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

}
