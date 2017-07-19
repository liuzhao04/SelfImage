package com.lz.img.service;


import java.util.List;

import com.lz.img.pojo.User;

public interface IUserSevice {

	public User getUserNameById(int id);
	
	public List<User> getUsers();
}
