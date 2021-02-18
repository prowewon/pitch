package com.java.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java.web.bean.RecordBean;

@Repository
public class AdminDao {

	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	private List<HashMap<String, Object>> list;
	private int flag;
	
	public List<HashMap<String, Object>> select() {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("admin.select");
		return list;
	}
	
	public int insert_rec(RecordBean rBean) {
		return sqlSession.insert("admin.insert_rec", rBean);
	}
	
	public int insert_img(HashMap<String, Object> map) {
		flag = sqlSession.insert("admin.insert_img",map);
		return flag;
	}
	
	public int insert_tra(HashMap<String, Object> map) {
		flag = sqlSession.insert("admin.insert_tra",map);
		return flag;
	}
	
	public List<HashMap<String, Object>> member() {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("admin.member");
		return list;
	}
	
	public int up_mem(HashMap<String, Object> map) {
		flag = sqlSession.update("admin.up_mem", map);
		return flag;
	}
}
