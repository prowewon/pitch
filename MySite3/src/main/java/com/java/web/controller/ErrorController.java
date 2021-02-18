package com.java.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Error")
public class ErrorController {

	@RequestMapping("")
	public String error() {
		return "error";
	}
}
