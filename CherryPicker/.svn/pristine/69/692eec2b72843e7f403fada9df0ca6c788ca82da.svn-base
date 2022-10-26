package com.CherryPicker.web.common.util;

 
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

 
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.CherryPicker.web.common.CommandMap;
 
public class ExcelView extends AbstractExcelPOIView {
	 
    @SuppressWarnings("unchecked")
    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
        String target = "books";//model.get("target").toString();
        
        System.out.println("buildExcelDocument Start ==========> ");
        //target�� ���� ���� ���� �ۼ��� �б��Ѵ�.
        if(target.equals("books")){
            //Object�� �Ѿ�� ���� �� Model�� �°� ����ȯ ���ش�.
            //ist<Books> listBooks = (List<Books>) model.get("excelList");
 
            //Sheet ����
            Sheet sheet = workbook.createSheet(target);
            Row row = null;
            int rowCount = 0;
            int cellCount = 0;
 
            // ���� Cell ����
            row = sheet.createRow(rowCount++);
 
            row.createCell(cellCount++).setCellValue("id");
            row.createCell(cellCount++).setCellValue("name");
            row.createCell(cellCount++).setCellValue("writer");
 
            // ������ Cell ����
//            for (Books book : listBooks) {
//                row = sheet.createRow(rowCount++);
//                cellCount = 0;
//                row.createCell(cellCount++).setCellValue(book.getId()); //�����͸� ������ �Է�
//                row.createCell(cellCount++).setCellValue(book.getName());
//                row.createCell(cellCount++).setCellValue(book.getWriter());
// 
//            }
 
        }
 
        if(target.equals("booksDetail")){
 
//            List<BooksDetail> booksDetailList = (List<BooksDetail>) model.get("excelList");
 
            //Sheet ����
            Sheet sheet = workbook.createSheet(target);
            Row row = null;
            int rowCount = 0;
            int cellCount = 0;
 
            // ���� Cell ����
            row = sheet.createRow(rowCount++);
 
            row.createCell(cellCount++).setCellValue("detail_id");
            row.createCell(cellCount++).setCellValue("id");
            row.createCell(cellCount++).setCellValue("publish_date");
            row.createCell(cellCount++).setCellValue("best_seller_yn");
 
            // ������ Cell ����
//            for (BooksDetail bookDetail : booksDetailList) {
//                row = sheet.createRow(rowCount++);
//                cellCount = 0;
//                row.createCell(cellCount++).setCellValue(bookDetail.getDetail_id());
//                row.createCell(cellCount++).setCellValue(bookDetail.getId());
//                row.createCell(cellCount++).setCellValue(bookDetail.getPublish_date());
//                row.createCell(cellCount++).setCellValue(bookDetail.getBest_seller_yn());
// 
//            }
 
        }
 
    }
 
    @Override
    protected Workbook createWorkbook() {
        return new XSSFWorkbook();
    }
 
}