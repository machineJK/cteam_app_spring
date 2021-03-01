package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class AnStudentAcceptCommand implements AnCommand{

	@Override
	//학생 -> 선생
	public void execute(Model model) {
		String teacher_id = (String) model.asMap().get("teacher_id");
		String student_id = (String) model.asMap().get("student_id");
		String check = (String) model.asMap().get("check");
		
		AnDao adao = new AnDao();
		int  state = adao.studentAccept(teacher_id,student_id,check);
		
		model.addAttribute("setToken", String.valueOf(state));
	}

}
