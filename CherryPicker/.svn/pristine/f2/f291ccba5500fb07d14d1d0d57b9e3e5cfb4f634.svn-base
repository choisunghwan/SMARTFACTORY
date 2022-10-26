package com.CherryPicker.web.common.util;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import com.CherryPicker.web.common.util.FileUtil;
import com.CherryPicker.web.common.util.PropertiesUtil;
import com.CherryPicker.web.common.util.ThumnailUtil;

@SuppressWarnings({"unchecked", "rawtypes"})
public class ParamMap extends LinkedHashMap {
	private static final long serialVersionUID = -2188356521146906457L;
	private Logger logger = Logger.getLogger(ParamMap.class);

	/**
	 * Parameter Set && File upload
	 * **********************************
	 * org_file_name : 실제 파일 이름
	 * upload_file_name : 업로드 파일 이름
	 * thum_list_file_name : 이미지 썸네일 목록 파일 이름
	 * thum_view_file_name : 이미지 썸네일 상세 파일 이름
	 * input_name : input_name
	 * upload_path : 업로드 경로
	 * file_ext : 파일 확장자
	 * file_size : 파일 크기
	 * file_type : 파일 타입
	 * display_order : 파일 순서
	 * img_width : 이미지 가로
	 * img_height : 이미지 세로
	 * **********************************
	 * @param request
	 */
	public void parseRequest(HttpServletRequest request) {
		parseRequestMapping(request, "Y");
	}
	
	/**
	 * Parameter Set && User define File upload
	 * @param request
	 * @param fileYN
	 */
	public void parseRequest(HttpServletRequest request, String fileYN) {
		parseRequestMapping(request, fileYN);
	}
	
	private void parseRequestMapping(HttpServletRequest request, String fileYN) {
		// Parameter
		Enumeration en = request.getParameterNames();
		String param = null;
		String[] values = null;
		while (en.hasMoreElements()) {
			param = (String) en.nextElement();
			values = request.getParameterValues(param);
			if (values.length == 1) {
				put(param, values[0]);
			} else {
				String valueArray[] = new String[values.length];
				for(int i = 0; i < values.length; i++) {
					valueArray[i] = values[i];
				}
				put(param, valueArray);
			}
		}
		
		// 첨부파일
		if("Y".equals(fileYN)) {
			if (request.getContentType() != null && request.getContentType().indexOf("multipart/form-data") != -1) {
				try{
					List fileList = getFileInfoList((MultipartHttpServletRequest)request);
					put("fileList", fileList);
				}catch(Exception e){}
			}
		}
		
//System.out.println("USER_SEQ_L : "+ WebUtils.getSessionAttribute(request, "USER_SEQ_L"));
		
		//Session 정보 확인 paramMap mapping
		if(WebUtils.getSessionAttribute(request, "USER_SEQ_L") != null && !"".equals(WebUtils.getSessionAttribute(request, "USER_SEQ_L") ) )
		{
			put( "USER_SEQ_L", WebUtils.getSessionAttribute(request, "USER_SEQ_L"));
			put( "USER_NO_L", WebUtils.getSessionAttribute(request, "USER_NO_L"));
			put( "USER_NM_L", WebUtils.getSessionAttribute(request, "USER_NM_L"));
			put( "USER_TP_L", WebUtils.getSessionAttribute(request, "USER_TP_L"));
			put( "DEPT_SEQ_L", WebUtils.getSessionAttribute(request, "DEPT_SEQ_L"));
			put( "DEPT_CD_L", WebUtils.getSessionAttribute(request, "DEPT_CD_L"));
			put( "DEPT_NM_L", WebUtils.getSessionAttribute(request, "DEPT_NM_L"));
			put( "STD_GRADE_L", WebUtils.getSessionAttribute(request, "STD_GRADE_L"));
			put( "USER_MOBILE_L", WebUtils.getSessionAttribute(request, "USER_MOBILE_L"));
			put( "USER_EMAIL_L", WebUtils.getSessionAttribute(request, "USER_EMAIL_L"));
			put( "LOGIN_TP_L", WebUtils.getSessionAttribute(request, "LOGIN_TP_L"));
			put( "MNGER_YN_L", WebUtils.getSessionAttribute(request, "MNGER_YN_L"));
		}
		
	}
	
