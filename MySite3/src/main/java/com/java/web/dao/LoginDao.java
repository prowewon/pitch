package com.java.web.dao;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDao {
	
	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	private int flag;
	
	public HashMap<String, Object> select(HashMap<String, Object> map) {
		return sqlSession.selectOne("login.select",map);
	}
	
	public HashMap<String, Object> selectId(String id) {
		return sqlSession.selectOne("login.selectId", id);
	}
	
	public int insert(HashMap<String, Object> map) {
		flag = sqlSession.insert("login.insert", map);
		return flag;
	}

}
