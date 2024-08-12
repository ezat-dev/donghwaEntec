package com.ace.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AnalysisController {

	
	@RequestMapping(value = "/analysis/historyTrend", method = RequestMethod.GET)
	public String getRecipeDetail(Model model) {
		return "/analysis/historyTrend.jsp";
	}
}
