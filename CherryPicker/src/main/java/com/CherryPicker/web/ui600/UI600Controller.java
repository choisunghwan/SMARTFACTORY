package com.CherryPicker.web.ui600;

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
import com.CherryPicker.web.ui600.UI600Service;

@Controller
public class UI600Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UI600Service UI600Service;
	
	@Autowired
	private CommService CommService;
	
	@RequestMapping(value="/CPMES/CPMES_UI610.do")
    public ModelAndView CPMES_UI610(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI610");
    	
    	List<Map<String,Object>> list = UI600Service.CPMES_UI610_searchuser(commandMap.getMap());
		
		mv.addObject("userInfo", list);
		
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI610_searchwork.do")
    public ModelAndView CPMES_UI610_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView(); 
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI610_searchwork(commandMap.getMap());
		
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI610_save_start.do")
    public ModelAndView CPMES_UI610_save_start(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		
		String pUserId = (String)commandMap.get("pUserId");
		String pWork = (String)commandMap.get("pWork");
		
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
				smap.put("R_ORDER_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP")));
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("pWork", pWork);
				smap.put("UPDATE_USER_CP", pUserId);
				
				list.add(smap);
			}
			
		}
		
		UI600Service.CPMES_UI610_save_start(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI610_save_end.do")
    public ModelAndView CPMES_UI610_save_end(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		
		String pUserId = (String)commandMap.get("pUserId");
		String pWork = (String)commandMap.get("pWork");
		
		String R_ORDER_PK_CP = "";
		String R_ORDER_DETAIL_PK_CP = "";
		
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
				smap.put("R_ORDER_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP")));
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("pWork", pWork);
				smap.put("UPDATE_USER_CP", pUserId);
				
				R_ORDER_PK_CP = CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP"));
				R_ORDER_DETAIL_PK_CP =  CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP"));
				
				list.add(smap);
			}
			
		}
		
		UI600Service.CPMES_UI610_save_end(list);
		
		commandMap.put("R_ORDER_DETAIL_PK_CP", R_ORDER_DETAIL_PK_CP);
		commandMap.put("R_ORDER_PK_CP", R_ORDER_PK_CP);
		
		List<Map<String,Object>> list1 = UI600Service.CPMES_UI610_searchCompYn(commandMap.getMap());
		
		if(list1.size()>0)
		{
			String WORK_CONFIRM1_CP = String.valueOf(list1.get(0).get("WORK_CONFIRM1_CP"));
			String WORK_CONFIRM2_CP = String.valueOf(list1.get(0).get("WORK_CONFIRM2_CP"));
			String WORK_CONFIRM3_CP = String.valueOf(list1.get(0).get("WORK_CONFIRM3_CP"));
			String WORK_CONFIRM4_CP = String.valueOf(list1.get(0).get("WORK_CONFIRM4_CP"));
			
			if("Y".equals(WORK_CONFIRM1_CP) && "Y".equals(WORK_CONFIRM2_CP) && "Y".equals(WORK_CONFIRM3_CP) && "Y".equals(WORK_CONFIRM4_CP))
			{
				commandMap.put("WORK_CONFIRM_CP", "Y");
				UI600Service.CPMES_UI610_update_compYn(commandMap.getMap());
			}
			
		}
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	
	@RequestMapping(value="/CPMES/CPMES_UI620.do")
    public ModelAndView CPMES_UI620(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI620");
    	
    	
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI620_searchuser.do")
    public ModelAndView CPMES_UI620_searchuser(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView(); 
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI610_searchuser(commandMap.getMap());
		
		mv.addObject("response", list);
			
		mv.setViewName("jsonView");
		
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI620_searchList.do")
    public ModelAndView CPMES_UI620_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView(); 
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI620_searchList(commandMap.getMap());
		
		mv.addObject("response", list);
			
		mv.setViewName("jsonView");
		
		return mv;
    }
	
	
	@RequestMapping(value="/CPMES/CPMES_UI630.do")
    public ModelAndView CPMES_UI630(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI630");
    	
    	List<Map<String,Object>> list = CommService.searchYearCombo(commandMap.getMap());
		mv.addObject("yearCombo", list);
		
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI630_searchList.do")
    public ModelAndView CPMES_UI630_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI630_searchList(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI640.do")
    public ModelAndView CPMES_UI640(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI640");
    	
    	List<Map<String,Object>> list = CommService.searchYearCombo(commandMap.getMap());
		mv.addObject("yearCombo", list);
		
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI640_searchList.do")
    public ModelAndView CPMES_UI640_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI640_searchList(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI650.do")
    public ModelAndView CPMES_UI650(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI650");
    	
    	List<Map<String,Object>> list = CommService.searchYearCombo(commandMap.getMap());
		mv.addObject("yearCombo", list);
		
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI650_searchList.do")
    public ModelAndView CPMES_UI650_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI650_searchList(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView();  
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI660.do")
    public ModelAndView CPMES_UI660(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI660");
    	
    	List<Map<String,Object>> list = CommService.searchYearCombo(commandMap.getMap());
		mv.addObject("yearCombo", list);
		
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI660_searchList.do")
    public ModelAndView CPMES_UI660_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI600Service.CPMES_UI660_searchList(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView();  
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	
}
