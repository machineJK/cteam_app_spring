package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.MatchingDTO;

public class anAdminMatchingCommand implements AnCommand{

	@Override
	public void execute(Model model) {

		AnDao adao = new AnDao();
		ArrayList<MatchingDTO> adtos = adao.anAdminMatching();
		
		model.addAttribute("anAdminMatching", adtos); 
	
	}

}
