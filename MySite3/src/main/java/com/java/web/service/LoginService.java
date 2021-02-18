package com.java.web.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java.web.dao.LoginDao;

@Service
public class LoginService {
	
	@Resource(name="loginDao")
	LoginDao lDao;
	
	private HashMap<String, Object> result;
	private int flag;
	
	public HashMap<String, Object> select(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result = lDao.select(map);
		return result;
	}

	public HashMap<String, Object> selectId(String id) {
		result = new HashMap<String, Object>();
		result = lDao.selectId(id);
		return result;
	}
	
	public int insert(HashMap<String, Object> map) {
		flag = lDao.insert(map);
		return flag;
	}
}
