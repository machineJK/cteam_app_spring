package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.TeacherDTO;

public class MyTeacherDetail implements AnCommand {

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");

		AnDao adao = new AnDao();
		TeacherDTO adto = adao.myTeacherDetail(id);
		
		model.addAttribute("myTeacherDetail", adto); 	
	}

}
