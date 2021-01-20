package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.TeacherDTO;

public class ASelectMultiCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		AnDao adao = new AnDao();
		ArrayList<TeacherDTO> adtos = adao.anSelectMulti();
		
		model.addAttribute("anSelectMulti", adtos); 		
	}

}
