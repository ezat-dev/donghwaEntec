package com.ace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ace.domain.AnalysisExc;
import com.ace.service.AnalysisExcService;

@Controller
public class AnalysisController {

	 @Autowired
	    private AnalysisExcService analysisExcService;
	
	 @RequestMapping(value = "/analysis/historyTrend", method = RequestMethod.GET)
		public String getRecipeDetail(Model model) {
			return "/analysis/historyTrend.jsp";
		}
	
	 @RequestMapping(value = "/analysis/historyTrend/getPenList", method = RequestMethod.GET)
	 @ResponseBody
	 public List<AnalysisExc> getPenList() {
	     return analysisExcService.getAllExcRecords();
	 }

}