	/**
	 * Parameter Set && File upload
	 * **********************************
	 * org_file_name : 실제 파일 이름
	 * upload_file_name : 업로드 파일 이름
	 * thum_list_file_name : 이미지 썸네일 목록 파일 이름
	 * thum_view_file_name : 이미지 썸네일 상세 파일 이름
	 * input_name : input_name
	 * upload_path : 업로드 경로
	 * file_ext : 파일 확장자
	 * file_size : 파일 크기
	 * file_type : 파일 타입
	 * display_order : 파일 순서
	 * img_width : 이미지 가로
	 * img_height : 이미지 세로
	 * **********************************
	 * @param request
	 */
	public void parseRequestCleanXss(HttpServletRequest request) {
		parseRequestMappingCleanXss(request, "Y");
	}
	
	/**
	 * Parameter Set && User define File upload
	 * @param request
	 * @param fileYN
	 */
	public void parseRequestCleanXss(HttpServletRequest request, String fileYN) {
		parseRequestMappingCleanXss(request, fileYN);
	}
	
	private void parseRequestMappingCleanXss(HttpServletRequest request, String fileYN) {
		// Parameter
		Enumeration en = request.getParameterNames();
		String param = null;
		String[] values = null;
		while (en.hasMoreElements()) {
			param = (String) en.nextElement();
			values = request.getParameterValues(param);
			if (values.length == 1) {
				
				values[0] = values[0].replaceAll("<", "&lt;").replaceAll(">", "&gt;");
				values[0] = values[0].replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
				values[0] = values[0].replaceAll("'", "&#39;");
				values[0] = values[0].replaceAll("eval\\((.*)\\)", "");
				values[0] = values[0].replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
				values[0] = values[0].replaceAll("script", "");
				
				put(param, values[0]);
			} else {
				String valueArray[] = new String[values.length];
				for(int i = 0; i < values.length; i++) {
					valueArray[i] = values[i];

					values[i] = values[i].replaceAll("<", "&lt;").replaceAll(">", "&gt;");
					values[i] = values[i].replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
					values[i] = values[i].replaceAll("'", "&#39;");
					values[i] = values[i].replaceAll("eval\\((.*)\\)", "");
					values[i] = values[i].replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
					values[i] = values[i].replaceAll("script", "");
				}
				put(param, valueArray);
			}
		}
		
		// 첨부파일
		if("Y".equals(fileYN)) {
			if (request.getContentType() != null && request.getContentType().indexOf("multipart/form-data") != -1) {
				List fileList = getFileInfoList((MultipartHttpServletRequest)request);
				put("fileList", fileList);
			}
		}

//		System.out.println("USER_SEQ_L : "+ WebUtils.getSessionAttribute(request, "USER_SEQ_L"));
		
		//Session 정보 확인 paramMap mapping
		if(WebUtils.getSessionAttribute(request, "USER_SEQ_L") != null && !"".equals(WebUtils.getSessionAttribute(request, "USER_SEQ_L") ) )
		{
			put( "USER_SEQ_L", WebUtils.getSessionAttribute(request, "USER_SEQ_L"));
			put( "USER_NO_L", WebUtils.getSessionAttribute(request, "USER_NO_L"));
			put( "USER_NM_L", WebUtils.getSessionAttribute(request, "USER_NM_L"));
			put( "USER_TP_L", WebUtils.getSessionAttribute(request, "USER_TP_L"));
			put( "DEPT_SEQ_L", WebUtils.getSessionAttribute(request, "DEPT_SEQ_L"));
			put( "DEPT_CD_L", WebUtils.getSessionAttribute(request, "DEPT_CD_L"));
			put( "DEPT_NM_L", WebUtils.getSessionAttribute(request, "DEPT_NM_L"));
			put( "STD_GRADE_L", WebUtils.getSessionAttribute(request, "STD_GRADE_L"));
			put( "USER_MOBILE_L", WebUtils.getSessionAttribute(request, "USER_MOBILE_L"));
			put( "USER_EMAIL_L", WebUtils.getSessionAttribute(request, "USER_EMAIL_L"));
			put( "LOGIN_TP_L", WebUtils.getSessionAttribute(request, "LOGIN_TP_L"));
			put( "MNGER_YN_L", WebUtils.getSessionAttribute(request, "MNGER_YN_L"));			
		}		
		
	}	
	
	
	/**
	 * 파일 업로드 및 정보를 가져온다.
	 * @param mpRequest
	 * @return
	 */
	private	 List getFileInfoList(MultipartHttpServletRequest mpRequest) {
		ArrayList fileList = new ArrayList(); // 파일 목록		
		Iterator fileNames = null; // 파일 이름	
		String formName = null; // 폼 이름
		MultipartFile formFile = null; // 폼 파일
		
		fileNames = mpRequest.getFileNames();
		while (fileNames.hasNext()){
			formName = (String) fileNames.next();
			formFile = mpRequest.getFile(formName);
			int fileNum = 99;
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			logger.debug("formName : " + formName);
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

			if(!formFile.isEmpty()) {
				String fileExt = FilenameUtils.getExtension(formFile.getOriginalFilename()); // 파일 확장자
				String fileType = StringUtils.defaultString(formFile.getContentType(), ""); // 파일 타입
				String limitKeyName = ""; // 파일 용량 제한 key name
				String extKeyName = ""; // 파일 허용 확장자 key name
				String listThumnailKeyName = ""; // list 썸네일 key name
				String viewThumnailKeyName = ""; // view 썸네일 key name
				String inputNames[] = formFile.getName().split("_"); // input names
				String inputName = "";
				
				if(inputNames != null && inputNames.length > 0) {
					for(int i = 0; i < inputNames.length; i++) {
						if(i == inputNames.length - 1) {
							try {
								fileNum = Integer.parseInt(inputNames[i]);
								inputName = StringUtils.substring(inputName, 0, inputName.length() - 1);
							} catch (Exception e) {
								inputName += inputNames[i];
							}
						} else {
							inputName += inputNames[i];
							inputName += "_";
						}
					}
				} else {
					inputName = "default";
				}
				
				if(fileType.contains("image")) {		
					limitKeyName = inputName + "_image_limit";
					extKeyName = inputName + "_image_ext";
					listThumnailKeyName = inputName + "_thum_list";
					viewThumnailKeyName = inputName + "_thum_view";
				} else if(fileType.contains("video")) {	
					limitKeyName = inputName + "_video_limit";
					extKeyName = inputName + "_video_ext";
				} else {								
					limitKeyName = inputName + "_etc_limit";
					extKeyName = inputName + "_etc_ext";
				}
				
				if(StringUtils.isEmpty(PropertiesUtil.getValue(limitKeyName))) {
					limitKeyName = limitKeyName.replaceAll(inputName, "default");
				}
				if(StringUtils.isEmpty(PropertiesUtil.getValue(extKeyName))) {
					extKeyName = extKeyName.replaceAll(inputName, "default");
				}
				if(StringUtils.isEmpty(PropertiesUtil.getValue(listThumnailKeyName))) {
					listThumnailKeyName = listThumnailKeyName.replaceAll(inputName, "default");
				}
				if(StringUtils.isEmpty(PropertiesUtil.getValue(viewThumnailKeyName))) {
					viewThumnailKeyName = viewThumnailKeyName.replaceAll(inputName, "default");
				}
				
				// step 1 - 파일 허용 확장자 확인
				if(!"ENC".equals(PropertiesUtil.getValue(extKeyName))) {
					String fileAccessExt = PropertiesUtil.getValue(extKeyName);
					if(fileAccessExt.toUpperCase().indexOf(fileExt.toUpperCase()) == -1) {
						put("fileErrorMsg", "[" + fileExt + "] 확장자는 등록하실 수 없습니다.");
						put("fileErrorNum", "0");
						break;
					}
				}
				
				// step 2 - 파일 용량 제한 확인
				if(PropertiesUtil.getLongValue(limitKeyName) != -1) {
					long fileAccessSize = PropertiesUtil.getLongValue(limitKeyName);
					if(formFile.getSize() > fileAccessSize) {
						put("fileErrorMsg", "파일 제한 용량을 초과하여 등록하실 수 없습니다.");
						put("fileErrorNum", "1");
						break;
					}
				}
				
				// step 3 - file upload
				ParamMap fileMap = FileUtil.upload(formFile, PropertiesUtil.getValue("upload_root"));
				
				if(fileMap != null) {
					fileMap.put("display_order", fileNum);
					
					// step 4 - 이미지일 경우 썸네일 생성
					if(fileType.contains("image")) {
						String sizeArr[] = null;
						String filePath = fileMap.getString("upload_path"); // 업로드 경로
						String uploadFileName = fileMap.getString("upload_file_name"); // 업로드 파일 명
						
						// 목록용 썸네일
						if(!"-1".equals(PropertiesUtil.getValue(listThumnailKeyName))) {
							sizeArr = PropertiesUtil.getValue(listThumnailKeyName).split(",");
							if("-1".equals(sizeArr[0]) || "-1".equals(sizeArr[1])) {
								new ThumnailUtil(fileMap, filePath, uploadFileName, Integer.parseInt(sizeArr[0].trim()), Integer.parseInt(sizeArr[1].trim()), "L", false);
							} else {
								new ThumnailUtil(fileMap, filePath, uploadFileName, Integer.parseInt(sizeArr[0].trim()), Integer.parseInt(sizeArr[1].trim()), "L", true);
							}
						}
						
						// 상세용 썸네일
						if(!"-1".equals(PropertiesUtil.getValue(viewThumnailKeyName))) {
							sizeArr = PropertiesUtil.getValue(viewThumnailKeyName).split(",");
							if("-1".equals(sizeArr[0]) || "-1".equals(sizeArr[1])) {
								new ThumnailUtil(fileMap, filePath, uploadFileName, Integer.parseInt(sizeArr[0].trim()), Integer.parseInt(sizeArr[1].trim()), "V", false);
							} else {
								new ThumnailUtil(fileMap, filePath, uploadFileName, Integer.parseInt(sizeArr[0].trim()), Integer.parseInt(sizeArr[1].trim()), "V", true);
							}
						}
					}
					
					logger.debug("########################################################################");
					logger.debug("org_file_name : " + fileMap.getString("org_file_name"));
					logger.debug("upload_file_name : " + fileMap.getString("upload_file_name"));
					logger.debug("thum_list_file_name : " + fileMap.getString("thum_list_file_name"));
					logger.debug("thum_view_file_name : " + fileMap.getString("thum_view_file_name"));
					logger.debug("input_name : " + fileMap.getString("input_name"));
					logger.debug("upload_path : " + fileMap.getString("upload_path"));
					logger.debug("file_ext : " + fileMap.getString("file_ext"));
					logger.debug("file_size : " + fileMap.getString("file_size"));
					logger.debug("file_type : " + fileMap.getString("file_type"));
					logger.debug("display_order : " + fileMap.getString("display_order"));
					logger.debug("img_width : " + fileMap.getString("img_width"));
					logger.debug("img_height : " + fileMap.getString("img_height"));
					logger.debug("########################################################################");
					
					fileList.add(fileMap);
				}
			}
		}
		
		return fileList;
	}
	
