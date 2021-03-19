package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.CheckDTO;

public class AnIdCheckCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");
		String mstWho = (String)model.asMap().get("mstWho");

		//System.out.println(id);

		AnDao adao = new AnDao();
		CheckDTO dto = adao.anIdCheck(id,mstWho);
		
		model.addAttribute("anIdCheck", dto); 
	}
}
