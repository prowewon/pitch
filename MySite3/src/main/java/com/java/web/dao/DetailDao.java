package com.java.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class DetailDao {

	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	private List<HashMap<String, Object>> list;
	private HashMap<String, Object> map;
	
	public List<HashMap<String, Object>> select(int REC_NO) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("detail.select", REC_NO);
		return list;
	}
	
	public HashMap<String, Object> cnt(int REC_NO) {
		map = new HashMap<String, Object>();
		map = sqlSession.selectOne("detail.cnt", REC_NO);
		return map;
	}
	
	public List<HashMap<String, Object>> comments(int REC_NO) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("detail.comments", REC_NO);
		return list;
	}
	
	public HashMap<String, Object> pagecnt(int REC_NO) {
		map = new HashMap<String, Object>();
		map = sqlSession.selectOne("detail.pagecnt", REC_NO);
		return map;
	}
	
	public List<HashMap<String, Object>> page(HashMap<String, Object> map) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("detail.page", map);
		return list;
	}
	
	public HashMap<String, Object> mocom(int COM_NO) {
		map = new HashMap<String, Object>();
		map = sqlSession.selectOne("detail.mocom", COM_NO);
		return map;
	}
	
	public int upcom(HashMap<String, Object> map) {
		int flag = sqlSession.update("detail.upcom", map);
		return flag;
	}
	
	public List<HashMap<String, Object>> overlapCom(HashMap<String, Object> map) {
		return sqlSession.selectList("detail.overlapCom", map);
	}
	
	public int insert(HashMap<String, Object> map) {
		int flag = sqlSession.insert("detail.insert", map);
		return flag;
	}
	
	public int delcom(int COM_NO) {
		int flag = sqlSession.update("detail.delcom", COM_NO);
		return flag;
	}
}
