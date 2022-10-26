package com.CherryPicker.web.common.util;
import java.awt.Color;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExcelXlsxDownloadView extends ExcelCustomView {

	private static final Logger logger = LoggerFactory.getLogger(ExcelXlsxDownloadView.class);
	
	@SuppressWarnings("unchecked")
	public void buildExcelDocument(Map<String, Object> model, XSSFWorkbook workbook,
			HttpServletRequest req, HttpServletResponse res) throws Exception 
	{		
		logger.info("---- {} ----", "ExcelXlsxDownloadView.buildPdfDocument()");	
		
		// 파일명
		String fileName = (String)model.get("fileName");
		
		// 헤더설정
		String userAgent = req.getHeader("User-Agent");
		if (userAgent.indexOf("MSIE") > -1) {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}		
		res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
			
		HashMap<String,Object> map = (HashMap<String,Object>)model.get("dataMap");
		String multi = (String)model.get("multi");		
		if (multi != null) {			
			for (int i = 0; i < Integer.parseInt(multi); i++) {				
				// 시트명
				String sheetName = (String)model.get("sheetName"+i);
				XSSFSheet sheet = createFirstSheet(workbook, sheetName, i);
				
				// 라벨명
				String labels[] = (String[])model.get("labels"+i);
				int columnWidth[] = (int[])model.get("columnWidth"+i);
				
				createColumnLabel(sheet, workbook, labels, columnWidth);
								
				List<HashMap<String,String>> list = (List<HashMap<String,String>>)map.get("dataList"+i);
				int length = (Integer)map.get("dataLength"+i);
				createPageRow(sheet, list, length, workbook);			
			}
		} else {
			// 시트명
			String sheetName = (String)model.get("sheetName");
			XSSFSheet sheet = createFirstSheet(workbook, sheetName, 0);
			
			// 라벨명
			String labels[] = (String[])model.get("labels");
			int columnWidth[] = (int[])model.get("columnWidth");
			
			createColumnLabel(sheet, workbook, labels, columnWidth);
			
			// 데이터			
			List<HashMap<String,String>> list = (List<HashMap<String,String>>)map.get("dataList");
			int length = (Integer)map.get("dataLength");
			createPageRow(sheet, list, length, workbook);
		}
		
	}
	
	//시트생성
	private XSSFSheet createFirstSheet(XSSFWorkbook workbook, String sheetName, int i) 
	{
		XSSFSheet sheet = workbook.createSheet();
		
		workbook.setSheetName(i, sheetName);
		//sheet.setColumnWidth(1, 256 * 30);
		
		return sheet;
	}

	//라벨(제목)생성
	private void createColumnLabel(XSSFSheet sheet, XSSFWorkbook workbook, String[] list, int[] columnWidth) 
	{
		// 속성
		XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
        
		Font font = workbook.createFont();
        font.setFontName("ARIAL");
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        font.setFontHeightInPoints((short) 10);
        font.setColor(IndexedColors.WHITE.getIndex());
        
        cellStyle.setFont(font);
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setFillForegroundColor(new XSSFColor(Color.decode("#2080D0")));
        cellStyle.setFillPattern((short) CellStyle.SOLID_FOREGROUND);        
        cellStyle.setBorderTop(CellStyle.BORDER_THIN);
        cellStyle.setTopBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setLeftBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setRightBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        cellStyle.setBottomBorderColor(IndexedColors.WHITE.getIndex());
        
        // 라벨
		XSSFRow firstRow = sheet.createRow(0);
		
		short width = 265;
		 
		for (int i = 0; i < list.length; i++) {
			XSSFCell cell = firstRow.createCell(i);
			if (columnWidth.length > 0) {
				sheet.setColumnWidth(i, (columnWidth[i] * width));
			}
			cell.setCellValue(list[i]);
			cell.setCellStyle(cellStyle);
		}		
	}

	//데이터 행생성
	private void createPageRow(XSSFSheet sheet, List<HashMap<String,String>> list, int length, XSSFWorkbook workbook)
	{		
		/*
		XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
        
		Font font = workbook.createFont();
        font.setFontName("ARIAL");
        font.setBoldweight(font.BOLDWEIGHT_BOLD);
        font.setFontHeightInPoints((short) 8);
        font.setColor(IndexedColors.WHITE.getIndex());
        
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setFillForegroundColor(new XSSFColor(Color.decode("#C0E0FF")));
        cellStyle.setFillPattern((short) CellStyle.SOLID_FOREGROUND);        
        cellStyle.setBorderTop(CellStyle.BORDER_THIN);
        cellStyle.setTopBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setLeftBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setRightBorderColor(IndexedColors.WHITE.getIndex());        
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        cellStyle.setBottomBorderColor(IndexedColors.WHITE.getIndex());
		 */

        if (list != null && list.size() >0) {
	        for (int i = 0; i <= list.size() - 1; i++) {	
	        	XSSFRow row = sheet.createRow(i + 1);
	        	HashMap<String,String> vo = (HashMap<String, String>)list.get(i);
	        	
	        	for (int j = 0; j < length; j++) {
	        		XSSFCell cell = row.createCell(j);
	        		
	        		String sn = nvl(vo.get("row"+(i+1)+"_cell_color_"+(j+1)));	        			        			
        			if(!"".equals(sn)) {
	        			int n = Integer.parseInt(sn);
	        			
	        			Font font = workbook.createFont();
	        	        font.setFontName("ARIAL");		        	        
	        	        font.setFontHeightInPoints((short) 8);		        	       
	        			font.setColor((short) n);
	        			
	        			XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
	        	        
	        	        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
	        	        cellStyle.setFillForegroundColor(new XSSFColor(Color.decode("#FFFFFF")));
	        	        cellStyle.setFillPattern((short) CellStyle.SOLID_FOREGROUND);        
	        	        cellStyle.setBorderTop(CellStyle.BORDER_THIN);
	        	        cellStyle.setTopBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
	        	        cellStyle.setLeftBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
	        	        cellStyle.setRightBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
	        	        cellStyle.setBottomBorderColor(IndexedColors.WHITE.getIndex());
	        			
	        	        cellStyle.setFont(font);
	        			cell.setCellStyle(cellStyle);
        			} else {
	        			Font font = workbook.createFont();
	        	        font.setFontName("ARIAL");		        	        
	        	        font.setFontHeightInPoints((short) 10);		        	       
	        			
	        			XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
	        	        
	        	        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
	        	        cellStyle.setFillForegroundColor(new XSSFColor(Color.decode("#FFFFFF")));
	        	        cellStyle.setFillPattern((short) CellStyle.SOLID_FOREGROUND);        
	        	        cellStyle.setBorderTop(CellStyle.BORDER_THIN);
	        	        //cellStyle.setTopBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
	        	        //cellStyle.setLeftBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
	        	        //cellStyle.setRightBorderColor(IndexedColors.WHITE.getIndex());        
	        	        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
	        	        //cellStyle.setBottomBorderColor(IndexedColors.WHITE.getIndex());
	        			
	        	        cellStyle.setFont(font);
	        			cell.setCellStyle(cellStyle);
	        		}
	        		
	        		cell.setCellValue(vo.get("row"+(i+1)+"_cell"+(j+1)));        		
	        		
				}          	
	        }
        } 
	}
	
	public static String nvl(String str, String replace) {
		if (str == null) {
			return replace;
		} else {
			return str;
		}
	}
	
	public static String nvl(String str) {		
		return nvl(str, "");
	}
}
