package com.CherryPicker.web.ui700;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.CherryPicker.web.comm.UserVO;
import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.CommonUtils;
import com.CherryPicker.web.ui700.UI700Service;

@Controller
public class UI700Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UI700Service UI700Service;
	
	@Autowired
	private CommService CommService;

///////////////////////////////////////////////////////////////////////////////////	
//출입 관리 시스템 클릭시 실행
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI710.do")
    public ModelAndView CPMES_UI710(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI710");
    	
    	List<Map<String,Object>> list1 = UI700Service.CPMES_UI710_passenger(commandMap.getMap());
    	List<Map<String,Object>> list2 = UI700Service.CPMES_UI710_passengerLog(commandMap.getMap());
 
    	mv.addObject("passenger", list1);
    	mv.addObject("passengerLog", list2);
    	
    	return mv;
    }
///////////////////////////////////////////////////////////////////////////////////	
//출입 관리 시스템 '조회'버튼 클릭시 실행
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI710_search.do")
    public ModelAndView CPMES_UI710_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		//리스트 불러오기
		List<Map<String,Object>> list = UI700Service.CPMES_UI710_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
///////////////////////////////////////////////////////////////////////////////////		
//물건 감지 시스템 클릭시 실행	
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI720.do")
    public ModelAndView CPMES_UI720(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI720");
    
    	return mv;
    }
///////////////////////////////////////////////////////////////////////////////////	
// 물건 감지 시스템 '조회' 버튼 클릭시 실행
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI720_search.do")
    public ModelAndView CPMES_UI720_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI700Service.CPMES_UI720_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
///////////////////////////////////////////////////////////////////////////////////	
// 화재🔥 감지 시스템 클릭시 실행
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI730.do")
    public ModelAndView CPMES_UI730(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI730");
    	
    	return mv;
    }
///////////////////////////////////////////////////////////////////////////////////	
// 화재🔥 감지 시스템 조회 버튼 클릭시 실행
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI730_search.do")
    public ModelAndView CPMES_UI730_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI700Service.CPMES_UI730_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }

///////////////////////////////////////////////////////////////////////////////////	
// 테스트용(지워도 됨)
///////////////////////////////////////////////////////////////////////////////////	
	@RequestMapping(value="/CPMES/CPMES_UI740.do")
    public ModelAndView CPMES_UI740(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI740");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI740_search.do")
    public ModelAndView CPMES_UI740_search(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI700Service.CPMES_UI740_search(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("response", list);
		
        mv.setViewName("jsonView");
			
		return mv;
    }
}
