package com.CherryPicker.web.ui500;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;

//public interface UI500Service {

@Service
@SuppressWarnings({"rawtypes"})
public class UI500Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI500DAO")
	private UI500DAO UI500DAO;
	
	//거래처 조회
	public List<Map<String, Object>> CPMES_UI510_search(Map<String, Object> map) throws Exception {
		return UI500DAO.CPMES_UI510_search(map);
	}
		
	public void CPMES_UI510_save(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI510_save(list.get(i));
		}
	}
	
	public void CPMES_UI510_delete(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI510_delete(list.get(i));
		}
	}
	
	public List<Map<String, Object>> CPMES_UI520_search(Map<String, Object> map) throws Exception {
		return UI500DAO.CPMES_UI520_search(map);
	}
		
	//사원관리
	public void CPMES_UI520_save(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI520_save(list.get(i));
		}
	}
	
	public void CPMES_UI520_delete(List<Map<String, Object>> list) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI520_delete(list.get(i));
		}
	}
		
	//공통코드 mas 조회
	public List<Map<String, Object>> CPMES_UI530_searchMas(Map<String, Object> map) throws Exception {
		return UI500DAO.CPMES_UI530_searchMas(map);
	}
	
	//공통코드 det 조회
	public List<Map<String, Object>> CPMES_UI530_searchDet(Map<String, Object> map) throws Exception {
		return UI500DAO.CPMES_UI530_searchDet(map);
	}
	
	//공통코드 MAS 저장
	public void CPMES_UI530_save(List<Map<String, Object>> list, List<Map<String, Object>> list2) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI530_saveMas(list.get(i));
		}
		
		for(int i=0, size=list2.size(); i<size; i++){
			UI500DAO.CPMES_UI530_saveDet(list2.get(i));
		}
		
	}
	
	//공통코드 코드 삭제
	public void CPMES_UI530_delete(List<Map<String, Object>> list, List<Map<String, Object>> list2) throws Exception {
		for(int i=0, size=list.size(); i<size; i++){
			UI500DAO.CPMES_UI530_delete(list.get(i));
		}
		
		for(int i=0, size=list2.size(); i<size; i++){
			UI500DAO.CPMES_UI530_delete_det(list2.get(i));
		}
		
	}
	
	
}
