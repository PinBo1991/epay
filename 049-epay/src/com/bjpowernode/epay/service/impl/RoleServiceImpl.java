package com.bjpowernode.epay.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjpowernode.epay.dao.RoleDao;
import com.bjpowernode.epay.domain.Role;
import com.bjpowernode.epay.service.RoleService;
import com.bjpowernode.epay.vo.PaginationVO;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource(name="roleDao")
	private RoleDao roleDao;
	
	@Override
	public void save(Role role) {
		roleDao.save(role);
	}

	@Override
	public void delete(String[] ids) {
		for (String id : ids) {
			roleDao.deleteById(id);			
		}
	}

	@Override
	public Role getById(String id) {
		return roleDao.getById(id);
	}

	@Override
	public void update(Role role) {
		roleDao.update(role);
	}

	@Override
	public PaginationVO<Role> getByPage(Integer pageNo, Integer pageSize) {
		PaginationVO<Role> paginationVO = new PaginationVO<Role>();
		paginationVO.setTotal(roleDao.getTotal());
		paginationVO.setDataList(roleDao.getRolesByPage(pageNo, pageSize));
		return paginationVO;
	}

}
