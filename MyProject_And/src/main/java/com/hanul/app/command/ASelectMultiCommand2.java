package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.StudentDTO;

public class ASelectMultiCommand2 implements AnCommand{

	@Override
	public void execute(Model model) {
		AnDao adao = new AnDao();
		ArrayList<StudentDTO> adtos = adao.anSelectMulti2();
		
		model.addAttribute("anSelectMulti2", adtos); 
		
	}

}
