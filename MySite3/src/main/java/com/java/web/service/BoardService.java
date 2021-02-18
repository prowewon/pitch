package com.java.web.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java.web.bean.BoardBean;
import com.java.web.dao.BoardDao;

@Service
public class BoardService {

	@Resource(name="boardDao")
	BoardDao bDao;
	
	private HashMap<String, Object> map, result;
	private int flag;
	private String boardIndex;
	
	public HashMap<String, Object> select() {
		map = new HashMap<String, Object>();
		map.put("list", bDao.select());
		return map;
	}
	
	public HashMap<String, Object> pagecnt() {
		map = new HashMap<String, Object>();
		map = bDao.pagecnt();
		return map;
	}
	
	public HashMap<String, Object> page(int pagecnt) {
		map = new HashMap<String, Object>();
		map.put("list", bDao.page(pagecnt));
		return map;
	}
	
	public int board_insert(HashMap<String, Object> map) {
		flag = bDao.board_insert(map);
		return flag;
	}
	
	public HashMap<String, Object> board_detail(int board_no) {
		map = new HashMap<String, Object>();
		map = bDao.board_detail(board_no);
		boardIndex = map.get("BOARD_INDEX").toString().replace("<br>","\n");
		map.put("boardIndex", boardIndex);
		map.put("list", bDao.selectComm(board_no));
		return map;
	}
	
	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result = bDao.board_detail(Integer.parseInt(map.get("boardNo").toString()));
		if (result.get("MEM_ID").equals(map.get("memId")) || map.get("memGrade").equals("[ROLE_ADMIN]")) {
			result.put("flag", "1");
		}else {
			result.put("flag", "0");
		}
		return result;
	}
	
	public int upBoard(BoardBean bBean) {
		flag = bDao.upBoard(bBean);
		return flag;
	}
	
	public HashMap<String, Object> delBoard(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result = bDao.board_detail(Integer.parseInt(map.get("boardNo").toString()));
		if (result.get("MEM_ID").equals(map.get("memId")) || map.get("memGrade").equals("[ROLE_ADMIN]")) {
			result.put("flag", bDao.delBoard(map));
		}else {
			result.put("flag", 2);
		}
		return result;
	}
	
	public HashMap<String, Object> search(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		if (Integer.parseInt(map.get("srchSelect").toString()) == 1) {
			result.put("list", bDao.searchTitle(map));
		}else if (Integer.parseInt(map.get("srchSelect").toString()) == 2) {
			result.put("list", bDao.searchIndex(map));
		}else if (Integer.parseInt(map.get("srchSelect").toString()) == 3) {
			result.put("list", bDao.search(map));
		}
		return result;
	}
	
	public int comment(HashMap<String, Object> map) {
		flag = bDao.comment(map);
		return flag;
	}
	
	public HashMap<String, Object> mocom(int comNo, String memId) {
		map = new HashMap<String, Object>();
		map = bDao.mocom(comNo);
		if (memId.equals(map.get("MEM_ID"))) {
			map.put("flag", "true");
		}else {
			map.put("flag", "false");
		}
		return map;
	}
	
	public int upcom(HashMap<String, Object> map) {
		flag = bDao.upcom(map);
		return flag;
	}
	
	public HashMap<String, Object> delcom(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result = bDao.mocom(Integer.parseInt(map.get("comNo").toString()));
		if (result.get("MEM_ID").equals(map.get("memId")) || map.get("memGrade").equals("[ROLE_ADMIN]")) {
			result.put("flag", bDao.delcom(map));
		}else {
			result.put("flag", 0);
		}
		return result;
	}
}
