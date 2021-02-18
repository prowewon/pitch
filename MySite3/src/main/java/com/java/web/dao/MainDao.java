package com.java.web.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MainDao {

	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	public List<HashMap<String, Object>> imgList() {
		return sqlSession.selectList("main.imgList");
	}
	
	public List<HashMap<String, Object>> select() {
		return sqlSession.selectList("main.select");
	}
	
	public List<HashMap<String, Object>> search(String search) {
		return sqlSession.selectList("main.search",search);
	}
}
