package com.CherryPicker.web.ui300;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.CherryPicker.web.common.util.FileUtils;


@Service
@SuppressWarnings({"rawtypes"})
public class UI300Service	{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="UI300DAO")
	private UI300DAO UI300DAO;

	public List<Map<String, Object>> CPMES_UI310_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI310_searchMas(map);
	}
	
	public List<Map<String, Object>> CPMES_UI310_searchDet(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI310_searchDet(map);
	}
	
	public List<Map<String, Object>> CPMES_UI310_reportMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI310_reportMas(map);
	}
	
	public List<Map<String, Object>> CPMES_UI310_reportDet(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI310_reportDet(map);
	}
	
	public List<Map<String, Object>> CPMES_UI320_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI320_searchMas(map);
	}

	public List<Map<String, Object>> CPMES_UI330_searchMas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return UI300DAO.CPMES_UI330_searchMas(map);
	}
	
	public void CPMES_UI310_saveMas(Map<String, Object> map) throws Exception {
		UI300DAO.CPMES_UI310_save_mas(map);
	}
	
	public Map<String, Object> getPOrderPk(Map<String, Object> smap) {
		// TODO Auto-generated method stub
		return UI300DAO.getPOrderPk(smap);
	}
	
	public void CPMES_UI310_saveDet( List<Map<String, Object>> list2) throws Exception {
		
		
		for(int i=0, size=list2.size(); i<size; i++){
			UI300DAO.CPMES_UI310_save_det(list2.get(i));
		}
		
	}
	
	public void CPMES_UI310_delete(Map<String, Object> map) throws Exception {
		UI300DAO.CPMES_UI310_del_mas(map);
		
		UI300DAO.CPMES_UI310_del_det(map);
		
	}
	
	public void CPMES_UI310_row_del(List<Map<String, Object>> list2) throws Exception {
		
		for(int i=0, size=list2.size(); i<size; i++){
			UI300DAO.CPMES_UI310_row_del(list2.get(i));
		}
		
	}
	
	public void CPMES_UI330_save( List<Map<String, Object>> list) throws Exception {
		
		for(int i=0, size=list.size(); i<size; i++){
			UI300DAO.CPMES_UI330_save(list.get(i));
		}
		
	}
	
	public void CPMES_UI330_work_save( List<Map<String, Object>> list) throws Exception {
		
		for(int i=0, size=list.size(); i<size; i++){
			UI300DAO.CPMES_UI330_work_save(list.get(i));
		}
		
	}
	
	
	
	
}
