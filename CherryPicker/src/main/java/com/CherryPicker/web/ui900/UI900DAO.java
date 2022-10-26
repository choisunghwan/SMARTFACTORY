package com.CherryPicker.web.ui900;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.CherryPicker.web.common.AbstractDAO;

@Repository("UI900DAO")
public class UI900DAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI910_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui900.PSMES_UI910_search", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI920_search_param(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui900.PSMES_UI920_search_param", map);
	}
	
	public void PSMES_UI930_insert(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI930_insert", map);
	}
	
	public void PSMES_UI930_update(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI930_update", map);
	}
	
	public void PSMES_UI930_delete(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI930_delete", map);
	}
	
//	DB작업을 담당하는 DAO 조회          ui900.PSMES에 UI940_search  
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI940_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui900.PSMES_UI940_search", map);
	}
//	DB작업을 담당하는 DAO 조건조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> PSMES_UI950_search_param(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui900.PSMES_UI950_search_param", map);
	}
	
	
	public void PSMES_UI960_insert(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI960_insert", map);
	}
	
	public void PSMES_UI960_update(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI960_update", map);
	}
	
	public void PSMES_UI960_delete(Map<String, Object> map) throws Exception{
		insert("ui900.PSMES_UI960_delete", map);
	}
}
