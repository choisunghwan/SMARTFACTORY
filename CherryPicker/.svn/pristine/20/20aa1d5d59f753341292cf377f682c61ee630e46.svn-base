package com.CherryPicker.web.ui900;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI900Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI900DAO")
	private UI900DAO UI900DAO;
	
	public List<Map<String, Object>> PSMES_UI910_search(Map<String, Object> map) throws Exception {
		return UI900DAO.PSMES_UI910_search(map);
	}
	
	public List<Map<String, Object>> PSMES_UI920_search_param(Map<String, Object> map) throws Exception {
		return UI900DAO.PSMES_UI920_search_param(map);
	}
	
	public void PSMES_UI930_insert(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI930_insert(list.get(i));
		}
	}
	
	public void PSMES_UI930_update(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI930_update(list.get(i));
		}
	}
	
	public void PSMES_UI930_delete(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI930_delete(list.get(i));
		}
	}
	
	
	
	
	
//TEST1	조회 페이지에서  조회 버튼 클릭시 PSMES_940_
	public List<Map<String, Object>> PSMES_UI940_search(Map<String, Object> map) throws Exception {
		return UI900DAO.PSMES_UI940_search(map);
	}
//TEST1	조건조회 페이지에서 조회 버튼 클릭시 PSMES_950_
	public List<Map<String, Object>> PSMES_UI950_search_param(Map<String, Object> map) throws Exception {
		return UI900DAO.PSMES_UI950_search_param(map);
	}
	
//TEST1	삽입,수정,삭제 페이지에서 삽입,수정,삭제 버튼 클릭시 PSMES_950_
	public void PSMES_UI960_insert(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI960_insert(list.get(i));
		}
	}
	
	public void PSMES_UI960_update(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI960_update(list.get(i));
		}
	}
	
	public void PSMES_UI960_delete(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI900DAO.PSMES_UI960_delete(list.get(i));
		}
	}
}
