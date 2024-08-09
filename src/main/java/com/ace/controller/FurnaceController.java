package com.ace.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.milo.opcua.sdk.client.OpcUaClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ace.service.FurnaceService;

@Controller
public class FurnaceController {

	@Autowired
	private FurnaceService furnaceService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getRecipeDetail(Model model) {
		return "recipeTest";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, List<Object>> asdad() {
		
		OpcUaClient localCient = MainController.client;
		
		Map<String, List<Object>> rtnMap = new HashMap<String, List<Object>>();
		
		furnaceService.setSSS();
		
		List<Object> testList = new ArrayList<Object>();
		
		for(int i=0; i<100; i++) {
			
		}
		
		return rtnMap;
	}
}
