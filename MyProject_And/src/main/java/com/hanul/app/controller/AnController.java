package com.hanul.app.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.hanul.app.command.AnCommand;
import com.hanul.app.command.AnJoinCommand;
import com.hanul.app.command.AnLoginCommand;



@Controller
public class AnController {
	
	AnCommand command;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	//안드로이드에서 온 정보가 여기로 넘겨짐
	@RequestMapping(value="/anJoin", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anJoin(HttpServletRequest req, Model model){
		
		//안드로이드와 연결되어있는지 확인하기
		System.out.println("anJoin()");
		
		//한글 설정
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		//받은 정보를 request방식으로 받기
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String nickname = (String) req.getParameter("nickname");
		String name = (String) req.getParameter("name");
		String gender = (String) req.getParameter("gender");
		String birth = (String) req.getParameter("birth");
		String email = (String) req.getParameter("email");
		String addr1 = (String) req.getParameter("addr1");
		String addr2 = (String) req.getParameter("addr2");
		String dbImgPath = (String) req.getParameter("dbImgPath");

		
//		//데이터가 제대로 연결되어 있는지 확인
//		System.out.println(id);
//		System.out.println(passwd);
//		System.out.println(name);
//		System.out.println(phonenumber);
//		System.out.println(address);
		
		//모델에 담기(그냥 하는것)
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		model.addAttribute("nickname", nickname);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("birth", birth);
		model.addAttribute("email", email);
		model.addAttribute("addr1", addr1);
		model.addAttribute("addr2", addr2);
		model.addAttribute("dbImgPath", dbImgPath);	
		
		MultipartRequest multi = (MultipartRequest)req;
		MultipartFile file = multi.getFile("image");
		
		if(file != null) {
			String fileName = file.getOriginalFilename();
			System.out.println(fileName);
			
			// 디렉토리 존재하지 않으면 생성
			makeDir(req);	
				
			if(file.getSize() > 0){			
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/");
				
				System.out.println( fileName + " : " + realImgPath);
				System.out.println( "fileSize : " + file.getSize());					
												
			 	try {
			 		// 이미지파일 저장
					file.transferTo(new File(realImgPath, fileName));										
				} catch (Exception e) {
					e.printStackTrace();
				} 
									
			}else{
				// 이미지파일 실패시
				fileName = "FileFail.jpg";
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/" + fileName);
				System.out.println(fileName + " : " + realImgPath);
						
			}			
			
		}

		command = new AnJoinCommand();
		command.execute(model);
		
		return "anJoin";
	}
	
	
	public void makeDir(HttpServletRequest req){
		File f = new File(req.getSession().getServletContext()
				.getRealPath("/resources"));
		if(!f.isDirectory()){
		f.mkdir();
		}	
	}
	
	//안드로이드에서 온 로그인 정보(id,pw)
	@RequestMapping(value="/anLogin", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anLogin(HttpServletRequest request, Model model){
		//System.out.println("anLogin()");
		System.out.println("anLogin()");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String id = (String) request.getParameter("id");
		String pw = (String) request.getParameter("pw");
		
		//System.out.println(id);
		//System.out.println(passwd);
		
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		
		command = new AnLoginCommand();
		command.execute(model);
		
		return "anLogin";
	}
}
