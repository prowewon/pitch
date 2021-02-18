package com.java.web.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.bean.BoardBean;
import com.java.web.service.BoardService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/Board")
public class BoardController {

	@Resource(name="boardService")
	BoardService bService;
	
	private HashMap<String, Object> map,result;
	private int pagenum, flag, comNo;
	private String boardIndex, memId;
	
	@RequestMapping("")
	public String select() {
		return "board";
	}
	
	@RequestMapping("/select")
	public ModelAndView select(ModelAndView mav) {
		result = new HashMap<String, Object>();
		result.put("list", bService.select());
		result.put("pagecnt", bService.pagecnt());
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/page")
	public ModelAndView page(ModelAndView mav, HttpServletRequest request) {
		result = new HashMap<String, Object>();
		pagenum = Integer.parseInt(request.getParameter("pagenum").toString());
		result = bService.page(pagenum);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/write")
	public String board_write() {
		return "board_insert";
	}
	
	@RequestMapping("/board_insert")
	public String insert(HttpServletRequest request, Principal principal) {
		map = new HashMap<String, Object>();
		map.put("menu_no", request.getParameter("menu_no"));
		map.put("board_title", request.getParameter("board_title"));
		map.put("board_index", request.getParameter("board_index").replace("\n","<br>"));
		map.put("mem_id", principal.getName());
		flag = bService.board_insert(map);
		return "board";
	}
	
	@RequestMapping("/board_detail")
	public String board_detail(HttpServletRequest request, Model model) {
		map = new HashMap<String, Object>();
		map = bService.board_detail(Integer.parseInt(request.getParameter("board_no")));
		model.addAllAttributes(map);
		return "board_detail";
	}
	
	@RequestMapping("/editBoard")
	public ModelAndView editBoard(HttpServletRequest request, Model model, Principal principal, Authentication auth, ModelAndView mav) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("boardNo", Integer.parseInt(request.getParameter("boardNo").toString()));
		map.put("memId", principal.getName());
		map.put("memGrade", auth.getAuthorities().toString());
		result = bService.editBoard(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/editpage")
	public String editpage(HttpServletRequest request, Model model) {
		map = new HashMap<String, Object>();
		map = bService.board_detail(Integer.parseInt(request.getParameter("boardNo")));
		model.addAllAttributes(map);
		return "edit_Board";
	}
	
	@RequestMapping("/upBoard")
	public ModelAndView upBoard(ModelAndView mav, BoardBean bBean) {
		boardIndex = bBean.getBoardIndex().replace("\n","<br>");
		bBean.setBoardIndex(boardIndex);
		flag = bService.upBoard(bBean);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(flag));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/delBoard")
	public ModelAndView delBoard(ModelAndView mav, BoardBean bBean, Authentication auth, Principal principal) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("memGrade", auth.getAuthorities());
		map.put("memId", principal.getName());
		map.put("boardNo", bBean.getBoardNo());
		
		result = bService.delBoard(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/search")
	public ModelAndView search(ModelAndView mav, HttpServletRequest request) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("srchSelect", request.getParameter("srchSelect"));
		map.put("srchInput", request.getParameter("srchInput"));
		result = bService.search(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/comment")
	public ModelAndView comment(ModelAndView mav, HttpServletRequest request, Principal principal) {
		map = new HashMap<String, Object>();
		map.put("comIndex", request.getParameter("comIndex"));
		map.put("boardNo", request.getParameter("boardNo"));
		map.put("memId", principal.getName());
		flag = bService.comment(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(flag));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/mocom")
	public ModelAndView mocom(HttpServletRequest request, Model model, Principal principal, ModelAndView mav) {
		result = new HashMap<String, Object>();
		comNo = Integer.parseInt(request.getParameter("comNo").toString());
		memId = principal.getName();
		result = bService.mocom(comNo, memId);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/upcom")
	public ModelAndView upcom(HttpServletRequest request, ModelAndView mav) {
		map = new HashMap<String, Object>();
		map.put("comIndex", request.getParameter("comIndex"));
		map.put("comNo", request.getParameter("comNo"));
		flag = bService.upcom(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(flag));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
	
	@RequestMapping("/delcom")
	public ModelAndView delcom(HttpServletRequest request, ModelAndView mav, Principal principal, Authentication auth) {
		map = new HashMap<String, Object>();
		result = new HashMap<String, Object>();
		map.put("comNo", request.getParameter("comNo"));
		map.put("memId", principal.getName());
		map.put("memGrade", auth.getAuthorities().toString());
		result = bService.delcom(map);
		mav.setViewName("json");
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(result));
		mav.addObject("message", jsonObject.toString());
		return mav;
	}
}
