package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class SetMatchCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String teacher_id = (String) model.asMap().get("teacher_id");
		String student_id = (String) model.asMap().get("student_id");
		
		AnDao adao = new AnDao();
		int  state = adao.setMatch(teacher_id, student_id);
		
		model.addAttribute("setToken", String.valueOf(state));
	}

}
