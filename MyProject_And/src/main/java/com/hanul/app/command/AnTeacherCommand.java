package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class AnTeacherCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String teacher_id = (String)model.asMap().get("teacher_id");
		String teacher_univ = (String)model.asMap().get("teacher_univ");	
		String teacher_major = (String)model.asMap().get("teacher_major");	
		String teacher_univnum = (String)model.asMap().get("teacher_univnum");	
		String teacher_subject = (String)model.asMap().get("teacher_subject");	
		String teacher_worktime = (String)model.asMap().get("teacher_worktime");	
		String teacher_pay = (String)model.asMap().get("teacher_pay");	
		String teacher_intro = (String)model.asMap().get("teacher_intro");	
		String teacher_image_path = (String)model.asMap().get("teacher_image_path");
		String teacher_nickname = (String)model.asMap().get("teacher_nickname");
		String teacher_addr = (String)model.asMap().get("teacher_addr");

		AnDao adao = new AnDao();
		int state = adao.anTeacher(teacher_id,teacher_univ,teacher_major,teacher_univnum,
				teacher_subject,teacher_worktime,teacher_pay,teacher_intro,teacher_image_path,
				teacher_nickname,teacher_addr);
		
		model.addAttribute("anTeacher", String.valueOf(state)); 	
	}

}
