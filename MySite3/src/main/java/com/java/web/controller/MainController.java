package com.java.web.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.service.MainService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/Main")
public class MainController {
	
	@Resource(name="mainService")
	MainService mService;
	
	private HashMap<String, Object> map, result;
	private String search;
	
	@RequestMapping("/main")
	public String main(Model model) {
		result = new HashMap<String, Object>();
		result = mService.imgList();
		model.addAllAttributes(result);
		return "main";
	}
	
	@RequestMapping(value="/select", method=RequestMethod.GET)
	public ModelAndView select(ModelAndView mav) {
		result = new HashMap<String, Object>();
		result= mService.select();
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public ModelAndView search(ModelAndView mav, HttpServletRequest request) {
		search = request.getParameter("search");
		result = mService.search(search);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
}
