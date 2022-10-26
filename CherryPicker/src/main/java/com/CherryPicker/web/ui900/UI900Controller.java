package com.CherryPicker.web.ui900;

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

import com.CherryPicker.web.comm.CommService;
import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.CommonUtils;
import com.CherryPicker.web.ui900.UI900Service;

@Controller
public class UI900Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UI900Service UI900Service;
	
	@Autowired
	private CommService CommService;
	
	@RequestMapping(value="/PSMES/PSMES_UI910.do")
    public ModelAndView PSMES_UI910(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/select_page");
    	
    	return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI910_search.do")
    public ModelAndView PSMES_UI910_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI900Service.PSMES_UI910_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI920.do")
    public ModelAndView PSMES_UI920(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/select_param");
    	 
    	return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI920_search_param.do")
    public ModelAndView PSMES_UI920_search_param(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI900Service.PSMES_UI920_search_param(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/PSMES/PSMES_UI930.do")
    public ModelAndView PSMES_UI930(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/insert_update_del_page");
    	 
    	return mv;
    }
	
	
	@RequestMapping(value="/PSMES/PSMES_UI930_save.do")
    public ModelAndView PSMES_UI930_save(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		
		String pCmd = (String)commandMap.get("pCmd");
		
		JSONParser jsonParser = new JSONParser();
		
		JSONArray jsonArray = new JSONArray();
				
		if(gridData != null)
		{
			jsonArray = (JSONArray) jsonParser.parse(gridData);
		}
		
		int iCnt = jsonArray.size();
		
		List<Map<String, Object>> list = new ArrayList();
		
		for(int i=0; i<iCnt; i++){
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
    		
			Map<String, Object> smap = new HashMap<String, Object>();
			
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));
			
			if("1".equals(chk))
			{
				smap.put("AAA", CommonUtils.isNull(jsonObj.get("AAA")));
				smap.put("BBB", CommonUtils.isNull(jsonObj.get("BBB")));
				smap.put("CCC", CommonUtils.isNull(jsonObj.get("CCC")));
				smap.put("DDD", CommonUtils.isNull(jsonObj.get("DDD")));
				
				list.add(smap);
			}
			
		}
		
		if("INSERT".equals(pCmd)) UI900Service.PSMES_UI930_insert(list);
		else if("UPDATE".equals(pCmd)) UI900Service.PSMES_UI930_update(list);
		else if("DELETE".equals(pCmd)) UI900Service.PSMES_UI930_delete(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	

	
//TEST1 조회 클릭시 작동.(main.jsp에서 왔음)
	@RequestMapping(value="/PSMES/PSMES_UI940.do")
    public ModelAndView PSMES_UI940(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/PSMES/select_test");
    	
    	return mv;
    }
	
//TEST1에 조회 페이지 안에 조회 버튼 클릭시 동작. (서비스:UI900Service.java 객체 호출)
	@RequestMapping(value="/PSMES/PSMES_UI940_search.do")
    public ModelAndView PSMES_UI940_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI900Service.PSMES_UI940_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;	
		
    }
	

	
	//TEST1 조건 조회 클릭시 작동.(main.jsp에서 왔음)
		@RequestMapping(value="/PSMES/PSMES_UI950.do")
	    public ModelAndView PSMES_UI950(CommandMap commandMap) throws Exception{
	    	ModelAndView mv = new ModelAndView("/PSMES/select_testparam");
	    	
	    	return mv;
	    }
		
	//TEST1에 조건 조회 페이지 안에 버튼 클릭시 동작. (서비스:UI900Service.java 객체 호출)
		@RequestMapping(value="/PSMES/PSMES_UI950_search_param.do")
	    public ModelAndView PSMES_UI950_search_param(CommandMap commandMap, HttpServletRequest request) throws Exception{
			
			List<Map<String,Object>> list = UI900Service.PSMES_UI950_search_param(commandMap.getMap());
			
			ModelAndView mv = new ModelAndView(); 
			mv.addObject("response", list);
			
	        mv.setViewName("jsonView");
				
			return mv;
			
			
	    }
		
	// TEST1 저장 수정 삭제
		@RequestMapping(value="/PSMES/PSMES_UI960.do")
	    public ModelAndView PSMES_UI960(CommandMap commandMap) throws Exception{
	    	ModelAndView mv = new ModelAndView("/PSMES/insert_update_del_page1");
	    	 
	    	return mv;
	    }

		@RequestMapping(value="/PSMES/PSMES_UI960_save.do")
	    public ModelAndView PSMES_UI960_save(CommandMap commandMap, HttpServletRequest request) throws Exception{
			String gridData = (String)commandMap.get("gridData");
			
			String pCmd = (String)commandMap.get("pCmd");
			
			JSONParser jsonParser = new JSONParser();
			
			JSONArray jsonArray = new JSONArray();
					
			if(gridData != null)
			{
				jsonArray = (JSONArray) jsonParser.parse(gridData);
			}
			
			int iCnt = jsonArray.size();
			
			List<Map<String, Object>> list = new ArrayList();
			
			for(int i=0; i<iCnt; i++){
				JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	    		
				Map<String, Object> smap = new HashMap<String, Object>();
				
				String chk =CommonUtils.isNull(jsonObj.get("CHK"));
				
				if("1".equals(chk))
				{
					smap.put("AAA", CommonUtils.isNull(jsonObj.get("AAA")));
					smap.put("BBB", CommonUtils.isNull(jsonObj.get("BBB")));
					smap.put("CCC", CommonUtils.isNull(jsonObj.get("CCC")));
					smap.put("DDD", CommonUtils.isNull(jsonObj.get("DDD")));
					
					list.add(smap);
				}
				
			}
			
			if("INSERT".equals(pCmd)) UI900Service.PSMES_UI960_insert(list);
			else if("UPDATE".equals(pCmd)) UI900Service.PSMES_UI960_update(list);
			else if("DELETE".equals(pCmd)) UI900Service.PSMES_UI960_delete(list);
			
			ModelAndView mv = new ModelAndView(); 
			mv.setViewName("jsonView");
				
			return mv;
	    }
	
}
