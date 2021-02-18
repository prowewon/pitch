package com.java.web.controller;

import java.security.Principal;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.service.DetailService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/Detail")
@SessionAttributes
public class DetailController {
	
	@Resource(name="detailService")
	DetailService dService;
	
	int REC_NO, COM_NO, comNo;
	String COM_INDEX, memId, memGrade;
	private HashMap<String, Object> result, list, cnt;
	
	@RequestMapping("/")
	public  String detail() {
		return "detail";
	}
	
	@RequestMapping(value="/select", method=RequestMethod.GET)
	public String select(HttpServletRequest request, Model model, HttpSession session) {
		REC_NO = Integer.parseInt(request.getParameter("recno"));
		session.setAttribute("REC_NO", REC_NO);
		result = dService.select(REC_NO);
		cnt = dService.cnt(REC_NO);
		model.addAllAttributes(result);
		model.addAllAttributes(cnt);
		return "detail";
	}
	
	@RequestMapping("/comments")
	public ModelAndView comments(ModelAndView mav, HttpSession session) {
		list = new HashMap<String, Object>();
		REC_NO = (Integer) session.getAttribute("REC_NO");
		list.put("comments", dService.comments(REC_NO));
		list.put("pagecnt", dService.pagecnt(REC_NO));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(list));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/page")
	public ModelAndView pagecnt(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		list = new HashMap<String, Object>();
		REC_NO = (Integer) session.getAttribute("REC_NO");
		list.put("REC_NO", REC_NO);
		list.put("pagecnt", request.getParameter("pagecnt"));
		result.put("comments", dService.page(list));
		result.put("pagecnt", dService.pagecnt(REC_NO));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/mocom")
	public ModelAndView mocom(HttpServletRequest request, Model model, Principal principal, ModelAndView mav) {
		comNo = Integer.parseInt(request.getParameter("comNo"));
		memId = principal.getName();
		result = dService.mocom(comNo, memId);
		COM_INDEX = ((String) result.get("COM_INDEX")).replaceAll("<br>", "\r\n");
		result.put("COM_INDEX", COM_INDEX);
		model.addAllAttributes(result);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/upcom")
	public ModelAndView upcom(HttpServletRequest request, ModelAndView mav) {
		list = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		list.put("comNo", Integer.parseInt(request.getParameter("comNo")));
		list.put("comIndex", request.getParameter("comIndex"));
		list.put("comYn", request.getParameter("comYn"));
		result.put("flag", dService.upcom(list));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	//Detail 화면에서 댓글 입력
	@RequestMapping("/insert")
	public ModelAndView insert(ModelAndView mav, HttpServletRequest request, Principal principal, HttpSession session) {
		list = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		list.put("REC_NO", session.getAttribute("REC_NO"));
		list.put("COM_YN", request.getParameter("COM_YN"));
		list.put("COM_INDEX", request.getParameter("COM_INDEX"));
		list.put("MEM_ID", principal.getName());
		result.put("flag", dService.insert(list));
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/delcom")
	public ModelAndView delcom(HttpServletRequest request, Principal principal, ModelAndView mav, Authentication auth) {
		list = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		comNo = Integer.parseInt(request.getParameter("comNo"));
		memGrade = auth.getAuthorities().toString();
		list.put("memId", principal.getName());
		list.put("comNo", comNo);
		list.put("memGrade", memGrade);
		result = dService.delcom(list);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
}
