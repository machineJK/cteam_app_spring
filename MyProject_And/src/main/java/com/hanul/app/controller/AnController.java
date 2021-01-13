package com.hanul.app.controller;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	//�ȵ���̵忡�� �� ������ ����� �Ѱ���
	@RequestMapping(value="/anJoin", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anJoin(HttpServletRequest req, Model model){
		
		//�ȵ���̵�� ����Ǿ��ִ��� Ȯ���ϱ�
		System.out.println("anJoin()");
		
		//�ѱ� ����
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		//���� ������ request������� �ޱ�
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String nickname = (String) req.getParameter("nickname");
		String name = (String) req.getParameter("name");
		String gender = (String) req.getParameter("gender");
		String birth = (String) req.getParameter("birth");
		String email = (String) req.getParameter("email");
		String addr1 = (String) req.getParameter("addr1");
		String addr2 = (String) req.getParameter("addr2");
		String picture = (String) req.getParameter("picture");

		
//		//�����Ͱ� ����� ����Ǿ� �ִ��� Ȯ��
//		System.out.println(id);
//		System.out.println(passwd);
//		System.out.println(name);
//		System.out.println(phonenumber);
//		System.out.println(address);
		
		//�𵨿� ���(�׳� �ϴ°�)
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		model.addAttribute("nickname", nickname);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("birth", birth);
		model.addAttribute("email", email);
		model.addAttribute("addr1", addr1);
		model.addAttribute("addr2", addr2);
		model.addAttribute("picture", picture);


		command = new AnJoinCommand();
		command.execute(model);
		
		return "anJoin";
	}
	
	//�ȵ���̵忡�� �� �α��� ����(id,pw)
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
