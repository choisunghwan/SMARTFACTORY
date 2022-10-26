package com.CherryPicker.web.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import org.apache.commons.lang3.StringUtils;

public class DateUtil {
    /**
     * 오늘 날짜를 yyyyMMdd 형식으로 가져온다.
     * @return
     */
    public static String getToday() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		return dateToString(cal.getTime(), "yyyyMMdd");
    }
    
    /**
     * 오늘 날짜를 원하는 날짜형식으로 가져온다
     * @param pattern
     * @return
     */
    public static String getToday(String pattern) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		return dateToString(cal.getTime(), pattern);
    }
    
    /**
     * 패턴에 맞는 날짜 형식으로 변환 (Date => String)
     * @param date		Date 날짜
     * @param pattern	날짜 형식
     * @return
     */
	public static String dateToString(Date date, String pattern) {
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.KOREA);	    
	    return formatter.format(date);
	}
	
	/**
     * 패턴에 맞는 날짜 형식으로 변환 (Date => String)
     * @param date		Date 날짜
     * @param pattern	날짜 형식
     * @return
     */
	public static String dateToString(java.sql.Date date, String pattern) {
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.KOREA);	    
	    return formatter.format(date);
	}
	
	/**
	 * 패턴에 맞는 날짜 형식으로 변환 (String => Date)
	 * @param stringDate		String 형 날짜
	 * @param stringPattern		String 형 날짜 형식
	 * @return
	 * @throws Exception
	 */
	public Date stringToDate(String stringDate, String stringPattern) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat(stringPattern, Locale.KOREA);	 
   		return formatter.parse(stringDate);
	}
	
	/**
	 * 입력된 일자 문자열을 확인하고 8자리로 리턴
	 * @param dateStr
	 * @return
	 */
	private static String validChkDate(String dateStr) {
		String _dateStr = dateStr;
		if (dateStr == null || !(dateStr.trim().length() == 8 || dateStr.trim().length() == 10)) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (dateStr.length() == 10) {
			_dateStr = StringUtils.substring(dateStr, 0, 4) + StringUtils.substring(dateStr, 4, 6) + StringUtils.substring(dateStr, 6, 8);
		}
		return _dateStr;
	}
	
	/**
	 * 날짜 연산
	 * @param sDate
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	private static String addYearMonthDay(String sDate, int year, int month, int day) {
		String dateStr = validChkDate(sDate);

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		try {
			cal.setTime(sdf.parse(dateStr));
		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (year != 0) {
			cal.add(Calendar.YEAR, year);
		}
		if (month != 0) {
			cal.add(Calendar.MONTH, month);
		}
		if (day != 0) {
			cal.add(Calendar.DATE, day);
		}
		
		return sdf.format(cal.getTime());
	}
	
	/**
	 * 년도를 더한다.
	 * @param dateStr
	 * @param year
	 * @return
	 */
	public static String addYear(String dateStr, int year) {
		return addYearMonthDay(dateStr, year, 0, 0);
	}
	
	/**
	 * 월을 더한다.
	 * @param dateStr
	 * @param month
	 * @return
	 */
	public static String addMonth(String dateStr, int month) {
		return addYearMonthDay(dateStr, 0, month, 0);
	}
	
	/**
	 * 일을 더한다.
	 * @param dateStr
	 * @param day
	 * @return
	 */
	public static String addDay(String dateStr, int day) {
		return addYearMonthDay(dateStr, 0, 0, day);
	}
	
	/**
	 * yyyyMMdd 포맷의 String 문자열을 gubun으로 변경한다.
	 * @param stringDate
	 * @param gubun
	 * @return
	 */
	public static String StringFormat(String stringDate, String gubun) {
		if(StringUtils.isEmpty(stringDate) || stringDate.length() != 8) {
			return stringDate;
		}
		
		String tmpDate = StringUtils.substring(stringDate, 0, 4) + gubun;
		tmpDate += StringUtils.substring(stringDate, 4, 6) + gubun;
		tmpDate += StringUtils.substring(stringDate, 6, 8);
		
		return tmpDate;
	}
	
	/**
	 * yyyyMMdd 기간
	 * @param dateStr1
	 * @param dateStr2
	 * @return
	 */
	public static int getDaysDiff(String dateStr1, String dateStr2) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		Date date1 = null;
		Date date2 = null;
		try {
			date1 = sdf.parse(dateStr1);
			date2 = sdf.parse(dateStr2);
		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid date format: args[0]=" + dateStr1 + " args[1]=" + dateStr2);
		}
		int days1 = (int) ((date1.getTime() / 3600000) / 24);
		int days2 = (int) ((date2.getTime() / 3600000) / 24);

		return days2 - days1;
	}
}
