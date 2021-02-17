package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.TokenDTO;

public class SetTokenCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String) model.asMap().get("id");
		String token = (String) model.asMap().get("token");
		
		AnDao adao = new AnDao();
		int  state = adao.setToken(id, token);
		
		model.addAttribute("setToken", String.valueOf(state));
		
	}

}
