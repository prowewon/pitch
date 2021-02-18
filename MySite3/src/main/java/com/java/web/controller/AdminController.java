package com.java.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.bean.RecordBean;
import com.java.web.service.AdminService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/Admin")
public class AdminController {

	@Resource(name="adminService")
	AdminService aService;
	
	private String rec_date;
	private HashMap<String, Object> result, map;
	
	@RequestMapping("")
	public String record(Model model) {
		result = new HashMap<String, Object>();
		map = new HashMap<String, Object>();
		result = aService.select();
		map = aService.member();
		model.addAllAttributes(result);
		model.addAllAttributes(map);
		return "admin";
	}
	
	@RequestMapping("/insert_rec")
	public String insert_rec(HttpServletRequest request, RecordBean rBean,
			MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException{
		result = new HashMap<String, Object>();
		rec_date = rBean.getRec_date().replace("-", ".");
		rBean.setRec_date(rec_date);
		result = aService.insert_rec(rBean, request, mRequest);
//		mav.setViewName("json");
//		
//		JSONObject jsonObject = new JSONObject();
//		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
//		mav.addObject("message", jsonObject.toString());
		return "main";
	}
	
	@RequestMapping("/insert_tra")
	public ModelAndView insert_tra(ModelAndView mav, HttpServletRequest request){
		map = new HashMap<String, Object>();
		map.put("REC_NO", request.getParameter("REC_NO"));
		map.put("TRA_NO", request.getParameter("TRA_NO"));
		map.put("TRA_NAME", request.getParameter("TRA_NAME"));
		map.put("TRA_URL", request.getParameter("TRA_URL"));
		result = aService.insert_tra(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/up_mem")
	public ModelAndView up_mem(ModelAndView mav, HttpServletRequest request) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("mem_no", request.getParameter("mem_no"));
		map.put("mem_id", request.getParameter("mem_id"));
		map.put("mem_pw", request.getParameter("mem_pw"));
		map.put("mem_name", request.getParameter("mem_name"));
		map.put("mem_email", request.getParameter("mem_email"));
		map.put("mem_grade", request.getParameter("mem_grade"));
		map.put("del_yn", request.getParameter("del_yn"));
		
		result = aService.up_mem(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
}
