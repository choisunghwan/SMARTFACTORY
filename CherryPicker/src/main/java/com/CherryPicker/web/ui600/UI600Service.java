package com.CherryPicker.web.ui600;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI600Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI600DAO")
	private UI600DAO UI600DAO;
	
	public List<Map<String, Object>> CPMES_UI610_searchuser(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI610_searchuser(map);
	}
	
	public List<Map<String, Object>> CPMES_UI610_searchwork(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI610_searchwork(map);
	}
	
	public void CPMES_UI610_save_start(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI600DAO.CPMES_UI610_save_start(list.get(i));
		}
	}
	
	public void CPMES_UI610_save_end(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI600DAO.CPMES_UI610_save_end(list.get(i));
		}
	}
	
	public List<Map<String, Object>> CPMES_UI610_searchCompYn(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI610_searchCompYn(map);
	}
	
	public void CPMES_UI610_update_compYn(Map<String, Object> map) throws Exception {
		UI600DAO.CPMES_UI610_update_compYn(map);
	}
	
	public List<Map<String, Object>> CPMES_UI620_searchList(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI620_searchList(map);
	}
	
	public List<Map<String, Object>> CPMES_UI630_searchList(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI630_searchList(map);
	}
	
	public List<Map<String, Object>> CPMES_UI640_searchList(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI640_searchList(map);
	}
	
	public List<Map<String, Object>> CPMES_UI650_searchList(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI650_searchList(map);
	}
	
	public List<Map<String, Object>> CPMES_UI660_searchList(Map<String, Object> map) throws Exception {
		return UI600DAO.CPMES_UI660_searchList(map);
	}
	
}
