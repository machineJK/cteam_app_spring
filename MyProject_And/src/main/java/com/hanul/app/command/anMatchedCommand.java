package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.MatchingDTO;

public class anMatchedCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");

		AnDao adao = new AnDao();
		ArrayList<MatchingDTO> adtos = adao.anMatched(id);
		
		model.addAttribute("anMatched", adtos); 
	
	}

}
