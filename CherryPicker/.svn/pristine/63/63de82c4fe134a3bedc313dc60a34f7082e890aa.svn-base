package com.CherryPicker.web.ui100;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.CommonUtils;
import com.CherryPicker.web.ui100.UI100Service;

@Controller
public class UI100Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UI100Service UI100Service;
	
	@RequestMapping(value="/PSMES/PSMES_UI110.do")
    public ModelAndView PSMES_UI110(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/PSMES_UI110");
    	
    	
    	return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI120.do")
    public ModelAndView PSMES_UI120(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/PSMES_UI120");
    	
    	return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI110_searchData1.do")
    public ModelAndView PSMES_UI110_searchData1(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI100Service.PSMES_UI110_searchData1(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("list", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI110_searchData2.do")
    public ModelAndView PSMES_UI110_searchData2(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI100Service.PSMES_UI110_searchData2(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("list", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI110_searchData3.do")
    public ModelAndView PSMES_UI110_searchData3(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI100Service.PSMES_UI110_searchData3(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("list", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
}
