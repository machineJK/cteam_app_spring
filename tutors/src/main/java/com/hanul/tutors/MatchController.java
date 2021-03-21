package com.hanul.tutors;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonService;
import match.ConditionVO;
import match.MatchServiceImpl;
import match.MatchVO;
import match.StudentVO;
import match.TeacherVO;
import member.MemberVO;

@Controller
public class MatchController {
	@Autowired private MatchServiceImpl service;
	@Autowired private CommonService common;
	
	/*
	 * @ResponseBody @RequestMapping(value = "/schools", produces =
	 * "application/json; charset = utf-8") public Object schools() { StringBuffer
	 * url = new StringBuffer(
	 * "http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=6e83295f45bcc45b5b6133c50b0f281f&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list&thisPage=1&perPage=500"
	 * ); return common.json_list_school(common.requestAPI(url)); }
	 */
	
	@RequestMapping("/list.match")
	public String match(HttpSession session, Model model, String subject) {
		session.setAttribute("category","match");
		if(session.getAttribute("loginInfo") != null) {
			MemberVO vo = (MemberVO) session.getAttribute("loginInfo");
			String id = vo.getId();
			model.addAttribute("isTeacher", service.isTeacher(id));
			model.addAttribute("isStudent", service.isStudent(id));
		}
		model.addAttribute("subject",subject);
		return "match/list";
	}

	@ResponseBody @RequestMapping("/data/teacher_list")
	public List<TeacherVO> teacher_list(ConditionVO vo) {
		return service.teacherList(vo);
	}
	
	@ResponseBody @RequestMapping("/data/student_list")
	public List<StudentVO> student_list(ConditionVO vo) {
		return service.studentList(vo);
	}
	
	@RequestMapping("/teacherDetail.match")
	public String teacherDetail(String teacher_id, Model model) {
		model.addAttribute("teacherDetail", service.teacherDetail(teacher_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		return "match/teacherDetail";
	}
	
	@RequestMapping("/studentDetail.match")
	public String studentDetail(String student_id, Model model) {
		model.addAttribute("studentDetail", service.studentDetail(student_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");		
		return "match/studentDetail";
	}
	
	@RequestMapping("/teacherModify.match")
	public String teacherModify(String teacher_id,Model model) {
		model.addAttribute("vo", service.teacherDetail(teacher_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");	
		return "match/teacherModify";
	}
	
	@RequestMapping("/teacherUpdate.match")
	public String teacherUpdate(TeacherVO vo) {
		service.teacherUpdate(vo);
		return "redirect:/teacherDetail.match?teacher_id=" + vo.getTeacher_id();
	}

	@RequestMapping("/studentModify.match")
	public String studentModify(String student_id,Model model) {
		model.addAttribute("vo", service.studentDetail(student_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");			
		return "match/studentModify";
	}
	
	@RequestMapping("/studentUpdate.match")
	public String studentUpdate(StudentVO vo) {
		service.studentUpdate(vo);
		return "redirect:/studentDetail.match?student_id=" + vo.getStudent_id();
	}
	
	@ResponseBody @RequestMapping("/student_match")
	public void student_match(MatchVO vo) {
		//System.out.println(vo.getTeacher_id());
		//System.out.println(vo.getStudent_id());
		service.student_match(vo);
	}
	
	@ResponseBody @RequestMapping("/teacherCheck.match")
	public void teacherCheck(MatchVO vo) {
		service.teacherCheck(vo);
	}
	
	@ResponseBody @RequestMapping("/teacherClose.match")
	public void teacherClose(MatchVO vo) {
		service.teacherClose(vo);
	}
	
	@ResponseBody @RequestMapping("/adminCheck.match")
	public void adminCheck(MatchVO vo) {
		service.adminCheck(vo);
	}
	
	@ResponseBody @RequestMapping("/adminClose.match")
	public void adminClose(MatchVO vo) {
		service.adminClose(vo);
	}
}
