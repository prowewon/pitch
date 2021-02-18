package com.java.web.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.service.LoginService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/Login")
public class LoginController {
	
	@Resource(name="loginService")
	LoginService lService;
	
	private HashMap<String, Object> map, result;
	private String page;
	
	@RequestMapping("")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/sign")
	public String sign() {
		return "sign";
	}
	
	@RequestMapping(value="/select", method=RequestMethod.POST)
	public String select(HttpServletRequest request, Model model) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("id", request.getParameter("id"));
		map.put("pwd", request.getParameter("pwd"));
		result = lService.select(map);
		if (result != null) {
			model.addAllAttributes(result);
			page = "main";
		} else {
			page = "login";
		}
		return page;
	}
	
	@RequestMapping(value="/selectId")
	public ModelAndView selectId(ModelAndView mav, HttpServletRequest request) {
		result = new HashMap<String, Object>();
		result.put("selectID", lService.selectId(request.getParameter("id")));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, HttpServletRequest request) {
		result = new HashMap<String, Object>();
		map = new HashMap<String, Object>();
		map.put("id", request.getParameter("id"));
		map.put("pwd", request.getParameter("pwd"));
		map.put("email", request.getParameter("email"));
		result.put("insert", lService.insert(map));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
		
	}
}
