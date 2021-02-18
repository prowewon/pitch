package com.java.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java.web.dao.MainDao;

@Service
public class MainService {

	@Resource(name="mainDao")
	MainDao mDao;

	HashMap<String, Object> map;
	
	public HashMap<String, Object> imgList() {
		map = new HashMap<String, Object>();
		map.put("imgList", mDao.imgList());
		return map;
	}
	
	public HashMap<String, Object> select() {
		map = new HashMap<String,Object>();
		map.put("list", mDao.select());
		return map;
	}
	
	public HashMap<String, Object> search(String search) {
		map = new HashMap<String, Object>();
		map.put("list", mDao.search(search));
		return map;
	}
}
