package com.java.web.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java.web.bean.MemberBean;
import com.java.web.dao.MyDao;

@Service
public class MyService {
	
	private HashMap<String, Object> result;
	
	@Resource(name="myDao")
	MyDao myDao;
	
	public HashMap<String, Object> mypage(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result.put("mypage", myDao.mypage(map));
		result.put("board", myDao.board(map));
		result.put("comment", myDao.comment(map));
		return result;
	}
	
	public HashMap<String, Object> up_name(MemberBean mBean) {
		result = new HashMap<String, Object>();
		if (Integer.parseInt(myDao.select_name(mBean).get("CNT").toString()) == 0) {
			myDao.up_name(mBean);
			result.put("flag", "수정되었습니다.");
		}else {
			result.put("flag", "중복된 닉네임입니다.");
		}
		return result;
	}
	
	public HashMap<String, Object> up_email(MemberBean mBean) {
		result = new HashMap<String, Object>();
		if (myDao.up_email(mBean) == 1) {
			result.put("flag", "이메일이 변경되었습니다.");
		}else {
			result.put("flag", "이메일을 확인해주세요.");
		}
		return result;
	}
	
	public HashMap<String, Object> up_pw(MemberBean mBean) {
		result = new HashMap<String, Object>();
		if (myDao.up_pw(mBean) == 1) {
			result.put("flag", "비밀번호가 변경되었습니다.");
		}else{
			result.put("flag", "비밀번호를 확인해주세요");
		}
		return result;
	}
	
}
