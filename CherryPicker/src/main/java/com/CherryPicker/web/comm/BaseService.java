package com.CherryPicker.web.comm;

import java.util.List;

import com.CherryPicker.web.common.util.ParamMap;

@SuppressWarnings({"rawtypes", "unchecked"})
public abstract class BaseService {
	
	/**
	 * 총 게시물 수 및 페이지 수 셋팅
	 * @param list
	 * @param paramMap
	 */
	protected void setTotalParam(List list, ParamMap paramMap) {
		int total_page = 1; 	// 전체 페이지 수
		int total_article = 0; 	// 전체 게시물 수
		if(list != null && list.size() > 0) {
			ParamMap temp = (ParamMap)list.get(0);
			total_article = temp.getInt("TOTAL_ARTICLE");
			total_page = (int)Math.ceil(total_article / paramMap.getDouble(paramMap.getString("page_size_name","page_size")));
		}
		paramMap.put("total_article", total_article);
		paramMap.put("total_page", total_page);
	}
}
