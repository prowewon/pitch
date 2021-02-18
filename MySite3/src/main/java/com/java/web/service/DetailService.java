package com.java.web.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java.web.dao.DetailDao;

@Service
public class DetailService {

	@Resource(name="detailDao")
	DetailDao dDao;
	
	private HashMap<String, Object> map,result;
	
	public HashMap<String, Object> select(int REC_NO) {
		map = new HashMap<String, Object>();
		map.put("list", dDao.select(REC_NO));
		return map;
	}
	
	public HashMap<String, Object> cnt(int REC_NO) {
		map = new HashMap<String, Object>();
		map = dDao.cnt(REC_NO);
		return map;
	}
	
	public HashMap<String, Object> comments(int REC_NO) {
		map = new HashMap<String, Object>();
		map.put("list", dDao.comments(REC_NO));
		return map;
	}
	
	public HashMap<String, Object> pagecnt(int REC_NO) {
		map = new HashMap<String, Object>();
		map = dDao.pagecnt(REC_NO);
		return map;
	}
	
	public HashMap<String, Object> page(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result.put("list", dDao.page(map));
		return result;
	}
	
	public HashMap<String, Object> mocom(int COM_NO, String memId) {
		map = new HashMap<String, Object>();
		map = dDao.mocom(COM_NO);
		if (memId.equals(map.get("MEM_ID"))) {
			map.put("flag", "true");
		}else {
			map.put("flag", "false");
		}
		return map;
	}
	
	public int upcom(HashMap<String, Object> map) {
		int flag = dDao.upcom(map);
		return flag;
	}
	
	public int insert(HashMap<String, Object> map) {
		int flag;
		if (dDao.overlapCom(map) == null || dDao.overlapCom(map).isEmpty()) {
			flag = dDao.insert(map);
		}else {
			flag = 2;
		}
		return flag;
	}
	
	public HashMap<String, Object> delcom(HashMap<String, Object> list) {
		map = new HashMap<String, Object>();
		map = dDao.mocom(Integer.parseInt(list.get("comNo").toString()));
		if ( map.get("MEM_ID").equals(list.get("memId")) || list.get("memGrade").equals("[ROLE_ADMIN]")) {
			if (dDao.delcom(Integer.parseInt(list.get("comNo").toString())) == 1) {
				map.put("flag", "삭제되었습니다.");
			}
		}else {
			map.put("flag", "권한이 없습니다.");
		}
		return map;
	}
}
