package com.CherryPicker.web.ui700;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.CherryPicker.web.common.AbstractDAO;

@Repository("UI700DAO")
public class UI700DAO extends AbstractDAO{
	
	//////////////////////////////////////////////////
	// 출입로그 조회
	//////////////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI710_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI710_search", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI720_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI720_search", map);
	}

//	선호
	public List<Map<String, Object>> CPMES_UI710_passenger(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI710_passenger", map);
	}
	
	public List<Map<String, Object>> CPMES_UI710_passengerLog(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI710_passengerLog", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI730_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI730_search", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> CPMES_UI740_search(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("ui700.CPMES_UI740_search", map);
	}
//	선호
}
