package com.CherryPicker.web.ui100;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI100Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI100DAO")
	private UI100DAO UI100DAO;
	
	public List<Map<String, Object>> PSMES_UI110_searchData1(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI100DAO.PSMES_UI110_searchData1(map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchData2(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI100DAO.PSMES_UI110_searchData2(map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchData3(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI100DAO.PSMES_UI110_searchData3(map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchOrderCom(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI100DAO.PSMES_UI110_searchOrderCom(map);
	}
	
	
}
