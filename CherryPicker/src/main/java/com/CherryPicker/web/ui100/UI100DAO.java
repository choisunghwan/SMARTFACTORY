package com.CherryPicker.web.ui100;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.CherryPicker.web.common.AbstractDAO;

@Repository("UI100DAO")
public class UI100DAO extends AbstractDAO{
	
	public List<Map<String, Object>> PSMES_UI110_searchData1(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui100.PSMES_UI110_searchData1", map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchData2(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui100.PSMES_UI110_searchData2", map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchData3(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui100.PSMES_UI110_searchData3", map);
	}
	
	public List<Map<String, Object>> PSMES_UI110_searchOrderCom(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui100.PSMES_UI110_searchOrderCom", map);
	}
	
	
		
	
}
