package com.CherryPicker.web.common.util;

 
import java.util.Map;
 
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

import com.CherryPicker.web.common.CommandMap;
 
public abstract class AbstractExcelPOIView extends AbstractView {
	// https://jira.spring.io/browse/SPR-6898
	 
    /** The content type for an Excel response */
    private static final String CONTENT_TYPE_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
 
    /**
     * Default Constructor. Sets the content type of the view for excel files.
     */
    public AbstractExcelPOIView() {
    }
 
    @Override
    protected boolean generatesDownloadContent() {
        return true;
    }
 
    /**
     * Renders the Excel view, given the specified model.
     */
    @Override
    protected final void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        Workbook workbook = createWorkbook();
 
        setContentType(CONTENT_TYPE_XLSX);
 
        buildExcelDocument(model, workbook, request, response);
 
        // Set the content type.
        response.setContentType(getContentType());
 
        // Flush byte array to servlet output stream.
        ServletOutputStream out = response.getOutputStream();
        out.flush();
        workbook.write(out);
        out.flush();
        if (workbook instanceof SXSSFWorkbook) {
            ((SXSSFWorkbook) workbook).dispose();
        }
 
        // Don't close the stream - we didn't open it, so let the container
        // handle it.
    }
 
    /**
     * Subclasses must implement this method to create an Excel Workbook.
     * HSSFWorkbook, XSSFWorkbook and SXSSFWorkbook are all possible formats.
     */
    protected abstract Workbook createWorkbook();
 
    /**
     * Subclasses must implement this method to create an Excel HSSFWorkbook
     * document, given the model.
     * 
     * @param model
     *            the model Map
     * @param workbook
     *            the Excel workbook to complete
     * @param request
     *            in case we need locale etc. Shouldn't look at attributes.
     * @param response
     *            in case we need to set cookies. Shouldn't write to it.
     */
    protected abstract void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception;
}