package com.java.web.controller;

import java.security.Principal;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.bean.MemberBean;
import com.java.web.service.MyService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/My")
public class MyController {
	
	@Resource(name="myService")
	MyService myService;
	
	private HashMap<String, Object> result, map;
	
	@RequestMapping("")
	public String my(Principal principal, Model model) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("mem_id", principal.getName());
		map.put("br", "<br>");
		result = myService.mypage(map);
		model.addAttribute("member", result);
		return "mypage";
	}
	
	@RequestMapping("/up_name")
	public ModelAndView up_name(MemberBean mBean, Principal principal, ModelAndView mav) {
		result = new HashMap<String, Object>();
		mBean.setMem_id(principal.getName());
		result = myService.up_name(mBean);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/up_email")
	public ModelAndView up_email(MemberBean mBean, Principal principal, ModelAndView mav) {
		result = new HashMap<String, Object>();
		mBean.setMem_id(principal.getName());
		result = myService.up_email(mBean);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/up_pw")
	public ModelAndView up_pw(MemberBean mBean, Principal principal, ModelAndView mav) {
		result = new HashMap<String, Object>();
		mBean.setMem_id(principal.getName());
		result = myService.up_pw(mBean);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
}
