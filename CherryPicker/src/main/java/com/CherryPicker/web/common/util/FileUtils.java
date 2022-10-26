package com.CherryPicker.web.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.jdbc.log.Log;

@Component("fileUtils")
public class FileUtils {
	private static String filePath = "";
	private static String oldfilePath = "";
	
	public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String attach_path = "resources/upload/";
	
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        String poNo = (String)map.get("sPoNo");
        String idx = (String)map.get("sIDX");
        
        File file = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(filePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("PO_NO", poNo);
        		listMap.put("IDX", idx);
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
	
	public List<Map<String,Object>> parseInsertFile04Info(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String attach_path = "resources/upload/ceo/so/";
	
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        String soNo = (String)map.get("sSoNo");
        String idx = (String)map.get("sIDX");
        
        File file = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(filePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("SO_NO", soNo);
        		listMap.put("IDX", idx);
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
	
	public List<Map<String,Object>> parseInsertFile05Info(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String attach_path = "resources/upload/ceo/po/";
	
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        String poNo = (String)map.get("sPoNo");
        String idx = (String)map.get("sIDX");
        
        File file = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(filePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("PO_NO", poNo);
        		listMap.put("IDX", idx);
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
//	public List<Map<String,Object>> parseProdInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
//		
//		String root_path = request.getSession().getServletContext().getRealPath("/");  
//	    String oldattach_path = "resources/upload/prod/file/";
//	    String attach_path = "resources/upload/prod/";
//	    
//	    oldfilePath= root_path+oldattach_path;
//	    filePath = root_path+attach_path;
//
//	    System.out.println("filePath=====> " + filePath);
//	
//		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
//    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
//    	
//    	MultipartFile multipartFile = null;
//    	String originalFileName = null;
//    	String originalFileExtension = null;
//    	String originalFileExtension1 = null;
//    	String storedFileName = null;
//    	
//    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
//        Map<String, Object> listMap = null; 
//        
//        //String boardIdx = (String)map.get("BOARD_IDX");
//        
//        String sPoNo =  (String)map.get("sPoNo");
//    	String sItemCode =  (String)map.get("sItemCode");
//    	String sSeq =  (String)map.get("sSeq");
//    	String sDegree =  (String)map.get("sDegree");
//    	String sIndex =  (String)map.get("sIndex");
//    	String fileSeq = (String)map.get("fileSeq");
//    	String sUserId = (String)map.get("sUserId");
//    	
//        File file = new File(oldfilePath);
//        File file1 = new File(filePath);
//        
//        if(file.exists() == false){
//        	file.mkdirs();
//        }
//        
//        if(file1.exists() == false){
//        	file1.mkdirs();
//        }
//        
//        while(iterator.hasNext()){
//        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
//        	if(multipartFile.isEmpty() == false){
//        		originalFileName = multipartFile.getOriginalFilename();
//        		
//        		System.out.println("===================================");
//        		System.out.println("originalFileName=>"+originalFileName);
//        		System.out.println("===================================");
//        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
//        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
//        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
//        		
//        		file = new File(oldfilePath + storedFileName);
//        		multipartFile.transferTo(file);
//        		
//        		FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);
//
//        		file.delete();
//                 
//        		listMap = new HashMap<String,Object>();
//        		listMap.put("sPoNo", sPoNo);
//        		listMap.put("sItemCode", sItemCode);
//        		listMap.put("sSeq", sSeq);
//        		listMap.put("sDegree", sDegree);
//        		listMap.put("sIndex", sIndex);
//        		listMap.put("fileSeq", fileSeq);
//        		listMap.put("sUserId", sUserId);
//        		
//        		//listMap.put("BOARD_IDX", boardIdx);
//        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
//        		listMap.put("STORED_FILE_NAME", storedFileName);
//        		listMap.put("FILE_SIZE", multipartFile.getSize());
//        		
//        		list.add(listMap);
//        	}
//        }
//		return list;
//	}
	
	public List<Map<String,Object>> parseProdInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String oldattach_path = "resources/upload/prod/file/";
	    String attach_path = "resources/upload/prod/";
	    
	    oldfilePath= root_path+oldattach_path;
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String originalFileExtension1 = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        
        String sPoNo =  (String)map.get("sPoNo");
    	String sItemCode =  (String)map.get("sItemCode");
    	String sSeq =  (String)map.get("sSeq");
    	String sDegree =  (String)map.get("sDegree");
    	String sIndex =  (String)map.get("sIndex");
    	String fileSeq = (String)map.get("fileSeq");
    	String sUserId = (String)map.get("sUserId");
    	
        File file = new File(oldfilePath);
        File file1 = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(file1.exists() == false){
        	file1.mkdirs();
        }
        
        
        
        int fseq = 0;
        int sIndexCnt = 1;
        
        fseq = Integer.parseInt(fileSeq);
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(oldfilePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);

        		file.delete();
                
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("sPoNo", sPoNo);
        		listMap.put("sItemCode", sItemCode);
        		listMap.put("sSeq", sSeq);
        		listMap.put("sDegree", sDegree);
        		System.out.println("=================================== sIndexCnt : " + sIndexCnt);
        		if("".equals(sIndex) || sIndex == null)
        		{
        			listMap.put("sIndex", sIndexCnt);
        			sIndexCnt++;
        			
        		}
        		else
        		{
        			listMap.put("sIndex", sIndex);
        		}
        		
        		listMap.put("fileSeq", fseq);
        		listMap.put("sUserId", sUserId);
        		
        		fseq++;
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		
        		list.add(listMap);
        	}
        }
		return list;
	}
	
	public List<Map<String,Object>> parseSoInsertFile01Info(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String oldattach_path = "resources/upload/so/file/";
	    String attach_path = "resources/upload/so/";
	    
	    String pSoNo =  (String)map.get("pSoNo");
    	String pBoardIdx =  (String)map.get("pBoardIdx");
    	
    	System.out.println("pBoardIdx === > " + pBoardIdx);
	    if("51".equals(pBoardIdx) || "52".equals(pBoardIdx) )
    	{
    		oldattach_path = "resources/upload/so/";
		}
	    
	    oldfilePath= root_path+oldattach_path;
	    filePath = root_path+attach_path;

	    
	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String originalFileExtension1 = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        
        
    	
    	
	
    	String sUserId = (String)map.get("sUserId");
    	
        File file = new File(oldfilePath);
        File file1 = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(file1.exists() == false){
        	file1.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			file = new File(oldfilePath + storedFileName);
        		}
        		else
        		{
        			file = new File(filePath + storedFileName);
        		}
        		
        		multipartFile.transferTo(file);
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);
        			file.delete();
        		}

        		
                 
        		listMap = new HashMap<String,Object>();
        		listMap.put("pSoNo", pSoNo);
        		listMap.put("pBoardIdx", pBoardIdx);
        		listMap.put("sUserId", sUserId);
        		
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		
        		list.add(listMap);
        	}
        }
    	return list;
    }
	
	public List<Map<String,Object>> parseSoInsertNctFile01Info(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String oldattach_path = "resources/upload/nctso/file/";
	    String attach_path = "resources/upload/nctso/";
	    
	    String pSoNo =  (String)map.get("pSoNo");
    	String pBoardIdx =  (String)map.get("pBoardIdx");
    	
    	System.out.println("pBoardIdx === > " + pBoardIdx);
	    if("51".equals(pBoardIdx) || "52".equals(pBoardIdx) )
    	{
    		oldattach_path = "resources/upload/nctso/";
		}
	    
	    oldfilePath= root_path+oldattach_path;
	    filePath = root_path+attach_path;

	    
	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String originalFileExtension1 = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        
        
    	
    	
	
    	String sUserId = (String)map.get("sUserId");
    	
        File file = new File(oldfilePath);
        File file1 = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(file1.exists() == false){
        	file1.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			file = new File(oldfilePath + storedFileName);
        		}
        		else
        		{
        			file = new File(filePath + storedFileName);
        		}
        		
        		multipartFile.transferTo(file);
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);
        			file.delete();
        		}

        		
                 
        		listMap = new HashMap<String,Object>();
        		listMap.put("pSoNo", pSoNo);
        		listMap.put("pBoardIdx", pBoardIdx);
        		listMap.put("sUserId", sUserId);
        		
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		
        		list.add(listMap);
        	}
        }
    	return list;
    }
	
	
	public List<Map<String,Object>> parsePoInsertFile01Info(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String oldattach_path = "resources/upload/po/report/";
	    String attach_path = "resources/upload/po/";
	    
	    String pPoNo =  (String)map.get("pPoNo");
    	String pBoardIdx =  (String)map.get("pBoardIdx");
    	
    	System.out.println("pBoardIdx === > " + pBoardIdx);
	    if("51".equals(pBoardIdx) || "52".equals(pBoardIdx) )
    	{
    		oldattach_path = "resources/upload/po/";
		}
	    
	    oldfilePath= root_path+oldattach_path;
	    filePath = root_path+attach_path;

	    
	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String originalFileExtension1 = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        
        
    	
    	
	
    	String sUserId = (String)map.get("sUserId");
    	
        File file = new File(oldfilePath);
        File file1 = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(file1.exists() == false){
        	file1.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			file = new File(oldfilePath + storedFileName);
        		}
        		else
        		{
        			file = new File(filePath + storedFileName);
        		}
        		
        		multipartFile.transferTo(file);
        		
        		if(!"51".equals(pBoardIdx) && !"52".equals(pBoardIdx) )
        		{
        			FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);
        			file.delete();
        		}

        		
                 
        		listMap = new HashMap<String,Object>();
        		listMap.put("pPoNo", pPoNo);
        		listMap.put("pBoardIdx", pBoardIdx);
        		listMap.put("sUserId", sUserId);
        		
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		
        		list.add(listMap);
        	}
        }
    	return list;
    }
    
    public List<Map<String,Object>> parseInsertSoFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
    		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String oldattach_path = "resources/upload/so/file/";
	    String attach_path = "resources/upload/so/";
	    
	    oldfilePath= root_path+oldattach_path;
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String originalFileExtension1 = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        
        String pSoNo =  (String)map.get("pSoNo");
    	String sUserId = (String)map.get("sUserId");
    	
        File file = new File(oldfilePath);
        File file1 = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(file1.exists() == false){
        	file1.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		originalFileExtension1 = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(oldfilePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		FileUtils.imageResize(oldfilePath + storedFileName, filePath + storedFileName, originalFileExtension1);

        		file.delete();
                 
        		listMap = new HashMap<String,Object>();
        		listMap.put("SO_NO", pSoNo);
        		listMap.put("sUserId", sUserId);
        		
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		
        		list.add(listMap);
        	}
        }
		return list;
	}
	
	public static void imageResize(String orgFilePath, String targetFilePath, String imageType) throws Exception{
		System.out.println("imageResize Start == > ");
		System.out.println("orgFilePath == > " +orgFilePath);
		System.out.println("targetFilePath == > " +targetFilePath);
		System.out.println("imageType == > " +imageType);
		
		
		BufferedImage originalImage = ImageIO.read(new File(orgFilePath));

		int imgwidth = Math.min(originalImage.getHeight(),  originalImage.getWidth());

		int imgheight = imgwidth;

		BufferedImage scaledImage = Scalr.crop(originalImage, (originalImage.getWidth() - imgwidth)/2, (originalImage.getHeight() - imgheight)/2, imgwidth, imgheight, null);

		BufferedImage resizedImage = Scalr.resize(scaledImage, 1000, 1000, null);

		ImageIO.write(resizedImage, imageType, new File(targetFilePath));

	}
	
	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        String boardIdx = (String)map.get("IDX");
        String requestName = null;
        String idx = null;
        
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		multipartFile.transferTo(new File(filePath + storedFileName));
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("IS_NEW", "Y");
        		listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        	else{
        		requestName = multipartFile.getName();
            	idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
            	if(map.containsKey(idx) == true && map.get(idx) != null){
            		listMap = new HashMap<String,Object>();
            		listMap.put("IS_NEW", "N");
            		listMap.put("FILE_IDX", map.get(idx));
            		list.add(listMap);
            	}
        	}
        }
		return list;
	}
	
	public List<Map<String,Object>> parseCrameInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		
		String root_path = request.getSession().getServletContext().getRealPath("/");  
	    String attach_path = "resources/upload/crame/";
	
	    filePath = root_path+attach_path;

	    System.out.println("filePath=====> " + filePath);
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        //String boardIdx = (String)map.get("BOARD_IDX");
        String soNo = (String)map.get("sSoNo");
        String idx = (String)map.get("sIDX");
        
        File file = new File(filePath);
        
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		
        		System.out.println("===================================");
        		System.out.println("originalFileName=>"+originalFileName);
        		System.out.println("===================================");
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(filePath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("SO_NO", soNo);
        		listMap.put("IDX", "0000");
        		//listMap.put("BOARD_IDX", boardIdx);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
}
