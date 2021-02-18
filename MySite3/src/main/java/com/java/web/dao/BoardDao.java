package com.java.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java.web.bean.BoardBean;

@Repository
public class BoardDao {

	@Resource(name="sqlSession")
	SqlSession sqlSession;
	
	private List<HashMap<String, Object>> list;
	private HashMap<String, Object> map;
	private int flag;
	
	public List<HashMap<String, Object>> select() {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.select");
		return list;
	}
	
	public HashMap<String, Object> pagecnt() {
		map = new HashMap<String,Object>();
		map = sqlSession.selectOne("board.pagecnt");
		return map;
	}
	
	public List<HashMap<String, Object>> page(int pagenum) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.page", pagenum);
		return list;
		
	}
	
	public int board_insert(HashMap<String, Object> map) {
		flag = sqlSession.insert("board.board_insert", map);
		return flag;
	}
	
	public HashMap<String, Object> board_detail(int board_no) {
		map = new HashMap<String, Object>();
		map = sqlSession.selectOne("board.board_detail", board_no);
		return map;
	}
	
	public int upBoard(BoardBean bBean) {
		flag = sqlSession.update("board.upBoard", bBean);
		return flag;
	}
	
	public int delBoard(HashMap<String, Object> map) {
		flag = sqlSession.update("board.delBoard", map);
		return flag;
	}
	
	public List<HashMap<String, Object>> searchTitle(HashMap<String, Object> map) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.searchTitle", map);
		return list;
	}
	
	public List<HashMap<String, Object>> searchIndex(HashMap<String, Object> map) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.searchIndex", map);
		return list;
	}
	
	public List<HashMap<String, Object>> search(HashMap<String, Object> map) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.search", map);
		return list;
	}
	
	public int comment(HashMap<String, Object> map) {
		flag = sqlSession.insert("board.comment", map);
		return flag;
	}
	
	public List<HashMap<String, Object>> selectComm(int boardNo) {
		list = new ArrayList<HashMap<String,Object>>();
		list = sqlSession.selectList("board.selectComm", boardNo);
		return list;
	}
	
	public HashMap<String, Object> mocom(int comNo) {
		map = new HashMap<String, Object>();
		map = sqlSession.selectOne("board.mocom", comNo);
		return map;
	}
	
	public int upcom(HashMap<String, Object> map) {
		flag = sqlSession.update("board.upcom", map);
		return flag;
	}
	
	public int delcom(HashMap<String, Object> map) {
		flag = sqlSession.update("board.delcom", map);
		return flag;
	}
}