	/**
	 * data type 에 따른 String 변환
	 * @param obj
	 * @return
	 */
	public String getStringValue(Object obj) {
		String sValue = "";
		try {
			if (obj instanceof String) {
				sValue = ((String) obj);
			} else if (obj instanceof String[]) {
				String temp[] = (String[])obj;
				for(int i = 0; i < temp.length; i++) {
					sValue += temp[i];
					if(i != temp.length - 1) {
						sValue += ",";
					}
				}
			} else if (obj instanceof BigDecimal) {
				sValue = ((BigDecimal) obj).toString();
			} else if (obj instanceof Integer) {
				sValue = ((Integer) obj).toString();
			} else if (obj instanceof Long) {
				sValue = ((Long) obj).toString();
			} else if (obj instanceof Double) {
				sValue = ((Double) obj).toString();
			} else {
				sValue = "";
			}
		} catch (Exception e) {
			sValue = "";
			e.getStackTrace();
		}
		
		return sValue;
	}

	/**
	 * key 값에 해당하는 value 값을 String 타입으로 반환
	 * @param key
	 * @return
	 */
	public String getString(String key) {
		String sValue = "";
		Object obj = null;
		try {
			obj = get(key);
			sValue = getStringValue(obj);
		}
		catch (Exception e) {
			sValue = "";
			e.getStackTrace();
		}
		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 String 타입으로 반환
	 * key 가 존재 하지 않을 경우 지정 값을 리턴
	 * @param key
	 * @param dValue
	 * @return
	 */
	public String getString(String key, String dValue) {
		String sValue = "";
		Object obj = null;
		try {
			obj = get(key);
			sValue = obj == null || obj.equals("")? dValue : getStringValue(obj);
		}
		catch (Exception e) {
			sValue = "";
			e.getStackTrace();
		}
		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 String[] 타입으로 반환
	 * @param key
	 * @return
	 */
	public String[] getStrings(String key) {
		String sValues[] = null;
		Object obj = null;
		try {
			obj = get(key);
			if (obj instanceof String) {
				sValues = new String[1];
				sValues[0] = (String)obj;
			}
			else {
				sValues = (String[]) obj;
			}
		}
		catch (Exception e) {
			sValues = null;
			e.getStackTrace();
		}

		return sValues;
	}
	
	/**
	 * key 값에 해당하는 value 값을 int 타입으로 반환
	 * @param key
	 * @return
	 */
	public int getInt(String key) {
		int sValue = -1;
		Object obj = null;

		try {
			obj = get(key);
			
			sValue = Integer.parseInt(getStringValue(obj));
		}
		catch (Exception e) {
			sValue = -1;
			e.getStackTrace();
		}

		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 int 타입으로 반환
	 * key 가 존재 하지 않을 경우 지정 값을 리턴
	 * @param key
	 * @return
	 */
	public int getInt(String key, int dValue) {
		int sValue = -1;
		Object obj = null;
		try {
			obj = get(key);
			sValue = obj == null || obj.equals("")? dValue : Integer.parseInt(getStringValue(obj));
		}
		catch (Exception e) {
			sValue = -1;
			e.getStackTrace();
		}
		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 double 타입으로 반환
	 * @param key
	 * @return
	 */
	public double getDouble(String key) {
		double sValue = -1d;
		Object obj = null;
		try {
			obj = get(key);
			sValue = Double.parseDouble(getStringValue(obj));
		}
		catch (Exception e) {
			sValue = -1d;
			e.getStackTrace();
		}
		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 double 타입으로 반환
	 * key 가 존재 하지 않을 경우 지정 값을 리턴
	 * @param key
	 * @param dValue
	 * @return
	 */
	public double getDouble(String key, double dValue) {
		double sValue = -1d;
		Object obj = null;
		try {
			obj = get(key);
			sValue = obj == null || obj.equals("")? dValue : Double.parseDouble(getStringValue(obj));
		}
		catch (Exception e) {
			sValue = -1;
			e.getStackTrace();
		}
		return sValue;
	}
	
	/**
	 * key 값에 해당하는 value 값을 java.util.Date 타입으로 반환
	 * @param key
	 * @param dValue
	 * @return
	 */
	public Date getDate(String key) {
		Date date = new Date();
		Object obj = null;
		try {
			obj = get(key);
			if (obj instanceof java.sql.Date) {
				return (Date)obj;
			}
		}
		catch (Exception e) {
			date = new Date();
			e.getStackTrace();
		}
		return date;
	}
	
	/**
	 * key 목록
	 * @return
	 */
	public ArrayList getStringKeys() {
		HashMap hm = this;
		ArrayList keys = new ArrayList();
		for (Iterator i = hm.keySet().iterator(); i.hasNext();) {
			Object key = (Object) i.next();
			keys.add(key);
		}
		return keys;
	}
}

