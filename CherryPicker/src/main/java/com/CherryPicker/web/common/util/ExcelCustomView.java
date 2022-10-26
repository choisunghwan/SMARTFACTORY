package com.CherryPicker.web.common.util;

import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.LocalizedResourceHelper;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * @author kimyuntae 20130703
 * ���� xlsx�� Ŀ���Һ�
 */
public abstract class ExcelCustomView extends AbstractView {

	/** The content type for an Excel response */
	private static final String CONTENT_TYPE = "application/vnd.ms-excel";

	/** The extension to look for existing templates */
	private static final String EXTENSION = ".xlsx";


	private String url;

	public ExcelCustomView() {
		setContentType(CONTENT_TYPE);
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		XSSFWorkbook workbook;
		if (this.url != null) {
			workbook = getTemplateSource(this.url, request);
		}
		else {
			workbook = new XSSFWorkbook();
			logger.debug("Created Excel Workbook from scratch");
		}

		buildExcelDocument(model, workbook, request, response);
		
		response.setContentType(getContentType());
				
		ServletOutputStream out = response.getOutputStream();
		workbook.write(out);
		out.flush();

	}

	protected XSSFWorkbook getTemplateSource(String url, HttpServletRequest request) throws Exception {
		LocalizedResourceHelper helper = new LocalizedResourceHelper(getApplicationContext());
		Locale userLocale = RequestContextUtils.getLocale(request);
		Resource inputFile = helper.findLocalizedResource(url, EXTENSION, userLocale);
		
		if (logger.isDebugEnabled()) {
			logger.debug("Loading Excel workbook from " + inputFile);
		}
		
		return new XSSFWorkbook(inputFile.getInputStream());
	}
	
	protected abstract void buildExcelDocument(
			Map<String, Object> model, XSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
	
		
}

