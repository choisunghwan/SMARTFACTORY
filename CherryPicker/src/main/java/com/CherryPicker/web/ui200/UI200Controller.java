package com.CherryPicker.web.ui200;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.CherryPicker.web.comm.CommService;
import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.common.util.CommonUtils;
import com.CherryPicker.web.ui200.UI200Service;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


@Controller
public class UI200Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UI200Service UI200Service;

	@Autowired
	private CommService CommService;
	
	@RequestMapping(value="/CPMES/CPMES_UI210.do")
    public ModelAndView CPMES_UI210(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI210");

    	commandMap.put("pCdTp", "NATION_TP_CP");
		List<Map<String,Object>> list = CommService.searchComcode(commandMap.getMap());
		mv.addObject("nationTp", list);
		
		commandMap.put("pCdTp", "SALES_TP_CP");
		List<Map<String,Object>> list1 = CommService.searchComcode(commandMap.getMap());
		mv.addObject("salesTp", list1);
    	return mv;
    }

	@RequestMapping(value="/CPMES/CPMES_UI210_searchMas.do")
    public ModelAndView CPMES_UI210_searchMas(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		Map<String,Object> MastInfo = UI200Service.CPMES_UI210_searchMas(commandMap.getMap());
		List<Map<String,Object>> DetailList = UI200Service.CPMES_UI210_searchDet(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("MastInfo", MastInfo);
		mv.addObject("DetailList", DetailList);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI210_searchDet.do")
    public ModelAndView CPMES_UI210_searchDet(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> DetailList = UI200Service.CPMES_UI210_searchDet(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("DetailList", DetailList);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI210_Main_save.do")
    public ModelAndView CPMES_UI210_Main_save(CommandMap commandMap, HttpServletRequest request) throws Exception{

		String gridData = (String)commandMap.get("gridData");

		String sUserId = (String)commandMap.get("sUserId");
		ModelAndView mv = new ModelAndView(); 
		Map<String, Object> smap = new HashMap<String, Object>();
		
		
		smap.put("pROrderPk"      ,  CommonUtils.isNull(commandMap.get("pROrderPkP")));
		smap.put("pROrderNo"      ,  CommonUtils.isNull(commandMap.get("pROrderNo")));
		smap.put("pROrderName"    ,  CommonUtils.isNull(commandMap.get("pROrderName")));
		smap.put("pCompanyCode"   ,  CommonUtils.isNull(commandMap.get("pCompanyCode")));
		smap.put("pROrderDate"    ,  CommonUtils.isNull(commandMap.get("pROrderDate")));
		smap.put("pFixedDate"     ,  CommonUtils.isNull(commandMap.get("pFixedDate")));
		smap.put("pShippingDate"  ,  CommonUtils.isNull(commandMap.get("pShippingDate")));
		smap.put("pEstimatedCost" ,  CommonUtils.isNull(commandMap.get("pEstimatedCost")));
		smap.put("pGeneralCost"   ,  CommonUtils.isNull(commandMap.get("pGeneralCost")));
		smap.put("pFinalCost"     ,  CommonUtils.isNull(commandMap.get("pFinalCost")));
		smap.put("pRemarks"       ,  CommonUtils.isNull(commandMap.get("pRemarks")));
		smap.put("pNationTp"      ,  CommonUtils.isNull(commandMap.get("pNationTp")));
		smap.put("pSalesTp"      ,  CommonUtils.isNull(commandMap.get("pSalesTp")));
		smap.put("CREATE_USER_CP", sUserId);
		smap.put("UPDATE_USER_CP", sUserId);
		
		UI200Service.CPMES_UI210_Main_save(smap);
		
		String sROrderPk = CommonUtils.isNull(commandMap.get("pROrderPk"));
		if(CommonUtils.isNull(commandMap.get("pROrderPk")) == "") {
			//수주번호로 R_ORDER_PK 구하기
			Map<String,Object> rOrderPk = UI200Service.getROrderPk(smap);
			//System.out.println(rOrderPk.get("R_ORDER_PK"));
			sROrderPk = String.valueOf(rOrderPk.get("R_ORDER_PK_CP"));
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

			smap = new HashMap<String, Object>();
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));

			if("1".equals(chk))
			{
				smap.put("R_ORDER_PK_CP",   sROrderPk);
				smap.put("R_ORDER_DETAIL_PK_CP",   CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				smap.put("PRODUCT_NO_CP",   CommonUtils.isNull(jsonObj.get("PRODUCT_NO_CP")));
				smap.put("PRODUCT_NAME_CP", CommonUtils.isNull(jsonObj.get("PRODUCT_NAME_CP")));
				smap.put("R_STANDARD_CP",   CommonUtils.isNull(jsonObj.get("R_STANDARD_CP")));
				smap.put("UNIT_COST_CP",    CommonUtils.isNull(jsonObj.get("UNIT_COST_CP")));
				smap.put("AMOUNT_CP",       CommonUtils.isNull(jsonObj.get("AMOUNT_CP")));
				smap.put("SUM_COST_CP",     CommonUtils.isNull(jsonObj.get("SUM_COST_CP")));
				smap.put("OUT_YN_CP",       CommonUtils.isNull(jsonObj.get("OUT_YN_CP")));
				smap.put("SELF_YN_CP",      CommonUtils.isNull(jsonObj.get("SELF_YN_CP")));
				smap.put("DRAWING_FILE_CP", CommonUtils.isNull(jsonObj.get("DRAWING_FILE_CP")));
				smap.put("NOTE_CP",         CommonUtils.isNull(jsonObj.get("NOTE_CP")));
				smap.put("CREATE_USER_CP",  sUserId);
				smap.put("UPDATE_USER_CP",  sUserId);
				list.add(smap);
			}
			
		}

		UI200Service.CPMES_UI210_Detail_save(list);

		mv.addObject("sROrderPk", sROrderPk);
		
		mv.setViewName("jsonView");
		return mv;
    }

	@RequestMapping(value="/CPMES/CPMES_UI210_delete.do")
    public ModelAndView CPMES_UI210_delete(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView(); 
		Map<String, Object> smap = new HashMap<String, Object>();
		smap.put("pROrderPk"      ,  CommonUtils.isNull(commandMap.get("pROrderPk")));
		UI200Service.CPMES_UI210_deleteMain(smap);
		UI200Service.CPMES_UI210_deleteDetail(smap);
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI210_delRow.do")
    public ModelAndView CPMES_UI210_delRow(CommandMap commandMap, HttpServletRequest request) throws Exception{
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
				
				smap.put("R_ORDER_DETAIL_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_DETAIL_PK_CP")));
				list.add(smap);
			}
			
		}
		
		UI200Service.CPMES_UI210_deleteRow(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	

	@RequestMapping(value="/CPMES/CPMES_UI210_FIleUp.do")
	@ResponseBody
    public ModelAndView CPMES_UI210_FIleUp(CommandMap commandMap,MultipartHttpServletRequest mtfRequest) throws Exception{
		List<MultipartFile> fileList = mtfRequest.getFiles("input_file");

		String sUserId = (String)commandMap.get("sUserId");
		String path = "C:\\upload\\";
        //System.out.println("fileList : " + fileList.size());
        //System.out.println("pROrderPk : " + mtfRequest.getParameter("pROrderPk"));
		File Folder = new File(path+"\\"+mtfRequest.getParameter("pROrderPk"));
		if (!Folder.exists()) {
			try{
			    Folder.mkdirs(); //폴더 생성합니다.
		    }catch(Exception e){
			    e.getStackTrace();
			}
		}
        for (MultipartFile mf : fileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            String fileName = FilenameUtils.removeExtension(mf.getOriginalFilename());
            long fileSize = mf.getSize(); // 파일 사이즈

            //System.out.println("originFileName : " + originFileName);
            //System.out.println("fileName : " + fileName);
            //System.out.println("fileSize : " + fileSize);

            String[] pkNum  = fileName.split("-");
            
            String orderNo = pkNum[0];
            String produnctNo = pkNum[1]+"-"+pkNum[2];
            
            Map<String, Object> smap = new HashMap<String, Object>();
    		

    		smap.put("pROrderPk"      ,  mtfRequest.getParameter("pROrderPkP"));
    		smap.put("originFileName"      ,  originFileName);
    		smap.put("orderNo"      ,  orderNo);
    		smap.put("produnctNo"    ,  produnctNo);
    		smap.put("CREATE_USER_CP", sUserId);
    		smap.put("UPDATE_USER_CP", sUserId);
    		
    		int result = UI200Service.CPMES_UI210_FIleUp(smap);

    		if(result < 1) {
    			UI200Service.CPMES_UI210_FIleIns(smap);
    		}
            //System.out.println("result : " + result);
            String safeFile = path + "\\"+mtfRequest.getParameter("pROrderPk")+ "\\" + originFileName;
            
            try {
                mf.transferTo(new File(safeFile));
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	

	@RequestMapping(value="/CPMES/CPMES_UI210_FileDown.do")
	public void CPMES_UI210_FIleDown( HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String, String> paramMap) {
		 
	    String path = "C:\\upload\\" + paramMap.get("filePath"); //full경로
	    String fileName = paramMap.get("fileName"); //파일명
	 
	    File file = new File(path+"\\"+fileName);
	 
	    FileInputStream fileInputStream = null;
	    ServletOutputStream servletOutputStream = null;
	 
	    try{
	        String downName = null;
	        String browser = request.getHeader("User-Agent");
	        //파일 인코딩
	        if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){//브라우저 확인 파일명 encode  
	            
	            downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
	            
	        }else{
	            
	            downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	            
	        }
	        
	        response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");             
	        response.setContentType("application/octer-stream");
	        response.setHeader("Content-Transfer-Encoding", "binary;");
	 
	        fileInputStream = new FileInputStream(file);
	        servletOutputStream = response.getOutputStream();
	 
	        byte b [] = new byte[1024];
	        int data = 0;
	 
	        while((data=(fileInputStream.read(b, 0, b.length))) != -1){
	            
	            servletOutputStream.write(b, 0, data);
	            
	        }
	 
	        servletOutputStream.flush();//출력
	        
	    }catch (Exception e) {
	        e.printStackTrace();
	    }finally{
	        if(servletOutputStream!=null){
	            try{
	                servletOutputStream.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
	        if(fileInputStream!=null){
	            try{
	                fileInputStream.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
	    }
	}
	
	/**
     * cell의 데이터를 string으로 변경
     * 
     * @param cell
     * @return
     */
    public String getStringValue(XSSFCell cell) {
        String rtnValue = "";
        try {
            rtnValue = cell.getStringCellValue();
        } catch(IllegalStateException e) {
            rtnValue = Integer.toString((int)cell.getNumericCellValue());            
        }
        
        return rtnValue;
    }
    
    /**
     * cell의 데이터를 string으로 변경
     * 
     * @param cell
     * @return
     */
    public String getCellNullStringValue(XSSFCell cell) {
        String rtnValue = "";
        try {
            rtnValue = cell.getStringCellValue();
        } catch(Exception e) {
            rtnValue = "";          
        }
        
        return rtnValue;
    }

	
	@RequestMapping(value="/CPMES/CPMES_UI210_excel_upload.do")
	@ResponseBody
    public ModelAndView CPMES_UI210_excel_upload(CommandMap commandMap,MultipartHttpServletRequest mtfRequest) throws Exception{
		MultipartFile mfile = mtfRequest.getFile("input_file");
		
		// MultipartFile to File
		File file = new File(mfile.getOriginalFilename());
		mfile.transferTo(file);
		
		//FileInputStream excelFile = new FileInputStream(file);
		
		FileInputStream fis = null;
        XSSFWorkbook workbook = null;

        List<Map<String, Object>> list = new ArrayList();
        
        try {
            
            fis= new FileInputStream(file);
            // HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
            workbook = new XSSFWorkbook(fis);
            
            // 탐색에 사용할 Sheet, Row, Cell 객체
            XSSFSheet curSheet;
            XSSFRow   curRow;
            XSSFCell  curCell;
            
            // 현재 Sheet 반환
            curSheet = workbook.getSheetAt(0);
            
            // row 탐색 for문
            for(int rowIndex=0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
                // row 0은 헤더정보이기 때문에 무시
                if(rowIndex != 0) {
                    // 현재 row 반환
                    curRow = curSheet.getRow(rowIndex);
                    Map<String, Object> map = new HashMap<String, Object>();
                    
                    String value;
                    
                    //System.out.println("##  getPhysicalNumberOfCells : "+String.valueOf(curRow.getPhysicalNumberOfCells()) + "##  getLastCellNum : "+String.valueOf(curRow.getLastCellNum()) );
                    
                    // row의 첫번째 cell값이 비어있지 않은 경우 만 cell탐색
                    //if(!"".equals(curRow.getCell(0).getStringCellValue())) {
                    if(!"".equals(getStringValue(curRow.getCell(0)))) {
                        
                        // cell 탐색 for 문
                        //for(int cellIndex=0;cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
                    	for(int cellIndex=0;cellIndex<curRow.getLastCellNum(); cellIndex++) {
                            curCell = curRow.getCell(cellIndex);
                            
                            int iCellType = 0;
                            
                            try {
                            	iCellType = curCell.getCellType();
                            }catch(NullPointerException ex){
                            	iCellType = 1;
                            }
                            
                            //System.out.println("rowIndex : "+String.valueOf(rowIndex)+", cellIndex : "+String.valueOf(cellIndex)+", getCellType : "+String.valueOf(iCellType));
                            
                            if(true) {
                                value = "";
                                // cell 스타일이 다르더라도 String으로 반환 받음
                                switch (iCellType){
	                                case XSSFCell.CELL_TYPE_FORMULA:
	                                    value = getStringValue(curCell);
	                                    break;
	                                case XSSFCell.CELL_TYPE_NUMERIC:
	                                    value = getStringValue(curCell); // curCell.getNumericCellValue()
	                                    break;
	                                case XSSFCell.CELL_TYPE_STRING:
	                                    value =  getCellNullStringValue(curCell); // curCell.getStringCellValue()
	                                    break;
	                                case XSSFCell.CELL_TYPE_BLANK:
	                                    value = ""; //curCell.getBooleanCellValue()+"";
	                                    break;
	                                case XSSFCell.CELL_TYPE_ERROR:
	                                    value = ""; //curCell.getErrorCellValue()+"";
	                                    break;
	                                default:
	                                    value = "";
	                                    break;
                                }
                                
                                //System.out.println("value : "+value);
                                
                                // 현재 column index에 따라서 vo에 입력
                                switch (cellIndex) {
                                case 1: // 품번
                                	map.put("PRODUCT_NO_CP", value);
                                    break;
                                    
                                case 2: // 품명
                                	map.put("PRODUCT_NAME_CP", value);
                                    break;
                                
                                case 3: // 규격
                                	map.put("R_STANDARD_CP", value);
                                    break;
                                    
                                case 4: // 단가
                                	map.put("UNIT_COST_CP", value);
                                    break;
                                    
                                case 5: // 수량
                                	map.put("AMOUNT_CP", value);
                                    break;
                                
                                case 6: // 금액
                                	map.put("SUM_COST_CP", value);
                                    break;
                                
                                case 7: // 비고
                                	map.put("NOTE_CP", value);
                                    break;
                                    
                                default:
                                    break;
                                }
                            }
                        }
                        
                        //System.out.println(map);
                        
                        // cell 탐색 이후 map 추가
                        list.add(map);
                    }
                }
            }
            
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( fis!= null) fis.close();
                
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		
		ModelAndView mv = new ModelAndView(); 
		
		mv.addObject("excellist", list);
		
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI211.do")
    public ModelAndView CPMES_UI211(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI211");

    	commandMap.put("pCdTp", "ACCOUNT_TP_CP");
		List<Map<String,Object>> list = CommService.searchComcode(commandMap.getMap());
		
		mv.addObject("accountTp", list);
		
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI212.do")
    public ModelAndView CPMES_UI212(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI212");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI213.do")
    public ModelAndView CPMES_UI213(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI213");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI214.do")
    public ModelAndView CPMES_UI214(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI214");
    	
    	return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI214_searchList.do")
    public ModelAndView CPMES_UI214_searchList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI200Service.CPMES_UI214_searchList(commandMap.getMap());
	
		ModelAndView mv = new ModelAndView(); 

		mv.addObject("response", list);
		
		mv.addObject("res", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI214_delete.do")
    public ModelAndView CPMES_UI214_delete(CommandMap commandMap, HttpServletRequest request) throws Exception{
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
				
				smap.put("R_ORDER_FILE_PK_CP", CommonUtils.isNull(jsonObj.get("R_ORDER_FILE_PK_CP")));
				list.add(smap);
			}
			
		}
		
		UI200Service.CPMES_UI214_delete(list);
		
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI220.do")
    public ModelAndView CPMES_UI220(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI220");
    	
    	commandMap.put("pCdTp", "SALES_TP_CP");
		List<Map<String,Object>> list = CommService.searchComcode(commandMap.getMap());
		mv.addObject("salesTp", list);
    	
    	return mv;
    }

	@RequestMapping(value="/CPMES/CPMES_UI220_searchMas.do")
    public ModelAndView CPMES_UI220_searchMas(CommandMap commandMap, HttpServletRequest request) throws Exception{
		
		List<Map<String,Object>> list = UI200Service.CPMES_UI220_searchMas(commandMap.getMap());
			
		
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	@RequestMapping(value="/CPMES/CPMES_UI230.do")
    public ModelAndView CPMES_UI230(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/CPMES/CPMES_UI230");
    	
    	return mv;
    }

	@RequestMapping(value="/CPMES/CPMES_UI230_searchMas.do")
    public ModelAndView CPMES_UI230_searchMas(CommandMap commandMap) throws Exception{

		List<Map<String,Object>> list = UI200Service.CPMES_UI230_searchMas(commandMap.getMap());
			
		ModelAndView mv = new ModelAndView(); 
			
		mv.addObject("response", list);
			
        mv.setViewName("jsonView");
			
		return mv;
    }
	
	@RequestMapping(value="/CPMES/CPMES_UI230_save.do")
    public ModelAndView CPMES_UI230_save(CommandMap commandMap, HttpServletRequest request) throws Exception{

		ModelAndView mv = new ModelAndView();
		
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

			Map<String, Object> smap = new HashMap<String, Object>();
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
			String chk =CommonUtils.isNull(jsonObj.get("CHK"));

			if("1".equals(chk))
			{
				smap.put("R_ORDER_PK_CP",   CommonUtils.isNull(jsonObj.get("R_ORDER_PK_CP")));
				smap.put("CREATE_USER_CP",  sUserId);
				smap.put("UPDATE_USER_CP",  sUserId);
				list.add(smap);
			}
			
		}

		UI200Service.CPMES_UI230_save(list);

		mv.setViewName("jsonView");
		return mv;
    }
}
