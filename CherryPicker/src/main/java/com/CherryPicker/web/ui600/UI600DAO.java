package com.CherryPicker.web.ui600;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.CherryPicker.web.common.AbstractDAO;

@Repository("UI600DAO")
public class UI600DAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI610_searchuser(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.CPMES_UI610_searchuser", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI610_searchwork(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.CPMES_UI610_searchwork", map);
	}
	
	public void CPMES_UI610_save_start(Map<String, Object> map) throws Exception{
		insert("ui600.CPMES_UI610_save_start", map);
	}
	
	public void CPMES_UI610_save_end(Map<String, Object> map) throws Exception{
		insert("ui600.CPMES_UI610_save_end", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI610_searchCompYn(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.CPMES_UI610_searchCompYn", map);
	}
	
	public void CPMES_UI610_update_compYn(Map<String, Object> map) throws Exception{
		insert("ui600.CPMES_UI610_update_compYn", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI620_searchList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.PSMES_UI620_searchList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI630_searchList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.PSMES_UI630_searchList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI640_searchList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.PSMES_UI640_searchList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI650_searchList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.PSMES_UI650_searchList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI660_searchList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui600.PSMES_UI660_searchList", map);
	}
	
	
	
	
	
}
