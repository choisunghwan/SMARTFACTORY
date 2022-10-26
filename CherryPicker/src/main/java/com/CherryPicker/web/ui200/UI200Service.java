package com.CherryPicker.web.ui200;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI200Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI200DAO")
	private UI200DAO UI200DAO;

	public List<Map<String, Object>> CPMES_UI220_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI220_searchMas(map);
	}

	public List<Map<String, Object>> CPMES_UI230_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI230_searchMas(map);
	}

	public void CPMES_UI210_Main_save(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		//System.out.println("Service Start");
		UI200DAO.CPMES_UI210_Main_save(smap);
	}

	public Map<String, Object> CPMES_UI210_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI210_searchMas(map);
	}

	public Map<String, Object> getROrderPk(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		return UI200DAO.getROrderPk(smap);
	}

	public void CPMES_UI210_Detail_save(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		for(int i=0, size=list.size(); i<size; i++){
			UI200DAO.CPMES_UI210_Detail_save(list.get(i));
		}
	}

	public List<Map<String, Object>> CPMES_UI210_searchDet(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI210_searchDet(map);
	}

	public void CPMES_UI210_deleteRow(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		for(int i=0, size=list.size(); i<size; i++){
			UI200DAO.CPMES_UI210_deleteRow(list.get(i));
		}
		
	}

	public void CPMES_UI210_deleteMain(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		UI200DAO.CPMES_UI210_deleteMain(smap);
	}

	public void CPMES_UI210_deleteDetail(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		UI200DAO.CPMES_UI210_deleteDetail(smap);
	}

	public int CPMES_UI210_FIleUp(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI210_FIleUp(smap);
	}

	public void CPMES_UI210_FIleIns(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		UI200DAO.CPMES_UI210_FIleIns(smap);
		
	}
	
	public void CPMES_UI230_save(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		for(int i=0, size=list.size(); i<size; i++){
			UI200DAO.CPMES_UI230_save(list.get(i));
		}
	}
	
	public List<Map<String, Object>> CPMES_UI214_searchList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI200DAO.CPMES_UI214_searchList(map);
	}

	public void CPMES_UI214_delete(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		for(int i=0, size=list.size(); i<size; i++){
			UI200DAO.CPMES_UI214_delete(list.get(i));
		}
	}
	
	
}
