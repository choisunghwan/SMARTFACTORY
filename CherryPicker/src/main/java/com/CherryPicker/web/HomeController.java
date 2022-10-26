package com.CherryPicker.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.CherryPicker.web.comm.CommService;
import com.CherryPicker.web.comm.UserVO;
import com.CherryPicker.web.common.CommandMap;
import com.CherryPicker.web.ui100.UI100Service;

//import com.pjmetal.web.common.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
//	UserVO user = new UserVO();
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private UI100Service UI100Service;
	
	
	@Resource(name="CommService")
	private CommService CommService;
	
	@RequestMapping(value="/main.do")
	public ModelAndView main(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/main");
    	
    	HttpSession session = request.getSession();
    	
    	UserVO user = (UserVO)session.getAttribute("UserInfo");
    	
//    	List<Map<String,Object>> list = UI100Service.PSMES_UI110_searchOrderCom(commandMap.getMap());
//    	
//    	mv.addObject("orderCom", list);
    	
    	
		return mv;
    	//return mv;
    }
	
	
	@RequestMapping(value="/login.do")
    public ModelAndView loginView(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/login");
    	
		return mv;
    }
	
	@RequestMapping(value="/sessionout.do")
    public ModelAndView sessionout(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/sessionout");
    	System.out.println("sessionout Start");
		return mv;
    }
	
	
	@RequestMapping(value = "/main_content", method = RequestMethod.GET)
	public String main_content(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/main_content2", method = RequestMethod.GET)
	public String main_content2(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home3";
	}
	

	@RequestMapping(value="/test.do")
    public ModelAndView testView(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/test");
    	
		return mv;
    }
	
	
	

//	@RequestMapping(value="/stream/{video_name:.+}", method= RequestMethod.GET)
//	@RequestMapping(value="/stream/aaa.do")
	@RequestMapping(value="/stream/aaa.do")
	ModelAndView stream(CommandMap commandMap,HttpServletRequest request, HttpServletResponse response) throws Exception{
//	public String stream(@PathVariable("video_name") String video_name, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException {
		String video_name = "test.mp4";
		String[] filename_seperate = video_name.split("\\."); 
		String exp;

		if(filename_seperate.length <= 1 ) {

			// 확장자 에러  //
			throw new RuntimeException("Wrong file name. You need to include expand file name");
			// response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING)); // response.getOutputStream().flush(); // return null;

		} else {
			exp = filename_seperate[1];
		}
		
		// Progressbar 에서 특정 위치를 클릭하거나 해서 임의 위치의 내용을 요청할 수 있으므로 // 파일의 임의의 위치에서 읽어오기 위해 RandomAccessFile 클래스를 사용한다. // 해당 파일이 없을 경우 예외 발생
		String FOLDER_MOVIE = "D:\\project\\";
		File file = new File(FOLDER_MOVIE + video_name);

		if(!file.exists()) throw new FileNotFoundException();

		RandomAccessFile randomFile = new RandomAccessFile(file, "r");

		long rangeStart = 0; // 요청 범위의 시작 위치
		long rangeEnd = 0; // 요청 범위의 끝 위치

		boolean isPart = false; //부분 요청일 경우 true, 전체 요청의 경우 false

		// randomFile 을 클로즈 하기 위하여 try~finally 사용 
		try{
			// 동영상 파일 크기
			long movieSize = randomFile.length();
			// 스트림 요청 범위, request의 헤더에서 range를 읽는다.

			String range = request.getHeader("range");

			// 브라우저에 따라 range 형식이 다른데, 기본 형식은 "bytes={start}-{end}" 형식이다. // range가 null이거나, reqStart가 0이고 end가 없을 경우 전체 요청이다. // 요청 범위를 구한다.
			if(range != null) {
				// 처리의 편의를 위해 요청 range에 end 값이 없을 경우 넣어줌
				if(range.endsWith("-")){ range = range+(movieSize - 1); }

				int idxm = range.trim().indexOf("-"); //"-" 위치

				rangeStart = Long.parseLong(range.substring(6,idxm));
				rangeEnd = Long.parseLong(range.substring(idxm+1));
				if(rangeStart > 0){
					isPart = true;
				}
			}else{	
				//range가 null인 경우 동영상 전체 크기로 초기값을 넣어줌. 0부터 시작하므로 -1
				rangeStart = 0; 
				rangeEnd = movieSize - 1;
			}

			// 전송 파일 크기
			long partSize = rangeEnd - rangeStart + 1;
			// 전송시작
			response.reset();
			// 전체 요청일 경우 200, 부분 요청일 경우 206을 반환상태 코드로 지정
			response.setStatus(isPart ? 206 : 200);
			// mime type 지정
			response.setContentType("video/mp4");
			// 전송 내용을 헤드에 넣어준다. 마지막에 파일 전체 크기를 넣는다.
			response.setHeader("Content-Range", "bytes "+rangeStart+"-"+rangeEnd+"/"+movieSize);
			response.setHeader("Accept-Ranges", "bytes"); 
			response.setHeader("Content-Length", ""+partSize); 
			OutputStream out = response.getOutputStream();

			// 동영상 파일의 전송시작 위치 지정
			randomFile.seek(rangeStart);
			// 파일 전송... java io는 1회 전송 byte수가 int로 지정됨 // 동영상 파일의 경우 int형으로는 처리 안되는 크기의 파일이 있으므로 // 8kb로 잘라서 파일의 크기가 크더라도 문제가 되지 않도록 구현
			int bufferSize = 8*1024; 
			byte[] buf = new byte[bufferSize]; 
			do{ 
				int block = partSize > bufferSize ? bufferSize : 
				(int)partSize; int len = randomFile.read(buf, 0, block); out.write(buf, 0, len); 
				partSize -= block; 
			
			}while(partSize > 0);
			
		}catch(IOException e){
				
		// 전송 중에 브라우저를 닫거나, 화면을 전환한 경우 종료해야 하므로 전송취소. // progressBar를 클릭한 경우에는 클릭한 위치값으로 재요청이 들어오므로 전송 취소.

		}finally{ randomFile.close(); } 
	
		return null;
	}
		
	
	
	
}
