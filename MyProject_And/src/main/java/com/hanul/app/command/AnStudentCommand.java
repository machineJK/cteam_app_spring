package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class AnStudentCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String student_id = (String)model.asMap().get("student_id");
		String student_subject = (String)model.asMap().get("student_subject");	
		String student_grade = (String)model.asMap().get("student_grade");	
		String student_intro = (String)model.asMap().get("student_intro");		
		String student_image_path = (String)model.asMap().get("student_image_path");
		String student_addr = (String)model.asMap().get("student_addr");
		String student_nickname = (String)model.asMap().get("student_nickname");

		AnDao adao = new AnDao();
		int state = adao.anStudent(student_id,student_subject,student_grade,
				student_intro,student_image_path,student_addr,student_nickname);
		
		model.addAttribute("anStudent", String.valueOf(state)); 	
		
	}

}
