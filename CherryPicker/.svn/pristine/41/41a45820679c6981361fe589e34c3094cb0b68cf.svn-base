package com.CherryPicker.web.common;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.CherryPicker.web.comm.UserVO;
import com.CherryPicker.web.common.CommandMap;

public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver{
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return CommandMap.class.isAssignableFrom(parameter.getParameterType());
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		CommandMap commandMap = new CommandMap();
		
		HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
		Enumeration<?> enumeration = request.getParameterNames();
		String userId = "";
		
		
		
		String key = null;
		String[] values = null;
		while(enumeration.hasMoreElements()){
			key = (String) enumeration.nextElement();
			values = request.getParameterValues(key);
			if(values != null){
				commandMap.put(key, (values.length > 1) ? values:values[0] );
			}
		}
		
		
		HttpSession session = request.getSession();
		  
		UserVO user = (UserVO)session.getAttribute("UserInfo");
		  
		if(request.getAttribute("sUserId") != null )
		{
			userId = (String)request.getAttribute("sUserId");
		}
		
		if(user != null ){
			userId = user.user_id;
		}
		
		commandMap.put("sUserId", userId);
		return commandMap;
	}

}
