package com.lz.img.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lz.img.dao.IUserDao;
import com.lz.img.pojo.User;
import com.lz.img.service.IUserSevice;

@Service("userService")
public class UserServiceImpl implements IUserSevice{
	@Resource
	private IUserDao userDao = null;

	@Override
	public User getUserNameById(int id) {
		return userDao.getUser(id);
	}

	@Override
	public List<User> getUsers() {
		return userDao.getUsers();
	}
	
}
