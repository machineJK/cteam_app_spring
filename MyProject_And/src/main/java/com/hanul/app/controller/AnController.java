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

import com.hanul.app.command.ASelectMultiCommand;
import com.hanul.app.command.ASelectMultiCommand2;
import com.hanul.app.command.AnCommand;
import com.hanul.app.command.AnJoinCommand;
import com.hanul.app.command.AnLoginCommand;
import com.hanul.app.command.AnStudentCommand;
import com.hanul.app.command.AnTeacherCommand;



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
	
	//선생 등록
	@RequestMapping(value="/anTeacher", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anTeacher(HttpServletRequest request, Model model){
		System.out.println("anTeacher()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String teacher_id = (String) request.getParameter("teacher_id");
		String teacher_univ = (String) request.getParameter("teacher_univ");
		String teacher_major = (String) request.getParameter("teacher_major");
		String teacher_univnum = (String) request.getParameter("teacher_univnum");
		String teacher_subject = (String) request.getParameter("teacher_subject");
		String teacher_worktime = (String) request.getParameter("teacher_worktime");
		String teacher_pay = (String) request.getParameter("teacher_pay");
		String teacher_intro = (String) request.getParameter("teacher_intro");
		String teacher_image_path = (String) request.getParameter("teacher_image_path");
		String teacher_nickname = (String) request.getParameter("teacher_nickname");
		String teacher_addr = (String) request.getParameter("teacher_addr");
		
		model.addAttribute("teacher_id", teacher_id);
		model.addAttribute("teacher_univ", teacher_univ);
		model.addAttribute("teacher_major", teacher_major);
		model.addAttribute("teacher_univnum", teacher_univnum);
		model.addAttribute("teacher_subject", teacher_subject);
		model.addAttribute("teacher_worktime", teacher_worktime);
		model.addAttribute("teacher_pay", teacher_pay);
		model.addAttribute("teacher_intro", teacher_intro);
		model.addAttribute("teacher_image_path", teacher_image_path);
		model.addAttribute("teacher_nickname", teacher_nickname);
		model.addAttribute("teacher_addr", teacher_addr);
		
		command = new AnTeacherCommand();
		command.execute(model);
		
		return "anTeacher";
	}
	
	//선생 등록
	@RequestMapping(value="/anStudent", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anStudent(HttpServletRequest request, Model model){
		System.out.println("anStudent()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String student_id = (String) request.getParameter("student_id");
		String student_subject = (String) request.getParameter("student_subject");
		String student_grade = (String) request.getParameter("student_grade");
		String student_intro = (String) request.getParameter("student_intro");
		String student_image_path = (String) request.getParameter("student_image_path");
		
		model.addAttribute("student_id", student_id);
		model.addAttribute("student_subject", student_subject);
		model.addAttribute("student_grade", student_grade);
		model.addAttribute("student_intro", student_intro);
		model.addAttribute("student_image_path", student_image_path);
		
		command = new AnStudentCommand();
		command.execute(model);
		
		return "anStudent";
	}
	
	//선생 리스트뷰
	@RequestMapping(value="/anSelectMulti", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectMulti(HttpServletRequest req, Model model){
		System.out.println("anSelectMulti()");
		
		command = new ASelectMultiCommand();
		command.execute(model);
		
		return "anSelectMulti";
	}
	
	//학생 리스트뷰
	@RequestMapping(value="/anSelectMulti2", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectMulti2(HttpServletRequest req, Model model){
		System.out.println("anSelectMulti2()");
		
		command = new ASelectMultiCommand2();
		command.execute(model);
		
		return "anSelectMulti2";
	}
	
	
}
