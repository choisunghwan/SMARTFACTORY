package com.CherryPicker.web.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import org.apache.commons.lang3.StringUtils;

@SuppressWarnings({"rawtypes", "unchecked"})
public class PropertiesUtil {
	private static PropertiesUtil instance = new PropertiesUtil();
	private static Map properties_info;

	public static PropertiesUtil getInstance() {
		if (instance == null) {
			synchronized (PropertiesUtil.class) {
				instance = new PropertiesUtil();
			}
		}
		return instance;
	}
	
	/**
	 * init config.properties
	 * @param config_path
	 */
	public void setConfigProperties(String config_path) {
		Properties properties = new Properties();
		Enumeration enumPropkeys = null;
        String keyName = null; // properties key
        String keyValue = null; // properties value
        try {
        	properties_info = new HashMap();
        	InputStream inputstream = new FileInputStream(new File(config_path));
            properties.load(inputstream);
            inputstream.close();
            
            enumPropkeys = properties.keys();
            while(enumPropkeys.hasMoreElements()) {
            	keyName		= StringUtils.defaultString((String)enumPropkeys.nextElement());
            	keyValue	= StringUtils.defaultString(properties.getProperty(keyName));
            	
            	properties_info.put(keyName.trim(), keyValue.trim());
            } 
        } catch(Exception e) {
            e.printStackTrace();
		}
	}

	/**
	 * config.properties에 key값에 해당하는 값을 리턴한다.
	 * @param keyName properties key name
	 * @return
	 */
	public static String getValue(String keyName) {
		try {
			if(properties_info == null) { throw new Exception("No properties Info"); }
			return StringUtils.defaultString((String) properties_info.get(keyName)).trim();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	/**
	 * config.properties에 key값에 해당하는 값을 리턴한다.
	 * @param keyName properties key name
	 * @return
	 */
	public static int getIntValue(String keyName) {
		try {
			if(properties_info == null) { throw new Exception("No properties Info"); }
			return Integer.parseInt(StringUtils.defaultString((String)properties_info.get(keyName)).trim());
		} catch (Exception e) {
			return -1;
		}
	}
	
	/**
	 * config.properties에 key값에 해당하는 값을 리턴한다.
	 * @param keyName properties key name
	 * @return
	 */
	public static long getLongValue(String keyName) {
		try {
			if(properties_info == null) { throw new Exception("No properties Info"); }
			return Long.parseLong(StringUtils.defaultString((String)properties_info.get(keyName)).trim());
		} catch (Exception e) {
			return -1;
		}
	}
}