package com.java.web.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java.web.bean.MemberBean;

@Repository
public class MyDao {
	
	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	public HashMap<String, Object> mypage(HashMap<String, Object> map) {
		return sqlSession.selectOne("my.mypage", map);
	}
	
	public List<HashMap<String, Object>> board(HashMap<String, Object> map) {
		return sqlSession.selectList("my.board", map);
	}
	
	public List<HashMap<String, Object>> comment(HashMap<String, Object> map) {
		return sqlSession.selectList("my.comment", map);
	}
	
	public HashMap<String, Object> select_name(MemberBean mBean) {
		return sqlSession.selectOne("my.select_name", mBean);
	}
	
	public int up_name(MemberBean mBean) {
		return sqlSession.update("my.up_name", mBean);
	}
	
	public int up_email(MemberBean mBean) {
		return sqlSession.update("my.up_email", mBean);
	}
	
	public int up_pw(MemberBean mBean) {
		return sqlSession.update("my.up_pw", mBean);
	}
}
