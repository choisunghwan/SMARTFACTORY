package com.CherryPicker.web.ui700;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI700Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI700DAO")
	private UI700DAO UI700DAO;
	//////////////////////////////////////////////////
	// 출입로그 조회
	//////////////////////////////////////////////////
	public List<Map<String, Object>> CPMES_UI710_search(Map<String, Object> map) throws Exception {
		return UI700DAO.CPMES_UI710_search(map);
	}
	
	public List<Map<String, Object>> CPMES_UI720_search(Map<String, Object> map) throws Exception {
		return UI700DAO.CPMES_UI720_search(map);
	}
	
//	선호
	public List<Map<String, Object>> CPMES_UI710_passenger(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI700DAO.CPMES_UI710_passenger(map);
	}
	
	public List<Map<String, Object>> CPMES_UI710_passengerLog(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI700DAO.CPMES_UI710_passengerLog(map);
	}
	
	public List<Map<String, Object>> CPMES_UI730_search(Map<String, Object> map) throws Exception {
		return UI700DAO.CPMES_UI730_search(map);
	}
	
	public List<Map<String, Object>> CPMES_UI740_search(Map<String, Object> map) throws Exception {
		return UI700DAO.CPMES_UI740_search(map);
	}
//	선호
}
