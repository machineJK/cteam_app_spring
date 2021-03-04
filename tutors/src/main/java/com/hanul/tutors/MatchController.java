package com.hanul.tutors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import match.MatchServiceImpl;

@Controller
public class MatchController {
	@Autowired private MatchServiceImpl service;
	
	@RequestMapping("/list.match")
	public String match(HttpSession session, Model model) {
		session.setAttribute("category","match");
		model.addAttribute("teacherList", service.teacherList());
		model.addAttribute("studentList",service.studentList());
		
		return "match/list";
	}
	
	@RequestMapping("/teacherDetail.match")
	public String detail(String teacher_id, Model model) {
		model.addAttribute("teacher_detail", service.teacherDetail(teacher_id));
		
		return "match/teacherDetail";
	}
	
}
