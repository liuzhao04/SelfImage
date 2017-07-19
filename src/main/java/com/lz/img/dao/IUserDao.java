package com.lz.img.dao;

import java.util.List;

import com.lz.img.pojo.User;

public interface IUserDao {
	public User getUser(int id);

	public List<User> getUsers();
}
