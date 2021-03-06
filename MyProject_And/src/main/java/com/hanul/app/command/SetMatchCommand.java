package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class SetMatchCommand implements AnCommand{

	@Override
	//�л� -> ����
	public void execute(Model model) {
		String teacher_id = (String) model.asMap().get("teacher_id");
		String teacher_nickname = (String) model.asMap().get("teacher_nickname");
		String student_id = (String) model.asMap().get("student_id");
		String student_nickname = (String) model.asMap().get("student_nickname");
		
		AnDao adao = new AnDao();
		int  state = adao.setMatch(teacher_id,teacher_nickname, student_id,student_nickname);
		
		model.addAttribute("setToken", String.valueOf(state));
	}

}
