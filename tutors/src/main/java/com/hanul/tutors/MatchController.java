package com.hanul.tutors;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import match.MatchServiceImpl;
import match.StudentVO;
import match.TeacherVO;

@Controller
public class MatchController {
	@Autowired private MatchServiceImpl service;
	
	@RequestMapping("/list.match")
	public String match(HttpSession session, Model model) {
		session.setAttribute("category","match");	
		
		return "match/list";
	}

	@ResponseBody @RequestMapping("/data/teacher_list")
	public List<TeacherVO> teacher_list(int count) {
		//System.out.println(count);
		return service.teacherList(count);
	}
	
	@ResponseBody @RequestMapping("/data/student_list")
	public List<StudentVO> student_list(int count) {
		return service.studentList(count);
	}
	
	@RequestMapping("/teacherDetail.match")
	public String teacherDetail(String teacher_id, Model model) {
		model.addAttribute("teacherDetail", service.teacherDetail(teacher_id));
		
		return "match/teacherDetail";
	}
	
	@RequestMapping("/studentDetail.match")
	public String studentDetail(String student_id, Model model) {
		model.addAttribute("studentDetail", service.studentDetail(student_id));
		
		return "match/studentDetail";
	}
	
	
	
}
