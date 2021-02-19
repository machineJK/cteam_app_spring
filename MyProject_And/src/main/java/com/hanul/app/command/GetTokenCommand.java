package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class GetTokenCommand implements AnCommand{

	public String execute(String id) {
		
		AnDao adao = new AnDao();
		String token = adao.getToken(id);
		
		return token;
		
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		
	}

}
