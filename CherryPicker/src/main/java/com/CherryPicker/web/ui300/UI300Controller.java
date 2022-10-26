package com.CherryPicker.web.ui300;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.CherryPicker.web.comm.CommService;
import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.CommonUtils;
import com.CherryPicker.web.ui300.UI300Service;

import net.sf.jasperreports.engine.JasperPrint;

@Controller
public class UI300Controller {
	Logger log = Logger.getLogger(this.getClass());
	CommonUtils utils = new CommonUtils();
	
	@Autowired
	private UI300Service UI300Service;
	
	@Autowired
	private CommService CommService;
	
	@Autowired
	private WebApplicationContext appContext;
	
	private static final String SP = File.separator;
	private static final String PATH = "pdf"+ SP +"web"+ SP + "output";
	private static final String JrXmlPATH = "WEB-INF" + SP + "jrxml";
	
	@RequestMapping(value="/CPMES/CPMES_UI310.do")
    public ModelAndView CPMES_UI310(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI310");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI310_searchMas.do")
    public ModelAndView CPMES_UI310_searchMas(CommandMap commandMap, HttpServletRequest request) throws Exception{
		// 여기가 조회 쿼리를 실행하는 부분 여기서 해당 로그를 실행 해 보며 됩니다. 
		// 로그는 이렇게 찍으시면 됩니다. 
		//jsp에서는 안되고요
		//jsp에서는 alert("...") 이렇게 
		//혹은 console.log("...") 이렇게 찍으시면 됩니다. console.log는 F12 console 창에서 확인 가능
		System.out.println("=============>" +(String)commandMap.get("P_ORDER_NO_CP "));
		
		List<Map<String,Object>> list = UI300Service.CPMES_UI310_searchMas(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv; 
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI310_searchDet.do")
    public ModelAndView CPMES_UI310_searchDet(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI300Service.CPMES_UI310_searchDet(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	
	@RequestMapping(value="/CPMES/CPMES_UI310_save.do")
    public ModelAndView CPMES_UI310_save(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		
		String sUserId = (String)commandMap.get("sUserId");
		
		commandMap.put("CREATE_USER_CP", sUserId);
		commandMap.put("UPDATE_USER_CP", sUserId);
		
		
		UI300Service.CPMES_UI310_saveMas(commandMap.getMap());
		
		String P_ORDER_PK_CP = CommonUtils.isNull(commandMap.get("P_ORDER_PK_CP"));
		if(CommonUtils.isNull(commandMap.get("P_ORDER_PK_CP")) == "") {
			//수주번호로 R_ORDER_PK_CP 구하기
			commandMap.put("P_ORDER_PK_CP", P_ORDER_PK_CP);
			Map<String,Object> rOrderPk = UI300Service.getPOrderPk(commandMap.getMap());
			P_ORDER_PK_CP = String.valueOf( rOrderPk.get("P_ORDER_PK_CP"));
		}
		
		JSONParser jsonParser = new JSONParser();
		
		JSONArray jsonArray = new JSONArray();
				
		if(gridData != null)
		{
			jsonArray = (JSONArray) jsonParser.parse(gridData);
		}
		
		int iCnt = jsonArray.size();
		
		List<Map<String, Object>> list = new ArrayList();
		
		for(int i=0; i<iCnt; i++){
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
    		
			Map<String, Object> smap = new HashMap<String, Object>();
			
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));
			
			if("1".equals(chk))
			{
				smap.put("P_ORDER_PK_CP", P_ORDER_PK_CP);
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("P_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("P_ORDER_DETAIL_PK_CP")));
				smap.put("P_PRODUCT_NO_CP", CommonUtils.isNull(jsonObj.get("P_PRODUCT_NO_CP")));
				smap.put("P_PRODUCT_NAME_CP", CommonUtils.isNull(jsonObj.get("P_PRODUCT_NAME_CP")));
				smap.put("P_STANDARD_CP", CommonUtils.isNull(jsonObj.get("P_STANDARD_CP")));
				smap.put("UNIT_COST_CP", CommonUtils.isNull(jsonObj.get("UNIT_COST_CP")));
				smap.put("AMOUNT_CP", CommonUtils.isNull(jsonObj.get("AMOUNT_CP")));
				smap.put("SUM_COST_CP", CommonUtils.isNull(jsonObj.get("SUM_COST_CP")));
				smap.put("NOTE_CP", CommonUtils.isNull(jsonObj.get("NOTE_CP")));
				smap.put("CREATE_USER_CP", sUserId);
				smap.put("UPDATE_USER_CP", sUserId);
				
				list.add(smap);
			}
			
		}
		
		
		UI300Service.CPMES_UI310_saveDet(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI310_delete.do")
    public ModelAndView CPMES_UI310_delete(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		UI300Service.CPMES_UI310_delete(commandMap.getMap());
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI310_row_del.do")
    public ModelAndView CPMES_UI510_del(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		String sUserId = (String)commandMap.get("sUserId");
		
		JSONParser jsonParser = new JSONParser();
		
		JSONArray jsonArray = new JSONArray();
				
		if(gridData != null)
		{
			jsonArray = (JSONArray) jsonParser.parse(gridData);
		}
		
		int iCnt = jsonArray.size();
		
		List<Map<String, Object>> list = new ArrayList();
		
		for(int i=0; i<iCnt; i++){
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
    		
			Map<String, Object> smap = new HashMap<String, Object>();
			
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));
			
			if("1".equals(chk))
			{
				smap.put("P_ORDER_DETAIL_PK", CommonUtils.isNull(jsonObj.get("P_ORDER_DETAIL_PK")));
				
				list.add(smap);
			}
			
		}
		
		UI300Service.CPMES_UI310_row_del(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	//report Test
	@RequestMapping(value="/CPMES/CPMES_UI310_Report.do")
    public ModelAndView CPMES_UI310_Report(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	
    	//"../img/sign.jpg" 직인 이미지 차후 추가 
    	
    	List<Map<String,Object>> list = UI300Service.CPMES_UI310_reportMas(commandMap.getMap());
    	List<Map<String,Object>> list1 = UI300Service.CPMES_UI310_reportDet(commandMap.getMap());
        
    	
    	UI300MainVO ui300MainVO = new UI300MainVO();
    	UI300DetailVO ui300DetailVO = new UI300DetailVO();
    	List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
    	
    	if(list.size()>0)
    	{
    		ui300MainVO.setP_order_no((String)list.get(0).get("P_ORDER_NO_CP"));
    		ui300MainVO.setP_order_name((String)list.get(0).get("P_ORDER_NAME_CP"));
    		ui300MainVO.setCompany_code_nm((String)list.get(0).get("COMPANY_CODE_NM_CP"));
    		ui300MainVO.setTel_no((String)list.get(0).get("TEL_NO_CP"));
    		ui300MainVO.setFax_no((String)list.get(0).get("FAX_NO_CP"));
    		ui300MainVO.setFixed_date((String)list.get(0).get("FIXED_DATE_CP"));
    		ui300MainVO.setAmount_cnt(String.valueOf(list.get(0).get("AMOUNT_CNT_CP")));
    		ui300MainVO.setFinal_cost((String)list.get(0).get("FINAL_COST_CP"));
    		ui300MainVO.setVat((String)list.get(0).get("VAT_CP"));
    		ui300MainVO.setTotal_cost((String)list.get(0).get("TOTAL_COST_CP"));
    		ui300MainVO.setTotal_nm((String)list.get(0).get("TOTAL_NM_CP"));
    		
    		for(int i=0;i<list1.size();i++)
    		{
    			ui300MainVO.addDetail(String.valueOf(list1.get(i).get("NUM_CP")), String.valueOf(list1.get(i).get("P_PRODUCT_NO_CP"))
    								, String.valueOf(list1.get(i).get("P_PRODUCT_NAME_CP")), String.valueOf(list1.get(i).get("P_STANDARD_CP")), String.valueOf(list1.get(i).get("UNIT_COST_CP"))
    								, String.valueOf(list1.get(i).get("AMOUNT_CP")), String.valueOf(list1.get(i).get("SUM_COST_CP"))
    								, String.valueOf(list1.get(i).get("SUM_COST_VAT_CP")), String.valueOf(list1.get(i).get("NOTE_CP")));
    		}
    		
    		String jrxmlPath = "";
			
			jrxmlPath = SP + getOutputPath(JrXmlPATH) + SP + "UI310.jrxml";
    		//jrxmlPath =  "dongaS" + SP + "jrxml" + SP + "invoice.jrxml";
    		//jrxmlPath =  getClass() + "/invoice.jrxml";
    		log.debug("jrxmlPath ========= > " + jrxmlPath);
			log.debug("getOutputPath(JrXmlPATH) ========= > " + getOutputPath(JrXmlPATH));
			 
			JasperPrint jasperPrint = utils.getJasperPrint(ui300MainVO, ui300MainVO.getDetails(), jrxmlPath);
			jasperPrintList.add(jasperPrint);
			
			String pdfFileName = "";
			String pWDate = CommonUtils.currentTime();
			String pdfPath = getOutputPath(PATH) + SP + "발주서"+ "_" + pWDate + ".pdf";
			
//				String pdfPath = getOutPdfPath("").replace("WEB-INF/classes", "pdf/web/output") + SP + "sOrder"+ "_" + pWDate + ".pdf";
			log.debug("pdfPath ========= > " + pdfPath);
			
			
			if(jasperPrintList.size() > 0) {
				pdfFileName = utils.makePdfList(jasperPrintList, pdfPath);
				
				//pdfFileName = pdfPath;
			}
			
			//ModelAndView mv = new ModelAndView(); 
			mv.addObject("pdfFileName", pdfFileName);
			mv.setViewName("jsonView");
			
			log.debug("pdfPath ========= > " + pdfPath);
    	}
    	//mv.addObject("packList", getCommonCodeLov(commandMap, "PACKING", "")); 
    	
    	return mv;
    } 
	
	@RequestMapping(value="/CPMES/CPMES_UI311.do")
    public ModelAndView CPMES_UI311(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI311");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI320.do")
    public ModelAndView CPMES_UI320(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI320");
    	
    	commandMap.put("pCdTp", "ORDER_TP_CP");
		List<Map<String,Object>> list = CommService.searchComcode(commandMap.getMap());
		
		mv.addObject("orderTp", list);
		
    	return mv;
    }

	@RequestMapping(value="/CPMES/CPMES_UI320_searchMas.do")
    public ModelAndView CPMES_UI320_searchMas(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI300Service.CPMES_UI320_searchMas(commandMap.getMap());
			
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	@RequestMapping(value="/CPMES/CPMES_UI330.do")
    public ModelAndView CPMES_UI330(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI330");
    	
    	return mv;
    }
	@RequestMapping(value="/CPMES/CPMES_UI330_searchMas.do")
    public ModelAndView CPMES_UI330_searchMas(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI300Service.CPMES_UI330_searchMas(commandMap.getMap());
			
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI330_save.do")
    public ModelAndView CPMES_UI330_save(CommandMap commandMap, HttpServletRequest request) throws Exception{
		String gridData = (String)commandMap.get("gridData");
		
		String sUserId = (String)commandMap.get("sUserId");
		
		JSONParser jsonParser = new JSONParser();
		
		JSONArray jsonArray = new JSONArray();
				
		if(gridData != null)
		{
			jsonArray = (JSONArray) jsonParser.parse(gridData);
		}
		
		int iCnt = jsonArray.size();
		
		List<Map<String, Object>> list = new ArrayList();
		List<Map<String, Object>> list1 = new ArrayList();
		
		for(int i=0; i<iCnt; i++){
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
    		
			Map<String, Object> smap = new HashMap<String, Object>();
			
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));
			
			if("1".equals(chk))
			{
				
				smap.put("P_ORDER_PK_CP", CommonUtils.isNull(jsonObj.get("P_ORDER_PK_CP")));
				smap.put("R_ORDER_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP")));
				smap.put("R_ORDER_NO_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_NO_CP")));
				smap.put("CREATE_USER_CP", sUserId);
				smap.put("UPDATE_USER_CP", sUserId);
				
				list.add(smap);
				
				if(!CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP")).equals("")) {
					list1.add(smap);
				}
				
			}
			
		}
		
		// 입고처리
		UI300Service.CPMES_UI330_save(list);
		
		// 작업지시의 외주발주의 작업완료 처리
		UI300Service.CPMES_UI330_work_save(list);
		
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	private String getOutputPath(String path) {
		ServletContext sc = appContext.getServletContext();
		String realPath = sc.getRealPath("/");
		String outputPath = realPath + path;
		
		return outputPath;
    }	
	
	private String getOutPdfPath(String path) {
		String url = this.getClass().getResource("").getPath();
		url = this.getClass().getResource("/").getPath();
		url = url.substring(0, url.length());
		
        String outputPath = url;
        return outputPath;
    }
}
